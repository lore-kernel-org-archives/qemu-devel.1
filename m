Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0420DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD13A20684
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQqhLjZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD13A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZgsk-0008Jq-UQ
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 14:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZgpO-0006hF-OS
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZgpM-000794-Qj
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:48:50 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZgpM-00078k-Kp
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:48:48 -0500
Received: by mail-oi1-x244.google.com with SMTP id x21so10712455oic.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LG+bHwbMsEGdO80YBke4qqYmPmZ0vV/g2PHxGIPXFZI=;
 b=aQqhLjZso2Vo1x353yF4z0UnGr5yGBU0eA9xSNbicwhiIHyF6m09h4XA36hOjVhcGX
 S3xA5soFQT8ZiYjPNDotLSTZx9FXNlXkVPmH9SPHNs0k1HFYJlQGpxfAvmpkPLVBGFYG
 vuBxrEblxEPccolF+jbkcWitaDcvjY/vOJ6bofldbMaUYYtaPJFzL1iJTvzxHqS26Ax1
 ccOWV7VQHA9mZrTM9rthfddgH4TAzuOdJ6ndkIUFRKI4mcnbAT5xmu3iKbZPkuXOd5uc
 PlgwwxG0eezatx2YgBp1hhWIzrD6mfzzOrJn/U7ZGox8S7L5nsDNwoHD03Km59SPmjcm
 xgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LG+bHwbMsEGdO80YBke4qqYmPmZ0vV/g2PHxGIPXFZI=;
 b=NCXYgS1x+zPrgta+/KwKBOcYQwv+F8fYEsSXwaxH6L+JqyiUZSwE0gwxFvttn1W2+k
 Jp3f2WDN2Tc2TRu5PAFlczhFiTwAPn5r5fufHIXKf0WTozxT9goZxGR7npuBYS/QiY+N
 aXxee0LGm1T7Lqt514QzlRQmhxwlL9UCyF7pV8NalhL68tlUMaqPzQxmdOQhh13IMVYj
 es48jxR56eJVYR7urVLWdJoVHq+iZhcSFW0QyXrUTyuhENZAybN2Eo9IvXLkCIgOrWEX
 KZtvZaf5UQHSnIZS6XAt67RDdSTX30/dWX9MxaaQxrR4WV/QJlCpVy6x9lvrmfsIjHG2
 xgpg==
X-Gm-Message-State: APjAAAW6nm38qQSMtHhLfArZd2lmeehHdLiqbPmDaHO0KTU7BGOp4qGP
 TVeHR5Pxee+Gs5cw3/M5+FFcqBNurd1tpgLR3wo=
X-Google-Smtp-Source: APXvYqxWDdNnuyIk3xuch7zY4vL5ielrSyDHNgNFiTtoU3HTy2vnM0cqGNpmHE18F+1MuK3PnSGWm8HRRFDAXjVhc+0=
X-Received: by 2002:aca:d17:: with SMTP id 23mr650869oin.136.1574797727256;
 Tue, 26 Nov 2019 11:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-5-mrolnik@gmail.com>
In-Reply-To: <20191124050225.30351-5-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 26 Nov 2019 20:48:36 +0100
Message-ID: <CAL1e-=gvZsJQVZJDpzw2J9XTmafrwWmZwcnXd4B0oAJzde7NwQ@mail.gmail.com>
Subject: Re: [PATCH v36 04/17] target/avr: Add instruction translation -
 Registers definition
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  target/avr/translate.c | 132 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 target/avr/translate.c
>
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> new file mode 100644
> index 0000000000..53c9892a60
> --- /dev/null
> +++ b/target/avr/translate.c
> @@ -0,0 +1,132 @@
> +/*
> + * QEMU AVR CPU
> + *
> + * Copyright (c) 2019 Michael Rolnik
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/qemu-print.h"
> +#include "tcg/tcg.h"
> +#include "cpu.h"
> +#include "exec/exec-all.h"
> +#include "disas/disas.h"
> +#include "tcg-op.h"
> +#include "exec/cpu_ldst.h"
> +#include "exec/helper-proto.h"
> +#include "exec/helper-gen.h"
> +#include "exec/log.h"
> +#include "exec/gdbstub.h"
> +#include "exec/translator.h"
> +#include "exec/gen-icount.h"
> +
> +/*
> + *  Define if you want a BREAK instruction translated to a breakpoint
> + *  Active debugging connection is assumed
> + *  This is for
> + *  https://github.com/seharris/qemu-avr-tests/tree/master/instruction-tests
> + *  tests
> + */
> +#undef BREAKPOINT_ON_BREAK
> +
> +static TCGv cpu_pc;
> +
> +static TCGv cpu_Cf;
> +static TCGv cpu_Zf;
> +static TCGv cpu_Nf;
> +static TCGv cpu_Vf;
> +static TCGv cpu_Sf;
> +static TCGv cpu_Hf;
> +static TCGv cpu_Tf;
> +static TCGv cpu_If;
> +
> +static TCGv cpu_rampD;
> +static TCGv cpu_rampX;
> +static TCGv cpu_rampY;
> +static TCGv cpu_rampZ;
> +
> +static TCGv cpu_r[NO_CPU_REGISTERS];
> +static TCGv cpu_eind;
> +static TCGv cpu_sp;
> +
> +static TCGv cpu_skip;
> +
> +static const char reg_names[NO_CPU_REGISTERS][8] = {
> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
> +};
> +#define REG(x) (cpu_r[x])
> +
> +enum {
> +    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu main loop.  */
> +    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable condition exit.  */
> +    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition exit.  */
> +};
> +
> +typedef struct DisasContext DisasContext;
> +
> +/* This is the state at translation time. */
> +struct DisasContext {
> +    TranslationBlock *tb;
> +
> +    CPUAVRState *env;
> +    CPUState *cs;
> +
> +    target_long npc;
> +    uint32_t opcode;
> +
> +    /* Routine used to access memory */
> +    int memidx;
> +    int bstate;
> +    int singlestep;
> +
> +    TCGv skip_var0;
> +    TCGv skip_var1;
> +    TCGCond skip_cond;
> +    bool free_skip_var0;

This set of four lines are by far the hardest to connect to the documentation.

Please add before them a sizable comment with explanations for:

- the reson these variables are introduced
- why are they here (part of DisasContext)
- what they affect
- summary of the way they work

Perhaps add comments to other places where "skip"-related data fields
are introduced.

(I believe the implementation is correct, but it is extremely hard to the reader
to reverse-engineer the intentions)

Yours,
Aleksandar

> +};
> +
> +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }
> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
> +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) * 2; }
> +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }
> +
> +static uint16_t next_word(DisasContext *ctx)
> +{
> +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
> +}
> +
> +static int append_16(DisasContext *ctx, int x)
> +{
> +    return x << 16 | next_word(ctx);
> +}
> +
> +
> +static bool avr_have_feature(DisasContext *ctx, int feature)
> +{
> +    if (!avr_feature(ctx->env, feature)) {
> +        gen_helper_unsupported(cpu_env);
> +        ctx->bstate = DISAS_NORETURN;
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
> +#include "decode_insn.inc.c"
> +
> --
> 2.17.2 (Apple Git-113)
>

