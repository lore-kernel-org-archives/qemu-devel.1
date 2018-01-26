Received: from eggs.gnu.org ([2001:4830:134:3::10]:35543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1efAi7-0004eX-2d
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 15:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1efAi3-0004BK-Tw
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 15:34:55 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1efAi3-00047V-Jv
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 15:34:51 -0500
References: <20180126183636.7586-1-samuel.thibault@ens-lyon.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <11f250c0-ce8e-3529-bbf2-d6275e0c1747@vivier.eu>
Date: Fri, 26 Jan 2018 21:34:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180126183636.7586-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix sched_getaffinity mask size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 26/01/2018 à 19:36, Samuel Thibault a écrit :
> We properly computed the capped mask size to be put to the application
> buffer, but didn't actually it. Also, we need to return the capped mask
> size instead of 0 on success.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>  linux-user/syscall.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 74378947f0..cf2369aac2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10496,10 +10496,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                          ret = -TARGET_EINVAL;
>                          break;
>                      }
> -                    ret = arg2;
> +                } else if (arg2 > ret) {
> +                    arg2 = ret;
>                  }
>  
>                  ret = host_to_target_cpu_mask(mask, mask_size, arg3, arg2);
> +
> +                if (ret == 0) {
> +                    ret = arg2;
> +                }
>              }
>          }
>          break;
> 

Modified code was:

    if (copy_to_user(arg3, mask, ret)) {
        goto efault;
    }

so the change should only be:

    if (host_to_target_cpu_mask(mask, mask_size, arg3, ret)) {
        goto efault;
    }

Thanks,
Laurent
