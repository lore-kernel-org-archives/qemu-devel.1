Received: from eggs.gnu.org ([2001:4830:134:3::10]:57459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEvXD-0004KP-TS
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEvX6-0006LW-NB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:11:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEvWy-0006D7-TM
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:11:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so1523336wma.4
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 05:11:27 -0700 (PDT)
References: <1540288688-4482-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540288688-4482-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bcd08f73-af75-b66d-c97c-be93317bbc60@redhat.com>
Date: Tue, 23 Oct 2018 14:11:25 +0200
MIME-Version: 1.0
In-Reply-To: <1540288688-4482-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] linux-user: Add support for
 semtimedop() syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, riku.voipio@iki.fi, ysu@wavecomp.com, laurent@vivier.eu, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, aurelien@aurel32.net

Hi Aleksandar,

On 23/10/18 11:58, Aleksandar Markovic wrote:
> From: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> 
> Add support for semtimedop() emulation.
> 
> Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   linux-user/syscall.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b8435f2..4b00b72 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6162,7 +6162,29 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
>       return 0;
>   }
>   #endif
> +#ifdef TARGET_NR_semtimedop
> +static inline abi_long do_semtimedop(int semid, abi_long ptr, unsigned nsops,
> +                                     abi_long timeout)
> +{
> +    struct sembuf sops[nsops];

'nsops' is user controlled, so it can overflow the stack.

> +    struct timespec ts, *pts;
> +
> +    if (timeout) {
> +        pts = &ts;
> +        if (target_to_host_timespec(pts, timeout)) {
> +            return -TARGET_EFAULT;
> +        }
> +    } else {
> +        pts = NULL;
> +    }
>   
> +    if (target_to_host_sembuf(sops, ptr, nsops)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    return get_errno(semtimedop(semid, sops, nsops, pts));
> +}
> +#endif
>   /* ??? Using host futex calls even when target atomic operations
>      are not really atomic probably breaks things.  However implementing
>      futexes locally would make futexes shared between multiple processes
> @@ -8661,6 +8683,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>       case TARGET_NR_semget:
>           return get_errno(semget(arg1, arg2, arg3));
>   #endif
> +#ifdef TARGET_NR_semtimedop
> +    case TARGET_NR_semtimedop:
> +        ret = do_semtimedop(arg1, arg2, arg3, arg4);
> +        break;
> +#endif
>   #ifdef TARGET_NR_semop
>       case TARGET_NR_semop:
>           return do_semop(arg1, arg2, arg3);
> 
