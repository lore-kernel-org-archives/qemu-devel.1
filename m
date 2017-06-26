Received: from eggs.gnu.org ([2001:4830:134:3::10]:39931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPWLZ-0007bU-T4
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPWLV-00053h-84
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:54:41 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPWLV-00053U-3R
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:54:37 -0400
Received: by mail-qt0-x244.google.com with SMTP id w6so685238qtg.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 08:54:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1498487280-17836-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <745bc99a-9768-8dc7-ec17-843ad39d354d@amsat.org>
Date: Mon, 26 Jun 2017 12:54:33 -0300
MIME-Version: 1.0
In-Reply-To: <1498487280-17836-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, patches@linaro.org

On 06/26/2017 11:28 AM, Peter Maydell wrote:
> In commit e330c118f2a5a the last usage of main_loop_wait() that cared
> about the return value was changed to no longer use it. Drop the
> now-useless return value and make the function return void.
> 
> We avoid the awkwardness of ifdeffery to handle the 'ret'
> variable in main_loop_wait() only being wanted if CONFIG_SLIRP
> by simply dropping all the ifdefs. There are stub implementations
> of slirp_pollfds_poll() and slirp_pollfds_fill() already in
> stubs/slirp.c which do nothing, as required.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> This will coincidentally satisfy Coverity, which currently complains
> in CID 1372464 that we call main_loop_wait() in vl.c and ignore the
> return value which may be reporting a poll() syscall failure.
> Essentially we don't expect poll() to fail, except perhaps with
> a transient EINTR -- if it ever did we'd spin retrying endlessly
> I think.
> ---
>   include/qemu/main-loop.h | 2 +-
>   util/main-loop.c         | 8 ++------
>   2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index d7e24af..6b4b60b 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -79,7 +79,7 @@ int qemu_init_main_loop(Error **errp);
>    *
>    * @nonblocking: Whether the caller should block until an event occurs.
>    */
> -int main_loop_wait(int nonblocking);
> +void main_loop_wait(int nonblocking);
>   
>   /**
>    * qemu_get_aio_context: Return the main loop's AioContext
> diff --git a/util/main-loop.c b/util/main-loop.c
> index 19cad6b..0b25405 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -487,7 +487,7 @@ static int os_host_main_loop_wait(int64_t timeout)
>   }
>   #endif
>   
> -int main_loop_wait(int nonblocking)
> +void main_loop_wait(int nonblocking)
>   {
>       int ret;
>       uint32_t timeout = UINT32_MAX;
> @@ -500,9 +500,7 @@ int main_loop_wait(int nonblocking)
>       /* poll any events */
>       g_array_set_size(gpollfds, 0); /* reset for new iteration */
>       /* XXX: separate device handlers from system ones */
> -#ifdef CONFIG_SLIRP
>       slirp_pollfds_fill(gpollfds, &timeout);
> -#endif
>   
>       if (timeout == UINT32_MAX) {
>           timeout_ns = -1;
> @@ -515,16 +513,14 @@ int main_loop_wait(int nonblocking)
>                                             &main_loop_tlg));
>   
>       ret = os_host_main_loop_wait(timeout_ns);
> -#ifdef CONFIG_SLIRP
>       slirp_pollfds_poll(gpollfds, (ret < 0));
> -#endif
>   
>       /* CPU thread can infinitely wait for event after
>          missing the warp */
>       qemu_start_warp_timer();
>       qemu_clock_run_all_timers();
>   
> -    return ret;
> +    return;

drop this return?

>   }
>   
>   /* Functions to operate on the main QEMU AioContext.  */
> 
