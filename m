Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DADBCA9EB9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 05:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF39F2087F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 05:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY2vVsG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF39F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPJvL-0003VD-TW
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 01:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iPJtl-0002Vh-17
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 01:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iPJtj-0000mn-8a
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 01:18:28 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:34735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iPJti-0000mI-V3
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 01:18:27 -0400
Received: by mail-ot1-x332.google.com with SMTP id m19so8756621otp.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 22:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=lumdLydA9oGXW9YM5W5Ui826YkmkN/DTSbkxPOxW+ho=;
 b=LY2vVsG0MXamRxfz4XHvxroBbAQ92AT8L2T8cjQ7OGZezdWEAuhq9rQvaqPkYKWkNz
 bp8JeDmBcN8LuCQLEPgQfJEIyl5nt5lg1s0vUYFZCsdko1D65uYkxoYVD9hNHLYgmY3X
 t1KSIHgTBl4DEvJLoI1xMUK8IVNSGzPpdBFqznqLNf/hMLHdcpmPDkV9x5qni+Xcwmr/
 91lSO+vo/BC5qI7xlr3kevL2oRVrdZfaV+B6MLYfw1lH6lfZjRLuyFiVFN1QDjL3Dha1
 hmyXmtj/lYIwgqHS/lmzKTEae0s7xR+/k5mQnJWmKIm8YpjfUVj6uhXntdI6nyhEg9x9
 AadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=lumdLydA9oGXW9YM5W5Ui826YkmkN/DTSbkxPOxW+ho=;
 b=di6tiKSWKqJoBYTzK4AAXl26Xo3Ts8nfWHqZari0U+8gAzlYByr5luyvDYMSXGCSt1
 ptbAtprS8YSBt+hvT6ISbLYctI9P1+cyF2FEkD/r+Cb49isW3hdkjG9aDHh/86lvaFU2
 s3Dzs2S9oasoBy9/v8LFhgt7TFN/NtHwRbnFdLZ6C+4JQWj4RHbiKLnlr+aWhDUvGT2i
 agL27KNwk4QGKL04KF7z5a0k4NeJ5oOAOQyaKO6fMuaQXk0K7jXs5josbNQ2kPFrTBRi
 QIHlZcOCq6mvX++FzoelFstjF8PPP2Dt2ePVcuV8KuuHngw1n7pOKwIbWJEykRY6TGBK
 5QKw==
X-Gm-Message-State: APjAAAWdmDK1WsiUMauBfIyJ0rrban0zmS+dxMlaR2LYpjh56URyo35H
 bM8m3QuX/cwj3QNjecea52QJOF70FvXJelj1h1M=
X-Google-Smtp-Source: APXvYqyBBeL69ZnijOoKZDk9as7mIs7i79unioey7ooRjT5KmG+1kBn2owJAHIx2xm6nuLu4ImvrF9T2JEVowvpbOY4=
X-Received: by 2002:a05:6830:1d8f:: with SMTP id
 y15mr7684091oti.121.1572326305982; 
 Mon, 28 Oct 2019 22:18:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 28 Oct 2019 22:18:25
 -0700 (PDT)
In-Reply-To: <20191028163447.18541-1-philmd@redhat.com>
References: <20191028163447.18541-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 29 Oct 2019 06:18:25 +0100
Message-ID: <CAL1e-=gK_Lf+ipsJxRPgyp01AuQiOeOn9QvzRxaR6LkTJiqhLA@mail.gmail.com>
Subject: Re: [PULL 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f06ec4059605be40"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f06ec4059605be40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, October 28, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> Hi Peter,
>
> This is a X86/MIPS pull, Paolo and Aleksandar are OK I send it:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04959.html
>
> Regards,
>
> Phil.
>
>
Does this pull request apply on the current code base directly, or is
dependant on prior application of other pull requests?

Thanks?
A.



> The following changes since commit 9bb73502321d46f4d320fa17aa3820
> 1445783fc4:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into
> staging (2019-10-28 13:32:40 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/pc_split_i440fx_piix-
> pull-request
>
> for you to fetch changes up to d1389352cde824ce8dab7c1a2ded150df6add124:
>
>   hw/pci-host/i440fx: Remove the last PIIX3 traces (2019-10-28 16:12:29
> +0100)
>
> ----------------------------------------------------------------
> The i440FX northbridge is only used by the PC machine, while the
> PIIX southbridge is also used by the Malta MIPS machine.
>
> Split the PIIX3 southbridge from i440FX northbridge.
>
> ----------------------------------------------------------------
>
> Herv=C3=A9 Poussineau (5):
>   piix4: Add the Reset Control Register
>   piix4: Add an i8259 Interrupt Controller as specified in datasheet
>   piix4: Rename PIIX4 object to piix4-isa
>   piix4: Add an i8257 DMA Controller as specified in datasheet
>   piix4: Add an i8254 PIT Controller as specified in datasheet
>
> Philippe Mathieu-Daud=C3=A9 (15):
>   MAINTAINERS: Keep PIIX4 South Bridge separate from PC Chipsets
>   Revert "irq: introduce qemu_irq_proxy()"
>   piix4: Add a MC146818 RTC Controller as specified in datasheet
>   hw/mips/mips_malta: Create IDE hard drive array dynamically
>   hw/mips/mips_malta: Extract the PIIX4 creation code as piix4_create()
>   hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c
>   hw/i386: Remove obsolete LoadStateHandler::load_state_old handlers
>   hw/pci-host/piix: Extract piix3_create()
>   hw/pci-host/piix: Move RCR_IOPORT register definition
>   hw/pci-host/piix: Define and use the PIIX IRQ Route Control Registers
>   hw/pci-host/piix: Move i440FX declarations to hw/pci-host/i440fx.h
>   hw/pci-host/piix: Fix code style issues
>   hw/pci-host/piix: Extract PIIX3 functions to hw/isa/piix3.c
>   hw/pci-host: Rename incorrectly named 'piix' as 'i440fx'
>   hw/pci-host/i440fx: Remove the last PIIX3 traces
>
>  MAINTAINERS                      |  14 +-
>  hw/acpi/pcihp.c                  |   2 +-
>  hw/acpi/piix4.c                  |  42 +--
>  hw/core/irq.c                    |  14 -
>  hw/i386/Kconfig                  |   3 +-
>  hw/i386/acpi-build.c             |   5 +-
>  hw/i386/pc_piix.c                |  10 +-
>  hw/i386/xen/xen-hvm.c            |   5 +-
>  hw/intc/apic_common.c            |  49 ----
>  hw/isa/Kconfig                   |   4 +
>  hw/isa/Makefile.objs             |   1 +
>  hw/isa/piix3.c                   | 399 +++++++++++++++++++++++++++++
>  hw/isa/piix4.c                   | 151 ++++++++++-
>  hw/mips/gt64xxx_pci.c            |   5 +-
>  hw/mips/mips_malta.c             |  46 +---
>  hw/pci-host/Kconfig              |   3 +-
>  hw/pci-host/Makefile.objs        |   2 +-
>  hw/pci-host/{piix.c =3D> i440fx.c} | 424 +------------------------------
>  hw/timer/i8254_common.c          |  40 ---
>  include/hw/acpi/piix4.h          |   6 -
>  include/hw/i386/pc.h             |  37 ---
>  include/hw/irq.h                 |   5 -
>  include/hw/isa/isa.h             |   2 +
>  include/hw/pci-host/i440fx.h     |  36 +++
>  include/hw/southbridge/piix.h    |  74 ++++++
>  stubs/pci-host-piix.c            |   3 +-
>  26 files changed, 699 insertions(+), 683 deletions(-)
>  create mode 100644 hw/isa/piix3.c
>  rename hw/pci-host/{piix.c =3D> i440fx.c} (58%)
>  delete mode 100644 include/hw/acpi/piix4.h
>  create mode 100644 include/hw/pci-host/i440fx.h
>  create mode 100644 include/hw/southbridge/piix.h
>
> --
> 2.21.0
>
>
>

--000000000000f06ec4059605be40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 28, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">Hi Peter,<br>
<br>
This is a X86/MIPS pull, Paolo and Aleksandar are OK I send it:<br>
<br>
=C2=A0 <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg=
04959.html" target=3D"_blank">https://lists.gnu.org/archive/<wbr>html/qemu-=
devel/2019-10/<wbr>msg04959.html</a><br>
<br>
Regards,<br>
<br>
Phil.<br>
<br></blockquote><div><br></div><div>Does this pull request apply on the cu=
rrent code base directly, or is dependant on prior application of other pul=
l requests?</div><div><br></div><div>Thanks?</div><div>A.</div><div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
The following changes since commit 9bb73502321d46f4d320fa17aa3820<wbr>14457=
83fc4:<br>
<br>
=C2=A0 Merge remote-tracking branch &#39;remotes/mst/tags/for_<wbr>upstream=
&#39; into staging (2019-10-28 13:32:40 +0000)<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/philmd/qemu.git" target=3D"_blank">htt=
ps://gitlab.com/philmd/<wbr>qemu.git</a> tags/pc_split_i440fx_piix-<wbr>pul=
l-request<br>
<br>
for you to fetch changes up to d1389352cde824ce8dab7c1a2ded15<wbr>0df6add12=
4:<br>
<br>
=C2=A0 hw/pci-host/i440fx: Remove the last PIIX3 traces (2019-10-28 16:12:2=
9 +0100)<br>
<br>
------------------------------<wbr>------------------------------<wbr>----<=
br>
The i440FX northbridge is only used by the PC machine, while the<br>
PIIX southbridge is also used by the Malta MIPS machine.<br>
<br>
Split the PIIX3 southbridge from i440FX northbridge.<br>
<br>
------------------------------<wbr>------------------------------<wbr>----<=
br>
<br>
Herv=C3=A9 Poussineau (5):<br>
=C2=A0 piix4: Add the Reset Control Register<br>
=C2=A0 piix4: Add an i8259 Interrupt Controller as specified in datasheet<b=
r>
=C2=A0 piix4: Rename PIIX4 object to piix4-isa<br>
=C2=A0 piix4: Add an i8257 DMA Controller as specified in datasheet<br>
=C2=A0 piix4: Add an i8254 PIT Controller as specified in datasheet<br>
<br>
Philippe Mathieu-Daud=C3=A9 (15):<br>
=C2=A0 MAINTAINERS: Keep PIIX4 South Bridge separate from PC Chipsets<br>
=C2=A0 Revert &quot;irq: introduce qemu_irq_proxy()&quot;<br>
=C2=A0 piix4: Add a MC146818 RTC Controller as specified in datasheet<br>
=C2=A0 hw/mips/mips_malta: Create IDE hard drive array dynamically<br>
=C2=A0 hw/mips/mips_malta: Extract the PIIX4 creation code as piix4_create(=
)<br>
=C2=A0 hw/isa/piix4: Move piix4_create() to hw/isa/piix4.c<br>
=C2=A0 hw/i386: Remove obsolete LoadStateHandler::load_state_<wbr>old handl=
ers<br>
=C2=A0 hw/pci-host/piix: Extract piix3_create()<br>
=C2=A0 hw/pci-host/piix: Move RCR_IOPORT register definition<br>
=C2=A0 hw/pci-host/piix: Define and use the PIIX IRQ Route Control Register=
s<br>
=C2=A0 hw/pci-host/piix: Move i440FX declarations to hw/pci-host/i440fx.h<b=
r>
=C2=A0 hw/pci-host/piix: Fix code style issues<br>
=C2=A0 hw/pci-host/piix: Extract PIIX3 functions to hw/isa/piix3.c<br>
=C2=A0 hw/pci-host: Rename incorrectly named &#39;piix&#39; as &#39;i440fx&=
#39;<br>
=C2=A0 hw/pci-host/i440fx: Remove the last PIIX3 traces<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +-<br>
=C2=A0hw/acpi/pcihp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0hw/acpi/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 42 +--<br>
=C2=A0hw/core/irq.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 14 -<br>
=C2=A0hw/i386/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0hw/i386/acpi-build.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A05 +-<br>
=C2=A0hw/i386/pc_piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 10 +-<br>
=C2=A0hw/i386/xen/xen-hvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A05 +-<br>
=C2=A0hw/intc/apic_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 49 ----<br>
=C2=A0hw/isa/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0hw/isa/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
=C2=A0hw/isa/piix3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 399 +++++++++++++++++++++++++++++<br>
=C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 151 ++++++++++-<br>
=C2=A0hw/mips/gt64xxx_pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A05 +-<br>
=C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 46 +---<br>
=C2=A0hw/pci-host/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A03 +-<br>
=C2=A0hw/pci-host/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 =
+-<br>
=C2=A0hw/pci-host/{piix.c =3D&gt; i440fx.c} | 424 +------------------------=
-----<wbr>-<br>
=C2=A0hw/timer/i8254_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 40 =
---<br>
=C2=A0include/hw/acpi/piix4.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A06 -<br>
=C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 37 ---<br>
=C2=A0include/hw/irq.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A05 -<br>
=C2=A0include/hw/isa/isa.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +<br>
=C2=A0include/hw/pci-host/i440fx.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 36 +++<br>
=C2=A0include/hw/southbridge/piix.h=C2=A0 =C2=A0 |=C2=A0 74 ++++++<br>
=C2=A0stubs/pci-host-piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A03 +-<br>
=C2=A026 files changed, 699 insertions(+), 683 deletions(-)<br>
=C2=A0create mode 100644 hw/isa/piix3.c<br>
=C2=A0rename hw/pci-host/{piix.c =3D&gt; i440fx.c} (58%)<br>
=C2=A0delete mode 100644 include/hw/acpi/piix4.h<br>
=C2=A0create mode 100644 include/hw/pci-host/i440fx.h<br>
=C2=A0create mode 100644 include/hw/southbridge/piix.h<br>
<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000f06ec4059605be40--

