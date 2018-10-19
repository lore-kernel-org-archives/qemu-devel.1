Received: from eggs.gnu.org ([2001:4830:134:3::10]:48716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gDTEb-00041y-HS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gDTEX-000454-5e
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:46:29 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gDTEW-0003vs-UQ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:46:25 -0400
Received: by mail-yb1-f196.google.com with SMTP id m184-v6so2034887ybm.0
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 04:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1539888473-16340-15-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539888473-16340-15-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Fri, 19 Oct 2018 13:46:09 +0200
Message-ID: <CAAdtpL5EsUj564MjVHCnfG67PpxSKnNaUnj3JkHo4skq4=7-wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 14/28] target/mips: Increase 'supported
 ISAs/ASEs' flag holder size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

Hi Aleksandar,

On Thu, Oct 18, 2018 at 9:20 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Increase the size of insn_flags holder size to 64 bits. This is
> needed for future extensions since existing bits are almost all used.
>

Why did you remove my S-o-b tag...?

> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/cpu.h       | 2 +-
>  target/mips/internal.h  | 2 +-
>  target/mips/translate.c | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 37703ea..3b3509c 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -811,7 +811,7 @@ struct CPUMIPSState {
>      int CCRes; /* Cycle count resolution/divisor */
>      uint32_t CP0_Status_rw_bitmask; /* Read/write bits in CP0_Status */
>      uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStatus=
 */
> -    int insn_flags; /* Supported instruction set */
> +    uint64_t insn_flags; /* Supported instruction set */
>
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index e41051f..bfe83ee 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -59,7 +59,7 @@ struct mips_def_t {
>      int32_t CP0_PageGrain_rw_bitmask;
>      int32_t CP0_PageGrain;
>      target_ulong CP0_EBaseWG_rw_bitmask;
> -    int insn_flags;
> +    uint64_t insn_flags;
>      enum mips_mmu_types mmu_type;
>  };
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index a309df7..c91c541 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1986,7 +1986,7 @@ typedef struct DisasContext {
>      target_ulong saved_pc;
>      target_ulong page_start;
>      uint32_t opcode;
> -    int insn_flags;
> +    uint64_t insn_flags;
>      int32_t CP0_Config1;
>      int32_t CP0_Config3;
>      int32_t CP0_Config5;
> @@ -2409,7 +2409,7 @@ static inline void check_dspr2(DisasContext *ctx)
>
>  /* This code generates a "reserved instruction" exception if the
>     CPU does not support the instruction set corresponding to flags. */
> -static inline void check_insn(DisasContext *ctx, int flags)
> +static inline void check_insn(DisasContext *ctx, uint64_t flags)
>  {
>      if (unlikely(!(ctx->insn_flags & flags))) {
>          generate_exception_end(ctx, EXCP_RI);
> @@ -2419,7 +2419,7 @@ static inline void check_insn(DisasContext *ctx, in=
t flags)
>  /* This code generates a "reserved instruction" exception if the
>     CPU has corresponding flag set which indicates that the instruction
>     has been removed. */
> -static inline void check_insn_opc_removed(DisasContext *ctx, int flags)
> +static inline void check_insn_opc_removed(DisasContext *ctx, uint64_t fl=
ags)
>  {
>      if (unlikely(ctx->insn_flags & flags)) {
>          generate_exception_end(ctx, EXCP_RI);
> --
> 2.7.4
>
>
