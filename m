Received: from eggs.gnu.org ([2001:4830:134:3::10]:40076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTZk-00089B-Bu
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTZf-0007os-6e
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:56:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHTZe-0007hk-UN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:56:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so11672344wma.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 05:56:36 -0700 (PDT)
References: <1540899411-16761-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540899411-16761-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <95050205-8dbe-cf95-61c5-25e8d3b55817@redhat.com>
Date: Tue, 30 Oct 2018 13:56:32 +0100
MIME-Version: 1.0
In-Reply-To: <1540899411-16761-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] target/mips: Enable only tested
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

On 30/10/18 12:36, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Enable MIPS 032 user mode for R5900.
> 
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
> +#if defined(CONFIG_USER_ONLY)

Can you explain this change in the commit message? I don't understand 
why you want to disable this CPU.

I'm currently running few asm tests with:

$ qemu-system-mips64 -machine mipssim -cpu R5900 -bios tx79_test.bin

(I use mipssim because I don't care about devices, but I'm trying to 
test priviledged instructions).

> +#if !defined(TARGET_MIPS64)

Ditto... Why? This cpu is 64-bit.

>       {
>           .name = "R5900",
>           .CP0_PRid = 0x00002E00,
> @@ -457,6 +459,8 @@ const mips_def_t mips_defs[] =
>           .insn_flags = CPU_R5900 | ASE_MMI,
>           .mmu_type = MMU_TYPE_R4000,
>       },
> +#endif
> +#endif
>       {
>           /* A generic CPU supporting MIPS32 Release 6 ISA.
>              FIXME: Support IEEE 754-2008 FP.
> 
