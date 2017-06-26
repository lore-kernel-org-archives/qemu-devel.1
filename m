Received: from eggs.gnu.org ([2001:4830:134:3::10]:45231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPWdR-0004Wh-0T
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPWdP-0004PA-SL
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:13:08 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPWdP-0004Od-Kj
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:13:07 -0400
Received: by mail-wm0-x236.google.com with SMTP id 62so2004424wmw.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 09:13:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <745bc99a-9768-8dc7-ec17-843ad39d354d@amsat.org>
References: <1498487280-17836-1-git-send-email-peter.maydell@linaro.org>
	<745bc99a-9768-8dc7-ec17-843ad39d354d@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2017 17:12:45 +0100
Message-ID: <CAFEAcA_ijfVzxGS2cdUKg-P+pyvHux_KXEAr6_xW6moYAuAykg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] main_loop: Make main_loop_wait() return
 void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 26 June 2017 at 16:54, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> On 06/26/2017 11:28 AM, Peter Maydell wrote:
>>
>> In commit e330c118f2a5a the last usage of main_loop_wait() that cared
>> about the return value was changed to no longer use it. Drop the
>> now-useless return value and make the function return void.
>>
>> We avoid the awkwardness of ifdeffery to handle the 'ret'
>> variable in main_loop_wait() only being wanted if CONFIG_SLIRP
>> by simply dropping all the ifdefs. There are stub implementations
>> of slirp_pollfds_poll() and slirp_pollfds_fill() already in
>> stubs/slirp.c which do nothing, as required.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>
>> ---
>> This will coincidentally satisfy Coverity, which currently complains
>> in CID 1372464 that we call main_loop_wait() in vl.c and ignore the
>> return value which may be reporting a poll() syscall failure.
>> Essentially we don't expect poll() to fail, except perhaps with
>> a transient EINTR -- if it ever did we'd spin retrying endlessly
>> I think.
>> ---
>>   include/qemu/main-loop.h | 2 +-
>>   util/main-loop.c         | 8 ++------
>>   2 files changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
>> index d7e24af..6b4b60b 100644
>> --- a/include/qemu/main-loop.h
>> +++ b/include/qemu/main-loop.h
>> @@ -79,7 +79,7 @@ int qemu_init_main_loop(Error **errp);
>>    *
>>    * @nonblocking: Whether the caller should block until an event occurs=
.
>>    */
>> -int main_loop_wait(int nonblocking);
>> +void main_loop_wait(int nonblocking);
>>     /**
>>    * qemu_get_aio_context: Return the main loop's AioContext
>> diff --git a/util/main-loop.c b/util/main-loop.c
>> index 19cad6b..0b25405 100644
>> --- a/util/main-loop.c
>> +++ b/util/main-loop.c
>> @@ -487,7 +487,7 @@ static int os_host_main_loop_wait(int64_t timeout)
>>   }
>>   #endif
>>   -int main_loop_wait(int nonblocking)
>> +void main_loop_wait(int nonblocking)
>>   {
>>       int ret;
>>       uint32_t timeout =3D UINT32_MAX;
>> @@ -500,9 +500,7 @@ int main_loop_wait(int nonblocking)
>>       /* poll any events */
>>       g_array_set_size(gpollfds, 0); /* reset for new iteration */
>>       /* XXX: separate device handlers from system ones */
>> -#ifdef CONFIG_SLIRP
>>       slirp_pollfds_fill(gpollfds, &timeout);
>> -#endif
>>         if (timeout =3D=3D UINT32_MAX) {
>>           timeout_ns =3D -1;
>> @@ -515,16 +513,14 @@ int main_loop_wait(int nonblocking)
>>                                             &main_loop_tlg));
>>         ret =3D os_host_main_loop_wait(timeout_ns);
>> -#ifdef CONFIG_SLIRP
>>       slirp_pollfds_poll(gpollfds, (ret < 0));
>> -#endif
>>         /* CPU thread can infinitely wait for event after
>>          missing the warp */
>>       qemu_start_warp_timer();
>>       qemu_clock_run_all_timers();
>>   -    return ret;
>> +    return;
>
>
> drop this return?

Oops, yes, Eric suggested that in v1 and I forgot :-(

thanks
-- PMM
