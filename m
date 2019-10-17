Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD5ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C414620872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnz+8hQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C414620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9ZJ-00083Y-Eq
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL9Ww-00069D-Ie
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL9Wu-00063U-KL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:25:42 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL9Wt-000631-UH
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 13:25:40 -0400
Received: by mail-oi1-x241.google.com with SMTP id a15so2878812oic.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=SP0zhS/GNj3RBt0DRPnnWgzxP1Z38uHjslG4W3YzD24=;
 b=Vnz+8hQWYdyIfgbNP+HuALfqXsgdoHCLc86c7iOdFCAjHFiC11+YcTRUWOe8dCKG/9
 8XG1NELYoVf2k6UD6wi9j+sQn8zO7+gO2heCHtQ8PVM2xOfRYizCfqByqKwjWr1F7IV2
 7GzLkrlnuah//hGYGEOZqW4dScrFDde9x2Heq7XvUT9hz3yyz3mR1R1O2Y3WlUUYy1Ry
 obeMcU/aiWpMFUq4yvaaZLQvT4VLHmtcrbrJZ5KvjXWIi7R9lBFSvO6pG3uCUpOQ+ZFd
 Nyj7ZRCnnWwFZ4gNvEGL8qLCHFnzXSBBfeF/f+xOKNfOYL5o5YnBl5+8SfVSmitGmQRU
 oqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=SP0zhS/GNj3RBt0DRPnnWgzxP1Z38uHjslG4W3YzD24=;
 b=cwcahxPuazWPmTUgEkh8ZvtJao0V0U9GpBblpmmA5vSD7/ryb2PKZscQMlxrAaUTSz
 /Mbq05I0h1DdJjRDa1itUqTdOWwpFOBE5lMJCT5tdUHf1qIG+jar43B70ahk1Ddy+jdn
 ntJOegMmdR6TJIoGqNWJJ0RyYoNmTODsdO5FMRLxrRAE8MD5vARyA/OjAm3ohMUj4Pmy
 aprwyKaImgoYblDBw2m4uHW/6Fgf4BUe76rWJg1GG9VtWBhdh2HdugjPWUQtEdSyh49G
 yNUUbqILAVL/bCWpQzRKyVaVlib1xTlnia8UqZRxjy00qny2lcWMSkU0Q+1YYCFT9nAY
 UFgA==
X-Gm-Message-State: APjAAAV66pXVCC28DFYi6POJLQjVMTnzeb5zh551EGHAv0fGdZ14KS3O
 6MMgjQxgX0MOGwuflDNg3Q6WIzwMxP5fM8sq+3I=
X-Google-Smtp-Source: APXvYqxJDxen9Gpcg1Q4tIq1IsyHwG2oWrg1JaqBAhZXxYSK0y/Fk41CVJ6qYgPAvs/gGQKYt5/9uDLV4paYWhsaNBY=
X-Received: by 2002:aca:62d5:: with SMTP id w204mr4221833oib.136.1571333138711; 
 Thu, 17 Oct 2019 10:25:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 10:25:37
 -0700 (PDT)
In-Reply-To: <20191014161843.84845-5-mrolnik@gmail.com>
References: <20191014161843.84845-1-mrolnik@gmail.com>
 <20191014161843.84845-5-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 19:25:37 +0200
Message-ID: <CAL1e-=g9ER4tuqEL2ubqb7oAbatcVR8x+A0LAydSwBJEnk9_ow@mail.gmail.com>
Subject: Re: [PATCH v32 04/13] target/avr: Add instruction translation -
 Registers definition
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000008e87ac05951e8191"
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008e87ac05951e8191
Content-Type: text/plain; charset="UTF-8"

On Monday, October 14, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

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
> + *  https://github.com/seharris/qemu-avr-tests/tree/master/
> instruction-tests
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


Hello, Michael,

Is there any particular reason or motivation beyond modelling status
register flags as TCGv variables?

A.




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
> +    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu main
> loop.  */
> +    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable condition
> exit.  */
> +    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition exit.
> */
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
> +
> +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }
> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
> +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) *
> 2; }
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
>

--0000000000008e87ac05951e8191
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 14, 2019, Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail=
.com">mrolnik@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/avr/translate.c | 132 ++++++++++++++++++++++++++++++<wbr>+++++=
++++++<br>
=C2=A01 file changed, 132 insertions(+)<br>
=C2=A0create mode 100644 target/avr/translate.c<br>
<br>
diff --git a/target/avr/translate.c b/target/avr/translate.c<br>
new file mode 100644<br>
index 0000000000..53c9892a60<br>
--- /dev/null<br>
+++ b/target/avr/translate.c<br>
@@ -0,0 +1,132 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/qemu-print.h&quot;<br>
+#include &quot;tcg/tcg.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+#include &quot;exec/exec-all.h&quot;<br>
+#include &quot;disas/disas.h&quot;<br>
+#include &quot;tcg-op.h&quot;<br>
+#include &quot;exec/cpu_ldst.h&quot;<br>
+#include &quot;exec/helper-proto.h&quot;<br>
+#include &quot;exec/helper-gen.h&quot;<br>
+#include &quot;exec/log.h&quot;<br>
+#include &quot;exec/gdbstub.h&quot;<br>
+#include &quot;exec/translator.h&quot;<br>
+#include &quot;exec/gen-icount.h&quot;<br>
+<br>
+/*<br>
+ *=C2=A0 Define if you want a BREAK instruction translated to a breakpoint=
<br>
+ *=C2=A0 Active debugging connection is assumed<br>
+ *=C2=A0 This is for<br>
+ *=C2=A0 <a href=3D"https://github.com/seharris/qemu-avr-tests/tree/master=
/instruction-tests" target=3D"_blank">https://github.com/seharris/<wbr>qemu=
-avr-tests/tree/master/<wbr>instruction-tests</a><br>
+ *=C2=A0 tests<br>
+ */<br>
+#undef BREAKPOINT_ON_BREAK<br>
+<br>
+static TCGv cpu_pc;<br>
+<br>
+static TCGv cpu_Cf;<br>
+static TCGv cpu_Zf;<br>
+static TCGv cpu_Nf;<br>
+static TCGv cpu_Vf;<br>
+static TCGv cpu_Sf;<br>
+static TCGv cpu_Hf;<br>
+static TCGv cpu_Tf;<br>
+static TCGv cpu_If;<br>
+</blockquote><div><br></div><div>Hello, Michael,</div><div><br></div><div>=
Is there any particular reason or motivation beyond modelling status regist=
er flags as TCGv variables?</div><div><br></div><div>A.</div><div><br></div=
><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+static TCGv cpu_rampD;<br>
+static TCGv cpu_rampX;<br>
+static TCGv cpu_rampY;<br>
+static TCGv cpu_rampZ;<br>
+<br>
+static TCGv cpu_r[NO_CPU_REGISTERS];<br>
+static TCGv cpu_eind;<br>
+static TCGv cpu_sp;<br>
+<br>
+static TCGv cpu_skip;<br>
+<br>
+static const char reg_names[NO_CPU_REGISTERS][8] =3D {<br>
+=C2=A0 =C2=A0 &quot;r0&quot;,=C2=A0 &quot;r1&quot;,=C2=A0 &quot;r2&quot;,=
=C2=A0 &quot;r3&quot;,=C2=A0 &quot;r4&quot;,=C2=A0 &quot;r5&quot;,=C2=A0 &q=
uot;r6&quot;,=C2=A0 &quot;r7&quot;,<br>
+=C2=A0 =C2=A0 &quot;r8&quot;,=C2=A0 &quot;r9&quot;,=C2=A0 &quot;r10&quot;,=
 &quot;r11&quot;, &quot;r12&quot;, &quot;r13&quot;, &quot;r14&quot;, &quot;=
r15&quot;,<br>
+=C2=A0 =C2=A0 &quot;r16&quot;, &quot;r17&quot;, &quot;r18&quot;, &quot;r19=
&quot;, &quot;r20&quot;, &quot;r21&quot;, &quot;r22&quot;, &quot;r23&quot;,=
<br>
+=C2=A0 =C2=A0 &quot;r24&quot;, &quot;r25&quot;, &quot;r26&quot;, &quot;r27=
&quot;, &quot;r28&quot;, &quot;r29&quot;, &quot;r30&quot;, &quot;r31&quot;,=
<br>
+};<br>
+#define REG(x) (cpu_r[x])<br>
+<br>
+enum {<br>
+=C2=A0 =C2=A0 DISAS_EXIT=C2=A0 =C2=A0=3D DISAS_TARGET_0,=C2=A0 /* We want =
return to the cpu main loop.=C2=A0 */<br>
+=C2=A0 =C2=A0 DISAS_LOOKUP =3D DISAS_TARGET_1,=C2=A0 /* We have a variable=
 condition exit.=C2=A0 */<br>
+=C2=A0 =C2=A0 DISAS_CHAIN=C2=A0 =3D DISAS_TARGET_2,=C2=A0 /* We have a sin=
gle condition exit.=C2=A0 */<br>
+};<br>
+<br>
+typedef struct DisasContext DisasContext;<br>
+<br>
+/* This is the state at translation time. */<br>
+struct DisasContext {<br>
+=C2=A0 =C2=A0 TranslationBlock *tb;<br>
+<br>
+=C2=A0 =C2=A0 CPUAVRState *env;<br>
+=C2=A0 =C2=A0 CPUState *cs;<br>
+<br>
+=C2=A0 =C2=A0 target_long npc;<br>
+=C2=A0 =C2=A0 uint32_t opcode;<br>
+<br>
+=C2=A0 =C2=A0 /* Routine used to access memory */<br>
+=C2=A0 =C2=A0 int memidx;<br>
+=C2=A0 =C2=A0 int bstate;<br>
+=C2=A0 =C2=A0 int singlestep;<br>
+<br>
+=C2=A0 =C2=A0 TCGv skip_var0;<br>
+=C2=A0 =C2=A0 TCGv skip_var1;<br>
+=C2=A0 =C2=A0 TCGCond skip_cond;<br>
+=C2=A0 =C2=A0 bool free_skip_var0;<br>
+};<br>
+<br>
+static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }<=
br>
+static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }<b=
r>
+static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) * 2;=
 }<br>
+static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }<b=
r>
+<br>
+static uint16_t next_word(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 return cpu_lduw_code(ctx-&gt;env, ctx-&gt;npc++ * 2);<br>
+}<br>
+<br>
+static int append_16(DisasContext *ctx, int x)<br>
+{<br>
+=C2=A0 =C2=A0 return x &lt;&lt; 16 | next_word(ctx);<br>
+}<br>
+<br>
+<br>
+static bool avr_have_feature(DisasContext *ctx, int feature)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_feature(ctx-&gt;env, feature)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_unsupported(cpu_<wbr>env);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;bstate =3D DISAS_NORETURN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool decode_insn(DisasContext *ctx, uint16_t insn);<br>
+#include &quot;decode_insn.inc.c&quot;<br>
+<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--0000000000008e87ac05951e8191--

