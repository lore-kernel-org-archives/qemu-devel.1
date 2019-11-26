Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC20C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C6B20684
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcecDzFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C6B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZhYK-0005AS-Rt
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 15:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iZhX5-0004XN-UT
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iZhX2-0001uA-OQ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:33:59 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:41429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iZhX2-0001tn-Hz
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:33:56 -0500
Received: by mail-qt1-x844.google.com with SMTP id 59so17377925qtg.8
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 12:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vCtxf/KHgWrqZKNkQt+yzx/xpWWipgFGv1oJLq8o+rI=;
 b=WcecDzFpMRDo01Y4X2FZ1HC9P8EEdj/bYrY3lY1gW0BoRWHa1pUFpvABUDnR/Y70N9
 LvUF/2Did2XcMIMHDdMV7wbMFU8c2+dilq6yu/fZrQchVzVzG4JVXMXNAc1vmZSLhEDz
 9UWH5VWVkXSyY+y76G0TPOLfu2Zt0Osj9HAEMCq1KGpoJMuzfHqxHH92gdnIAe0GzzRS
 lxRxNsmVPezXkQLWRvOT/VUaXd1W3nDm2scVS3vbONyf6FuOSdgis2kwoVLWxH/AE00L
 U6G4kWm5Wzm84MhQp+qcKlJ1FrJlUpYzANkCBJ1oCjMUnurLV3cwIZ/63raILcjop8d0
 3APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vCtxf/KHgWrqZKNkQt+yzx/xpWWipgFGv1oJLq8o+rI=;
 b=N2JKm/xUSqZrU96StRrLiRraDhNnanRugGh5VFs5qkH9KxgaeDZh729T8Ih8PCmELP
 1LoRKvoXGuc+29xvJMzt/873s5+a/JmRv2eZ4Dbz/jSQyy0BXZa2tP7nGPBhYnolySEh
 WaQE1eY2ly37su69QKsKZF4cBZPFNHOB6GloELjJkcUbgWSdt4mFdewwMK2hA4DurkNW
 twpEfCPn6VnQqPjVd27F8x17Q58Km6/TBOT/rZe+Qph0zDszgTFnXTF/rwi/EhLqj6rW
 3YpajObDsVrlCkUGvcyVUjSOHreZauVfFLJ/hffSa9oetD3deYfnLNlC5+memPbZ2wdY
 b/1A==
X-Gm-Message-State: APjAAAUoBN3kCbpNaM6Tc/hW1J99S5AqbGIGyyQvtpOAxae49bgfJn/O
 ogCzrrU770ar9xf1mwsyb+cK+Gw0tlgYhMLI17I=
X-Google-Smtp-Source: APXvYqz2BVw38mSXdXjxcLh9Kj2wbo9E/+lQlqxLdZpJqqWfOKdlRbfRAaCFTkEyEm39Qkwkrv3Un5w+cbHvErKwHuA=
X-Received: by 2002:aed:24d9:: with SMTP id u25mr37372062qtc.229.1574800435552; 
 Tue, 26 Nov 2019 12:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-11-mrolnik@gmail.com>
 <CAL1e-=jGAd9ENuoDvcx7E64zBFhKn45=xpP6t+a8kVJfnPcUFQ@mail.gmail.com>
In-Reply-To: <CAL1e-=jGAd9ENuoDvcx7E64zBFhKn45=xpP6t+a8kVJfnPcUFQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 26 Nov 2019 22:32:48 +0200
Message-ID: <CAK4993j9g4Q4pu=LsOTB2k9UaFhr632-1jrN8qO0RFsTbvMJ-Q@mail.gmail.com>
Subject: Re: [PATCH v36 10/17] target/avr: Add instruction disassembly function
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000008da688059845cceb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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

--0000000000008da688059845cceb
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 26, 2019 at 9:52 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

> On Sun, Nov 24, 2019 at 6:03 AM Michael Rolnik <mrolnik@gmail.com> wrote:
> >
> > Provide function disassembles executed instruction when `-d in_asm` is
> > provided
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > ---
> >  target/avr/cpu.h       |   1 +
> >  target/avr/cpu.c       |   2 +-
> >  target/avr/disas.c     | 214 +++++++++++++++++++++++++++++++++++++++++
> >  target/avr/translate.c |  11 +++
> >  4 files changed, 227 insertions(+), 1 deletion(-)
> >  create mode 100644 target/avr/disas.c
> >
> > diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> > index ed9218af5f..574118beab 100644
> > --- a/target/avr/cpu.h
> > +++ b/target/avr/cpu.h
> > @@ -157,6 +157,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu, int
> int_req);
> >  hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >  int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> >  int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> > +int avr_print_insn(bfd_vma addr, disassemble_info *info);
> >
> >  static inline int avr_feature(CPUAVRState *env, int feature)
> >  {
> > diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> > index dae56d7845..52ec21dd16 100644
> > --- a/target/avr/cpu.c
> > +++ b/target/avr/cpu.c
> > @@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *cs)
> >  static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info
> *info)
> >  {
> >      info->mach = bfd_arch_avr;
> > -    info->print_insn = NULL;
> > +    info->print_insn = avr_print_insn;
> >  }
> >
> >  static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
> > diff --git a/target/avr/disas.c b/target/avr/disas.c
> > new file mode 100644
> > index 0000000000..727fc463ce
> > --- /dev/null
> > +++ b/target/avr/disas.c
> > @@ -0,0 +1,214 @@
> > +/*
> > + * OpenRISC disassembler
> > + *
> > + * Copyright (c) 2018 Richard Henderson <rth@twiddle.net>
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "disas/dis-asm.h"
> > +#include "qemu/bitops.h"
> > +#include "cpu.h"
> > +
> > +typedef struct {
> > +    disassemble_info *info;
> > +    uint16_t next_word;
> > +    bool next_word_used;
> > +} DisasContext;
> > +
> > +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16);
> }
> > +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
> > +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) *
> 2; }
> > +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }
> > +
>
> Is there any better way for naming these four function than
> meaningless to_A, to_B, to_C, to_D?


> Aleksandar
>

if you look into insn.decode file you will see the following comment.
 #   A = [16 .. 31]
 #   B = [16 .. 23]
 #   C = [24, 26, 28, 30]
 #   D = [0, 2, 4, 6, 8, .. 30]

I can call them if you prefer
A is regs_16_to_31_by_one
B is regs_16_to_23_by_one
C is regs_24_to_30_by_two
D is regs_00_to_30_by_two



>
> > +static uint16_t next_word(DisasContext *ctx)
> > +{
> > +    ctx->next_word_used = true;
> > +    return ctx->next_word;
> > +}
> > +
> > +static int append_16(DisasContext *ctx, int x)
> > +{
> > +    return x << 16 | next_word(ctx);
> > +}
> > +
> > +
> > +/* Include the auto-generated decoder.  */
> > +static bool decode_insn(DisasContext *ctx, uint16_t insn);
> > +#include "decode_insn.inc.c"
> > +
> > +#define output(mnemonic, format, ...) \
> > +    (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format, \
> > +                        mnemonic, ##__VA_ARGS__))
> > +
> > +int avr_print_insn(bfd_vma addr, disassemble_info *info)
> > +{
> > +    DisasContext ctx;
> > +    DisasContext *pctx = &ctx;
> > +    bfd_byte buffer[4];
> > +    uint16_t insn;
> > +    int status;
> > +
> > +    ctx.info = info;
> > +
> > +    status = info->read_memory_func(addr, buffer, 4, info);
> > +    if (status != 0) {
> > +        info->memory_error_func(status, addr, info);
> > +        return -1;
> > +    }
> > +    insn = bfd_getl16(buffer);
> > +    ctx.next_word = bfd_getl16(buffer + 2);
> > +    ctx.next_word_used = false;
> > +
> > +    if (!decode_insn(&ctx, insn)) {
> > +        output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
> > +    }
> > +
> > +    return ctx.next_word_used ? 4 : 2;
> > +}
> > +
> > +
> > +#define INSN(opcode, format, ...)
>  \
> > +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)
> \
> > +{
>  \
> > +    output(#opcode, format, ##__VA_ARGS__);
>  \
> > +    return true;
> \
> > +}
> > +
> > +#define INSN_MNEMONIC(opcode, mnemonic, format, ...)
> \
> > +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)
> \
> > +{
>  \
> > +    output(mnemonic, format, ##__VA_ARGS__);
> \
> > +    return true;
> \
> > +}
> > +
> > +/*
> > + *   C       Z       N       V       S       H       T       I
> > + *   0       1       2       3       4       5       6       7
> > + */
> > +static const char *brbc[] = {
> > +    "BRCC", "BRNE", "BRPL", "BRVC", "BRGE", "BRHC", "BRTC", "BRID"
> > +};
> > +
> > +static const char *brbs[] = {
> > +    "BRCS", "BREQ", "BRMI", "BRVS", "BRLT", "BRHS", "BRTS", "BRIE"
> > +};
> > +
> > +static const char *bset[] = {
> > +    "SEC",  "SEZ",  "SEN",  "SEZ",  "SES",  "SEH",  "SET",  "SEI"
> > +};
> > +
> > +static const char *bclr[] = {
> > +    "CLC",  "CLZ",  "CLN",  "CLZ",  "CLS",  "CLH",  "CLT",  "CLI"
> > +};
> > +
> > +INSN(ADC,    "r%d, r%d", a->rd, a->rr)
> > +INSN(ADD,    "r%d, r%d", a->rd, a->rr)
> > +INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)
> > +INSN(AND,    "r%d, r%d", a->rd, a->rr)
> > +INSN(ANDI,   "r%d, %d", a->rd, a->imm)
> > +INSN(ASR,    "r%d", a->rd)
> > +INSN_MNEMONIC(BCLR,  bclr[a->bit], "")
> > +INSN(BLD,    "r%d, %d", a->rd, a->bit)
> > +INSN_MNEMONIC(BRBC,  brbc[a->bit], ".%+d", a->imm * 2)
> > +INSN_MNEMONIC(BRBS,  brbs[a->bit], ".%+d", a->imm * 2)
> > +INSN(BREAK,  "")
> > +INSN_MNEMONIC(BSET,  bset[a->bit], "")
> > +INSN(BST,    "r%d, %d", a->rd, a->bit)
> > +INSN(CALL,   "0x%x", a->imm * 2)
> > +INSN(CBI,    "%d, %d", a->reg, a->bit)
> > +INSN(COM,    "r%d", a->rd)
> > +INSN(CP,     "r%d, r%d", a->rd, a->rr)
> > +INSN(CPC,    "r%d, r%d", a->rd, a->rr)
> > +INSN(CPI,    "r%d, %d", a->rd, a->imm)
> > +INSN(CPSE,   "r%d, r%d", a->rd, a->rr)
> > +INSN(DEC,    "r%d", a->rd)
> > +INSN(DES,    "%d", a->imm)
> > +INSN(EICALL, "")
> > +INSN(EIJMP,  "")
> > +INSN(ELPM1,  "")
> > +INSN(ELPM2,  "r%d, Z", a->rd)
> > +INSN(ELPMX,  "r%d, Z+", a->rd)
> > +INSN(EOR,    "r%d, r%d", a->rd, a->rr)
> > +INSN(FMUL,   "r%d, r%d", a->rd, a->rr)
> > +INSN(FMULS,  "r%d, r%d", a->rd, a->rr)
> > +INSN(FMULSU, "r%d, r%d", a->rd, a->rr)
> > +INSN(ICALL,  "")
> > +INSN(IJMP,   "")
> > +INSN(IN,     "r%d, $%d", a->rd, a->imm)
> > +INSN(INC,    "r%d", a->rd)
> > +INSN(JMP,    "0x%x", a->imm * 2)
> > +INSN(LAC,    "Z, r%d", a->rd)
> > +INSN(LAS,    "Z, r%d", a->rd)
> > +INSN(LAT,    "Z, r%d", a->rd)
> > +INSN(LDDY,   "r%d, Y+%d", a->rd, a->imm)
> > +INSN(LDDZ,   "r%d, Z+%d", a->rd, a->imm)
> > +INSN(LDI,    "r%d, %d", a->rd, a->imm)
> > +INSN(LDS,    "r%d, %d", a->rd, a->imm)
> > +INSN(LDX1,   "r%d, X", a->rd)
> > +INSN(LDX2,   "r%d, X+", a->rd)
> > +INSN(LDX3,   "r%d, -X", a->rd)
> > +INSN(LDY2,   "r%d, Y+", a->rd)
> > +INSN(LDY3,   "r%d, -Y", a->rd)
> > +INSN(LDZ2,   "r%d, Z+", a->rd)
> > +INSN(LDZ3,   "r%d, -Z", a->rd)
> > +INSN(LPM1,   "")
> > +INSN(LPM2,   "r%d, Z", a->rd)
> > +INSN(LPMX,   "r%d, Z+", a->rd)
> > +INSN(LSR,    "r%d", a->rd)
> > +INSN(MOV,    "r%d, r%d", a->rd, a->rr)
> > +INSN(MOVW,   "r%d:r%d, r%d,r:r%d", a->rd + 1, a->rd, a->rr + 1, a->rr)
> > +INSN(MUL,    "r%d, r%d", a->rd, a->rr)
> > +INSN(MULS,   "r%d, r%d", a->rd, a->rr)
> > +INSN(MULSU,  "r%d, r%d", a->rd, a->rr)
> > +INSN(NEG,    "r%d", a->rd)
> > +INSN(NOP,    "")
> > +INSN(OR,     "r%d, r%d", a->rd, a->rr)
> > +INSN(ORI,    "r%d, %d", a->rd, a->imm)
> > +INSN(OUT,    "$%d, r%d", a->imm, a->rd)
> > +INSN(POP,    "r%d", a->rd)
> > +INSN(PUSH,   "r%d", a->rd)
> > +INSN(RCALL,  ".%+d", a->imm * 2)
> > +INSN(RET,    "")
> > +INSN(RETI,   "")
> > +INSN(RJMP,   ".%+d", a->imm * 2)
> > +INSN(ROR,    "r%d", a->rd)
> > +INSN(SBC,    "r%d, r%d", a->rd, a->rr)
> > +INSN(SBCI,   "r%d, %d", a->rd, a->imm)
> > +INSN(SBI,    "$%d, %d", a->reg, a->bit)
> > +INSN(SBIC,   "$%d, %d", a->reg, a->bit)
> > +INSN(SBIS,   "$%d, %d", a->reg, a->bit)
> > +INSN(SBIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
> > +INSN(SBRC,   "r%d, %d", a->rr, a->bit)
> > +INSN(SBRS,   "r%d, %d", a->rr, a->bit)
> > +INSN(SLEEP,  "")
> > +INSN(SPM,    "")
> > +INSN(SPMX,   "Z+")
> > +INSN(STDY,   "r%d, Y+%d", a->rd, a->imm)
> > +INSN(STDZ,   "r%d, Z+%d", a->rd, a->imm)
> > +INSN(STS,    "r%d, %d", a->rd, a->imm)
> > +INSN(STX1,   "r%d, X", a->rr)
> > +INSN(STX2,   "r%d, X+", a->rr)
> > +INSN(STX3,   "r%d, -X", a->rr)
> > +INSN(STY2,   "r%d, Y+", a->rd)
> > +INSN(STY3,   "r%d, -Y", a->rd)
> > +INSN(STZ2,   "r%d, Z+", a->rd)
> > +INSN(STZ3,   "r%d, -Z", a->rd)
> > +INSN(SUB,    "r%d, r%d", a->rd, a->rr)
> > +INSN(SUBI,   "r%d, %d", a->rd, a->imm)
> > +INSN(SWAP,   "r%d", a->rd)
> > +INSN(WDR,    "")
> > +INSN(XCH,    "Z, r%d", a->rd)
> > +
> > diff --git a/target/avr/translate.c b/target/avr/translate.c
> > index fdf4e11f58..0446009d68 100644
> > --- a/target/avr/translate.c
> > +++ b/target/avr/translate.c
> > @@ -3019,6 +3019,17 @@ done_generating:
> >
> >      tb->size = (ctx.npc - pc_start) * 2;
> >      tb->icount = num_insns;
> > +
> > +#ifdef DEBUG_DISAS
> > +    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
> > +        && qemu_log_in_addr_range(tb->pc)) {
> > +        qemu_log_lock();
> > +        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
> > +        log_target_disas(cs, tb->pc, tb->size);
> > +        qemu_log("\n");
> > +        qemu_log_unlock();
> > +    }
> > +#endif
> >  }
> >
> >  void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
> > --
> > 2.17.2 (Apple Git-113)
> >
>


-- 
Best Regards,
Michael Rolnik

--0000000000008da688059845cceb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 26, 2019 at 9:52 PM Aleks=
andar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksanda=
r.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On Sun, Nov 24, 2019 at 6:03 AM Michael Rolnik &lt;<a hre=
f=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; Provide function disassembles executed instruction when `-d in_asm` is=
<br>
&gt; provided<br>
&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br=
>
&gt;=C2=A0 target/avr/disas.c=C2=A0 =C2=A0 =C2=A0| 214 ++++++++++++++++++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 target/avr/translate.c |=C2=A0 11 +++<br>
&gt;=C2=A0 4 files changed, 227 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 create mode 100644 target/avr/disas.c<br>
&gt;<br>
&gt; diff --git a/target/avr/cpu.h b/target/avr/cpu.h<br>
&gt; index ed9218af5f..574118beab 100644<br>
&gt; --- a/target/avr/cpu.h<br>
&gt; +++ b/target/avr/cpu.h<br>
&gt; @@ -157,6 +157,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu, int int=
_req);<br>
&gt;=C2=A0 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);<b=
r>
&gt;=C2=A0 int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int r=
eg);<br>
&gt;=C2=A0 int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int =
reg);<br>
&gt; +int avr_print_insn(bfd_vma addr, disassemble_info *info);<br>
&gt;<br>
&gt;=C2=A0 static inline int avr_feature(CPUAVRState *env, int feature)<br>
&gt;=C2=A0 {<br>
&gt; diff --git a/target/avr/cpu.c b/target/avr/cpu.c<br>
&gt; index dae56d7845..52ec21dd16 100644<br>
&gt; --- a/target/avr/cpu.c<br>
&gt; +++ b/target/avr/cpu.c<br>
&gt; @@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *cs)<br>
&gt;=C2=A0 static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_in=
fo *info)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;mach =3D bfd_arch_avr;<br>
&gt; -=C2=A0 =C2=A0 info-&gt;print_insn =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 info-&gt;print_insn =3D avr_print_insn;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static void avr_cpu_realizefn(DeviceState *dev, Error **errp)<br=
>
&gt; diff --git a/target/avr/disas.c b/target/avr/disas.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..727fc463ce<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/disas.c<br>
&gt; @@ -0,0 +1,214 @@<br>
&gt; +/*<br>
&gt; + * OpenRISC disassembler<br>
&gt; + *<br>
&gt; + * Copyright (c) 2018 Richard Henderson &lt;<a href=3D"mailto:rth@twi=
ddle.net" target=3D"_blank">rth@twiddle.net</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;disas/dis-asm.h&quot;<br>
&gt; +#include &quot;qemu/bitops.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +<br>
&gt; +typedef struct {<br>
&gt; +=C2=A0 =C2=A0 disassemble_info *info;<br>
&gt; +=C2=A0 =C2=A0 uint16_t next_word;<br>
&gt; +=C2=A0 =C2=A0 bool next_word_used;<br>
&gt; +} DisasContext;<br>
&gt; +<br>
&gt; +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16=
); }<br>
&gt; +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8)=
; }<br>
&gt; +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4)=
 * 2; }<br>
&gt; +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2=
; }<br>
&gt; +<br>
<br>
Is there any better way for naming these four function than<br>
meaningless to_A, to_B, to_C, to_D?=C2=A0</blockquote><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
Aleksandar<br></blockquote><div><br></div><div>if you look into insn.decode=
 file you will see the following comment.</div><div>=C2=A0# =C2=A0 A =3D [1=
6 .. 31]<br>=C2=A0# =C2=A0 B =3D [16 .. 23]<br>=C2=A0# =C2=A0 C =3D [24, 26=
, 28, 30]<br>=C2=A0# =C2=A0 D =3D [0, 2, 4, 6, 8, .. 30]<br></div><div><br>=
</div><div>I can call them if you prefer=C2=A0</div><div>A is regs_16_to_31=
_by_one</div><div>B is regs_16_to_23_by_one</div><div>C is regs_24_to_30_by=
_two</div><div>D is regs_00_to_30_by_two</div><div><br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +static uint16_t next_word(DisasContext *ctx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;next_word_used =3D true;<br>
&gt; +=C2=A0 =C2=A0 return ctx-&gt;next_word;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int append_16(DisasContext *ctx, int x)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return x &lt;&lt; 16 | next_word(ctx);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +/* Include the auto-generated decoder.=C2=A0 */<br>
&gt; +static bool decode_insn(DisasContext *ctx, uint16_t insn);<br>
&gt; +#include &quot;decode_insn.inc.c&quot;<br>
&gt; +<br>
&gt; +#define output(mnemonic, format, ...) \<br>
&gt; +=C2=A0 =C2=A0 (pctx-&gt;info-&gt;fprintf_func(pctx-&gt;info-&gt;strea=
m, &quot;%-9s &quot; format, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 mnemonic, ##__VA_ARGS__))<br>
&gt; +<br>
&gt; +int avr_print_insn(bfd_vma addr, disassemble_info *info)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DisasContext ctx;<br>
&gt; +=C2=A0 =C2=A0 DisasContext *pctx =3D &amp;ctx;<br>
&gt; +=C2=A0 =C2=A0 bfd_byte buffer[4];<br>
&gt; +=C2=A0 =C2=A0 uint16_t insn;<br>
&gt; +=C2=A0 =C2=A0 int status;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 <a href=3D"http://ctx.info" rel=3D"noreferrer" target=
=3D"_blank">ctx.info</a> =3D info;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 status =3D info-&gt;read_memory_func(addr, buffer, 4, i=
nfo);<br>
&gt; +=C2=A0 =C2=A0 if (status !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;memory_error_func(status, addr, =
info);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 insn =3D bfd_getl16(buffer);<br>
&gt; +=C2=A0 =C2=A0 ctx.next_word =3D bfd_getl16(buffer + 2);<br>
&gt; +=C2=A0 =C2=A0 ctx.next_word_used =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!decode_insn(&amp;ctx, insn)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 output(&quot;.db&quot;, &quot;0x%02x, 0x%=
02x&quot;, buffer[0], buffer[1]);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ctx.next_word_used ? 4 : 2;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +#define INSN(opcode, format, ...)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +{=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 output(#opcode, format, ##__VA_ARGS__);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 return true;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; +}<br>
&gt; +<br>
&gt; +#define INSN_MNEMONIC(opcode, mnemonic, format, ...)=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +{=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 output(mnemonic, format, ##__VA_ARGS__);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 return true;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + *=C2=A0 =C2=A0C=C2=A0 =C2=A0 =C2=A0 =C2=A0Z=C2=A0 =C2=A0 =C2=A0 =C2=
=A0N=C2=A0 =C2=A0 =C2=A0 =C2=A0V=C2=A0 =C2=A0 =C2=A0 =C2=A0S=C2=A0 =C2=A0 =
=C2=A0 =C2=A0H=C2=A0 =C2=A0 =C2=A0 =C2=A0T=C2=A0 =C2=A0 =C2=A0 =C2=A0I<br>
&gt; + *=C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 =C2=A0 =C2=A0 =C2=
=A02=C2=A0 =C2=A0 =C2=A0 =C2=A03=C2=A0 =C2=A0 =C2=A0 =C2=A04=C2=A0 =C2=A0 =
=C2=A0 =C2=A05=C2=A0 =C2=A0 =C2=A0 =C2=A06=C2=A0 =C2=A0 =C2=A0 =C2=A07<br>
&gt; + */<br>
&gt; +static const char *brbc[] =3D {<br>
&gt; +=C2=A0 =C2=A0 &quot;BRCC&quot;, &quot;BRNE&quot;, &quot;BRPL&quot;, &=
quot;BRVC&quot;, &quot;BRGE&quot;, &quot;BRHC&quot;, &quot;BRTC&quot;, &quo=
t;BRID&quot;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const char *brbs[] =3D {<br>
&gt; +=C2=A0 =C2=A0 &quot;BRCS&quot;, &quot;BREQ&quot;, &quot;BRMI&quot;, &=
quot;BRVS&quot;, &quot;BRLT&quot;, &quot;BRHS&quot;, &quot;BRTS&quot;, &quo=
t;BRIE&quot;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const char *bset[] =3D {<br>
&gt; +=C2=A0 =C2=A0 &quot;SEC&quot;,=C2=A0 &quot;SEZ&quot;,=C2=A0 &quot;SEN=
&quot;,=C2=A0 &quot;SEZ&quot;,=C2=A0 &quot;SES&quot;,=C2=A0 &quot;SEH&quot;=
,=C2=A0 &quot;SET&quot;,=C2=A0 &quot;SEI&quot;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const char *bclr[] =3D {<br>
&gt; +=C2=A0 =C2=A0 &quot;CLC&quot;,=C2=A0 &quot;CLZ&quot;,=C2=A0 &quot;CLN=
&quot;,=C2=A0 &quot;CLZ&quot;,=C2=A0 &quot;CLS&quot;,=C2=A0 &quot;CLH&quot;=
,=C2=A0 &quot;CLT&quot;,=C2=A0 &quot;CLI&quot;<br>
&gt; +};<br>
&gt; +<br>
&gt; +INSN(ADC,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(ADD,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(ADIW,=C2=A0 =C2=A0&quot;r%d:r%r, %d&quot;, a-&gt;rd + 1, a-&gt;r=
d, a-&gt;imm)<br>
&gt; +INSN(AND,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(ANDI,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(ASR,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN_MNEMONIC(BCLR,=C2=A0 bclr[a-&gt;bit], &quot;&quot;)<br>
&gt; +INSN(BLD,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;bit)<br>
&gt; +INSN_MNEMONIC(BRBC,=C2=A0 brbc[a-&gt;bit], &quot;.%+d&quot;, a-&gt;im=
m * 2)<br>
&gt; +INSN_MNEMONIC(BRBS,=C2=A0 brbs[a-&gt;bit], &quot;.%+d&quot;, a-&gt;im=
m * 2)<br>
&gt; +INSN(BREAK,=C2=A0 &quot;&quot;)<br>
&gt; +INSN_MNEMONIC(BSET,=C2=A0 bset[a-&gt;bit], &quot;&quot;)<br>
&gt; +INSN(BST,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;bit)<br>
&gt; +INSN(CALL,=C2=A0 =C2=A0&quot;0x%x&quot;, a-&gt;imm * 2)<br>
&gt; +INSN(CBI,=C2=A0 =C2=A0 &quot;%d, %d&quot;, a-&gt;reg, a-&gt;bit)<br>
&gt; +INSN(COM,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(CP,=C2=A0 =C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)=
<br>
&gt; +INSN(CPC,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(CPI,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(CPSE,=C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(DEC,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(DES,=C2=A0 =C2=A0 &quot;%d&quot;, a-&gt;imm)<br>
&gt; +INSN(EICALL, &quot;&quot;)<br>
&gt; +INSN(EIJMP,=C2=A0 &quot;&quot;)<br>
&gt; +INSN(ELPM1,=C2=A0 &quot;&quot;)<br>
&gt; +INSN(ELPM2,=C2=A0 &quot;r%d, Z&quot;, a-&gt;rd)<br>
&gt; +INSN(ELPMX,=C2=A0 &quot;r%d, Z+&quot;, a-&gt;rd)<br>
&gt; +INSN(EOR,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(FMUL,=C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(FMULS,=C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(FMULSU, &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(ICALL,=C2=A0 &quot;&quot;)<br>
&gt; +INSN(IJMP,=C2=A0 =C2=A0&quot;&quot;)<br>
&gt; +INSN(IN,=C2=A0 =C2=A0 =C2=A0&quot;r%d, $%d&quot;, a-&gt;rd, a-&gt;imm=
)<br>
&gt; +INSN(INC,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(JMP,=C2=A0 =C2=A0 &quot;0x%x&quot;, a-&gt;imm * 2)<br>
&gt; +INSN(LAC,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(LAS,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(LAT,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(LDDY,=C2=A0 =C2=A0&quot;r%d, Y+%d&quot;, a-&gt;rd, a-&gt;imm)<br=
>
&gt; +INSN(LDDZ,=C2=A0 =C2=A0&quot;r%d, Z+%d&quot;, a-&gt;rd, a-&gt;imm)<br=
>
&gt; +INSN(LDI,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(LDS,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(LDX1,=C2=A0 =C2=A0&quot;r%d, X&quot;, a-&gt;rd)<br>
&gt; +INSN(LDX2,=C2=A0 =C2=A0&quot;r%d, X+&quot;, a-&gt;rd)<br>
&gt; +INSN(LDX3,=C2=A0 =C2=A0&quot;r%d, -X&quot;, a-&gt;rd)<br>
&gt; +INSN(LDY2,=C2=A0 =C2=A0&quot;r%d, Y+&quot;, a-&gt;rd)<br>
&gt; +INSN(LDY3,=C2=A0 =C2=A0&quot;r%d, -Y&quot;, a-&gt;rd)<br>
&gt; +INSN(LDZ2,=C2=A0 =C2=A0&quot;r%d, Z+&quot;, a-&gt;rd)<br>
&gt; +INSN(LDZ3,=C2=A0 =C2=A0&quot;r%d, -Z&quot;, a-&gt;rd)<br>
&gt; +INSN(LPM1,=C2=A0 =C2=A0&quot;&quot;)<br>
&gt; +INSN(LPM2,=C2=A0 =C2=A0&quot;r%d, Z&quot;, a-&gt;rd)<br>
&gt; +INSN(LPMX,=C2=A0 =C2=A0&quot;r%d, Z+&quot;, a-&gt;rd)<br>
&gt; +INSN(LSR,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(MOV,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(MOVW,=C2=A0 =C2=A0&quot;r%d:r%d, r%d,r:r%d&quot;, a-&gt;rd + 1, =
a-&gt;rd, a-&gt;rr + 1, a-&gt;rr)<br>
&gt; +INSN(MUL,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(MULS,=C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(MULSU,=C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(NEG,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(NOP,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt; +INSN(OR,=C2=A0 =C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)=
<br>
&gt; +INSN(ORI,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(OUT,=C2=A0 =C2=A0 &quot;$%d, r%d&quot;, a-&gt;imm, a-&gt;rd)<br>
&gt; +INSN(POP,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(PUSH,=C2=A0 =C2=A0&quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(RCALL,=C2=A0 &quot;.%+d&quot;, a-&gt;imm * 2)<br>
&gt; +INSN(RET,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt; +INSN(RETI,=C2=A0 =C2=A0&quot;&quot;)<br>
&gt; +INSN(RJMP,=C2=A0 =C2=A0&quot;.%+d&quot;, a-&gt;imm * 2)<br>
&gt; +INSN(ROR,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(SBC,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(SBCI,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(SBI,=C2=A0 =C2=A0 &quot;$%d, %d&quot;, a-&gt;reg, a-&gt;bit)<br>
&gt; +INSN(SBIC,=C2=A0 =C2=A0&quot;$%d, %d&quot;, a-&gt;reg, a-&gt;bit)<br>
&gt; +INSN(SBIS,=C2=A0 =C2=A0&quot;$%d, %d&quot;, a-&gt;reg, a-&gt;bit)<br>
&gt; +INSN(SBIW,=C2=A0 =C2=A0&quot;r%d:r%d, %d&quot;, a-&gt;rd + 1, a-&gt;r=
d, a-&gt;imm)<br>
&gt; +INSN(SBRC,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rr, a-&gt;bit)<br>
&gt; +INSN(SBRS,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rr, a-&gt;bit)<br>
&gt; +INSN(SLEEP,=C2=A0 &quot;&quot;)<br>
&gt; +INSN(SPM,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt; +INSN(SPMX,=C2=A0 =C2=A0&quot;Z+&quot;)<br>
&gt; +INSN(STDY,=C2=A0 =C2=A0&quot;r%d, Y+%d&quot;, a-&gt;rd, a-&gt;imm)<br=
>
&gt; +INSN(STDZ,=C2=A0 =C2=A0&quot;r%d, Z+%d&quot;, a-&gt;rd, a-&gt;imm)<br=
>
&gt; +INSN(STS,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(STX1,=C2=A0 =C2=A0&quot;r%d, X&quot;, a-&gt;rr)<br>
&gt; +INSN(STX2,=C2=A0 =C2=A0&quot;r%d, X+&quot;, a-&gt;rr)<br>
&gt; +INSN(STX3,=C2=A0 =C2=A0&quot;r%d, -X&quot;, a-&gt;rr)<br>
&gt; +INSN(STY2,=C2=A0 =C2=A0&quot;r%d, Y+&quot;, a-&gt;rd)<br>
&gt; +INSN(STY3,=C2=A0 =C2=A0&quot;r%d, -Y&quot;, a-&gt;rd)<br>
&gt; +INSN(STZ2,=C2=A0 =C2=A0&quot;r%d, Z+&quot;, a-&gt;rd)<br>
&gt; +INSN(STZ3,=C2=A0 =C2=A0&quot;r%d, -Z&quot;, a-&gt;rd)<br>
&gt; +INSN(SUB,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(SUBI,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(SWAP,=C2=A0 =C2=A0&quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(WDR,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt; +INSN(XCH,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<br>
&gt; +<br>
&gt; diff --git a/target/avr/translate.c b/target/avr/translate.c<br>
&gt; index fdf4e11f58..0446009d68 100644<br>
&gt; --- a/target/avr/translate.c<br>
&gt; +++ b/target/avr/translate.c<br>
&gt; @@ -3019,6 +3019,17 @@ done_generating:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 tb-&gt;size =3D (ctx.npc - pc_start) * 2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 tb-&gt;icount =3D num_insns;<br>
&gt; +<br>
&gt; +#ifdef DEBUG_DISAS<br>
&gt; +=C2=A0 =C2=A0 if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; qemu_log_in_addr_range(tb-&gt;=
pc)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_lock();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IN: %s\n&quot;, lookup_sym=
bol(tb-&gt;pc));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_target_disas(cs, tb-&gt;pc, tb-&gt;si=
ze);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_unlock();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb=
,<br>
&gt; --<br>
&gt; 2.17.2 (Apple Git-113)<br>
&gt;<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div></div>

--0000000000008da688059845cceb--

