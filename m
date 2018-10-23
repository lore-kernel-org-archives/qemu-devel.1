Received: from eggs.gnu.org ([2001:4830:134:3::10]:57271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gF141-0001W7-O0
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 14:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gF13y-0005Xw-V0
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 14:05:57 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gF13y-0005Gv-Kd
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 14:05:54 -0400
References: <1540300056-7935-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540300056-7935-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <73c93e70-997e-7ec0-0814-ee2f491d933c@vivier.eu>
Date: Tue, 23 Oct 2018 19:04:24 +0100
MIME-Version: 1.0
In-Reply-To: <1540300056-7935-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] linux-user: Add support for
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
Cc: aurelien@aurel32.net, arikalo@wavecomp.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, ysu@wavecomp.com

On 23/10/2018 14:07, Aleksandar Markovic wrote:
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Add support for semtimedop() emulation.
> 
> Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/syscall.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8b01ab0..e722ba8 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6162,7 +6162,29 @@ static inline abi_long host_to_target_stat64(void *cpu_env,
>      return 0;
>  }
>  #endif
> +#ifdef TARGET_NR_semtimedop
> +static inline abi_long do_semtimedop(int semid, abi_long ptr, unsigned nsops,
> +                                     abi_long timeout)
> +{
> +    struct sembuf sops[nsops];
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

The current function do_semop() actually uses a safe_semtimedop() with a
NULL timeout pointer. Perhaps you can change/rename this function to
take the timeout pointer and convert it, and use it for TARGET_NR_semop
with NULL timeout pointer and with TARGET_NR_semtimeop with the pointer
to the target timeout.

And agree with Philippe, I think it's a good opportunity to replace the
stack allocated structure by a g_mallocated_one()

Thanks,
Laurent
