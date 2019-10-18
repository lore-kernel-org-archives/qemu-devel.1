Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00008CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B002D21897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eriAxyZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B002D21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOZq-0008SW-Tk
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLOY2-0006vd-5Y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLOY0-00058u-9J
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:27:50 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLOY0-00058W-3P
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:27:48 -0400
Received: by mail-ot1-x344.google.com with SMTP id s22so4398150otr.6
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=pUEiwwQjLt2xYtGo8SnML1+NaFafEWCmpGE3KBmhDn0=;
 b=eriAxyZteyVB4WtHCAzvWmaRQhkwM0uMDCK+my7Yjf1sn5WRYrPsA4yUc1qT++2uFQ
 bC4MFJbyEZVmSl0s7mc45RfXkjObw1xFrD33nZSb7vW5t9FqxrAD3S+vqktS3FSMElnZ
 qOqE7TOWMm43Cv0wsL/OHgEugzOxQKlQNLJMjkeEZLatlwH7T0BYyuGpwv4Ywd4qNtmi
 IRfxoT7kRuBmf1OHbfIOHASJGhHDCW0RKwLq5309ORgkG3ms/HL/RA+trH6uU0GH1Yz9
 DNCg08rLd1AWKa6COhUoL6OBM/jGXo9w9Jrj+Y6D2F5DCHjBNv+VnQSJ6BshlxL9H2Te
 xz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=pUEiwwQjLt2xYtGo8SnML1+NaFafEWCmpGE3KBmhDn0=;
 b=rDEaV6qyUvPbNA+vHi5vir45datokj+t/1/6Gg2qnl9kkbcsrV0DsljFvUoQzgDz78
 jlH+iRAZgYxJrKfdUGDm0/H2C/wjaqkWFsqKFEvwDiQJXwaKTQHH6TG8MOCBSdw745wv
 z+pBjraIatu9vjPrmQu+1p7l/Zeuq9ArClwWmNoGFuJ6xnnI42uKi/4YZdf/G14Ce4vK
 NS/LGuIUlK5LZUtXY/owoE/vSF4EYpjMWHAAgP99fxa6/3Pudd293iSllDcFnrosn4op
 V22jO5LuF0l/N7B0gY/lnNooTjGZ7cCsKAX8ImPyUmzrPiJcO7LF94AC8icMr5RJTS0h
 gFpg==
X-Gm-Message-State: APjAAAVCnqHzARbwWe6PboRbwWMINFMk2yhfdXx5jubCoNWk+MgMA3Bd
 oXmbdjPCfh3h+1LN4r3CegYr36JgrGOfWeFat7B0cg==
X-Google-Smtp-Source: APXvYqxLUhgmO8EKAWDeaK/wSUnVVwy1YBz5OXY5mIPd5Mh9un+34aA9PHp1kh0TApObn8a+hdslUGrfDw9XYkfzfOo=
X-Received: by 2002:a9d:4f0f:: with SMTP id d15mr6463206otl.64.1571390867071; 
 Fri, 18 Oct 2019 02:27:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 18 Oct 2019 02:27:46
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-29-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-29-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 18 Oct 2019 11:27:46 +0200
Message-ID: <CAL1e-=ioYVfXb1JEwM58BKt+wQ4bV82QnqiTD2uX65aJpVmdYw@mail.gmail.com>
Subject: Re: [PATCH 28/32] hw/pci-host/piix: Move i440FX declarations to
 hw/pci-host/i440fx.h
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006f688a05952bf23b"
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006f688a05952bf23b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> The hw/pci-host/piix.c contains a mix of PIIX3 and i440FX chipsets
> functions. To be able to split it, we need to export some
> declarations first.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS                  |  1 +
>  hw/acpi/pcihp.c              |  2 +-
>  hw/i386/pc_piix.c            |  1 +
>  hw/pci-host/piix.c           |  1 +
>  include/hw/i386/pc.h         | 22 ---------------------
>  include/hw/pci-host/i440fx.h | 37 ++++++++++++++++++++++++++++++++++++
>  stubs/pci-host-piix.c        |  3 ++-
>  7 files changed, 43 insertions(+), 24 deletions(-)
>  create mode 100644 include/hw/pci-host/i440fx.h
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/MAINTAINERS b/MAINTAINERS
> index 556f58bd8c..adf059a164 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1228,6 +1228,7 @@ F: hw/i386/
>  F: hw/pci-host/piix.c
>  F: hw/pci-host/q35.c
>  F: hw/pci-host/pam.c
> +F: include/hw/pci-host/i440fx.h
>  F: include/hw/pci-host/q35.h
>  F: include/hw/pci-host/pam.h
>  F: hw/isa/lpc_ich9.c
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 82d295b6e8..8413348a33 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -27,7 +27,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/pcihp.h"
>
> -#include "hw/i386/pc.h"
> +#include "hw/pci-host/i440fx.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/acpi/acpi.h"
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 5b35ff04c7..8ac4bf12ca 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -29,6 +29,7 @@
>  #include "hw/loader.h"
>  #include "hw/i386/pc.h"
>  #include "hw/i386/apic.h"
> +#include "hw/pci-host/i440fx.h"
>  #include "hw/southbridge/piix.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/firmware/smbios.h"
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index a450fc726e..0b5da5bc94 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -27,6 +27,7 @@
>  #include "hw/irq.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_host.h"
> +#include "hw/pci-host/i440fx.h"
>  #include "hw/southbridge/piix.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/isa/isa.h"
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 1c20b96571..cead2828de 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -248,28 +248,6 @@ int cmos_get_fd_drive_type(FloppyDriveType fd0);
>  /* hpet.c */
>  extern int no_hpet;
>
> -/* piix_pci.c */
> -struct PCII440FXState;
> -typedef struct PCII440FXState PCII440FXState;
> -
> -#define TYPE_I440FX_PCI_HOST_BRIDGE "i440FX-pcihost"
> -#define TYPE_I440FX_PCI_DEVICE "i440FX"
> -
> -#define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
> -
> -PCIBus *i440fx_init(const char *host_type, const char *pci_type,
> -                    PCII440FXState **pi440fx_state, int *piix_devfn,
> -                    ISABus **isa_bus, qemu_irq *pic,
> -                    MemoryRegion *address_space_mem,
> -                    MemoryRegion *address_space_io,
> -                    ram_addr_t ram_size,
> -                    ram_addr_t below_4g_mem_size,
> -                    ram_addr_t above_4g_mem_size,
> -                    MemoryRegion *pci_memory,
> -                    MemoryRegion *ram_memory);
> -
> -PCIBus *find_i440fx(void);
> -
>  /* pc_sysfw.c */
>  void pc_system_flash_create(PCMachineState *pcms);
>  void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion
> *rom_memory);
> diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
> new file mode 100644
> index 0000000000..e327f9bf87
> --- /dev/null
> +++ b/include/hw/pci-host/i440fx.h
> @@ -0,0 +1,37 @@
> +/*
> + * QEMU i440FX North Bridge Emulation
> + *
> + * Copyright (c) 2006 Fabrice Bellard
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef HW_PCI_I440FX_H
> +#define HW_PCI_I440FX_H
> +
> +#include "hw/hw.h"
> +#include "hw/pci/pci_bus.h"
> +
> +typedef struct PCII440FXState PCII440FXState;
> +
> +#define TYPE_I440FX_PCI_HOST_BRIDGE "i440FX-pcihost"
> +#define TYPE_I440FX_PCI_DEVICE "i440FX"
> +
> +#define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE "igd-passthrough-i440FX"
> +
> +PCIBus *i440fx_init(const char *host_type, const char *pci_type,
> +                    PCII440FXState **pi440fx_state, int *piix_devfn,
> +                    ISABus **isa_bus, qemu_irq *pic,
> +                    MemoryRegion *address_space_mem,
> +                    MemoryRegion *address_space_io,
> +                    ram_addr_t ram_size,
> +                    ram_addr_t below_4g_mem_size,
> +                    ram_addr_t above_4g_mem_size,
> +                    MemoryRegion *pci_memory,
> +                    MemoryRegion *ram_memory);
> +
> +PCIBus *find_i440fx(void);
> +
> +#endif
> diff --git a/stubs/pci-host-piix.c b/stubs/pci-host-piix.c
> index 6ed81b1f21..93975adbfe 100644
> --- a/stubs/pci-host-piix.c
> +++ b/stubs/pci-host-piix.c
> @@ -1,5 +1,6 @@
>  #include "qemu/osdep.h"
> -#include "hw/i386/pc.h"
> +#include "hw/pci-host/i440fx.h"
> +
>  PCIBus *find_i440fx(void)
>  {
>      return NULL;
> --
> 2.21.0
>
>
>

--0000000000006f688a05952bf23b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"ma=
ilto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>
<br>
The hw/pci-host/piix.c contains a mix of PIIX3 and i440FX chipsets<br>
functions. To be able to split it, we need to export some<br>
declarations first.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-<br>
=C2=A0hw/i386/pc_piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 =
+<br>
=C2=A0hw/pci-host/piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 =
+<br>
=C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 22 ----------=
-----------<br>
=C2=A0include/hw/pci-host/i440fx.h | 37 ++++++++++++++++++++++++++++++<wbr>=
++++++<br>
=C2=A0stubs/pci-host-piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A07 files changed, 43 insertions(+), 24 deletions(-)<br>
=C2=A0create mode 100644 include/hw/pci-host/i440fx.h<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank" st=
yle=3D"font-size:14px;line-height:22.1200008392334px">amarkovic@wavecomp.co=
m</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000=
08392334px">&gt;</span><br></div><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 556f58bd8c..adf059a164 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1228,6 +1228,7 @@ F: hw/i386/<br>
=C2=A0F: hw/pci-host/piix.c<br>
=C2=A0F: hw/pci-host/q35.c<br>
=C2=A0F: hw/pci-host/pam.c<br>
+F: include/hw/pci-host/i440fx.h<br>
=C2=A0F: include/hw/pci-host/q35.h<br>
=C2=A0F: include/hw/pci-host/pam.h<br>
=C2=A0F: hw/isa/lpc_ich9.c<br>
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c<br>
index 82d295b6e8..8413348a33 100644<br>
--- a/hw/acpi/pcihp.c<br>
+++ b/hw/acpi/pcihp.c<br>
@@ -27,7 +27,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;hw/acpi/pcihp.h&quot;<br>
<br>
-#include &quot;hw/i386/pc.h&quot;<br>
+#include &quot;hw/pci-host/i440fx.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci_bridge.h&quot;<br>
=C2=A0#include &quot;hw/acpi/acpi.h&quot;<br>
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c<br>
index 5b35ff04c7..8ac4bf12ca 100644<br>
--- a/hw/i386/pc_piix.c<br>
+++ b/hw/i386/pc_piix.c<br>
@@ -29,6 +29,7 @@<br>
=C2=A0#include &quot;hw/loader.h&quot;<br>
=C2=A0#include &quot;hw/i386/pc.h&quot;<br>
=C2=A0#include &quot;hw/i386/apic.h&quot;<br>
+#include &quot;hw/pci-host/i440fx.h&quot;<br>
=C2=A0#include &quot;hw/southbridge/piix.h&quot;<br>
=C2=A0#include &quot;hw/display/ramfb.h&quot;<br>
=C2=A0#include &quot;hw/firmware/smbios.h&quot;<br>
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c<br>
index a450fc726e..0b5da5bc94 100644<br>
--- a/hw/pci-host/piix.c<br>
+++ b/hw/pci-host/piix.c<br>
@@ -27,6 +27,7 @@<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci_host.h&quot;<br>
+#include &quot;hw/pci-host/i440fx.h&quot;<br>
=C2=A0#include &quot;hw/southbridge/piix.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
=C2=A0#include &quot;hw/isa/isa.h&quot;<br>
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h<br>
index 1c20b96571..cead2828de 100644<br>
--- a/include/hw/i386/pc.h<br>
+++ b/include/hw/i386/pc.h<br>
@@ -248,28 +248,6 @@ int cmos_get_fd_drive_type(<wbr>FloppyDriveType fd0);<=
br>
=C2=A0/* hpet.c */<br>
=C2=A0extern int no_hpet;<br>
<br>
-/* piix_pci.c */<br>
-struct PCII440FXState;<br>
-typedef struct PCII440FXState PCII440FXState;<br>
-<br>
-#define TYPE_I440FX_PCI_HOST_BRIDGE &quot;i440FX-pcihost&quot;<br>
-#define TYPE_I440FX_PCI_DEVICE &quot;i440FX&quot;<br>
-<br>
-#define TYPE_IGD_PASSTHROUGH_I440FX_<wbr>PCI_DEVICE &quot;igd-passthrough-=
i440FX&quot;<br>
-<br>
-PCIBus *i440fx_init(const char *host_type, const char *pci_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCII=
440FXState **pi440fx_state, int *piix_devfn,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ISAB=
us **isa_bus, qemu_irq *pic,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memo=
ryRegion *address_space_mem,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memo=
ryRegion *address_space_io,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_=
addr_t ram_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_=
addr_t below_4g_mem_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_=
addr_t above_4g_mem_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memo=
ryRegion *pci_memory,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memo=
ryRegion *ram_memory);<br>
-<br>
-PCIBus *find_i440fx(void);<br>
-<br>
=C2=A0/* pc_sysfw.c */<br>
=C2=A0void pc_system_flash_create(<wbr>PCMachineState *pcms);<br>
=C2=A0void pc_system_firmware_init(<wbr>PCMachineState *pcms, MemoryRegion =
*rom_memory);<br>
diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h<br=
>
new file mode 100644<br>
index 0000000000..e327f9bf87<br>
--- /dev/null<br>
+++ b/include/hw/pci-host/i440fx.h<br>
@@ -0,0 +1,37 @@<br>
+/*<br>
+ * QEMU i440FX North Bridge Emulation<br>
+ *<br>
+ * Copyright (c) 2006 Fabrice Bellard<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
+ * See the COPYING file in the top-level directory.<br>
+ *<br>
+ */<br>
+<br>
+#ifndef HW_PCI_I440FX_H<br>
+#define HW_PCI_I440FX_H<br>
+<br>
+#include &quot;hw/hw.h&quot;<br>
+#include &quot;hw/pci/pci_bus.h&quot;<br>
+<br>
+typedef struct PCII440FXState PCII440FXState;<br>
+<br>
+#define TYPE_I440FX_PCI_HOST_BRIDGE &quot;i440FX-pcihost&quot;<br>
+#define TYPE_I440FX_PCI_DEVICE &quot;i440FX&quot;<br>
+<br>
+#define TYPE_IGD_PASSTHROUGH_I440FX_<wbr>PCI_DEVICE &quot;igd-passthrough-=
i440FX&quot;<br>
+<br>
+PCIBus *i440fx_init(const char *host_type, const char *pci_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCII=
440FXState **pi440fx_state, int *piix_devfn,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ISAB=
us **isa_bus, qemu_irq *pic,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memo=
ryRegion *address_space_mem,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memo=
ryRegion *address_space_io,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_=
addr_t ram_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_=
addr_t below_4g_mem_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_=
addr_t above_4g_mem_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memo=
ryRegion *pci_memory,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memo=
ryRegion *ram_memory);<br>
+<br>
+PCIBus *find_i440fx(void);<br>
+<br>
+#endif<br>
diff --git a/stubs/pci-host-piix.c b/stubs/pci-host-piix.c<br>
index 6ed81b1f21..93975adbfe 100644<br>
--- a/stubs/pci-host-piix.c<br>
+++ b/stubs/pci-host-piix.c<br>
@@ -1,5 +1,6 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;hw/i386/pc.h&quot;<br>
+#include &quot;hw/pci-host/i440fx.h&quot;<br>
+<br>
=C2=A0PCIBus *find_i440fx(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--0000000000006f688a05952bf23b--

