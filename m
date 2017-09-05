Received: from eggs.gnu.org ([2001:4830:134:3::10]:48755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpCyF-00066r-EV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpCyA-0005UL-Ly
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:28:47 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:38426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpCyA-0005TF-Fp
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:28:42 -0400
Received: by mail-wr0-x236.google.com with SMTP id 108so8361449wra.5
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 05:28:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170828221901.12827-1-portia.stephens@xilinx.com>
References: <20170828221901.12827-1-portia.stephens@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 13:28:20 +0100
Message-ID: <CAFEAcA-5tT6X=N7UOiYMecN-OnxOfDAfoGswa01QXCOt4JDWig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Remove 5J architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Portia Stephens <portia.stephens@xilinx.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, stephensportia@gmail.com, Alistair Francis <alistair.francis@xilinx.com>

On 28 August 2017 at 23:19, Portia Stephens <portia.stephens@xilinx.com> wrote:
> This fixes the issue that any BXJ instruction will result in an illegal_op.
> This is because the 5J archiecture is always unsupported.
> 5J architecture doesn't have a feature set and ENABLE_ARCH_5J is hardcoded
> to 0, causing any ARCH(5J) to result in an illegal_op. The only use of
> ARCH(5J) is in the BXJ instruction disassembly.
>
> This patch replaces that ARCH(5J) with ARCH(6) and removes the 5J architecture,
> this isn't technically correct since the v5J ISA does support the BXJ
> instruction. This change means that running a BXJ instruction on any v5 will
> cause an illegal_op but it is better than the current state where any
> architecture running a BXJ would cause an illegal_op. The correct solution
> would be to create a feature set for v5J but that doesn't seem worth it as the
> v5J is so old.
>
> Signed-off-by: Portia Stephens <portia.stephens@xilinx.com>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>  target/arm/translate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index d1a5f56998..4a30c0d7e0 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -41,7 +41,6 @@
>  #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
>  /* currently all emulated v5 cores are also v5TE, so don't bother */
>  #define ENABLE_ARCH_5TE   arm_dc_feature(s, ARM_FEATURE_V5)
> -#define ENABLE_ARCH_5J    0
>  #define ENABLE_ARCH_6     arm_dc_feature(s, ARM_FEATURE_V6)
>  #define ENABLE_ARCH_6K    arm_dc_feature(s, ARM_FEATURE_V6K)
>  #define ENABLE_ARCH_6T2   arm_dc_feature(s, ARM_FEATURE_THUMB2)
> @@ -8389,7 +8388,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>              break;
>          case 0x2:
>              if (op1 == 1) {
> -                ARCH(5J); /* bxj */
> +                /* This should actually be ARCH(5J) but there is currently no
> +                 * 5J architecture in QEMU.
> +                 */
> +                ARCH(6); /* bxj */
>                  /* Trivial implementation equivalent to bx.  */
>                  tmp = load_reg(s, rm);
>                  gen_bx(s, tmp);

Thanks for this patch. However we do have both v5-no-J
(arm946, all the pxa2xx cores) and v5-with-J CPUs (arm926, arm1026),
so I think it would be better to fix this bug by adding an
extra ARM_FEATURE_JAZELLE, which would be set in
arm_cpu_realizefn() if ARM_FEATURE_V6 is set, and set in
the per-core realize functions for arm926 and arm1026.
It should be a fairly small patch overall I think.

thanks
-- PMM
