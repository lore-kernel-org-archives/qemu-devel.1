Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64A4C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FBF206CA
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="BxUDwBQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FBF206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlZQ-0001tI-IL
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGlYl-0001Rb-8d
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:05:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGlYi-0005Ik-Nj
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:05:58 -0400
Received: by mail-wm1-x342.google.com with SMTP id x23so4927539wmi.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=O6wSjc2hLJXpa/SdIjFlh9hFkOpPt/tgCbPWyRd7W50=;
 b=BxUDwBQvVE734kwtCaWvUGG/MsW/ekRCBGUmqhABxGsL1WGWpcPlI1NyrBKqfpl7+J
 mj8X5bPNiWIePG9s3InAX8MVtbzMXwaAS6IWLekNvBAE6C/ftHxF0G2gHpRxBboRMomt
 pmVbqeBb2K/KUQLEdK2S4tcL2+EeO/IysFuuBO+FbhWyjcG8+TXraaMicfdumqxOWVIi
 Toqv33e0zn/PsGWKWfEuNmWhha+Qx2z9VjfWnH/oHhIfYVHfjDRAeCD49PpDXRRwbV8R
 gLSdiHKWGdKlaRD6DnVv91o9GDvSHvZCUHqQuXHxu9v3+YpMyOt4vJeflfwCHhh/Dzug
 IWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=O6wSjc2hLJXpa/SdIjFlh9hFkOpPt/tgCbPWyRd7W50=;
 b=Q/6hFmS40Eb6IhO5d6DPwxRbFKpU+8INaISb0/WwYAkVS4PNE7EOHy8uko1GF8kAwg
 vZWXToBxz2VSYREuR0Z6qZqUu9oT8lXA4XGbC7V83inkJnOxfHSQi1lArU4tZp2gFdcq
 ry4Sotj37RNSIX5gwNQ4f82P3IE8cLIWHb5X9KFUjzOCObB1VrbilWK0Oqdj2obMPkR+
 9zXK/Yt+NzZaOVrHm8VDtDp/ozxJedZ+wGASGqpI52hxnWAS38aKnpbwUrP9R90/Gmor
 cMS+4UZqnW4v2Txp+7Ps+Bt/qMuabg8P4NIl0Y/pz9woHjhDp7GkdHymLc9OehsJJ7jm
 YW7w==
X-Gm-Message-State: AOAM532s/ZjuRJABN8zT+MU+dvZ2oVbYk691LWr8LqvN3YwRRRVt2rMI
 ahVHMtp8zC6XnkweWDEQOFQN817B6MU7sCugBgcaVg==
X-Google-Smtp-Source: ABdhPJwFVpbnhX1sj2MhvgMK4IphTNTP9DtCm96/arVAzn4XkcUB9L87MBIb+ym06cZ2rKg6CaU94blwqkawR842xDw=
X-Received: by 2002:a1c:7405:: with SMTP id p5mr2922377wmc.35.1599840353939;
 Fri, 11 Sep 2020 09:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200904161000.12115-1-ani@anisinha.ca>
 <CAMDeoFVQWeWArPty2z4rNbdmS7O2X66SaONqiKzFqFpaKwuNDg@mail.gmail.com>
 <98b26cfa-3ff7-4302-9fc2-0e6672cfbd08@Spark>
 <a6c38469-356d-4629-be12-92129e1b1b96@Spark>
 <20200911115138-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200911115138-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 11 Sep 2020 21:35:42 +0530
Message-ID: <CAARzgwyKccWaPDSwsAg7bW7=F7DxAsf7Lw=TvqOkp_i6tdXZow@mail.gmail.com>
Subject: Re: [PATCH v3] i440fx/acpi: do not add hotplug related amls for cold
 plugged bridges
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::342;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 9:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 10, 2020 at 12:19:19AM +0530, Ani Sinha wrote:
> > On Sep 10, 2020, 00:00 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> >
> >     On Sep 9, 2020, 23:20 +0530, Julia Suvorova <jusual@redhat.com>, wr=
ote:
> >
> >         On Fri, Sep 4, 2020 at 6:10 PM Ani Sinha <ani@anisinha.ca> wrot=
e:
> >
> >
> >
> >             Cold plugged bridges are not hot unpluggable, even when the=
ir
> >             hotplug
> >
> >             property (acpi-pci-hotplug-with-bridge-support) is turned o=
ff.
> >             Please see
> >
> >             the function acpi_pcihp_pc_no_hotplug() (thanks Julia). How=
ever,
> >             with
> >
> >             the current implementaton, windows would try to hot-unplug =
a pci
> >             bridge when
> >
> >             it's hotplug switch is off. This is regardless of whether t=
here are
> >             devices
> >
> >             attached to the bridge. This is because we add amls like _E=
J0 etc
> >             for the
> >
> >             pci slot where the bridge is cold plugged. We have a demo v=
ideo
> >             here:
> >
> >             https://youtu.be/pME2sjyQweo
> >
> >
> >
> >             In this fix, we identify a cold plugged bridge and for cold=
 plugged
> >             bridges,
> >
> >             we do not add the appropriate amls and acpi methods that ar=
e used
> >             by the OS
> >
> >             to identify a hot-pluggable/unpluggable pci device. After t=
his
> >             change, Windows
> >
> >             does not show an option to eject the PCI bridge. A demo vid=
eo is
> >             here:
> >
> >             https://youtu.be/kbgej5B9Hgs
> >
> >
> >
> >             While at it, I have also updated a stale comment.
> >
> >
> >
> >             This change is tested with a Windows 2012R2 guest image and=
 Windows
> >             2019 server
> >
> >             guest image running on Ubuntu 18.04 host. This change is ba=
sed off
> >             of upstream
> >
> >             qemu master branch tag v5.1.0.
> >
> >
> >
> >             Signed-off-by: Ani Sinha <ani@anisinha.ca>
> >
> >
> >
> >         Reviewed-by: Julia Suvorova <jusual@redhat.com>
> >
> >
> >
> >         BTW, aren't all bridges handled in build_append_pci_bus_devices=
()
> >         cold-plugged?
> >
> >
> >
> >     Yes they are.
> >
> >
> > Maybe as an improvement we can simply identify a bridge instead of a co=
ld
> > plugged bridge. However let=E2=80=99s have that improvement as a separa=
te patch on top
> > of this. Also let=E2=80=99s see what Igor thinks.
>
> Well this changes acpi tables so I don't see how this will pass
> the unit tests. Did you test this change?

There were no unit tests to cover this bridge flag. I have added the
unit tests. It's the same one you have queued.

>
>
> >
> >
> >
> >             ---
> >
> >             hw/i386/acpi-build.c | 12 ++++++------
> >
> >             1 file changed, 6 insertions(+), 6 deletions(-)
> >
> >
> >
> >             changelog:
> >
> >             v3: commit log updates providing more accurate information =
as
> >             received from Julia.
> >
> >             v2: cosmetic commit log updates with patch testing informat=
ion.
> >
> >             v1: initial patch.
> >
> >
> >
> >
> >
> >             diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >
> >             index b7bcbbbb2a..90b863f4ec 100644
> >
> >             --- a/hw/i386/acpi-build.c
> >
> >             +++ b/hw/i386/acpi-build.c
> >
> >             @@ -359,6 +359,7 @@ static void build_append_pci_bus_device=
s(Aml
> >             *parent_scope, PCIBus *bus,
> >
> >             int slot =3D PCI_SLOT(i);
> >
> >             bool hotplug_enabled_dev;
> >
> >             bool bridge_in_acpi;
> >
> >             + bool cold_plugged_bridge;
> >
> >
> >
> >             if (!pdev) {
> >
> >             if (bsel) { /* add hotplug slots for non present devices */
> >
> >             @@ -380,15 +381,14 @@ static void build_append_pci_bus_devi=
ces(Aml
> >             *parent_scope, PCIBus *bus,
> >
> >             pc =3D PCI_DEVICE_GET_CLASS(pdev);
> >
> >             dc =3D DEVICE_GET_CLASS(pdev);
> >
> >
> >
> >             - /* When hotplug for bridges is enabled, bridges are
> >
> >             - * described in ACPI separately (see build_pci_bus_end).
> >
> >             - * In this case they aren't themselves hot-pluggable.
> >
> >             + /*
> >
> >             + * Cold plugged bridges aren't themselves hot-pluggable.
> >
> >             * Hotplugged bridges *are* hot-pluggable.
> >
> >             */
> >
> >             - bridge_in_acpi =3D pc->is_bridge && pcihp_bridge_en &&
> >
> >             - !DEVICE(pdev)->hotplugged;
> >
> >             + cold_plugged_bridge =3D pc->is_bridge && !DEVICE(pdev)->h=
otplugged;
> >
> >             + bridge_in_acpi =3D cold_plugged_bridge && pcihp_bridge_en=
;
> >
> >
> >
> >             - hotplug_enabled_dev =3D bsel && dc->hotpluggable && !
> >             bridge_in_acpi;
> >
> >             + hotplug_enabled_dev =3D bsel && dc->hotpluggable && !
> >             cold_plugged_bridge;
> >
> >
> >
> >             if (pc->class_id =3D=3D PCI_CLASS_BRIDGE_ISA) {
> >
> >             continue;
> >
> >             --
> >
> >             2.17.1
> >
> >
> >
> >
> >
>

