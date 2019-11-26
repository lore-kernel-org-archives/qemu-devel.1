Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3E4C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 00:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8CA20665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 00:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNli83Be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8CA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZkly-0005km-0G
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 19:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZkk8-000559-LU
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZkk1-0005tG-S3
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:59:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30559
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZkk1-0005sY-MB
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574812772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nG45HO0cSKFexE8kHB4b9a33ymnTIlIckJ2Bzt3ND4=;
 b=KNli83BeTbZmBIBbgQM1wTLe4lmhq+iTW2hzinUsFWGG21AbXCzQeW00S2+SghCOXjSJoV
 SxAktDERTDkam3044IIo8T4sUxqojWegwRndWY0yHfAg5TKwggxyTBByof+9ZN8pZj45zN
 wJ6mdAFKjyvVelKdV8LHlAass/YLglc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-4URu4CI3PqO_7cz4EwtnaQ-1; Tue, 26 Nov 2019 18:59:28 -0500
Received: by mail-wr1-f70.google.com with SMTP id h7so11355185wrb.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 15:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z5f7wDgHEhw7OahsI4cjGcyTBmz84Nf4zKO4IO8FVZ0=;
 b=a7JwNOMrEbXIAlKw7wG0tYyEMVbOXDLk2BuUGkQxQet0JtFdxhPSorJan5R7Sq2qSN
 nbEpNCpq8wZofzxKt+Mq7i12elMDk5kHzYLbC2rpwPpIH1nB8ptHDdJDBNVTd6fbgWPx
 b5m2Cp5C3KiGtR97gPopLalzDppBrSsKLS7VjTPylAkIJk1GHgczgGE9lHCu1s9zNOLg
 hAXKkpJpL7HWrgYdfEmgyynBZ/aOK607AIkNyeRWiUw3eibNpYopYcpwN4hk0Jnc1ASX
 kbcnm74C8D94YSUQF+JQ+OtGa8VXAjPQRUDH0OHkcK3k0mPyEpXviS1O2QWwYfglo2b7
 WHkQ==
X-Gm-Message-State: APjAAAVIkbLjw9E/KbhE9e1h64oFmPyFgS0Q7svWkmWON25qouIUuTYP
 q7cP7Vri9LhaApqYkoRirPLfkx2mRbyR+2wMme5k47sc7uD8m+TAdTuOqXZMaS8OhN2YD7DrUO7
 YFRSNfHVv+7klkmg=
X-Received: by 2002:a1c:f70d:: with SMTP id v13mr1429499wmh.45.1574812767568; 
 Tue, 26 Nov 2019 15:59:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxnNud3RR/IEDwjcLMTSqH8wmkeRhy3YJdrzhfGEOfjEaQQ6yn7knbMXU3iryK68hRk6anVoA==
X-Received: by 2002:a1c:f70d:: with SMTP id v13mr1429471wmh.45.1574812766995; 
 Tue, 26 Nov 2019 15:59:26 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id c144sm4773769wmd.1.2019.11.26.15.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2019 15:59:26 -0800 (PST)
Subject: Re: [PATCH v36 10/17] target/avr: Add instruction disassembly function
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-11-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <20aa93b4-4039-bb02-c2c7-7e6aeca8c457@redhat.com>
Date: Wed, 27 Nov 2019 00:59:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191124050225.30351-11-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: 4URu4CI3PqO_7cz4EwtnaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: thuth@redhat.com, Joaquin de Andres <me@xcancerberox.com.ar>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/24/19 6:02 AM, Michael Rolnik wrote:
> Provide function disassembles executed instruction when `-d in_asm` is
> provided

Maybe "Implement the disassemble_info::print_insn() callback which print=20
a disassembled instruction."

> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>   target/avr/cpu.h       |   1 +
>   target/avr/cpu.c       |   2 +-
>   target/avr/disas.c     | 214 +++++++++++++++++++++++++++++++++++++++++
>   target/avr/translate.c |  11 +++
>   4 files changed, 227 insertions(+), 1 deletion(-)
>   create mode 100644 target/avr/disas.c
>=20
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index ed9218af5f..574118beab 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -157,6 +157,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu, int int_re=
q);
>   hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>   int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>   int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +int avr_print_insn(bfd_vma addr, disassemble_info *info);
>  =20
>   static inline int avr_feature(CPUAVRState *env, int feature)
>   {
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index dae56d7845..52ec21dd16 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *cs)
>   static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *inf=
o)
>   {
>       info->mach =3D bfd_arch_avr;
> -    info->print_insn =3D NULL;
> +    info->print_insn =3D avr_print_insn;
>   }
>  =20
>   static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
> diff --git a/target/avr/disas.c b/target/avr/disas.c
> new file mode 100644
> index 0000000000..727fc463ce
> --- /dev/null
> +++ b/target/avr/disas.c
> @@ -0,0 +1,214 @@
> +/*
> + * OpenRISC disassembler

AVR?

> + *
> + * Copyright (c) 2018 Richard Henderson <rth@twiddle.net>

Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>?

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
> +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); =
}
> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
> +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) * =
2; }
> +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }
> +
> +static uint16_t next_word(DisasContext *ctx)
> +{
> +    ctx->next_word_used =3D true;
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
> +    DisasContext *pctx =3D &ctx;
> +    bfd_byte buffer[4];
> +    uint16_t insn;
> +    int status;
> +
> +    ctx.info =3D info;
> +
> +    status =3D info->read_memory_func(addr, buffer, 4, info);
> +    if (status !=3D 0) {
> +        info->memory_error_func(status, addr, info);
> +        return -1;
> +    }
> +    insn =3D bfd_getl16(buffer);
> +    ctx.next_word =3D bfd_getl16(buffer + 2);
> +    ctx.next_word_used =3D false;
> +
> +    if (!decode_insn(&ctx, insn)) {
> +        output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
> +    }
> +
> +    return ctx.next_word_used ? 4 : 2;
> +}
> +
> +
> +#define INSN(opcode, format, ...)                                       =
\
> +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)        =
\
> +{                                                                       =
\
> +    output(#opcode, format, ##__VA_ARGS__);                             =
\
> +    return true;                                                        =
\
> +}
> +
> +#define INSN_MNEMONIC(opcode, mnemonic, format, ...)                    =
\
> +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)        =
\
> +{                                                                       =
\
> +    output(mnemonic, format, ##__VA_ARGS__);                            =
\
> +    return true;                                                        =
\
> +}
> +
> +/*
> + *   C       Z       N       V       S       H       T       I
> + *   0       1       2       3       4       5       6       7
> + */
> +static const char *brbc[] =3D {
> +    "BRCC", "BRNE", "BRPL", "BRVC", "BRGE", "BRHC", "BRTC", "BRID"
> +};
> +
> +static const char *brbs[] =3D {
> +    "BRCS", "BREQ", "BRMI", "BRVS", "BRLT", "BRHS", "BRTS", "BRIE"
> +};
> +
> +static const char *bset[] =3D {
> +    "SEC",  "SEZ",  "SEN",  "SEZ",  "SES",  "SEH",  "SET",  "SEI"
> +};
> +
> +static const char *bclr[] =3D {
> +    "CLC",  "CLZ",  "CLN",  "CLZ",  "CLS",  "CLH",  "CLT",  "CLI"
> +};
> +
> +INSN(ADC,    "r%d, r%d", a->rd, a->rr)
> +INSN(ADD,    "r%d, r%d", a->rd, a->rr)
> +INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)

I suppose this is a typo and you want:

-- >8 --
-INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)
+INSN(ADIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
---

Because I'm getting:

target/avr/disas.c: In function =91trans_ADIW=92:
target/avr/disas.c:53:51: error: unknown conversion type character =91r=92=
=20
in format [-Werror=3Dformat=3D]
    53 |     (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format, =
\
       |                                                   ^~~~~~~
target/avr/disas.c:86:5: note: in expansion of macro =91output=92
    86 |     output(#opcode, format, ##__VA_ARGS__);=20
         \
       |     ^~~~~~
target/avr/disas.c:119:1: note: in expansion of macro =91INSN=92
   119 | INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)
       | ^~~~
target/avr/disas.c:119:21: note: format string is defined here
   119 | INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)
       |                     ^
target/avr/disas.c:53:51: error: too many arguments for format=20
[-Werror=3Dformat-extra-args]
    53 |     (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format, =
\
       |                                                   ^~~~~~~
target/avr/disas.c:86:5: note: in expansion of macro =91output=92
    86 |     output(#opcode, format, ##__VA_ARGS__);=20
         \
       |     ^~~~~~
target/avr/disas.c:119:1: note: in expansion of macro =91INSN=92
   119 | INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)
       | ^~~~
cc1: all warnings being treated as errors
make[1]: *** [rules.mak:69: target/avr/disas.o] Error 1


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
>  =20
>       tb->size =3D (ctx.npc - pc_start) * 2;
>       tb->icount =3D num_insns;
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
>   }
>  =20
>   void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
>=20

Testing time...

$ avr-softmmu/qemu-system-avr -M sample -bios demo.elf -d in_asm,unimp,int
IN:
0x00000000:  JMP       0x110

IN:
0x00000110:  EOR       r1, r1
0x00000112:  OUT       $63, r1
0x00000114:  LDI       r28, 255
0x00000116:  LDI       r29, 33
0x00000118:  OUT       $62, r29
0x0000011a:  OUT       $61, r28
0x0000011c:  LDI       r16, 0
0x0000011e:  OUT       $60, r16
0x00000120:  LDI       r17, 2
0x00000122:  LDI       r26, 0
0x00000124:  LDI       r27, 2
0x00000126:  LDI       r30, 80
0x00000128:  LDI       r31, 87
0x0000012a:  LDI       r16, 0
0x0000012c:  OUT       $59, r16
0x0000012e:  RJMP      .+4

IN:
0x00000134:  CPI       r26, 96
0x00000136:  CPC       r27, r17
0x00000138:  BRNE      .-10
IN:
0x00000130:  ELPMX     r0, Z+
0x00000132:  STX2      r0, X+
0x00000134:  CPI       r26, 96
0x00000136:  CPC       r27, r17
0x00000138:  BRNE      .-10

IN:
0x0000013a:  LDI       r18, 18
0x0000013c:  LDI       r26, 96
0x0000013e:  LDI       r27, 2
0x00000140:  RJMP      .+2

IN:
0x00000144:  CPI       r26, 208
0x00000146:  CPC       r27, r18
0x00000148:  BRNE      .-8

IN:
0x00000142:  STX2      r1, X+
0x00000144:  CPI       r26, 208
0x00000146:  CPC       r27, r18
0x00000148:  BRNE      .-8

IN:
0x0000014a:  CALL      0x156

IN: main
IN: main
0x00000156:  PUSH      r14
0x00000158:  PUSH      r15
0x0000015a:  PUSH      r16
0x0000015c:  PUSH      r28
0x0000015e:  PUSH      r29
0x00000160:  IN        r28, $61
0x00000162:  IN        r29, $62
0x00000164:  CALL      0x26c

IN: prvIncrementResetCount
0x0000026c:  PUSH      r28
0x0000026e:  PUSH      r29
0x00000270:  IN        r28, $61
0x00000272:  IN        r29, $62
0x00000274:  NOP
0x00000276:  POP       r29
0x00000278:  POP       r28
0x0000027a:  RET

IN: main
0x00000168:  CALL      0x5c6

IN: vParTestInitialise
0x000005c6:  PUSH      r28
0x000005c8:  PUSH      r29
0x000005ca:  IN        r28, $61
0x000005cc:  IN        r29, $62
0x000005ce:  LDI       r24, 255
0x000005d0:  STS       r24, 0
0x000005d2:  MULS      r16, r20
0x000005d4:  LDI       r24, 33
0x000005d6:  LDI       r25, 0
0x000005d8:  LDI       r18, 255
0x000005da:  MOVW      r31:r30, r25,r:r24
0x000005dc:  STDZ      r18, Z+0
0x000005de:  LDI       r24, 34
0x000005e0:  LDI       r25, 0
0x000005e2:  LDS       r18, 0
0x000005e4:  MULS      r16, r20
0x000005e6:  MOVW      r31:r30, r25,r:r24
0x000005e8:  STDZ      r18, Z+0
0x000005ea:  NOP
0x000005ec:  POP       r29
0x000005ee:  POP       r28
0x000005f0:  RET

IN: vParTestInitialise
0x000005dc:  STDZ      r18, Z+0

gpio A: unimplemented device write (size 1, value 0xff, offset 0x1)
[...]

IN: vParTestToggleLED
0x000006c0:  LDI       r24, 34
0x000006c2:  LDI       r25, 0
0x000006c4:  LDS       r18, 0
0x000006c6:  MULS      r16, r20
0x000006c8:  MOVW      r31:r30, r25,r:r24
0x000006ca:  STDZ      r18, Z+0
0x000006cc:  CALL      0x30d6

IN: vParTestToggleLED
0x000006ca:  STDZ      r18, Z+0

gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
IN: vParTestToggleLED
0x000006cc:  CALL      0x30d6

IN: vParTestToggleLED
0x000006d0:  NOP
0x000006d2:  POP       r0
0x000006d4:  POP       r0
0x000006d6:  POP       r29
0x000006d8:  POP       r28
0x000006da:  RET
[...]

IN: vParTestToggleLED
0x000006b4:  LDS       r25, 0
0x000006b6:  MULS      r16, r20
0x000006b8:  LDDY      r24, Y+1
0x000006ba:  OR        r24, r25
0x000006bc:  STS       r24, 0
0x000006be:  MULS      r16, r20
0x000006c0:  LDI       r24, 34
0x000006c2:  LDI       r25, 0
0x000006c4:  LDS       r18, 0
0x000006c6:  MULS      r16, r20
0x000006c8:  MOVW      r31:r30, r25,r:r24
0x000006ca:  STDZ      r18, Z+0
0x000006cc:  CALL      0x30d6

gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)

We have a blinking LED!


$ avr-softmmu/qemu-system-avr -M sample -bios=20
ATmegaBOOT_168_atmega328.elf -d in_asm,unimp,int
[...]
0x00007800:  JMP       0x7868

IN:
0x00007868:  EOR       r1, r1
0x0000786a:  OUT       $63, r1
0x0000786c:  LDI       r28, 255
0x0000786e:  LDI       r29, 8
0x00007870:  OUT       $62, r29
0x00007872:  OUT       $61, r28
0x00007874:  LDI       r17, 1
0x00007876:  LDI       r26, 0
0x00007878:  LDI       r27, 1
0x0000787a:  LDI       r30, 226
0x0000787c:  LDI       r31, 133
0x0000787e:  RJMP      .+4

IN:
0x00007884:  CPI       r26, 2
0x00007886:  CPC       r27, r17
0x00007888:  BRNE      .-10

IN:
0x00007880:  LPMX      r0, Z+
0x00007882:  STX2      r0, X+
0x00007884:  CPI       r26, 2
0x00007886:  CPC       r27, r17
0x00007888:  BRNE      .-10

gpio H: unimplemented device write (size 1, value 0x80, offset 0x0)
gpio H: unimplemented device write (size 1, value 0x0, offset 0x1)
IN:
0x0000788a:  LDI       r18, 2
0x0000788c:  LDI       r26, 2
0x0000788e:  LDI       r27, 1
0x00007890:  RJMP      .+2

IN:
0x00007894:  CPI       r26, 13
0x00007896:  CPC       r27, r18
0x00007898:  BRNE      .-8

IN:
0x00007892:  STX2      r1, X+
0x00007894:  CPI       r26, 13
0x00007896:  CPC       r27, r18
0x00007898:  BRNE      .-8

gpio H: unimplemented device write (size 1, value 0x0, offset 0x2)
gpio J: unimplemented device write (size 1, value 0x0, offset 0x0)
gpio J: unimplemented device write (size 1, value 0x0, offset 0x1)
gpio J: unimplemented device write (size 1, value 0x0, offset 0x2)
gpio K: unimplemented device write (size 1, value 0x0, offset 0x0)
gpio K: unimplemented device write (size 1, value 0x0, offset 0x1)
gpio K: unimplemented device write (size 1, value 0x0, offset 0x2)
gpio L: unimplemented device write (size 1, value 0x0, offset 0x0)
gpio L: unimplemented device write (size 1, value 0x0, offset 0x1)
gpio L: unimplemented device write (size 1, value 0x0, offset 0x2)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0x0)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0x1)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0x2)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0x3)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0x4)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0x5)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0x6)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0x7)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0x8)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0x9)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0xa)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0xb)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0xc)
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,=20
offset 0xd)
usart 3: unimplemented device write (size 1, value 0x0, offset 0x0)
usart 3: unimplemented device write (size 1, value 0x0, offset 0x1)
usart 3: unimplemented device write (size 1, value 0x0, offset 0x2)
usart 3: unimplemented device write (size 1, value 0x0, offset 0x3)
usart 3: unimplemented device write (size 1, value 0x0, offset 0x4)
usart 3: unimplemented device write (size 1, value 0x0, offset 0x5)
usart 3: unimplemented device write (size 1, value 0x0, offset 0x6)
IN:
0x0000789a:  CALL      0x7b8c

IN: main
[...]

Wow, congratulation, I'm impressed how fast you implemented that!

:) :)

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


