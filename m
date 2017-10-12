Received: from eggs.gnu.org ([2001:4830:134:3::10]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e2ggZ-0007Eb-Q3
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e2ggW-0007S0-C4
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:50:15 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1e2ggQ-0007It-IC
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:50:12 -0400
References: <1507822245-15748-1-git-send-email-peter.maydell@linaro.org>
	<1507822245-15748-3-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b5d3e2e6-31c0-0496-bfee-3baad5d571f9@vivier.eu>
Date: Thu, 12 Oct 2017 18:49:55 +0200
MIME-Version: 1.0
In-Reply-To: <1507822245-15748-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: Fix
 TARGET_MTIOCTOP/MTIOCGET/MTIOCPOS values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, pgndev <pgnet.dev@gmail.com>

Le 12/10/2017 à 17:30, Peter Maydell a écrit :
> The TARGET_MTIOCTOP/TARGET_MTIOCGET/TARGET_MTIOCPOS values
> were being defined in terms of host struct types, but
> these structures are such that their size might differ
> on different hosts. Switch to using a target struct
> definition instead.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/syscall_defs.h | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index f7cc9f9..16d56fa 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2706,9 +2706,34 @@ struct target_f_owner_ex {
>  #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
>  #define TARGET_VFAT_IOCTL_READDIR_SHORT   TARGET_IORU('r', 2)
>  
> -#define TARGET_MTIOCTOP        TARGET_IOW('m', 1, struct mtop)
> -#define TARGET_MTIOCGET        TARGET_IOR('m', 2, struct mtget)
> -#define TARGET_MTIOCPOS        TARGET_IOR('m', 3, struct mtpos)
> +struct target_mtop {
> +    abi_short mt_op;
> +    abi_int mt_count;
> +};
> +
> +#if defined(TARGET_SPARC) || defined(TARGET_MIPS)
> +typedef abi_long target_kernel_daddr_t;
> +#else
> +typedef abi_int target_kernel_daddr_t;
> +#endif

Perhaps you can add these ones into include/exec/user/abitypes.h ?

> +struct target_mtget {
> +    abi_long mt_type;
> +    abi_long mt_resid;
> +    abi_long mt_dsreg;
> +    abi_long mt_gstat;
> +    abi_long mt_erreg;
> +    target_kernel_daddr_t mt_fileno;
> +    target_kernel_daddr_t mt_blkno;
> +};

I think you need to update STRUCT(mtget, ...) in
linux-user/syscall_types.h to reflect the size difference for MIPS and
SPARC.

Thanks,
Laurent
