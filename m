Received: from eggs.gnu.org ([2001:4830:134:3::10]:35330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHXPD-0007C1-Sd
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHXP8-0008GP-06
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:02:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHXP7-0008Fh-PT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:02:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so13425006wrw.8
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 10:02:09 -0700 (PDT)
References: <1540914249-3392-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540914249-3392-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bd184613-b6c5-57c8-6c7d-bea5feb283eb@redhat.com>
Date: Tue, 30 Oct 2018 18:02:05 +0100
MIME-Version: 1.0
In-Reply-To: <1540914249-3392-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] target/mips: Enable only tested
 modes for R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: smarkovic@wavecomp.com, pjovanovic@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

Hi Aleksandar,

On 30/10/18 16:44, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Enable MIPS 032 user mode for R5900.
> 
> Expose to end-user only features that make sense and are appropriately
> tested. In this case, enable only MIPS 032 user mode for R5900.
> 
> About defined(CONFIG_USER_ONLY), it is just because a reasonable
> testing was not provided for system mode. Some reasonable
> ("acceptance") testing should be done, and made available
> to others. A system image, kernel, and command line + plus
> some relatively mild testing of system mode should suffice.
> 
> About !defined(TARGET_MIPS64), this is because O32 is the only
> supported user-mode ABI for this CPU.
> 
> Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   target/mips/translate_init.inc.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
> index cab2003..d84c58e 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -410,6 +410,8 @@ const mips_def_t mips_defs[] =
>           .insn_flags = CPU_MIPS32R5 | ASE_MSA,
>           .mmu_type = MMU_TYPE_R4000,
>       },

Do you mind adding those one line comment when applying this series?
(no need to respin IMHO):

> +#if defined(CONFIG_USER_ONLY)

   #if defined(CONFIG_USER_ONLY) /* System mode not implemented */

> +#if !defined(TARGET_MIPS64)

   #if !defined(TARGET_MIPS64) /* Only O32 user-mode ABI is supported */

>       {
>           .name = "R5900",
>           .CP0_PRid = 0x00002E00,
> @@ -457,6 +459,8 @@ const mips_def_t mips_defs[] =
>           .insn_flags = CPU_R5900 | ASE_MMI,
>           .mmu_type = MMU_TYPE_R4000,
>       },
> +#endif
> +#endif

I'm not super happy with this patch but as you said it is reasonable, so 
I accept it (Thanks for the comments btw).

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>       {
>           /* A generic CPU supporting MIPS32 Release 6 ISA.
>              FIXME: Support IEEE 754-2008 FP.
> 
