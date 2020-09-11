Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BDBC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8EF20659
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="Gh+JbMTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8EF20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGljc-000144-CB
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGliU-0000UM-KQ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:16:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGliS-0006sQ-GJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:16:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id m6so12077493wrn.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YYe5CV3KKqgAKSHef+Jm6vDhGV1447eNGmJhykM2HRc=;
 b=Gh+JbMTu1eTugLn2BVAfNPZFykRNxt98hDYZr7QX0obIJOfuadr4UzM2ehMKid0hsO
 /ouwKKA0whkONfWt7VRUhA+O6Fr6Vykzz1DszUFFtfNDtK1fpm3+4vNRO9LH8YEjYKun
 p8IS3J1J7ngiHd2KenDR6DYgOA7IGBhVMsOGbR/KCCoUhbVyS0EEzBPO8f3JK+Zux98J
 OqzmqO7ZNK1AHWkw58mpRZESnZ6wU4+26eeTiVSJVXNFFAxBFRGCyn32T0QVid8kK+qM
 8l6MeGw4lildnYHs5i7vzdVyAvr6IDxzMo2wVAoyFDYDoH321LBVmvA/Ib0Es17tldem
 ZvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YYe5CV3KKqgAKSHef+Jm6vDhGV1447eNGmJhykM2HRc=;
 b=Q2I6U+Cd4aMlYZuj+dlnPICSQn8ko3JNSrBJLliwP+Bt9glho4+m4CaqjFJiN02Og3
 sqSBePeMj1WL0b1x4Jvcj9+FU4128EMk8uSjwwdhp9zLq8PT7VA8WXe7bQ5yCr+Y9mlL
 Prhvji7j5bFjJxxfI9lVCjHmSorW6ANprWtosJ1j3igTZ05coxLCzaIb1WLkVf4rYN0e
 6lI0vrBSdvK337u7PtCIH2mebfTG7fnUniQZCSjnHkDPedpofHeQa6Bzq8YTaJUnBiOu
 q6+jvNuhOVv+F8pj0tQaxZKKF3tP+dT4SEjVdEecsNwqn2lIszwCgIJUD5HG15kaNp6I
 xkMg==
X-Gm-Message-State: AOAM532Nf0gUHZEuNppBT5swy2iLrRjMyShSqwa1uYh8BBjr8kb/vdEX
 n75X8LbUT1Md40ayLggMbXV+PzJlGNOjqY9dS3QmcA==
X-Google-Smtp-Source: ABdhPJx/faKj4xk9u5d1rTJ0EZgxXHTJReNFBwyvA5zGQaO4s5YwJofOomWhloDkGn/e9JcEvU0BtTAZPRaLjAplBd8=
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr2619492wrm.291.1599840958785; 
 Fri, 11 Sep 2020 09:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200904161000.12115-1-ani@anisinha.ca>
 <CAMDeoFVQWeWArPty2z4rNbdmS7O2X66SaONqiKzFqFpaKwuNDg@mail.gmail.com>
 <98b26cfa-3ff7-4302-9fc2-0e6672cfbd08@Spark>
 <a6c38469-356d-4629-be12-92129e1b1b96@Spark>
 <20200911115138-mutt-send-email-mst@kernel.org>
 <CAARzgwyKccWaPDSwsAg7bW7=F7DxAsf7Lw=TvqOkp_i6tdXZow@mail.gmail.com>
 <20200911120838-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200911120838-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 11 Sep 2020 21:45:47 +0530
Message-ID: <CAARzgwyg83QyuVCi303K6gKHYKqB1GE7ez89c825KjWF3w7J4g@mail.gmail.com>
Subject: Re: [PATCH v3] i440fx/acpi: do not add hotplug related amls for cold
 plugged bridges
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x444.google.com
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

On Fri, Sep 11, 2020 at 9:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Sep 11, 2020 at 09:35:42PM +0530, Ani Sinha wrote:
> > On Fri, Sep 11, 2020 at 9:22 PM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Thu, Sep 10, 2020 at 12:19:19AM +0530, Ani Sinha wrote:
> > > > On Sep 10, 2020, 00:00 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> > > >
> > > >     On Sep 9, 2020, 23:20 +0530, Julia Suvorova <jusual@redhat.com>=
, wrote:
> > > >
> > > >         On Fri, Sep 4, 2020 at 6:10 PM Ani Sinha <ani@anisinha.ca> =
wrote:
> > > >
> > > >
> > > >
> > > >             Cold plugged bridges are not hot unpluggable, even when=
 their
> > > >             hotplug
> > > >
> > > >             property (acpi-pci-hotplug-with-bridge-support) is turn=
ed off.
> > > >             Please see
> > > >
> > > >             the function acpi_pcihp_pc_no_hotplug() (thanks Julia).=
 However,
> > > >             with
> > > >
> > > >             the current implementaton, windows would try to hot-unp=
lug a pci
> > > >             bridge when
> > > >
> > > >             it's hotplug switch is off. This is regardless of wheth=
er there are
> > > >             devices
> > > >
> > > >             attached to the bridge. This is because we add amls lik=
e _EJ0 etc
> > > >             for the
> > > >
> > > >             pci slot where the bridge is cold plugged. We have a de=
mo video
> > > >             here:
> > > >
> > > >             https://youtu.be/pME2sjyQweo
> > > >
> > > >
> > > >
> > > >             In this fix, we identify a cold plugged bridge and for =
cold plugged
> > > >             bridges,
> > > >
> > > >             we do not add the appropriate amls and acpi methods tha=
t are used
> > > >             by the OS
> > > >
> > > >             to identify a hot-pluggable/unpluggable pci device. Aft=
er this
> > > >             change, Windows
> > > >
> > > >             does not show an option to eject the PCI bridge. A demo=
 video is
> > > >             here:
> > > >
> > > >             https://youtu.be/kbgej5B9Hgs
> > > >
> > > >
> > > >
> > > >             While at it, I have also updated a stale comment.
> > > >
> > > >
> > > >
> > > >             This change is tested with a Windows 2012R2 guest image=
 and Windows
> > > >             2019 server
> > > >
> > > >             guest image running on Ubuntu 18.04 host. This change i=
s based off
> > > >             of upstream
> > > >
> > > >             qemu master branch tag v5.1.0.
> > > >
> > > >
> > > >
> > > >             Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > >
> > > >
> > > >
> > > >         Reviewed-by: Julia Suvorova <jusual@redhat.com>
> > > >
> > > >
> > > >
> > > >         BTW, aren't all bridges handled in build_append_pci_bus_dev=
ices()
> > > >         cold-plugged?
> > > >
> > > >
> > > >
> > > >     Yes they are.
> > > >
> > > >
> > > > Maybe as an improvement we can simply identify a bridge instead of =
a cold
> > > > plugged bridge. However let=E2=80=99s have that improvement as a se=
parate patch on top
> > > > of this. Also let=E2=80=99s see what Igor thinks.
> > >
> > > Well this changes acpi tables so I don't see how this will pass
> > > the unit tests. Did you test this change?
> >
> > There were no unit tests to cover this bridge flag. I have added the
> > unit tests. It's the same one you have queued.
>
>
> Hmm. somehow the new tests fail for me ...

Maybe you need to pull this change out, make sure the tests passes and
then apply it again:

commit b26b2241baefc51fe2069b83cea9cfa654e75a43 (HEAD -> v5.1.0)
Author: Ani Sinha <ani@anisinha.ca>
Date:   Tue Sep 1 15:19:22 2020 +0530

    piix4: don't reserve hw resources when hotplug is off globally

    When acpi hotplug is turned off for both root pci bus as well as for pc=
i
    bridges, we should not generate the related amls for DSDT table or
initialize
    related hw ports or reserve hw resources. This change makes sure all th=
ose
    operations are turned off in the case acpi pci hotplug is off globally.

    Signed-off-by: Ani Sinha <ani@anisinha.ca>


>
> > >
> > >
> > > >
> > > >
> > > >
> > > >             ---
> > > >
> > > >             hw/i386/acpi-build.c | 12 ++++++------
> > > >
> > > >             1 file changed, 6 insertions(+), 6 deletions(-)
> > > >
> > > >
> > > >
> > > >             changelog:
> > > >
> > > >             v3: commit log updates providing more accurate informat=
ion as
> > > >             received from Julia.
> > > >
> > > >             v2: cosmetic commit log updates with patch testing info=
rmation.
> > > >
> > > >             v1: initial patch.
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >             diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.=
c
> > > >
> > > >             index b7bcbbbb2a..90b863f4ec 100644
> > > >
> > > >             --- a/hw/i386/acpi-build.c
> > > >
> > > >             +++ b/hw/i386/acpi-build.c
> > > >
> > > >             @@ -359,6 +359,7 @@ static void build_append_pci_bus_de=
vices(Aml
> > > >             *parent_scope, PCIBus *bus,
> > > >
> > > >             int slot =3D PCI_SLOT(i);
> > > >
> > > >             bool hotplug_enabled_dev;
> > > >
> > > >             bool bridge_in_acpi;
> > > >
> > > >             + bool cold_plugged_bridge;
> > > >
> > > >
> > > >
> > > >             if (!pdev) {
> > > >
> > > >             if (bsel) { /* add hotplug slots for non present device=
s */
> > > >
> > > >             @@ -380,15 +381,14 @@ static void build_append_pci_bus_=
devices(Aml
> > > >             *parent_scope, PCIBus *bus,
> > > >
> > > >             pc =3D PCI_DEVICE_GET_CLASS(pdev);
> > > >
> > > >             dc =3D DEVICE_GET_CLASS(pdev);
> > > >
> > > >
> > > >
> > > >             - /* When hotplug for bridges is enabled, bridges are
> > > >
> > > >             - * described in ACPI separately (see build_pci_bus_end=
).
> > > >
> > > >             - * In this case they aren't themselves hot-pluggable.
> > > >
> > > >             + /*
> > > >
> > > >             + * Cold plugged bridges aren't themselves hot-pluggabl=
e.
> > > >
> > > >             * Hotplugged bridges *are* hot-pluggable.
> > > >
> > > >             */
> > > >
> > > >             - bridge_in_acpi =3D pc->is_bridge && pcihp_bridge_en &=
&
> > > >
> > > >             - !DEVICE(pdev)->hotplugged;
> > > >
> > > >             + cold_plugged_bridge =3D pc->is_bridge && !DEVICE(pdev=
)->hotplugged;
> > > >
> > > >             + bridge_in_acpi =3D cold_plugged_bridge && pcihp_bridg=
e_en;
> > > >
> > > >
> > > >
> > > >             - hotplug_enabled_dev =3D bsel && dc->hotpluggable && !
> > > >             bridge_in_acpi;
> > > >
> > > >             + hotplug_enabled_dev =3D bsel && dc->hotpluggable && !
> > > >             cold_plugged_bridge;
> > > >
> > > >
> > > >
> > > >             if (pc->class_id =3D=3D PCI_CLASS_BRIDGE_ISA) {
> > > >
> > > >             continue;
> > > >
> > > >             --
> > > >
> > > >             2.17.1
> > > >
> > > >
> > > >
> > > >
> > > >
> > >
>

