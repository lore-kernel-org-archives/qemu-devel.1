Received: from eggs.gnu.org ([2001:4830:134:3::10]:44963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ew93A-0006JE-J4
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ew935-0006WY-Jv
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:14:48 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49377)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ew935-0006W6-9U
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:14:43 -0400
References: <20180314153121.23838-1-james.cowgill@mips.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <46dbae6e-4ff6-5003-e8e6-175bf0fbd51f@vivier.eu>
Date: Wed, 14 Mar 2018 17:13:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180314153121.23838-1-james.cowgill@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: implement HWCAP bits on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Cowgill <james.cowgill@mips.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Le 14/03/2018 à 16:31, James Cowgill a écrit :
> Add support for the two currently defined HWCAP bits on MIPS - R6 and
> MSA.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1754372
> Signed-off-by: James Cowgill <james.cowgill@mips.com>
> ---
> This was resent because I think I messed up my email config. Apologies if you
> receive this twice.
> 
>  linux-user/elfload.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 5fc130cc20..747b0ed10b 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -950,6 +950,30 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
>  #define USE_ELF_CORE_DUMP
>  #define ELF_EXEC_PAGESIZE        4096
>  
> +/* See arch/mips/include/uapi/hwcap.h.  */

in fact arch/mips/include/uapi/asm/hwcap.h

> +enum {
> +    HWCAP_MIPS_R6           = (1 << 0),
> +    HWCAP_MIPS_MSA          = (1 << 1),
> +};

We have this for ARM only in elfload.c since:

    afce2927aa Arm AT_HWCAP AUXV entry (Paul Brook) [2005]

but they have been added in include/elf.h since:

    41d9ea80ac tcg-arm: Use qemu_getauxval [Richard Henderson, 2013]

and I think we should remove them (they are prefixed by ARM_)

So the MIPS ones should be in include/elf.h (with the #define form).

Richard, any comment?

Thanks,
Laurent
