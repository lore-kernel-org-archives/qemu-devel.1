Received: from eggs.gnu.org ([2001:4830:134:3::10]:55917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXQu6-0004WR-FG
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXQu3-0000xX-DH
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:47:34 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXQu3-0000xB-4s
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:47:31 -0400
Received: by mail-wr0-x241.google.com with SMTP id b8-v6so8118997wro.6
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 05:47:30 -0700 (PDT)
References: <20180625111935.26108-1-alex.bennee@linaro.org>
	<20180625111935.26108-11-alex.bennee@linaro.org>
	<5fb3e032-bd7d-092f-b6da-f33ba7ff9530@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5fb3e032-bd7d-092f-b6da-f33ba7ff9530@amsat.org>
Date: Mon, 25 Jun 2018 13:47:28 +0100
Message-ID: <87vaa7vxr3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 10/10] linux-user: add gcov support to
 preexit_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 06/25/2018 08:19 AM, Alex Benn=C3=A9e wrote:
>> As we don't always take the normal exit path when running a guest we
>> can skip the normal exit destructors where gcov normally dumps it's
>> info. The GCC manual suggests long running programs use __gcov_dump()
>> to flush out the coverage state periodically so we use that here.
>
> Shouldn't we also check for this symbol in the ./configure script?

Sure - I couldn't find it exported anywhere - just mentioned in the
documentation. I think it has been there a while though.
>
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>> ---
>>  linux-user/exit.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/linux-user/exit.c b/linux-user/exit.c
>> index aed8713fae..14e94e28fa 100644
>> --- a/linux-user/exit.c
>> +++ b/linux-user/exit.c
>> @@ -19,10 +19,17 @@
>>  #include "qemu/osdep.h"
>>  #include "qemu.h"
>>
>> +#ifdef CONFIG_GCOV
>> +extern void __gcov_dump(void);
>> +#endif
>> +
>>  void preexit_cleanup(CPUArchState *env, int code)
>>  {
>>  #ifdef TARGET_GPROF
>>          _mcleanup();
>> +#endif
>> +#ifdef CONFIG_GCOV
>> +        __gcov_dump();
>>  #endif
>>          gdb_exit(env, code);
>>  }
>>


--
Alex Benn=C3=A9e
