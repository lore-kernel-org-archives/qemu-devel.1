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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA198CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C4A222C5
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBaQgQ2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C4A222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLS0b-0005Cw-Se
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLRyz-0003eD-9x
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLRyx-00018o-Pu
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:07:53 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLRyx-00018a-KH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:07:51 -0400
Received: by mail-oi1-x244.google.com with SMTP id w6so5117346oie.11
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=cU4Le2uZN2kUygkoBT99G2cJi+hgVIxtf8QhGpCMiEo=;
 b=OBaQgQ2KuZ4Z/Luu2xRAFlzj9GQN1HN6NYo3HIriFNyItnkhmrI7okgnhy/X0zVPHd
 qN29vaLB8hrqIE87dfIE5V+VO5E6OONt7AXZdl9uEiEdghweeNmy3crphyuuWlOoVZ4J
 hbnU5NKo9CZuYkB5WRiR1V2doWDGOzfe6tNpe6MCkVXVS/6U5WcKFeRs2LU0TnpwFZbF
 oXG9Qq9zg0c9gHiawzeH2xWb3NBWipZbH4eqYPojXovEzAAZlW/Sbf3rOyEQPKooYAs+
 WpAtApjsgLK+dwBW1Pgb3tCsLJYoZ9MmB9n/fSGUUycolaYQDIev1h/acGC54+4hkpys
 0cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=cU4Le2uZN2kUygkoBT99G2cJi+hgVIxtf8QhGpCMiEo=;
 b=fxVBL/Bdsx4CO4wcQINmCJ0VuSTM5y6EZQgIU0pVh5O3PqMIkNmwxYQnN6UIB6CCts
 hMFLJW/xSTPq79cDmsMr+KVibezhcITgrZPeMf79GeHycbLezWdMa1/OHD+XWf5s+d7V
 UqIBy2q4G3FONlYfCRqYZHOnYkV11li6PTpJC3Dmk2IjdMRDsf6Y++24SxXo+7lBzucF
 DDThVPc2xcpi07L/3m41+bvDluMybc59JaIzrNSmlHGl4D1YYDYOIIzA9oi/deTQZNxp
 VEvdrkioIqff5LX5Abb7niip1LlXYqwYsKm0n+QcpIZeECxl2//Zjt5twnsKmHJdPFsL
 b0Sg==
X-Gm-Message-State: APjAAAU5JKyFtNhiJa817L4fN1+0yW7pEkJrYgacOOSQTLXbCPinEX7O
 c3yVG9VHoiGglwjzokh+UsLApQDmo8822ssNIm0=
X-Google-Smtp-Source: APXvYqwZGyTi4q7XpMcPyzImyjrjoHWQ3o+TY3SryW5ivIhXH+dde0+zRINx8KZo+OAbACDK762fpZb0UJAuHbhYDKw=
X-Received: by 2002:aca:4e56:: with SMTP id c83mr8024184oib.53.1571404070902; 
 Fri, 18 Oct 2019 06:07:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 18 Oct 2019 06:07:50
 -0700 (PDT)
In-Reply-To: <e149d24f-8d77-4126-8fc8-012b114dfe37@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-27-philmd@redhat.com>
 <CAL1e-=jVr+idQKNdOGSrODeq7XU-0JcCFTwapqk9-JvAKxk6Pw@mail.gmail.com>
 <e149d24f-8d77-4126-8fc8-012b114dfe37@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 18 Oct 2019 15:07:50 +0200
Message-ID: <CAL1e-=iOhZATK3M4Qv8GXCtW8frSj7Jw5vGkJPUiz2G3Fh7BTw@mail.gmail.com>
Subject: Re: [PATCH 26/32] hw/pci-host/piix: Move RCR_IOPORT register
 definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000071e34205952f058c"
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

--00000000000071e34205952f058c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, October 18, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> On 10/18/19 11:19 AM, Aleksandar Markovic wrote:
>
>> On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com
>> <mailto:philmd@redhat.com>> wrote:
>>
>>     From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org <mailto:f4bug@ams=
at.org
>> >>
>>
>>     The RCR_IOPORT register belongs to the PIIX chipset.
>>     Move the definition to "piix.h".
>>
>>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>>     <mailto:philmd@redhat.com>>
>>     ---
>>       hw/pci-host/piix.c            | 1 +
>>       include/hw/i386/pc.h          | 6 ------
>>       include/hw/southbridge/piix.h | 6 ++++++
>>       3 files changed, 7 insertions(+), 6 deletions(-)
>>
>>
>> Does it make sense to add prefix PIIX_ or a similar one to the register
>> name?
>>
>
> Good idea, it will make the comment in hw/i386/acpi-build.c:213 cleaner:


Correct. Let's than add PIIX_ prefix.

Thanks in advance.

A.



>     /* The above need not be conditional on machine type because the rese=
t
> port
>      * happens to be the same on PIIX (pc) and ICH9 (q35). */
>     QEMU_BUILD_BUG_ON(ICH9_RST_CNT_IOPORT !=3D RCR_IOPORT);
>
>
>> In any case:
>>
>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com <mailto:
>> amarkovic@wavecomp.com>>
>>
>
> Thanks!
>
>
>>     diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
>>     index 3292703de7..3770575c1a 100644
>>     --- a/hw/pci-host/piix.c
>>     +++ b/hw/pci-host/piix.c
>>     @@ -27,6 +27,7 @@
>>       #include "hw/irq.h"
>>       #include "hw/pci/pci.h"
>>       #include "hw/pci/pci_host.h"
>>     +#include "hw/southbridge/piix.h"
>>       #include "hw/qdev-properties.h"
>>       #include "hw/isa/isa.h"
>>       #include "hw/sysbus.h"
>>     diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>>     index 183326d9fe..1c20b96571 100644
>>     --- a/include/hw/i386/pc.h
>>     +++ b/include/hw/i386/pc.h
>>     @@ -257,12 +257,6 @@ typedef struct PCII440FXState PCII440FXState;
>>
>>       #define TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE
>>     "igd-passthrough-i440FX"
>>
>>     -/*
>>     - * Reset Control Register: PCI-accessible ISA-Compatible Register
>>     at address
>>     - * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0,
>>     8086:7000).
>>     - */
>>     -#define RCR_IOPORT 0xcf9
>>     -
>>       PCIBus *i440fx_init(const char *host_type, const char *pci_type,
>>                           PCII440FXState **pi440fx_state, int *piix_devf=
n,
>>                           ISABus **isa_bus, qemu_irq *pic,
>>     diff --git a/include/hw/southbridge/piix.h
>>     b/include/hw/southbridge/piix.h
>>     index add352456b..79ebe0089b 100644
>>     --- a/include/hw/southbridge/piix.h
>>     +++ b/include/hw/southbridge/piix.h
>>     @@ -18,6 +18,12 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn,
>>     uint32_t smb_io_base,
>>                             qemu_irq sci_irq, qemu_irq smi_irq,
>>                             int smm_enabled, DeviceState **piix4_pm);
>>
>>     +/*
>>     + * Reset Control Register: PCI-accessible ISA-Compatible Register
>>     at address
>>     + * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0,
>>     8086:7000).
>>     + */
>>     +#define RCR_IOPORT 0xcf9
>>     +
>>       extern PCIDevice *piix4_dev;
>>
>>       DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
>>     --     2.21.0
>>
>>
>>

--00000000000071e34205952f058c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, October 18, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">On 10/18/19 11:19 AM, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"ma=
ilto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a> &lt;mailto:=
<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a=
>&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org" target=3D"_blank">f4bug@amsat.org</a> &lt;mailto:<a href=3D"mai=
lto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt;&gt;<br>
<br>
=C2=A0 =C2=A0 The RCR_IOPORT register belongs to the PIIX chipset.<br>
=C2=A0 =C2=A0 Move the definition to &quot;piix.h&quot;.<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mai=
lto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a><br>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:philmd@redhat.com" target=3D"_bl=
ank">philmd@redhat.com</a>&gt;&gt;<br>
=C2=A0 =C2=A0 ---<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0hw/pci-host/piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 1 +<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 6 ------<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0include/hw/southbridge/piix.<wbr>h | 6 ++++++<br>
=C2=A0 =C2=A0 =C2=A0=C2=A03 files changed, 7 insertions(+), 6 deletions(-)<=
br>
<br>
<br>
Does it make sense to add prefix PIIX_ or a similar one to the register nam=
e?<br>
</blockquote>
<br>
Good idea, it will make the comment in hw/i386/acpi-build.c:213 cleaner:</b=
lockquote><div><br></div><div>Correct. Let&#39;s than add PIIX_ prefix.</di=
v><div><br></div><div>Thanks in advance.</div><div><br></div><div>A.</div><=
div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=C2=A0 =C2=A0 /* The above need not be conditional on machine type because =
the reset port<br>
=C2=A0 =C2=A0 =C2=A0* happens to be the same on PIIX (pc) and ICH9 (q35). *=
/<br>
=C2=A0 =C2=A0 QEMU_BUILD_BUG_ON(ICH9_RST_CNT<wbr>_IOPORT !=3D RCR_IOPORT);<=
br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
In any case:<br>
<br>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.c=
om" target=3D"_blank">amarkovic@wavecomp.com</a> &lt;mailto:<a href=3D"mail=
to:amarkovic@wavecomp.com" target=3D"_blank">amarkovic@wavecomp.com</a><wbr=
>&gt;&gt;<br>
</blockquote>
<br>
Thanks!<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
=C2=A0 =C2=A0 diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c<br>
=C2=A0 =C2=A0 index 3292703de7..3770575c1a 100644<br>
=C2=A0 =C2=A0 --- a/hw/pci-host/piix.c<br>
=C2=A0 =C2=A0 +++ b/hw/pci-host/piix.c<br>
=C2=A0 =C2=A0 @@ -27,6 +27,7 @@<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0#include &quot;hw/pci/pci_host.h&quot;<br>
=C2=A0 =C2=A0 +#include &quot;hw/southbridge/piix.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0#include &quot;hw/isa/isa.h&quot;<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0 =C2=A0 diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h<br>
=C2=A0 =C2=A0 index 183326d9fe..1c20b96571 100644<br>
=C2=A0 =C2=A0 --- a/include/hw/i386/pc.h<br>
=C2=A0 =C2=A0 +++ b/include/hw/i386/pc.h<br>
=C2=A0 =C2=A0 @@ -257,12 +257,6 @@ typedef struct PCII440FXState PCII440FXS=
tate;<br>
<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0#define TYPE_IGD_PASSTHROUGH_I440FX_PC<wbr>I_DEVI=
CE<br>
=C2=A0 =C2=A0 &quot;igd-passthrough-i440FX&quot;<br>
<br>
=C2=A0 =C2=A0 -/*<br>
=C2=A0 =C2=A0 - * Reset Control Register: PCI-accessible ISA-Compatible Reg=
ister<br>
=C2=A0 =C2=A0 at address<br>
=C2=A0 =C2=A0 - * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function=
 0,<br>
=C2=A0 =C2=A0 8086:7000).<br>
=C2=A0 =C2=A0 - */<br>
=C2=A0 =C2=A0 -#define RCR_IOPORT 0xcf9<br>
=C2=A0 =C2=A0 -<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0PCIBus *i440fx_init(const char *host_type, const =
char *pci_type,<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0PCII440FXState **pi440fx_state, int *piix_devfn,<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0ISABus **isa_bus, qemu_irq *pic,<br>
=C2=A0 =C2=A0 diff --git a/include/hw/southbridge/piix.<wbr>h<br>
=C2=A0 =C2=A0 b/include/hw/southbridge/piix.<wbr>h<br>
=C2=A0 =C2=A0 index add352456b..79ebe0089b 100644<br>
=C2=A0 =C2=A0 --- a/include/hw/southbridge/piix.<wbr>h<br>
=C2=A0 =C2=A0 +++ b/include/hw/southbridge/piix.<wbr>h<br>
=C2=A0 =C2=A0 @@ -18,6 +18,12 @@ I2CBus *piix4_pm_init(PCIBus *bus, int dev=
fn,<br>
=C2=A0 =C2=A0 uint32_t smb_io_base,<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq sci_irq, qemu_irq smi_irq,<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int smm_enabled, DeviceState **piix4_pm);<br>
<br>
=C2=A0 =C2=A0 +/*<br>
=C2=A0 =C2=A0 + * Reset Control Register: PCI-accessible ISA-Compatible Reg=
ister<br>
=C2=A0 =C2=A0 at address<br>
=C2=A0 =C2=A0 + * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function=
 0,<br>
=C2=A0 =C2=A0 8086:7000).<br>
=C2=A0 =C2=A0 + */<br>
=C2=A0 =C2=A0 +#define RCR_IOPORT 0xcf9<br>
=C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0extern PCIDevice *piix4_dev;<br>
<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0DeviceState *piix4_create(PCIBus *pci_bus, ISABus=
 **isa_bus,<br>
=C2=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A02.21.0<br>
<br>
<br>
</blockquote>
</blockquote>

--00000000000071e34205952f058c--

