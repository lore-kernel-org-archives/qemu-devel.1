Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88200C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55A4207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="gaEY7aDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55A4207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFH24-00043f-Of
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 09:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kFH1S-0003dB-0i
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:17:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kFH1P-0007Tt-N6
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:17:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id v4so14186137wmj.5
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zvl8SIyMQe++u6u6R7WM5RnDEw1Fekz/K8ua6AxACJ8=;
 b=gaEY7aDRruBmOVLxFaZ2PgFWwcF4358luelnLH7Rv7/6G+2oyXAqEwv7uYPXV09f0Q
 +KuHDDTlLspeJgARp2cRpo55aj/4e/ONjbi/XON44CABg9K+DqR2H4WcyBdLR2/FZT08
 yZv6tNq9tiLd37oFEo2Gv00g4dcgbtp5sOct+UbsoOvFROOtTdwNGnKrg1OjWsKxjwGD
 pYIouzWMKf8+Ilg5/RIIV2G0rAUiJMtZ8qwdqU0dIUP8rIDz3vx+Rg2YdVRBWhfAjeqC
 eF8zSeuC8AJtZ42SNQ8r7vaM35wu9XgyrMS0GhDYBPBUmWM0W9QsQxdCBD+GLCxKZx2D
 zyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zvl8SIyMQe++u6u6R7WM5RnDEw1Fekz/K8ua6AxACJ8=;
 b=c0tuy/S55Tt9QkFxS5LitNpzLM8GgwYaOddDr4Sfv10URdQF5Ut+ENuX3MsY3sEpnz
 FbPrmwne5IfUevIH8AgLsV7PPUONa9oQrJYEJiqnLglOtiPyDKMKIpcgaRmGSOK9A4G+
 5fQcnHTJd4M+PSepPOB89LlB7KgLHKwnAE+ms8VwTnEF8qgo1qBuRSd8ck2Yq/B8+tGn
 1FFF8nm3h4gqU6jHrlBAvRl2/NRt01O4YTMnX8sSQ4OVunL3FEva14+aPOh3gAliBkFP
 XPNglObeaRHEr/8hhfkBL76+zhPMxjkmVkAQ8XLMw/R/ULSkV5vSuf2fh/WR8Dw2kFhz
 z71g==
X-Gm-Message-State: AOAM530CgukWuODREIAeFAfLP2jXFee8/ArITvH9Z/PEigludiEXGJ+L
 f0gyUTqF21S/7nvXWjrFHsK0BJti02o2AITd1igo+UJlPs2+gg==
X-Google-Smtp-Source: ABdhPJzPZN03mEcBVDwwrp6pveVMYrHyIrXPnmcY6H/TwXi5GQPuF5O+tNVbfPlYNZNcRqu1C6L3lPE0k8mFELrXifQ=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr20068266wmf.20.1599484640944; 
 Mon, 07 Sep 2020 06:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200904161000.12115-1-ani@anisinha.ca>
In-Reply-To: <20200904161000.12115-1-ani@anisinha.ca>
From: Ani Sinha <ani@anisinha.ca>
Date: Mon, 7 Sep 2020 18:47:09 +0530
Message-ID: <CAARzgwzZtRzrLNpgeE3NtimQZzz9VunyTTGNQ8KXVkYzezZFiA@mail.gmail.com>
Subject: Re: [PATCH v3] i440fx/acpi: do not add hotplug related amls for cold
 plugged bridges
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d8fa9005aeb9097d"
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d8fa9005aeb9097d
Content-Type: text/plain; charset="UTF-8"

Julia Michael,

Can you please provide your inputs on this one and the corresponding unit
tests?

On Fri, Sep 4, 2020 at 9:40 PM Ani Sinha <ani@anisinha.ca> wrote:

> Cold plugged bridges are not hot unpluggable, even when their hotplug
>
> property (acpi-pci-hotplug-with-bridge-support) is turned off. Please see
>
> the function acpi_pcihp_pc_no_hotplug() (thanks Julia). However, with
>
> the current implementaton, windows would try to hot-unplug a pci bridge
> when
>
> it's hotplug switch is off. This is regardless of whether there are devices
>
> attached to the bridge. This is because we add amls like _EJ0 etc for the
>
> pci slot where the bridge is cold plugged. We have a demo video here:
>
> https://youtu.be/pME2sjyQweo
>
>
>
> In this fix, we identify a cold plugged bridge and for cold plugged
> bridges,
>
> we do not add the appropriate amls and acpi methods that are used by the OS
>
> to identify a hot-pluggable/unpluggable pci device. After this change,
> Windows
>
> does not show an option to eject the PCI bridge. A demo video is here:
>
> https://youtu.be/kbgej5B9Hgs
>
>
>
> While at it, I have also updated a stale comment.
>
>
>
> This change is tested with a Windows 2012R2 guest image and Windows 2019
> server
>
> guest image running on Ubuntu 18.04 host. This change is based off of
> upstream
>
> qemu master branch tag v5.1.0.
>
>
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
> ---
>
>  hw/i386/acpi-build.c | 12 ++++++------
>
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
>
>
> changelog:
>
> v3: commit log updates providing more accurate information as received
> from Julia.
>
> v2: cosmetic commit log updates with patch testing information.
>
> v1: initial patch.
>
>
>
>
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>
> index b7bcbbbb2a..90b863f4ec 100644
>
> --- a/hw/i386/acpi-build.c
>
> +++ b/hw/i386/acpi-build.c
>
> @@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml
> *parent_scope, PCIBus *bus,
>
>          int slot = PCI_SLOT(i);
>
>          bool hotplug_enabled_dev;
>
>          bool bridge_in_acpi;
>
> +        bool cold_plugged_bridge;
>
>
>
>          if (!pdev) {
>
>              if (bsel) { /* add hotplug slots for non present devices */
>
> @@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml
> *parent_scope, PCIBus *bus,
>
>          pc = PCI_DEVICE_GET_CLASS(pdev);
>
>          dc = DEVICE_GET_CLASS(pdev);
>
>
>
> -        /* When hotplug for bridges is enabled, bridges are
>
> -         * described in ACPI separately (see build_pci_bus_end).
>
> -         * In this case they aren't themselves hot-pluggable.
>
> +        /*
>
> +         * Cold plugged bridges aren't themselves hot-pluggable.
>
>           * Hotplugged bridges *are* hot-pluggable.
>
>           */
>
> -        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
>
> -            !DEVICE(pdev)->hotplugged;
>
> +        cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
>
> +        bridge_in_acpi =  cold_plugged_bridge && pcihp_bridge_en;
>
>
>
> -        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
>
> +        hotplug_enabled_dev = bsel && dc->hotpluggable &&
> !cold_plugged_bridge;
>
>
>
>          if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
>
>              continue;
>
> --
>
> 2.17.1
>
>
>
>

--000000000000d8fa9005aeb9097d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Julia Michael,</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Can you please provide your inputs on this one and the correspond=
ing unit tests?</div><div dir=3D"auto"><br></div><div dir=3D"auto">On Fri, =
Sep 4, 2020 at 9:40 PM Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca">ani=
@anisinha.ca</a>&gt; wrote:<br></div><div><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204=
,204,204)">Cold plugged bridges are not hot unpluggable, even when their ho=
tplug<br><br>property (acpi-pci-hotplug-with-bridge-support) is turned off.=
 Please see<br><br>the function acpi_pcihp_pc_no_hotplug() (thanks Julia). =
However, with<br><br>the current implementaton, windows would try to hot-un=
plug a pci bridge when<br><br>it&#39;s hotplug switch is off. This is regar=
dless of whether there are devices<br><br>attached to the bridge. This is b=
ecause we add amls like _EJ0 etc for the<br><br>pci slot where the bridge i=
s cold plugged. We have a demo video here:<br><br><a href=3D"https://youtu.=
be/pME2sjyQweo" rel=3D"noreferrer" target=3D"_blank">https://youtu.be/pME2s=
jyQweo</a><br><br><br><br>In this fix, we identify a cold plugged bridge an=
d for cold plugged bridges,<br><br>we do not add the appropriate amls and a=
cpi methods that are used by the OS<br><br>to identify a hot-pluggable/unpl=
uggable pci device. After this change, Windows<br><br>does not show an opti=
on to eject the PCI bridge. A demo video is here:<br><br><a href=3D"https:/=
/youtu.be/kbgej5B9Hgs" rel=3D"noreferrer" target=3D"_blank">https://youtu.b=
e/kbgej5B9Hgs</a><br><br><br><br>While at it, I have also updated a stale c=
omment.<br><br><br><br>This change is tested with a Windows 2012R2 guest im=
age and Windows 2019 server<br><br>guest image running on Ubuntu 18.04 host=
. This change is based off of upstream<br><br>qemu master branch tag v5.1.0=
.<br><br><br><br>Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:ani@anisinh=
a.ca" target=3D"_blank">ani@anisinha.ca</a>&gt;<br><br>---<br><br>=C2=A0hw/=
i386/acpi-build.c | 12 ++++++------<br><br>=C2=A01 file changed, 6 insertio=
ns(+), 6 deletions(-)<br><br><br><br>changelog:<br><br>v3: commit log updat=
es providing more accurate information as received from Julia.<br><br>v2: c=
osmetic commit log updates with patch testing information.<br><br>v1: initi=
al patch.<br><br><br><br><br><br>diff --git a/hw/i386/acpi-build.c b/hw/i38=
6/acpi-build.c<br><br>index b7bcbbbb2a..90b863f4ec 100644<br><br>--- a/hw/i=
386/acpi-build.c<br><br>+++ b/hw/i386/acpi-build.c<br><br>@@ -359,6 +359,7 =
@@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,=
<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int slot =3D PCI_SLOT(i);<br><br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool hotplug_enabled_dev;<br><br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0bool bridge_in_acpi;<br><br>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bool cold_plugged_bridge;<br><br><br><br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (!pdev) {<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (bsel) { /* add hotplug slots for non present devices */<br><br>@@=
 -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml *parent_sc=
ope, PCIBus *bus,<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pc =3D PCI_DEVIC=
E_GET_CLASS(pdev);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc =3D DEVICE_G=
ET_CLASS(pdev);<br><br><br><br>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* When hotplug=
 for bridges is enabled, bridges are<br><br>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* described in ACPI separately (see build_pci_bus_end).<br><br>-=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In this case they aren&#39;t themselves ho=
t-pluggable.<br><br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br><br>+=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0* Cold plugged bridges aren&#39;t themselves hot-plugga=
ble.<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Hotplugged bridges *are* h=
ot-pluggable.<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br><br>-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 bridge_in_acpi =3D pc-&gt;is_bridge &amp;&amp; pcihp_b=
ridge_en &amp;&amp;<br><br>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !DEVI=
CE(pdev)-&gt;hotplugged;<br><br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cold_plugged_b=
ridge =3D pc-&gt;is_bridge &amp;&amp; !DEVICE(pdev)-&gt;hotplugged;<br><br>=
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bridge_in_acpi =3D=C2=A0 cold_plugged_bridge &=
amp;&amp; pcihp_bridge_en;<br><br><br><br>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hotp=
lug_enabled_dev =3D bsel &amp;&amp; dc-&gt;hotpluggable &amp;&amp; !bridge_=
in_acpi;<br><br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hotplug_enabled_dev =3D bsel &=
amp;&amp; dc-&gt;hotpluggable &amp;&amp; !cold_plugged_bridge;<br><br><br><=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pc-&gt;class_id =3D=3D PCI_CLASS_B=
RIDGE_ISA) {<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continu=
e;<br><br>-- <br><br>2.17.1<br><br><br><br></blockquote></div></div>

--000000000000d8fa9005aeb9097d--

