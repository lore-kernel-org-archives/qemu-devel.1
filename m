Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6A7C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C9C21741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDPF/JZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C9C21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05BL-0005Wu-Dx
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1j058B-0000d9-6D
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1j0588-0003Kt-Dh
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:18 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:44313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1j0588-0003Ft-66
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:16 -0500
Received: by mail-qv1-xf43.google.com with SMTP id n8so1114952qvg.11
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 07:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=54G+CYCHGRXMdevsxzhbkIds9bO1PhV2qcIwfkJFrAg=;
 b=iDPF/JZL8aRLAwpjXpbwBu4r246IRXlLUmvv/n5+ubR6X4CkQ25EcEr8Sk+SzDpzD0
 o53USTnoSwijRAKaXuGFjrZf0AEQ9hlOJXAzNVHjhu/SIo37YESturCK9fJJwpooI/bn
 xKUU1huUWi46gT227UuOwyK3vZMz3YWjPSLzTe4s/vkpAq2vSCXrqwUDDboL0B0XLBvW
 rBIiSEj68BT9zAjpWKBaWkCe45XRLyoKyZSNkug3TgzeVo0e/BWPzj2YM7DT/H79VTGa
 2+gOENxJL152cjf/RD0VvD5Ql91dsYi1g9mvhqwpUhxlkEl4eadprNseoMH/yOEWnWhd
 sLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=54G+CYCHGRXMdevsxzhbkIds9bO1PhV2qcIwfkJFrAg=;
 b=hqzttHGnwJE3dUV5sff4z/alDCIJvF8jqMf8Lrr1dAdyJ3a62hgugpX40KQQi+uIe4
 O9eovnStf5+3/QWGZ+0vBDz2FJp/iZ/nUVDNh246tWdtX57OJsrkOiHtjbaqLJVFTqtD
 2zep6bhBO6EQkd8pjNaWmjm81v8wyau/C/5N2ku9KhHJM/TBa2iY0f9F2IyX+9E//7M5
 XA+fXNuiKKr3mdzCEjFTVCGiULtjiW2qREVMd+ml8XXGPe6sOLILqellkkik5kf6buRp
 2ggliCBzDYsQRJbmL9H3TBgFYop5ETUctDdPp8DNEcujeePLRpD25FuNkn2lg2PiNNnM
 XVeA==
X-Gm-Message-State: APjAAAUMSJqY1wDjgPJ7MT2+HUt37OS4kpriJF6sd/m4pNEwaKJQ7YLl
 qpSqpsV+JOwyzUugBJ88S+BjHUSk02ZK2sUsf7U=
X-Google-Smtp-Source: APXvYqzq1XnKhgm45b99aTE82Xlf5f+dGVAsF8+lodDOlAqkQj3rYDENc2saAhvghw3fFAAo0M4J0MkjS/lgtLCZvNM=
X-Received: by 2002:a0c:8d0a:: with SMTP id r10mr6681724qvb.7.1581087675158;
 Fri, 07 Feb 2020 07:01:15 -0800 (PST)
MIME-Version: 1.0
References: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1581040680-308-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1581040680-308-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 7 Feb 2020 17:00:36 +0200
Message-ID: <CAK4993jtzCCqJEySYN8eXKKwZ51HS1LBxdpSs5-oow39jq4T8w@mail.gmail.com>
Subject: Re: [PATCH rc5 01/32] target/avr: Add basic parameters of the new
 platform
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="0000000000003c93de059dfda944"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003c93de059dfda944
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Michael Rolnik <mrolnik@gmail.com>

On Fri, Feb 7, 2020 at 3:58 AM Aleksandar Markovic <
aleksandar.markovic@rt-rk.com> wrote:

> From: Michael Rolnik <mrolnik@gmail.com>
>
> This includes definitions of various basic parameters needed
> for integration of a new platform into QEMU.
>
> [AM: Split a larger AVR introduction patch into logical units]
> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/avr/cpu-param.h | 37 ++++++++++++++++++++++++++++
>  target/avr/cpu.h       | 66
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS            |  7 ++++++
>  3 files changed, 110 insertions(+)
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
> index 0000000..ecdeafb
> --- /dev/null
> +++ b/target/avr/cpu.h
> @@ -0,0 +1,66 @@
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
> +#include "exec/cpu-defs.h"
> +
> +#define TCG_GUEST_DEFAULT_MO 0
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
> +#endif /* !defined (QEMU_AVR_CPU_H) */
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e72b5e5..4e47309 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -163,6 +163,13 @@ S: Maintained
>  F: hw/arm/smmu*
>  F: include/hw/arm/smmu*
>
> +AVR TCG CPUs
> +M: Michael Rolnik <mrolnik@gmail.com>
> +R: Sarah Harris <S.E.Harris@kent.ac.uk>
> +S: Maintained
> +F: target/avr/cpu-param.h
> +F: target/avr/cpu.h
> +
>  CRIS TCG CPUs
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
> --
> 2.7.4
>
>

--=20
Best Regards,
Michael Rolnik

--0000000000003c93de059dfda944
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gm=
ail.com">mrolnik@gmail.com</a>&gt;<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 7, 2020 at 3:58 AM Aleksa=
ndar Markovic &lt;<a href=3D"mailto:aleksandar.markovic@rt-rk.com">aleksand=
ar.markovic@rt-rk.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">From: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gma=
il.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
<br>
This includes definitions of various basic parameters needed<br>
for integration of a new platform into QEMU.<br>
<br>
[AM: Split a larger AVR introduction patch into logical units]<br>
Suggested-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@g=
mail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt;<br>
Co-developed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" ta=
rget=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Co-developed-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" =
target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" ta=
rget=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@=
gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt;<br>
Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" target=
=3D"_blank">imammedo@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0target/avr/cpu-param.h | 37 ++++++++++++++++++++++++++++<br>
=C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 66 +++++++++++++++++++++=
+++++++++++++++++++++++++++++<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 ++++++=
<br>
=C2=A03 files changed, 110 insertions(+)<br>
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
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" rel=3D"norefe=
rrer" target=3D"_blank">http://www.gnu.org/licenses/lgpl-2.1.html</a>&gt;<b=
r>
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
index 0000000..ecdeafb<br>
--- /dev/null<br>
+++ b/target/avr/cpu.h<br>
@@ -0,0 +1,66 @@<br>
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
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" rel=3D"norefe=
rrer" target=3D"_blank">http://www.gnu.org/licenses/lgpl-2.1.html</a>&gt;<b=
r>
+ */<br>
+<br>
+#ifndef QEMU_AVR_CPU_H<br>
+#define QEMU_AVR_CPU_H<br>
+<br>
+#include &quot;exec/cpu-defs.h&quot;<br>
+<br>
+#define TCG_GUEST_DEFAULT_MO 0<br>
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
+#endif /* !defined (QEMU_AVR_CPU_H) */<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index e72b5e5..4e47309 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -163,6 +163,13 @@ S: Maintained<br>
=C2=A0F: hw/arm/smmu*<br>
=C2=A0F: include/hw/arm/smmu*<br>
<br>
+AVR TCG CPUs<br>
+M: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blan=
k">mrolnik@gmail.com</a>&gt;<br>
+R: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" target=3D"_bl=
ank">S.E.Harris@kent.ac.uk</a>&gt;<br>
+S: Maintained<br>
+F: target/avr/cpu-param.h<br>
+F: target/avr/cpu.h<br>
+<br>
=C2=A0CRIS TCG CPUs<br>
=C2=A0M: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com" =
target=3D"_blank">edgar.iglesias@gmail.com</a>&gt;<br>
=C2=A0S: Maintained<br>
-- <br>
2.7.4<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--0000000000003c93de059dfda944--

