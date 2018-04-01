Received: from eggs.gnu.org ([2001:4830:134:3::10]:45482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2kAG-00035d-ED
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2kAC-0005pe-Gj
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:05:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:54929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f2kAC-0005o7-49
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 17:05:20 -0400
References: <20180401203739.31670-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <26d50d9e-20a4-08e5-a860-e0cae22efd29@vivier.eu>
Date: Sun, 1 Apr 2018 23:05:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180401203739.31670-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix error propagation in
 clock_gettime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 01/04/2018 à 22:37, Max Filippov a écrit :
> host_to_target_timespec may return error if target address could not be
> locked, but it is ignored.
> Propagate return value of host_to_target_timespec to the caller of
> clock_gettime.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d51e2a00ee31..52e2f9c16479 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11884,7 +11884,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>          struct timespec ts;
>          ret = get_errno(clock_gettime(arg1, &ts));
>          if (!is_error(ret)) {
> -            host_to_target_timespec(arg2, &ts);
> +            ret = host_to_target_timespec(arg2, &ts);
>          }
>          break;
>      }
> 

Could you also update in the same way clock_getres?

There are other syscalls ignoring result of host_to_target_timespec(),
but they are also ignoring result of target_to_host_timespec, but I
don't think the -rc stage is the good moment to fix them all.

Thanks,
Laurent
