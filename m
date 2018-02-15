Received: from eggs.gnu.org ([2001:4830:134:3::10]:44786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJeH-0002G3-OS
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJeD-0002ws-LZ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:32:29 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:34945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emJeD-0002vx-CO
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:32:25 -0500
References: <20180211174704.27441-1-samuel.thibault@ens-lyon.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <db8f6563-1e53-2024-daf3-fbea2a204d36@vivier.eu>
Date: Thu, 15 Feb 2018 14:32:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180211174704.27441-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2] linux-user: Fix sched_getaffinity mask
 size
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

Le 11/02/2018 à 18:47, Samuel Thibault a écrit :
> We properly computed the capped mask size to be put to the application
> buffer, but didn't actually used it. Also, we need to return the capped mask
> size instead of 0 on success.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> ---
> Difference from v1:
> - simplify fix
> ---
>  linux-user/syscall.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 82b35a6bdf..bcda3362fc 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10493,7 +10493,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                      ret = arg2;
>                  }
>  
> -                ret = host_to_target_cpu_mask(mask, mask_size, arg3, arg2);
> +                if (host_to_target_cpu_mask(mask, mask_size, arg3, ret)) {
> +                    goto efault;
> +                }
>              }
>          }
>          break;
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
