Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBE4C33CA2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6770420684
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUKZEyiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6770420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZgvQ-0001xX-GR
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 14:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZgsv-0000Um-6d
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZgss-0001NN-8S
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:52:28 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZgss-0001Mm-32
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:52:26 -0500
Received: by mail-oi1-x241.google.com with SMTP id v138so17821454oif.6
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5g2exnkpDOoziWdBedW6WiCSWuC2m55PPo6/JR03IAc=;
 b=kUKZEyiRYHn1f8nCEdVgkW5Zt5uoSHHaY7zpSgjnU0AgWSo3vcHFizkZLzlojuGR9V
 eC5MoSUz8ygu4DNnm4dRaWUyFmUKxn/LF8Nktf3F5tuQm2KNF+d4IoTdIP9pyaD8hxKU
 M54j2N6J+iXg5O7iuhr2/lcEdaB0ZJx5FJ/h8AG6i1yxvxiqFFp1bC/+syCOympbAOSA
 z0TAKeIHnZo+Hg/x8lkL/vjsEU6Xwf4ef0SYAoi283TzjEI2WvMthOSbFkKE5Mk4Buyn
 ataT3o9C/z155e/c8UHupd6KRwE+4JsSx37AMV1RRHFNMF3i8NszLUmz4x21/hy1wu3+
 jLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5g2exnkpDOoziWdBedW6WiCSWuC2m55PPo6/JR03IAc=;
 b=MGIvwt6AZi0U5JjNIaTXhQ+DTlwhmgN92LAl9P7nBB+hYRJK+RBCIf0icqgC0Xpzad
 XoVnfueEXTO3cZid3LEKIDyzxhz3jXvO94MB9qmcVa/Rz7jhNlIO0eKx9CkmRX4O24k5
 TuSR3MEecEGIszC7IMbLWFX/xUrxjpxOiDYQgpnnM/flJN81hDhtXXj4fvccFsUYMpVM
 gIQ7a3AVprBwtERooX5YpD5+5SrP5wygZgsotz9vw+7KSEB++WzAQWQ8tvPM6s0F3xxy
 qu1JyNjIeQVDMDoFsf/A+9JBg6vUL0fhnjhlmK78l7tan6oDBGSplyl10y3mrcB20myz
 PwhQ==
X-Gm-Message-State: APjAAAWFlgpehNz/1FQO3LHgOuL5n4pwGqOZYPdtGMXDSZFNtPdrCt5x
 PfEsrmuolwXZ8E9+osLvwaCTgoQ32XsMudh/to0F7w==
X-Google-Smtp-Source: APXvYqw8VJ6CqPAR6hL5ZS6VgP9jy0gxCE2ixO6bTIa10Dvnw7cleY2NXUdmPgtdYXcK7pV44hlfF+4gwVvZw0vqVS0=
X-Received: by 2002:aca:6287:: with SMTP id w129mr646404oib.106.1574797945078; 
 Tue, 26 Nov 2019 11:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-11-mrolnik@gmail.com>
In-Reply-To: <20191124050225.30351-11-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 26 Nov 2019 20:52:14 +0100
Message-ID: <CAL1e-=jGAd9ENuoDvcx7E64zBFhKn45=xpP6t+a8kVJfnPcUFQ@mail.gmail.com>
Subject: Re: [PATCH v36 10/17] target/avr: Add instruction disassembly function
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 24, 2019 at 6:03 AM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> Provide function disassembles executed instruction when `-d in_asm` is
> provided
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  target/avr/cpu.h       |   1 +
>  target/avr/cpu.c       |   2 +-
>  target/avr/disas.c     | 214 +++++++++++++++++++++++++++++++++++++++++
>  target/avr/translate.c |  11 +++
>  4 files changed, 227 insertions(+), 1 deletion(-)
>  create mode 100644 target/avr/disas.c
>
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index ed9218af5f..574118beab 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -157,6 +157,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +int avr_print_insn(bfd_vma addr, disassemble_info *info);
>
>  static inline int avr_feature(CPUAVRState *env, int feature)
>  {
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index dae56d7845..52ec21dd16 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *cs)
>  static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
>  {
>      info->mach = bfd_arch_avr;
> -    info->print_insn = NULL;
> +    info->print_insn = avr_print_insn;
>  }
>
>  static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
> diff --git a/target/avr/disas.c b/target/avr/disas.c
> new file mode 100644
> index 0000000000..727fc463ce
> --- /dev/null
> +++ b/target/avr/disas.c
> @@ -0,0 +1,214 @@
> +/*
> + * OpenRISC disassembler
> + *
> + * Copyright (c) 2018 Richard Henderson <rth@twiddle.net>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "disas/dis-asm.h"
> +#include "qemu/bitops.h"
> +#include "cpu.h"
> +
> +typedef struct {
> +    disassemble_info *info;
> +    uint16_t next_word;
> +    bool next_word_used;
> +} DisasContext;
> +
> +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }
> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
> +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) * 2; }
> +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }
> +

Is there any better way for naming these four function than
meaningless to_A, to_B, to_C, to_D?

Aleksandar

> +static uint16_t next_word(DisasContext *ctx)
> +{
> +    ctx->next_word_used = true;
> +    return ctx->next_word;
> +}
> +
> +static int append_16(DisasContext *ctx, int x)
> +{
> +    return x << 16 | next_word(ctx);
> +}
> +
> +
> +/* Include the auto-generated decoder.  */
> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
> +#include "decode_insn.inc.c"
> +
> +#define output(mnemonic, format, ...) \
> +    (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format, \
> +                        mnemonic, ##__VA_ARGS__))
> +
> +int avr_print_insn(bfd_vma addr, disassemble_info *info)
> +{
> +    DisasContext ctx;
> +    DisasContext *pctx = &ctx;
> +    bfd_byte buffer[4];
> +    uint16_t insn;
> +    int status;
> +
> +    ctx.info = info;
> +
> +    status = info->read_memory_func(addr, buffer, 4, info);
> +    if (status != 0) {
> +        info->memory_error_func(status, addr, info);
> +        return -1;
> +    }
> +    insn = bfd_getl16(buffer);
> +    ctx.next_word = bfd_getl16(buffer + 2);
> +    ctx.next_word_used = false;
> +
> +    if (!decode_insn(&ctx, insn)) {
> +        output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
> +    }
> +
> +    return ctx.next_word_used ? 4 : 2;
> +}
> +
> +
> +#define INSN(opcode, format, ...)                                       \
> +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)        \
> +{                                                                       \
> +    output(#opcode, format, ##__VA_ARGS__);                             \
> +    return true;                                                        \
> +}
> +
> +#define INSN_MNEMONIC(opcode, mnemonic, format, ...)                    \
> +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)        \
> +{                                                                       \
> +    output(mnemonic, format, ##__VA_ARGS__);                            \
> +    return true;                                                        \
> +}
> +
> +/*
> + *   C       Z       N       V       S       H       T       I
> + *   0       1       2       3       4       5       6       7
> + */
> +static const char *brbc[] = {
> +    "BRCC", "BRNE", "BRPL", "BRVC", "BRGE", "BRHC", "BRTC", "BRID"
> +};
> +
> +static const char *brbs[] = {
> +    "BRCS", "BREQ", "BRMI", "BRVS", "BRLT", "BRHS", "BRTS", "BRIE"
> +};
> +
> +static const char *bset[] = {
> +    "SEC",  "SEZ",  "SEN",  "SEZ",  "SES",  "SEH",  "SET",  "SEI"
> +};
> +
> +static const char *bclr[] = {
> +    "CLC",  "CLZ",  "CLN",  "CLZ",  "CLS",  "CLH",  "CLT",  "CLI"
> +};
> +
> +INSN(ADC,    "r%d, r%d", a->rd, a->rr)
> +INSN(ADD,    "r%d, r%d", a->rd, a->rr)
> +INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)
> +INSN(AND,    "r%d, r%d", a->rd, a->rr)
> +INSN(ANDI,   "r%d, %d", a->rd, a->imm)
> +INSN(ASR,    "r%d", a->rd)
> +INSN_MNEMONIC(BCLR,  bclr[a->bit], "")
> +INSN(BLD,    "r%d, %d", a->rd, a->bit)
> +INSN_MNEMONIC(BRBC,  brbc[a->bit], ".%+d", a->imm * 2)
> +INSN_MNEMONIC(BRBS,  brbs[a->bit], ".%+d", a->imm * 2)
> +INSN(BREAK,  "")
> +INSN_MNEMONIC(BSET,  bset[a->bit], "")
> +INSN(BST,    "r%d, %d", a->rd, a->bit)
> +INSN(CALL,   "0x%x", a->imm * 2)
> +INSN(CBI,    "%d, %d", a->reg, a->bit)
> +INSN(COM,    "r%d", a->rd)
> +INSN(CP,     "r%d, r%d", a->rd, a->rr)
> +INSN(CPC,    "r%d, r%d", a->rd, a->rr)
> +INSN(CPI,    "r%d, %d", a->rd, a->imm)
> +INSN(CPSE,   "r%d, r%d", a->rd, a->rr)
> +INSN(DEC,    "r%d", a->rd)
> +INSN(DES,    "%d", a->imm)
> +INSN(EICALL, "")
> +INSN(EIJMP,  "")
> +INSN(ELPM1,  "")
> +INSN(ELPM2,  "r%d, Z", a->rd)
> +INSN(ELPMX,  "r%d, Z+", a->rd)
> +INSN(EOR,    "r%d, r%d", a->rd, a->rr)
> +INSN(FMUL,   "r%d, r%d", a->rd, a->rr)
> +INSN(FMULS,  "r%d, r%d", a->rd, a->rr)
> +INSN(FMULSU, "r%d, r%d", a->rd, a->rr)
> +INSN(ICALL,  "")
> +INSN(IJMP,   "")
> +INSN(IN,     "r%d, $%d", a->rd, a->imm)
> +INSN(INC,    "r%d", a->rd)
> +INSN(JMP,    "0x%x", a->imm * 2)
> +INSN(LAC,    "Z, r%d", a->rd)
> +INSN(LAS,    "Z, r%d", a->rd)
> +INSN(LAT,    "Z, r%d", a->rd)
> +INSN(LDDY,   "r%d, Y+%d", a->rd, a->imm)
> +INSN(LDDZ,   "r%d, Z+%d", a->rd, a->imm)
> +INSN(LDI,    "r%d, %d", a->rd, a->imm)
> +INSN(LDS,    "r%d, %d", a->rd, a->imm)
> +INSN(LDX1,   "r%d, X", a->rd)
> +INSN(LDX2,   "r%d, X+", a->rd)
> +INSN(LDX3,   "r%d, -X", a->rd)
> +INSN(LDY2,   "r%d, Y+", a->rd)
> +INSN(LDY3,   "r%d, -Y", a->rd)
> +INSN(LDZ2,   "r%d, Z+", a->rd)
> +INSN(LDZ3,   "r%d, -Z", a->rd)
> +INSN(LPM1,   "")
> +INSN(LPM2,   "r%d, Z", a->rd)
> +INSN(LPMX,   "r%d, Z+", a->rd)
> +INSN(LSR,    "r%d", a->rd)
> +INSN(MOV,    "r%d, r%d", a->rd, a->rr)
> +INSN(MOVW,   "r%d:r%d, r%d,r:r%d", a->rd + 1, a->rd, a->rr + 1, a->rr)
> +INSN(MUL,    "r%d, r%d", a->rd, a->rr)
> +INSN(MULS,   "r%d, r%d", a->rd, a->rr)
> +INSN(MULSU,  "r%d, r%d", a->rd, a->rr)
> +INSN(NEG,    "r%d", a->rd)
> +INSN(NOP,    "")
> +INSN(OR,     "r%d, r%d", a->rd, a->rr)
> +INSN(ORI,    "r%d, %d", a->rd, a->imm)
> +INSN(OUT,    "$%d, r%d", a->imm, a->rd)
> +INSN(POP,    "r%d", a->rd)
> +INSN(PUSH,   "r%d", a->rd)
> +INSN(RCALL,  ".%+d", a->imm * 2)
> +INSN(RET,    "")
> +INSN(RETI,   "")
> +INSN(RJMP,   ".%+d", a->imm * 2)
> +INSN(ROR,    "r%d", a->rd)
> +INSN(SBC,    "r%d, r%d", a->rd, a->rr)
> +INSN(SBCI,   "r%d, %d", a->rd, a->imm)
> +INSN(SBI,    "$%d, %d", a->reg, a->bit)
> +INSN(SBIC,   "$%d, %d", a->reg, a->bit)
> +INSN(SBIS,   "$%d, %d", a->reg, a->bit)
> +INSN(SBIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
> +INSN(SBRC,   "r%d, %d", a->rr, a->bit)
> +INSN(SBRS,   "r%d, %d", a->rr, a->bit)
> +INSN(SLEEP,  "")
> +INSN(SPM,    "")
> +INSN(SPMX,   "Z+")
> +INSN(STDY,   "r%d, Y+%d", a->rd, a->imm)
> +INSN(STDZ,   "r%d, Z+%d", a->rd, a->imm)
> +INSN(STS,    "r%d, %d", a->rd, a->imm)
> +INSN(STX1,   "r%d, X", a->rr)
> +INSN(STX2,   "r%d, X+", a->rr)
> +INSN(STX3,   "r%d, -X", a->rr)
> +INSN(STY2,   "r%d, Y+", a->rd)
> +INSN(STY3,   "r%d, -Y", a->rd)
> +INSN(STZ2,   "r%d, Z+", a->rd)
> +INSN(STZ3,   "r%d, -Z", a->rd)
> +INSN(SUB,    "r%d, r%d", a->rd, a->rr)
> +INSN(SUBI,   "r%d, %d", a->rd, a->imm)
> +INSN(SWAP,   "r%d", a->rd)
> +INSN(WDR,    "")
> +INSN(XCH,    "Z, r%d", a->rd)
> +
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index fdf4e11f58..0446009d68 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -3019,6 +3019,17 @@ done_generating:
>
>      tb->size = (ctx.npc - pc_start) * 2;
>      tb->icount = num_insns;
> +
> +#ifdef DEBUG_DISAS
> +    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
> +        && qemu_log_in_addr_range(tb->pc)) {
> +        qemu_log_lock();
> +        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
> +        log_target_disas(cs, tb->pc, tb->size);
> +        qemu_log("\n");
> +        qemu_log_unlock();
> +    }
> +#endif
>  }
>
>  void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
> --
> 2.17.2 (Apple Git-113)
>

