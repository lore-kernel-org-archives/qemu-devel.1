Received: from eggs.gnu.org ([2001:4830:134:3::10]:39328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eUcK8-0000iy-LD
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eUcK5-0005pH-3b
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:50:32 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:60800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eUcK4-0005oA-IO
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:50:28 -0500
References: <20171228141104.15198-1-samuel.thibault@ens-lyon.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <189dec5d-6408-31d6-1df8-52e3397c8a98@vivier.eu>
Date: Thu, 28 Dec 2017 18:50:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171228141104.15198-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix sched_get/setaffinity
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Le 28/12/2017 à 15:11, Samuel Thibault a écrit :
> sched_get/setaffinity linux-user syscalls were missing conversions for
> little/big endian, which is hairy since longs may not be the same size
> either.
> 
> For simplicity, this just introduces loops to convert bit by bit like is
> done for select.
> 

I think you should introduce two new functions:
target_to_host_cpu_mask()/host_to_target_cpu_mask().

> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  linux-user/syscall.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 11c9116c4a..8ec7de96ce 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10341,6 +10341,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>          {
>              unsigned int mask_size;
>              unsigned long *mask;
> +            abi_ulong *abimask;
> +            unsigned i, j;
>  
>              /*
>               * sched_getaffinity needs multiples of ulong, so need to take
> @@ -10353,6 +10355,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              mask_size = (arg2 + (sizeof(*mask) - 1)) & ~(sizeof(*mask) - 1);
>  
>              mask = alloca(mask_size);
> +            memset(mask, 0, mask_size);
>              ret = get_errno(sys_sched_getaffinity(arg1, mask_size, mask));
>  
>              if (!is_error(ret)) {
> @@ -10372,9 +10375,27 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                      ret = arg2;
>                  }
>  
> -                if (copy_to_user(arg3, mask, ret)) {
> +                abimask = lock_user(VERIFY_WRITE, arg3, arg2, 0);
> +                if (!abimask) {
>                      goto efault;
>                  }
> +
> +                for (i = 0 ; i < arg2 / sizeof(abi_ulong); i++) {
> +                    unsigned abi_ubits = sizeof(abi_ulong) * 8;
> +                    unsigned ubits = sizeof(*mask) * 8;
> +                    unsigned bit = i * abi_ubits;
> +                    abi_ulong val = 0;
> +
> +                    for (j = 0; j < abi_ubits; j++, bit++) {
> +                        if (mask[bit / ubits] & (1UL << (bit % ubits))) {

You should use __CPUMASK() and introduce a TARGET_CPUMASK().

Thanks,
Laurent
