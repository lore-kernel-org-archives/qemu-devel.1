Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA127C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66710208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="KU5+TZcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66710208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBb4U-0004Ue-Lc
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kBb3V-0003zH-Am
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:52:21 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kBb3R-0007h5-PW
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:52:21 -0400
Received: by mail-pl1-x641.google.com with SMTP id t11so233995plr.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version; bh=4TMfKvSUmrifdAVq0sO3GvaEeYOv5PcTF4kWfM9fiKo=;
 b=KU5+TZcj9bBUU98kV9OAlyEvYqRbi09y+JP97VEUU088dztFZB6iT/0hifNKhwZUwr
 6sEu0FT1fFK0NP/57pd0bGzXpFmiuO+GWrOtfwiPHotbADnjASpgBlRmE7ELHElRTjYT
 LrDa+sG7UbUeuNMnRuCMQRvxrxoxIPFc8SXk+m5Qz1w4ZIv20292a9GlzbWKC6IfHlsS
 gJFDcnK1OU/XWRTeRkD+G/hcdtg82ljWh5onqwCqAuvnS6I/ey5gljEe7ZWKepLVNjtm
 t7Qd/uqWxJXF+Mty6Up0SOpk6dJHJEj/BDeXB6Og84n6ZAl6KkkgTKsRLYk33D+8l31H
 Hq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
 :references:subject:mime-version;
 bh=4TMfKvSUmrifdAVq0sO3GvaEeYOv5PcTF4kWfM9fiKo=;
 b=PWsCCjAkHvFxr2yNW3NnNQUJVcciNTvV48MRxz+BZtaK4u10lhqQCuu5IGpUSoMzqu
 D2wkOJ9Uc82YMKw6zgh2QNU5H78Na30rB53Kvjzjey6l+OblmSAWNX6G36frtQ3suC0G
 22Rw1KjYbOXHhgkUTDHkGUdSQoXK9gUVuY+qpBOP27LpEv0cX7kq7GzxKi9oLTvlJ+V9
 V0gGDz07I+hn/OesKpVXAr6QOEUijVZWbukBpI+DNjXQ/VUPm5lejzFJe6vLb/gPkQKQ
 tVCLX2vFYLWDhYbx4KEnbW/SKBH1mu9oTFB9kGqPBbk0dQWHOUGcNecsoUSBPY0cyScF
 sQWA==
X-Gm-Message-State: AOAM532n7PBU3ZdsDNchCuWupc8FVDRJkpMH/BlMRoAkkcmZ+T7lWR9R
 6TrH0daxq8R4iPBn3oVhhYU5og==
X-Google-Smtp-Source: ABdhPJx3sl7vMRhXxZOBUrGhM3OyZ+HmWz2pWRh1aMuSqX4YvTtAMFN0Y+hfUdZ0W9iBdZ+ynihA2A==
X-Received: by 2002:a17:90b:3543:: with SMTP id
 lt3mr566897pjb.180.1598608335552; 
 Fri, 28 Aug 2020 02:52:15 -0700 (PDT)
Received: from [192.168.1.3] ([115.96.108.41])
 by smtp.gmail.com with ESMTPSA id z23sm1062978pfk.26.2020.08.28.02.52.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Aug 2020 02:52:14 -0700 (PDT)
Date: Fri, 28 Aug 2020 15:21:52 +0530
From: Ani Sinha <ani@anisinha.ca>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <d67e8431-b23a-46ee-94f3-544c4476848e@Spark>
In-Reply-To: <20200828114907.42961cd3@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
 <20200827133954.2118749-7-mst@redhat.com>
 <20200827194115.673f94de@imammedo-mac>
 <CAARzgwzLcu5iHrXNZrVbg2Yx27AvyYWrKqBZ0wK7CveQ_eKgsQ@mail.gmail.com>
 <20200828114907.42961cd3@redhat.com>
Subject: Re: [PULL 06/13] Introduce a new flag for i440fx to disable PCI
 hotplug on the root bus
X-Readdle-Message-ID: d67e8431-b23a-46ee-94f3-544c4476848e@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f48d3c9_46e87ccd_239"
Received-SPF: none client-ip=2607:f8b0:4864:20::641;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x641.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5f48d3c9_46e87ccd_239
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Ani
On Aug 28, 2020, 15:19 +0530, Igor Mammedov <imammedo@redhat.com>, wrote:
> On Thu, 27 Aug 2020 23:29:34 +0530
> Ani Sinha <ani@anisinha.ca> wrote:
>
> > On Thu, Aug 27, 2020 at 11:11 PM Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > On Thu, 27 Aug 2020 09:40:34 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > > From: Ani Sinha <ani@anisinha.ca>
> > > >
> > > > We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with which
> > > > we can turn on or off PCI device hotplug on the root bus. This flag can be
> > > > used to prevent all PCI devices from getting hotplugged or unplugged from the
> > > > root PCI bus.
> > > > This feature is targetted mostly towards Windows VMs. It is useful in cases
> > > > where some hypervisor admins want to deploy guest VMs in a way so that the
> > > > users of the guest OSes are not able to hot-eject certain PCI devices from
> > > > the Windows system tray. Laine has explained the use case here in detail:
> > > > https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
> > > >
> > > > Julia has resolved this issue for PCIE buses with the following commit:
> > > > 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")
> > > >
> > > > This commit attempts to introduce similar behavior for PCI root buses used in
> > > > i440fx machine types (although in this case, we do not have a per-slot
> > > > capability to turn hotplug on or off).
> > > >
> > > > Usage:
> > > > -global PIIX4_PM.acpi-root-pci-hotplug=off
> > > >
> > > > By default, this option is enabled which means that hotplug is turned on for
> > > > the PCI root bus.
> > > >
> > > > The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for PCI-PCI
> > > > bridges remain as is and can be used along with this new flag to control PCI
> > > > hotplug on PCI bridges.
> > > >
> > > > This change has been tested using a Windows 2012R2 server guest image and also
> > > > with a Windows 2019 server guest image on a Ubuntu 18.04 host using the latest
> > > > master qemu from upstream.
> > > >
> > > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > > Message-Id: <20200821165403.26589-1-ani@anisinha.ca>
> > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > >
> > > > Tested-by: Igor Mammedov <imammedo@redhat.com>
> > > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > A glitch in scripts?
> > > I didn't review nor tested this (v8) version
> >
> > oops! I am so eager to get this done and dusted :)
> it's merged now,

Wait it merged without your review?
>
> can you add a test case for it please?
>
> You can use test_acpi_piix4_tcg_bridge() as model.
> See header comment at the top of bios-tables-test.c
> for how to prepare and submit testcase.

Will get on it.
>
> >
> > >
> > > > ---
> > > > include/hw/acpi/pcihp.h | 2 +-
> > > > hw/acpi/pcihp.c | 23 ++++++++++++++++++++++-
> > > > hw/acpi/piix4.c | 5 ++++-
> > > > 3 files changed, 27 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> > > > index 8bc4a4c01d..02f4665767 100644
> > > > --- a/include/hw/acpi/pcihp.h
> > > > +++ b/include/hw/acpi/pcihp.h
> > > > @@ -67,7 +67,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> > > > Error **errp);
> > > >
> > > > /* Called on reset */
> > > > -void acpi_pcihp_reset(AcpiPciHpState *s);
> > > > +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off);
> > > >
> > > > extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
> > > >
> > > > diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> > > > index 9e31ab2da4..39b1f74442 100644
> > > > --- a/hw/acpi/pcihp.c
> > > > +++ b/hw/acpi/pcihp.c
> > > > @@ -104,6 +104,24 @@ static void acpi_set_pci_info(void)
> > > > }
> > > > }
> > > >
> > > > +static void acpi_pcihp_disable_root_bus(void)
> > > > +{
> > > > + static bool root_hp_disabled;
> > > > + PCIBus *bus;
> > > > +
> > > > + if (root_hp_disabled) {
> > > > + return;
> > > > + }
> > > > +
> > > > + bus = find_i440fx();
> > > > + if (bus) {
> > > > + /* setting the hotplug handler to NULL makes the bus non-hotpluggable */
> > > > + qbus_set_hotplug_handler(BUS(bus), NULL);
> > > > + }
> > > > + root_hp_disabled = true;
> > > > + return;
> > > > +}
> > > > +
> > > > static void acpi_pcihp_test_hotplug_bus(PCIBus *bus, void *opaque)
> > > > {
> > > > AcpiPciHpFind *find = opaque;
> > > > @@ -209,8 +227,11 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
> > > > }
> > > > }
> > > >
> > > > -void acpi_pcihp_reset(AcpiPciHpState *s)
> > > > +void acpi_pcihp_reset(AcpiPciHpState *s, bool acpihp_root_off)
> > > > {
> > > > + if (acpihp_root_off) {
> > > > + acpi_pcihp_disable_root_bus();
> > > > + }
> > > > acpi_set_pci_info();
> > > > acpi_pcihp_update(s);
> > > > }
> > > > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > > > index 26bac4f16c..e6163bb6ce 100644
> > > > --- a/hw/acpi/piix4.c
> > > > +++ b/hw/acpi/piix4.c
> > > > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> > > >
> > > > AcpiPciHpState acpi_pci_hotplug;
> > > > bool use_acpi_hotplug_bridge;
> > > > + bool use_acpi_root_pci_hotplug;
> > > >
> > > > uint8_t disable_s3;
> > > > uint8_t disable_s4;
> > > > @@ -324,7 +325,7 @@ static void piix4_pm_reset(DeviceState *dev)
> > > > pci_conf[0x5B] = 0x02;
> > > > }
> > > > pm_io_space_update(s);
> > > > - acpi_pcihp_reset(&s->acpi_pci_hotplug);
> > > > + acpi_pcihp_reset(&s->acpi_pci_hotplug, !s->use_acpi_root_pci_hotplug);
> > > > }
> > > >
> > > > static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
> > > > @@ -635,6 +636,8 @@ static Property piix4_pm_properties[] = {
> > > > DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> > > > DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMState,
> > > > use_acpi_hotplug_bridge, true),
> > > > + DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> > > > + use_acpi_root_pci_hotplug, true),
> > > > DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> > > > acpi_memory_hotplug.is_enabled, true),
> > > > DEFINE_PROP_END_OF_LIST(),
> > >
> >
>

--5f48d3c9_46e87ccd_239
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageSignatureSection=22><br />
Ani</div>
<div name=3D=22messageReplySection=22>
<div dir=3D=22auto=22>On Aug 28, 2020, 15:19 +0530, Igor Mammedov &lt;ima=
mmedo=40redhat.com&gt;, wrote:</div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Thu, 27 Aug 2020 23:29:34 +05=
30</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>Ani Sinha &lt;ani=40anisinha.ca&=
gt; wrote:</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Thu, Aug 27, 2020 at 11:11 PM=
 Igor Mammedov &lt;imammedo=40redhat.com&gt; wrote:</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>On Thu, 27 Aug 2020 09:40:34 -04=
00</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>=22Michael S. Tsirkin=22 &lt;mst=
=40redhat.com&gt; wrote:</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=46rom: Ani Sinha &lt;ani=40anisin=
ha.ca&gt;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>We introduce a new global flag 'ac=
pi-root-pci-hotplug' for i440fx with which</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>we can turn on or off PCI device h=
otplug on the root bus. This flag can be</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>used to prevent all PCI devices fr=
om getting hotplugged or unplugged from the</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>root PCI bus.</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>This feature is targetted mostly t=
owards Windows VMs. It is useful in cases</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>where some hypervisor admins want =
to deploy guest VMs in a way so that the</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>users of the guest OSes are not ab=
le to hot-eject certain PCI devices from</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>the Windows system tray. Laine has=
 explained the use case here in detail:</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>https://www.redhat.com/archives/li=
bvir-list/2020-=46ebruary/msg00110.html</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>Julia has resolved this issue for =
PCIE buses with the following commit:</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>530a0963184e57e71a5b538 (=22pcie=5F=
root=5Fport: Add hotplug disabling option=22)</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>This commit attempts to introduce =
similar behavior for PCI root buses used in</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>i440fx machine types (although in =
this case, we do not have a per-slot</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>capability to turn hotplug on or o=
ff).</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>Usage:</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>-global PIIX4=5FPM.acpi-root-pci-h=
otplug=3Doff</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>By default, this option is enabled=
 which means that hotplug is turned on for</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>the PCI root bus.</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>The previously existing flag 'acpi=
-pci-hotplug-with-bridge-support' for PCI-PCI</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>bridges remain as is and can be us=
ed along with this new flag to control PCI</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>hotplug on PCI bridges.</blockquot=
e>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>This change has been tested using =
a Windows 2012R2 server guest image and also</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>with a Windows 2019 server guest i=
mage on a Ubuntu 18.04 host using the latest</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>master qemu from upstream.</blockq=
uote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>Signed-off-by: Ani Sinha &lt;ani=40=
anisinha.ca&gt;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>Message-Id: &lt;20200821165403.265=
89-1-ani=40anisinha.ca&gt;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>Reviewed-by: Michael S. Tsirkin &l=
t;mst=40redhat.com&gt;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>Signed-off-by: Michael S. Tsirkin =
&lt;mst=40redhat.com&gt;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>Tested-by: Igor Mammedov &lt;imamm=
edo=40redhat.com&gt;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>Reviewed-by: Igor Mammedov &lt;ima=
mmedo=40redhat.com&gt;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>A glitch in scripts=3F</blockquo=
te>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>I didn't review nor tested this =
(v8) version</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>oops=21 I am so eager to get thi=
s done and dusted :)</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>it's merged now,</blockquote>
<div dir=3D=22auto=22><br />
Wait it merged without your review=3F<br /></div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>can you add a test case for it p=
lease=3F</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>You can use test=5Facpi=5Fpiix4=5F=
tcg=5Fbridge() as model.</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>See header comment at the top of=
 bios-tables-test.c</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22>for how to prepare and submit te=
stcase.</blockquote>
<div dir=3D=22auto=22><br />
Will get on it.<br /></div>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>---</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>include/hw/acpi/pcihp.h =7C 2 +-</=
blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>hw/acpi/pcihp.c =7C 23 +++++++++++=
+++++++++++-</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>hw/acpi/piix4.c =7C 5 ++++-</block=
quote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>3 files changed, 27 insertions(+),=
 3 deletions(-)</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>diff --git a/include/hw/acpi/pcihp=
.h b/include/hw/acpi/pcihp.h</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>index 8bc4a4c01d..02f4665767 10064=
4</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>--- a/include/hw/acpi/pcihp.h</blo=
ckquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+++ b/include/hw/acpi/pcihp.h</blo=
ckquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=40=40 -67,7 +67,7 =40=40 void acp=
i=5Fpcihp=5Fdevice=5Funplug=5Frequest=5Fcb(HotplugHandler *hotplug=5Fdev,=
</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>Error **errp);</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>/* Called on reset */</blockquote>=

</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>-void acpi=5Fpcihp=5Freset(AcpiPci=
HpState *s);</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+void acpi=5Fpcihp=5Freset(AcpiPci=
HpState *s, bool acpihp=5Froot=5Foff);</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>extern const VMStateDescription vm=
state=5Facpi=5Fpcihp=5Fpci=5Fstatus;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>diff --git a/hw/acpi/pcihp.c b/hw/=
acpi/pcihp.c</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>index 9e31ab2da4..39b1f74442 10064=
4</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>--- a/hw/acpi/pcihp.c</blockquote>=

</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+++ b/hw/acpi/pcihp.c</blockquote>=

</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=40=40 -104,6 +104,24 =40=40 stati=
c void acpi=5Fset=5Fpci=5Finfo(void)</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+static void acpi=5Fpcihp=5Fdisabl=
e=5Froot=5Fbus(void)</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+=7B</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ static bool root=5Fhp=5Fdisabled=
;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ PCIBus *bus;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ if (root=5Fhp=5Fdisabled) =7B</b=
lockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ return;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ =7D</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ bus =3D find=5Fi440fx();</blockq=
uote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ if (bus) =7B</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ /* setting the hotplug handler t=
o NULL makes the bus non-hotpluggable */</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ qbus=5Fset=5Fhotplug=5Fhandler(B=
US(bus), NULL);</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ =7D</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ root=5Fhp=5Fdisabled =3D true;</=
blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ return;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+=7D</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>static void acpi=5Fpcihp=5Ftest=5F=
hotplug=5Fbus(PCIBus *bus, void *opaque)</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=7B</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>AcpiPciHp=46ind *find =3D opaque;<=
/blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=40=40 -209,8 +227,11 =40=40 stati=
c void acpi=5Fpcihp=5Fupdate(AcpiPciHpState *s)</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>-void acpi=5Fpcihp=5Freset(AcpiPci=
HpState *s)</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+void acpi=5Fpcihp=5Freset(AcpiPci=
HpState *s, bool acpihp=5Froot=5Foff)</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=7B</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ if (acpihp=5Froot=5Foff) =7B</bl=
ockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ acpi=5Fpcihp=5Fdisable=5Froot=5F=
bus();</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ =7D</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>acpi=5Fset=5Fpci=5Finfo();</blockq=
uote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>acpi=5Fpcihp=5Fupdate(s);</blockqu=
ote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>diff --git a/hw/acpi/piix4.c b/hw/=
acpi/piix4.c</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>index 26bac4f16c..e6163bb6ce 10064=
4</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>--- a/hw/acpi/piix4.c</blockquote>=

</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+++ b/hw/acpi/piix4.c</blockquote>=

</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=40=40 -78,6 +78,7 =40=40 typedef =
struct PIIX4PMState =7B</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>AcpiPciHpState acpi=5Fpci=5Fhotplu=
g;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>bool use=5Facpi=5Fhotplug=5Fbridge=
;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ bool use=5Facpi=5Froot=5Fpci=5Fh=
otplug;</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>uint8=5Ft disable=5Fs3;</blockquot=
e>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>uint8=5Ft disable=5Fs4;</blockquot=
e>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=40=40 -324,7 +325,7 =40=40 static=
 void piix4=5Fpm=5Freset(DeviceState *dev)</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>pci=5Fconf=5B0x5B=5D =3D 0x02;</bl=
ockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>pm=5Fio=5Fspace=5Fupdate(s);</bloc=
kquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>- acpi=5Fpcihp=5Freset(&amp;s-&gt;=
acpi=5Fpci=5Fhotplug);</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ acpi=5Fpcihp=5Freset(&amp;s-&gt;=
acpi=5Fpci=5Fhotplug, =21s-&gt;use=5Facpi=5Froot=5Fpci=5Fhotplug);</block=
quote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=7D</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>static void piix4=5Fpm=5Fpowerdown=
=5Freq(Notifier *n, void *opaque)</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>=40=40 -635,6 +636,8 =40=40 static=
 Property piix4=5Fpm=5Fproperties=5B=5D =3D =7B</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FUINT8(ACPI=5FPM=5F=
PROP=5FS4=5FVAL, PIIX4PMState, s4=5Fval, 2),</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FBOOL(=22acpi-pci=
-hotplug-with-bridge-support=22, PIIX4PMState,</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>use=5Facpi=5Fhotplug=5Fbridge, tru=
e),</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ DE=46INE=5FPROP=5FBOOL(=22acpi-r=
oot-pci-hotplug=22, PIIX4PMState,</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>+ use=5Facpi=5Froot=5Fpci=5Fhotplu=
g, true),</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FBOOL(=22memory-h=
otplug-support=22, PIIX4PMState,</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>acpi=5Fmemory=5Fhotplug.is=5Fenabl=
ed, true),</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(211, 84, 0); margin: 0px; p=
adding-left: 10px; border-left-width: thin; border-left-style: solid; pad=
ding-bottom: 5px; padding-top: 5px;=22>DE=46INE=5FPROP=5FEND=5FO=46=5FLIS=
T(),</blockquote>
</blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(52, 152, 219); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid;=22=
>
<blockquote style=3D=22border-left-color: rgb(230, 126, 34); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</blockquote>
<blockquote style=3D=22border-left-color: rgb(26, 188, 156); margin: 0px;=
 padding-left: 10px; border-left-width: thin; border-left-style: solid; p=
adding-bottom: 5px; padding-top: 5px;=22><br /></blockquote>
</div>
</body>
</html>

--5f48d3c9_46e87ccd_239--


