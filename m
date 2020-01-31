Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B06C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 19:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D2D2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 19:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u47rTcU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D2D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixbtf-0005U5-S5
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 14:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixbsy-00053C-FQ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 14:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixbsv-0000wb-Ju
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 14:23:24 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixbsv-0000sg-AU
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 14:23:21 -0500
Received: by mail-ot1-x344.google.com with SMTP id a15so7670379otf.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 11:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=/kBHTiApJt6OyzLUl5CZOGKN5XAKmv2WREXnrMV28zI=;
 b=u47rTcU+35+M8kQEtHEm5cnVvh34tPeK9I74o6J52qPpLdPI1AeyBjQkoAr82HOTX/
 31iCkMe1MuD5QfNLPArO7ZjUnuFZzNuzUYrVuDJDHvzII7gyDqVgE1gfcFBv2X8K9R6N
 PFBYOfi97ZY8fgTnhIRA5ns1F98bXkj7uMtOGXtPRmKRAwgHWUCKCq+Z6w84/0LkOqOi
 ifQRQXBdY0rq0+XmA+k9GC7+FTZLp6h9GLOaVe2ZT9E1mNlhKz6VZL3lBUr0YU/RSlnq
 YRsuYSrNZ7lAd9bojg9gvDs6nKrrjI83dyoWL5JPpeVYqkCzIwN9gWKGY7zMP78tgRWs
 8EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=/kBHTiApJt6OyzLUl5CZOGKN5XAKmv2WREXnrMV28zI=;
 b=djJBaDgCLeBHP18qtwNCRbHha9pOGAU8+aurmoF9EICNs4DMszC793GlyRdRFnnBYC
 ipNZTIsDphbv5qiA/oP6hLCj0kZiLbMBNmWbXIXSQ19ZIhEtEk9IAnivRUjPCULDdsP3
 SYot2kjoopTkRm4C5lToJxuzydGpngCrPQTxsnJvhLKXj9t0ZiF2MgesFvRoBh9S8b12
 xiRa8PaEcShb4dTyyB9lYFybgzyshfEMStmSXNSnb/udhl1x87hRS0l+mzOJbUSiubUX
 i82UK4mX+SAzKD06M7a6bvVUJus1vKygRZ+V0/xgjiS1FDmtAATBgB59wn57s1Vpf62P
 zsPg==
X-Gm-Message-State: APjAAAVwRl0GkWIhqeP8u+8LNnhtgr7zg0Qf9KiZBlDfzmN0WSxqONbe
 CTwi04TzIeeR4Pc9p6nXwKUqDNKfjedIBPpvbGo=
X-Google-Smtp-Source: APXvYqwuj1tTSJd6XTI2QXTwhpb331kXTLKQlImxa5XALUYi/GPmAQQ16TR0GVsjwppO2ni87J/u1K6uSXexJ+PSceY=
X-Received: by 2002:a9d:831:: with SMTP id 46mr9081957oty.295.1580498600452;
 Fri, 31 Jan 2020 11:23:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 31 Jan 2020 11:23:20 -0800 (PST)
In-Reply-To: <1580428993-4767-2-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 31 Jan 2020 20:23:20 +0100
Message-ID: <CAL1e-=jQMCdQ9QmG1j0MfTcg7T0DV8iYtrJ4Muu3wf95cRwULA@mail.gmail.com>
Subject: Re: [PATCH rc4 01/29] target/avr: Add basic parameters for new AVR
 platform
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="000000000000a5e4dc059d74811f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a5e4dc059d74811f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, January 31, 2020, Aleksandar Markovic <
aleksandar.markovic@rt-rk.com> wrote:

> From: Michael Rolnik <mrolnik@gmail.com>
>
> This includes definitions of various basic parameters needed
> for integration of a new platform into QEMU.
>
> [AM: Split a larger AVR introduction patch into logical units]
> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>
> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> ---
>  target/avr/cpu-param.h | 37 ++++++++++++++++++++++++++
>  target/avr/cpu.h       | 72 ++++++++++++++++++++++++++++++
> ++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 target/avr/cpu-param.h
>  create mode 100644 target/avr/cpu.h
>
> diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
> new file mode 100644
> index 0000000..0c29ce4
> --- /dev/null
> +++ b/target/avr/cpu-param.h
> @@ -0,0 +1,37 @@
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
> +#ifndef AVR_CPU_PARAM_H
> +#define AVR_CPU_PARAM_H
> +
> +#define TARGET_LONG_BITS 32
> +/*
> + * TARGET_PAGE_BITS cannot be more than 8 bits because
> + * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and the=
y
> + *     should be implemented as a device and not memory
> + * 2.  SRAM starts at the address 0x0100
> + */
> +#define TARGET_PAGE_BITS 8
> +#define TARGET_PHYS_ADDR_SPACE_BITS 24
> +#define TARGET_VIRT_ADDR_SPACE_BITS 24
> +#define NB_MMU_MODES 2
> +
> +
> +#endif
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> new file mode 100644
> index 0000000..d122611
> --- /dev/null
> +++ b/target/avr/cpu.h
> @@ -0,0 +1,72 @@
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
> +#ifndef QEMU_AVR_CPU_H
> +#define QEMU_AVR_CPU_H
> +
> +#include "cpu-qom.h"
> +#include "exec/cpu-defs.h"
> +
> +#define TCG_GUEST_DEFAULT_MO 0
> +#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
> +#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
> +#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
> +
> +/*
> + * AVR has two memory spaces, data & code.
> + * e.g. both have 0 address
> + * ST/LD instructions access data space
> + * LPM/SPM and instruction fetching access code memory space
> + */
> +#define MMU_CODE_IDX 0
> +#define MMU_DATA_IDX 1
> +
> +#define EXCP_RESET 1
> +#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
> +
> +/* Number of CPU registers */
> +#define NUMBER_OF_CPU_REGISTERS 32
> +/* Number of IO registers accessible by ld/st/in/out */
> +#define NUMBER_OF_IO_REGISTERS 64
> +
> +/*
> + * Offsets of AVR memory regions in host memory space.
> + *
> + * This is needed because the AVR has separate code and data address
> + * spaces that both have start from zero but have to go somewhere in
> + * host memory.
> + *
> + * It's also useful to know where some things are, like the IO registers=
.
> + */
> +/* Flash program memory */
> +#define OFFSET_CODE 0x00000000
> +/* CPU registers, IO registers, and SRAM */
> +#define OFFSET_DATA 0x00800000
> +/* CPU registers specifically, these are mapped at the start of data */
> +#define OFFSET_CPU_REGISTERS OFFSET_DATA
> +/*
> + * IO registers, including status register, stack pointer, and memory
> + * mapped peripherals, mapped just after CPU registers
> + */
> +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)
> +
> +#define EF_AVR_MACH 0x7F


This line seems to belong more to patch 6, where it basically extracts bits
6..0 from e_flags.

+
> +#endif /* !defined (QEMU_AVR_CPU_H) */
> --
> 2.7.4
>
>

--000000000000a5e4dc059d74811f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, January 31, 2020, Aleksandar Markovic &lt;<a href=3D"mai=
lto:aleksandar.markovic@rt-rk.com">aleksandar.markovic@rt-rk.com</a>&gt; wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">From: Michael Rolnik &lt;<a href=3D"=
mailto:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt;<br>
<br>
This includes definitions of various basic parameters needed<br>
for integration of a new platform into QEMU.<br>
<br>
[AM: Split a larger AVR introduction patch into logical units]<br>
Suggested-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@g=
mail.com">aleksandar.m.mail@gmail.com</a>&gt;<br>
<br>
Co-developed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mr=
olnik@gmail.com</a>&gt;<br>
Co-developed-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk">=
S.E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk">S.=
E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo=
@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@=
gmail.com">aleksandar.m.mail@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/avr/cpu-param.h | 37 ++++++++++++++++++++++++++<br>
=C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 72 +++++++++++++++++++++=
+++++++++<wbr>++++++++++++++++++++<br>
=C2=A02 files changed, 109 insertions(+)<br>
=C2=A0create mode 100644 target/avr/cpu-param.h<br>
=C2=A0create mode 100644 target/avr/cpu.h<br>
<br>
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h<br>
new file mode 100644<br>
index 0000000..0c29ce4<br>
--- /dev/null<br>
+++ b/target/avr/cpu-param.h<br>
@@ -0,0 +1,37 @@<br>
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
+#ifndef AVR_CPU_PARAM_H<br>
+#define AVR_CPU_PARAM_H<br>
+<br>
+#define TARGET_LONG_BITS 32<br>
+/*<br>
+ * TARGET_PAGE_BITS cannot be more than 8 bits because<br>
+ * 1.=C2=A0 all IO registers occupy [0x0000 .. 0x00ff] address range, and =
they<br>
+ *=C2=A0 =C2=A0 =C2=A0should be implemented as a device and not memory<br>
+ * 2.=C2=A0 SRAM starts at the address 0x0100<br>
+ */<br>
+#define TARGET_PAGE_BITS 8<br>
+#define TARGET_PHYS_ADDR_SPACE_BITS 24<br>
+#define TARGET_VIRT_ADDR_SPACE_BITS 24<br>
+#define NB_MMU_MODES 2<br>
+<br>
+<br>
+#endif<br>
diff --git a/target/avr/cpu.h b/target/avr/cpu.h<br>
new file mode 100644<br>
index 0000000..d122611<br>
--- /dev/null<br>
+++ b/target/avr/cpu.h<br>
@@ -0,0 +1,72 @@<br>
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
+#ifndef QEMU_AVR_CPU_H<br>
+#define QEMU_AVR_CPU_H<br>
+<br>
+#include &quot;cpu-qom.h&quot;<br>
+#include &quot;exec/cpu-defs.h&quot;<br>
+<br>
+#define TCG_GUEST_DEFAULT_MO 0<br>
+#define AVR_CPU_TYPE_SUFFIX &quot;-&quot; TYPE_AVR_CPU<br>
+#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)<br>
+#define CPU_RESOLVING_TYPE TYPE_AVR_CPU<br>
+<br>
+/*<br>
+ * AVR has two memory spaces, data &amp; code.<br>
+ * e.g. both have 0 address<br>
+ * ST/LD instructions access data space<br>
+ * LPM/SPM and instruction fetching access code memory space<br>
+ */<br>
+#define MMU_CODE_IDX 0<br>
+#define MMU_DATA_IDX 1<br>
+<br>
+#define EXCP_RESET 1<br>
+#define EXCP_INT(n) (EXCP_RESET + (n) + 1)<br>
+<br>
+/* Number of CPU registers */<br>
+#define NUMBER_OF_CPU_REGISTERS 32<br>
+/* Number of IO registers accessible by ld/st/in/out */<br>
+#define NUMBER_OF_IO_REGISTERS 64<br>
+<br>
+/*<br>
+ * Offsets of AVR memory regions in host memory space.<br>
+ *<br>
+ * This is needed because the AVR has separate code and data address<br>
+ * spaces that both have start from zero but have to go somewhere in<br>
+ * host memory.<br>
+ *<br>
+ * It&#39;s also useful to know where some things are, like the IO registe=
rs.<br>
+ */<br>
+/* Flash program memory */<br>
+#define OFFSET_CODE 0x00000000<br>
+/* CPU registers, IO registers, and SRAM */<br>
+#define OFFSET_DATA 0x00800000<br>
+/* CPU registers specifically, these are mapped at the start of data */<br=
>
+#define OFFSET_CPU_REGISTERS OFFSET_DATA<br>
+/*<br>
+ * IO registers, including status register, stack pointer, and memory<br>
+ * mapped peripherals, mapped just after CPU registers<br>
+ */<br>
+#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)<br>
+<br>
+#define EF_AVR_MACH 0x7F</blockquote><div><br></div><div>This line seems t=
o belong more to patch 6, where it basically extracts bits 6..0 from e_flag=
s.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+<br>
+#endif /* !defined (QEMU_AVR_CPU_H) */<br>
-- <br>
2.7.4<br>
<br>
</blockquote>

--000000000000a5e4dc059d74811f--

