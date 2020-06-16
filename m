Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1251BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41772098B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="YowGLFgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41772098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBYt-0002j3-2p
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1jlBVs-0007r4-DX
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:20:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1jlBVq-00059z-B4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:20:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id x13so20735120wrv.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fKmeIt7w8WPPk6i1PHJWxdOIec66Soh/1diRqhLZsno=;
 b=YowGLFgsNH9GJcQB4nfvooKOdd0NxFuxwliPBoS2E2IEf+FUbGkDEfIBlv+O4rudk7
 OrHSgDrCBLq5nvx8XZsPAwcA+WhUGLvpvKF8SXYZ3m8qDJ5rwKJ3J8X/tBBY0mAdwZsV
 5BvFiy+hlIhS+dDxvP/nt40ptpMwjmZEsoXilpNcyAXYJlm7WShONCmMhaYwRKnlQlBy
 FmCxhLFkGYtkFvT4npasz6TIxCWdulRD0HZgioAph6f70pxFr0WVm6/3+UEjzx+2MGCK
 o8brVkVT9p1EIW10cnHdpNeA+JguCBHqSwmFWLKkbSV0kiTtRpqxmZP3mHT2qyvgebRE
 ghiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fKmeIt7w8WPPk6i1PHJWxdOIec66Soh/1diRqhLZsno=;
 b=sp3mj4J+IMs6xSsdUp1UdEWr/YWOA7KbbE9VpDCYEGagjls+7kibSlCqNYpDNR35uw
 mTanWWWcjhMKJnJe1xy6/Owx54X6MBFUlktfboiJ6T+8ssUftxvuF7vK3ihhty55qeL6
 bz4N/LAYoKyyDYZ0fu9KOYMfykUFSk5oeWBtkuQLrTtzmO2k+GgiD4qUJbp5Qat02lb9
 DZMTcTtdKaDsIQ+nMce5VX9T8UaggbCjK0WbX9ggQuxpVJUMSlxi7T4xjGDQnHYnrOeb
 VNP8SIqZ/8HLHdDZQ5cbCeVrM82wOMnZhVmytPUtePTEPTL1XwrQ4gQBHnRhF7nnZqHJ
 0N5w==
X-Gm-Message-State: AOAM530I0Mn5ZqR9iLXcLV44ToPBOFJQGT00lfUvgFjENIOQyXhMPhpA
 jl9ZsixR4jPOk2Sf9SIsM4oPfjui0sN8xEJIlWHL9A==
X-Google-Smtp-Source: ABdhPJzL3+GWm67Tpurw0Vk48+Bu4nfgcabTtlb9C0RluQ2n7j/cFyDRjE/XG9wTqbLzSaPx+pPN6h7kA7MvwzfjHGk=
X-Received: by 2002:adf:b355:: with SMTP id k21mr3033229wrd.76.1592313624310; 
 Tue, 16 Jun 2020 06:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <1592310699-58916-1-git-send-email-ani.sinha@nutanix.com>
 <20200616151735.17a84340@redhat.com>
In-Reply-To: <20200616151735.17a84340@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 16 Jun 2020 18:50:13 +0530
Message-ID: <CAARzgwwKwdYW0BK4-W2=q=g3cN4BZfPN6p8QqvgAsqJ7tifHtA@mail.gmail.com>
Subject: Re: [PATCH V3] Rename use_acpi_pci_hotplug to more appropriate
 use_acpi_hotplug_bridge
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f2da2b05a8336748"
Received-SPF: none client-ip=2a00:1450:4864:20::443;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f2da2b05a8336748
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 16, 2020 at 6:47 PM Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 16 Jun 2020 12:31:39 +0000
> Ani Sinha <ani.sinha@nutanix.com> wrote:
>
> > Currently, the option use_acpi_pci_hotplug is being used to control
> device
> > hotplug capability using ACPI for slots of cold plugged bridges. Hence,
> we
> > are renaming this option to better reflect what it actually does.
> >
> > Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
> > ---
>
> what was wrong with v2?


i removed the change-id string.


> Also for the future,
> can you add under --- line change log please?
>
> >  hw/acpi/piix4.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)


It's already here.


> >
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index 85c199b..7de44bc 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -77,7 +77,7 @@ typedef struct PIIX4PMState {
> >      Notifier powerdown_notifier;
> >
> >      AcpiPciHpState acpi_pci_hotplug;
> > -    bool use_acpi_pci_hotplug;
> > +    bool use_acpi_hotplug_bridge;
> >
> >      uint8_t disable_s3;
> >      uint8_t disable_s4;
> > @@ -204,16 +204,17 @@ static const VMStateDescription vmstate_pci_status
> = {
> >      }
> >  };
> >
> > -static bool vmstate_test_use_acpi_pci_hotplug(void *opaque, int
> version_id)
> > +static bool vmstate_test_use_acpi_hotplug_bridge(void *opaque, int
> version_id)
> >  {
> >      PIIX4PMState *s = opaque;
> > -    return s->use_acpi_pci_hotplug;
> > +    return s->use_acpi_hotplug_bridge;
> >  }
> >
> > -static bool vmstate_test_no_use_acpi_pci_hotplug(void *opaque, int
> version_id)
> > +static bool vmstate_test_no_use_acpi_hotplug_bridge(void *opaque,
> > +                                                    int version_id)
> >  {
> >      PIIX4PMState *s = opaque;
> > -    return !s->use_acpi_pci_hotplug;
> > +    return !s->use_acpi_hotplug_bridge;
> >  }
> >
> >  static bool vmstate_test_use_memhp(void *opaque)
> > @@ -290,11 +291,11 @@ static const VMStateDescription vmstate_acpi = {
> >          VMSTATE_STRUCT_TEST(
> >
> acpi_pci_hotplug.acpi_pcihp_pci_status[ACPI_PCIHP_BSEL_DEFAULT],
> >              PIIX4PMState,
> > -            vmstate_test_no_use_acpi_pci_hotplug,
> > +            vmstate_test_no_use_acpi_hotplug_bridge,
> >              2, vmstate_pci_status,
> >              struct AcpiPciHpPciStatus),
> >          VMSTATE_PCI_HOTPLUG(acpi_pci_hotplug, PIIX4PMState,
> > -                            vmstate_test_use_acpi_pci_hotplug),
> > +                            vmstate_test_use_acpi_hotplug_bridge),
> >          VMSTATE_END_OF_LIST()
> >      },
> >      .subsections = (const VMStateDescription*[]) {
> > @@ -528,7 +529,7 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn,
> uint32_t smb_io_base,
> >      s->smi_irq = smi_irq;
> >      s->smm_enabled = smm_enabled;
> >      if (xen_enabled()) {
> > -        s->use_acpi_pci_hotplug = false;
> > +        s->use_acpi_hotplug_bridge = false;
> >      }
> >
> >      qdev_init_nofail(dev);
> > @@ -593,7 +594,7 @@ static void
> piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> >
> >      acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > -                    s->use_acpi_pci_hotplug);
> > +                    s->use_acpi_hotplug_bridge);
> >
> >      s->cpu_hotplug_legacy = true;
> >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > @@ -631,7 +632,7 @@ static Property piix4_pm_properties[] = {
> >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_DISABLED, PIIX4PMState,
> disable_s4, 0),
> >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> >      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support",
> PIIX4PMState,
> > -                     use_acpi_pci_hotplug, true),
> > +                     use_acpi_hotplug_bridge, true),
> >      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> >                       acpi_memory_hotplug.is_enabled, true),
> >      DEFINE_PROP_END_OF_LIST(),
>
>

--000000000000f2da2b05a8336748
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Jun 16, 2020 at 6:47 PM Igor Mammedov &lt;<a href=
=3D"mailto:imammedo@redhat.com">imammedo@redhat.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-color:=
rgb(204,204,204)">On Tue, 16 Jun 2020 12:31:39 +0000<br>
Ani Sinha &lt;<a href=3D"mailto:ani.sinha@nutanix.com" target=3D"_blank">an=
i.sinha@nutanix.com</a>&gt; wrote:<br>
<br>
&gt; Currently, the option use_acpi_pci_hotplug is being used to control de=
vice<br>
&gt; hotplug capability using ACPI for slots of cold plugged bridges. Hence=
, we<br>
&gt; are renaming this option to better reflect what it actually does.<br>
&gt; <br>
&gt; Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:ani.sinha@nutanix.com" =
target=3D"_blank">ani.sinha@nutanix.com</a>&gt;<br>
&gt; ---<br>
<br>
what was wrong with v2?</blockquote><div dir=3D"auto"><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,=
204)"></blockquote><div dir=3D"auto">i removed the change-id string.</div><=
div dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-l=
eft:1ex;border-left-color:rgb(204,204,204)"><br>
Also for the future,<br>
can you add under --- line change log please?<br>
<br>
&gt;=C2=A0 hw/acpi/piix4.c | 21 +++++++++++----------<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 10 deletions(-)</blockquote><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s already here.</div><di=
v dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-lef=
t:1ex;border-left-color:rgb(204,204,204)"><br>
&gt; <br>
&gt; diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c<br>
&gt; index 85c199b..7de44bc 100644<br>
&gt; --- a/hw/acpi/piix4.c<br>
&gt; +++ b/hw/acpi/piix4.c<br>
&gt; @@ -77,7 +77,7 @@ typedef struct PIIX4PMState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Notifier powerdown_notifier;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 AcpiPciHpState acpi_pci_hotplug;<br>
&gt; -=C2=A0 =C2=A0 bool use_acpi_pci_hotplug;<br>
&gt; +=C2=A0 =C2=A0 bool use_acpi_hotplug_bridge;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint8_t disable_s3;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint8_t disable_s4;<br>
&gt; @@ -204,16 +204,17 @@ static const VMStateDescription vmstate_pci_stat=
us =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; -static bool vmstate_test_use_acpi_pci_hotplug(void *opaque, int versi=
on_id)<br>
&gt; +static bool vmstate_test_use_acpi_hotplug_bridge(void *opaque, int ve=
rsion_id)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 PIIX4PMState *s =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 return s-&gt;use_acpi_pci_hotplug;<br>
&gt; +=C2=A0 =C2=A0 return s-&gt;use_acpi_hotplug_bridge;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -static bool vmstate_test_no_use_acpi_pci_hotplug(void *opaque, int ve=
rsion_id)<br>
&gt; +static bool vmstate_test_no_use_acpi_hotplug_bridge(void *opaque,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int version_id)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 PIIX4PMState *s =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 return !s-&gt;use_acpi_pci_hotplug;<br>
&gt; +=C2=A0 =C2=A0 return !s-&gt;use_acpi_hotplug_bridge;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static bool vmstate_test_use_memhp(void *opaque)<br>
&gt; @@ -290,11 +291,11 @@ static const VMStateDescription vmstate_acpi =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_STRUCT_TEST(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_pci_hotplug.acpi_=
pcihp_pci_status[ACPI_PCIHP_BSEL_DEFAULT],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PIIX4PMState,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmstate_test_no_use_acpi_pc=
i_hotplug,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmstate_test_no_use_acpi_ho=
tplug_bridge,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2, vmstate_pci_status,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct AcpiPciHpPciSta=
tus),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_PCI_HOTPLUG(acpi_pci_hotplug=
, PIIX4PMState,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmstate_test_use_acpi_pci_hotplug),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmstate_test_use_acpi_hotplug_bridge),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .subsections =3D (const VMStateDescription*[]) {<b=
r>
&gt; @@ -528,7 +529,7 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint=
32_t smb_io_base,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 s-&gt;smi_irq =3D smi_irq;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 s-&gt;smm_enabled =3D smm_enabled;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (xen_enabled()) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;use_acpi_pci_hotplug =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;use_acpi_hotplug_bridge =3D false;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdev_init_nofail(dev);<br>
&gt; @@ -593,7 +594,7 @@ static void piix4_acpi_system_hot_add_init(MemoryR=
egion *parent,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(parent, GPE_BASE, &amp=
;s-&gt;io_gpe);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 acpi_pcihp_init(OBJECT(s), &amp;s-&gt;acpi_pci_hot=
plug, bus, parent,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 s-&gt;use_acpi_pci_hotplug);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 s-&gt;use_acpi_hotplug_bridge);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 s-&gt;cpu_hotplug_legacy =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 object_property_add_bool(OBJECT(s), &quot;cpu-hotp=
lug-legacy&quot;,<br>
&gt; @@ -631,7 +632,7 @@ static Property piix4_pm_properties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_DISABLED, PIIX4P=
MState, disable_s4, 0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMStat=
e, s4_val, 2),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;acpi-pci-hotplug-with-bridg=
e-support&quot;, PIIX4PMState,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0use_acpi_pci_hotplug, true),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0use_acpi_hotplug_bridge, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;memory-hotplug-support&quot=
;, PIIX4PMState,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0acpi_memory_hotplug.is_enabled, true),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
<br>
</blockquote></div></div>

--000000000000f2da2b05a8336748--

