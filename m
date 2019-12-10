Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E6BC00454
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 21:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B342467E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 21:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+KGeEbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B342467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iemgj-0002j1-GC
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 16:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iemfj-0002EA-Ir
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 16:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iemfi-00013r-1S
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 16:03:55 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iemfh-00013e-T9
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 16:03:53 -0500
Received: by mail-ot1-x341.google.com with SMTP id i15so16833732oto.7
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 13:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lb/ChyuhHQbP72FsuTcLEjZ/KuK+DKbdsTihtCIrXCg=;
 b=j+KGeEbAS3cbmLVxxN/wiDMxF6QafvyuYnwGExRsCddl6jD/zUs6PubC7nsLE5aZFU
 qgb2g4Y120qgePbZkoq6Umpvv+s4DLhivi73kgjc7AeFb1XIpd/HR0dbuPenoBcLUasG
 XgxRElt/sVl000JvH+hYaXJN1+Rirwqaf+PxzVHJcaBue1ahurmsssiacnywDE0yN40n
 NJ4dISfaqjw0FclChZgiXKXNZznwdT563L9HMVBus7/Ok1lPUdp9cK3TZIwI+sjwKZdu
 8PUZexZ+xIqBG96z0Lc4pX5Eg5ulDofD81Dq1SV1v3Qw3mqEpQd9DfJ5z7ny0B8cMl11
 74cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lb/ChyuhHQbP72FsuTcLEjZ/KuK+DKbdsTihtCIrXCg=;
 b=c7DGspvUT209zAQpvrCzCCjNnfScCiwxBjI3osoL8sSxykFrfhhEAePTwvWw5+0TdP
 B4E7BOYy9On25K1YIAafi0e3aIAXWoKV+02mqmFHEmNZ2hn6L9ELc3KMQxg0mOi9uBcb
 9WkS8+qE6gHHD+6SvIZMRBSiWAas5hTfyqitqqVTsJsoWsBtLo1n2YkVVqNqejYEPphX
 YtHXwYf9XJwshwtoftWVvMKyo3qsjnoA07IgAFADm8sr3G9Qdu5ihylw1k3+FUmdHEm8
 NKqRU3j/aJ36wHSsDwqTsS2aTrtcFAtapaSvC5rhoVslGuxQ9sD1Rut5JDm2yCKxpIBT
 YqOg==
X-Gm-Message-State: APjAAAVp1XB2B3R7pOw3IQYxalRsknL0SQUrfvMBqNUDPDz+aHyoD4GT
 hzrEN+rC1MuFHxcCxy+zRDxKSDk9lUApJWmdX7s=
X-Google-Smtp-Source: APXvYqyjh3f7acqAC9oDUKz/fqD3BSdOWbOakS8zr9mSan7hSXDZWkN0IF1zX6SWBayHRXNsPT+muz/99RFpq1OjRU8=
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr18405146otn.341.1576011832951; 
 Tue, 10 Dec 2019 13:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20191208183922.13757-1-mrolnik@gmail.com>
 <20191208183922.13757-5-mrolnik@gmail.com>
In-Reply-To: <20191208183922.13757-5-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 10 Dec 2019 22:03:42 +0100
Message-ID: <CAL1e-=j4uQqjnAgm+z64FqQ9W4JS=fjFvPZBBXYZrBqbS62J2A@mail.gmail.com>
Subject: Re: [PATCH v38 04/22] target/avr: Add instruction translation -
 Registers definition
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Thomas Huth <thuth@redhat.com>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Dec 8, 2019 at 7:40 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/avr/translate.c | 143 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 target/avr/translate.c
>
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> new file mode 100644
> index 0000000000..0139bcabb1
> --- /dev/null
> +++ b/target/avr/translate.c
> @@ -0,0 +1,143 @@
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
> +#include "tcg-op.h"
> +#include "exec/cpu_ldst.h"
> +#include "exec/helper-proto.h"
> +#include "exec/helper-gen.h"
> +#include "exec/log.h"
> +#include "exec/translator.h"
> +#include "exec/gen-icount.h"
> +
> +/*
> + *  Define if you want a BREAK instruction translated to a breakpoint
> + *  Active debugging connection is assumed
> + *  This is for
> + *  https://github.com/seharris/qemu-avr-tests/tree/master/instruction-t=
ests
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
> +static TCGv cpu_r[NUMBER_OF_CPU_REGISTERS];
> +static TCGv cpu_eind;
> +static TCGv cpu_sp;
> +
> +static TCGv cpu_skip;
> +
> +static const char reg_names[NUMBER_OF_CPU_REGISTERS][8] =3D {
> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
> +};
> +#define REG(x) (cpu_r[x])
> +
> +enum {
> +    DISAS_EXIT   =3D DISAS_TARGET_0,  /* We want return to the cpu main =
loop.  */
> +    DISAS_LOOKUP =3D DISAS_TARGET_1,  /* We have a variable condition ex=
it.  */
> +    DISAS_CHAIN  =3D DISAS_TARGET_2,  /* We have a single condition exit=
.  */
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
> +};

Still waiting on the comment...

> +
> +static int to_regs_16_31_by_one(DisasContext *ctx, int indx)
> +{
> +    return 16 + (indx % 16);
> +}
> +
> +static int to_regs_16_23_by_one(DisasContext *ctx, int indx)
> +{
> +    return 16 + (indx % 8);
> +}
> +static int to_regs_24_30_by_two(DisasContext *ctx, int indx)
> +{
> +    return 24 + (indx % 4) * 2;
> +}
> +static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
> +{
> +    return (indx % 16) * 2;
> +}
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
> +        ctx->bstate =3D DISAS_NORETURN;
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

