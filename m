Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B228C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 10:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0243820692
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 10:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4YJCTWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0243820692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNwkn-0000wA-5O
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 06:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jNwk1-0000E6-Fo
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jNwjy-0005Rm-RN
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:55:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jNwjy-0005RV-MQ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 06:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586775297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mouWL9esHDQH3pzbVuALj79s7czZcOh6oOLChTjBtn4=;
 b=G4YJCTWqj+KGUdEHw69TNK1WEuu7UP7VEFJpfk855KfTiRBMpzDl+/bYiauALY1bVLwFXc
 ifGGDP9kKZTAvqpDEr1MF5XAXps5mgCChd4ZerhUSnCcHSs6RPXzmIT+kDSIm8ZkeFPTHS
 hU9Hf5niGZS/Y/X1uLW6pe/sRAbBDD4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-sf9Or1iiMhO7t-15k8x5pg-1; Mon, 13 Apr 2020 06:54:55 -0400
X-MC-Unique: sf9Or1iiMhO7t-15k8x5pg-1
Received: by mail-wr1-f71.google.com with SMTP id p16so3715674wro.16
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 03:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YALn3EL1CPLgXOJUl/YE29JEMwzz7MeT7P7e/v7/gsc=;
 b=ptqZMb4fage6vkR3niQr12C5CVYq823R5eDyc7oL0NaFgnIF0q0gsu++Dm4AOztnoC
 Q9MthYuzjKtG5uBFhxjr6z1nm4YA5Ehw99ryR6fNZCKtecLrL1rhV6w0xqgLn/zPLwE0
 rA30pzXq9BkiwJnVSefpnUcyTN1N3mOylu7ySZTjnHSpJNyfYLgT2EXnGsN1hiCZv0UL
 CsMTzLwaHNXRGq6oDpotEMPjcYZlu3ZkRPhUMc+hiit0sh7STUJJleV5tnIFZOR5afae
 fBFm5K5WQi3su+zGUf05w2dY2LNvO4E5ZPlrJkg92TA94n3q1pYd6zJ+gF3lbU36jJAd
 VKmQ==
X-Gm-Message-State: AGi0PuaLqnqKk+GzT5VuStNw8z0h3HcrcTeFsNtYvhXWx8XgUr9MUSeB
 Bg2x32K0nXBc6W+7UU+FVaX6dnht/qpYyCiEomjP3Hhlfn4b8ZwaYOMw/29joTw7D20vFdw3ZW0
 0wvcMT6gzlxEfPKg=
X-Received: by 2002:a1c:9d0d:: with SMTP id g13mr14116859wme.102.1586775294792; 
 Mon, 13 Apr 2020 03:54:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypKwtKCfU23v8E1dcO7AOY88ARasRhIagbdH4SmBfaqgTgkrzVzGM3/dluN0KiuTKIqFGWIrig==
X-Received: by 2002:a1c:9d0d:: with SMTP id g13mr14116844wme.102.1586775294549; 
 Mon, 13 Apr 2020 03:54:54 -0700 (PDT)
Received: from redhat.com ([185.107.45.41])
 by smtp.gmail.com with ESMTPSA id t20sm4722285wmi.2.2020.04.13.03.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 03:54:53 -0700 (PDT)
Date: Mon, 13 Apr 2020 06:54:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] hw/pci/pcie: Forbid hot-plug via QMP if it's disabled on
 the slot
Message-ID: <20200413065048-mutt-send-email-mst@kernel.org>
References: <20200407145017.1041256-1-jusual@redhat.com>
 <20200408125120.7678d9ae@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200408125120.7678d9ae@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 08, 2020 at 12:51:20PM +0200, Igor Mammedov wrote:
> On Tue,  7 Apr 2020 16:50:17 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
>=20
> > Raise an error when trying to hot-plug/unplug a device through QMP to a=
 device
> > with disabled hot-plug capability. This makes the device behaviour more
> > consistent and provides an explanation of the failure in the case of
> > asynchronous unplug.
>=20
> it applies to hotplug in general (i.e. not only QMP)
>=20
> >=20
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  hw/pci/pcie.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index 0eb3a2a5d2..e9798caa8a 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -415,6 +415,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_=
dev, DeviceState *dev,
> >  {
> >      PCIDevice *hotplug_pdev =3D PCI_DEVICE(hotplug_dev);
> >      uint8_t *exp_cap =3D hotplug_pdev->config + hotplug_pdev->exp.exp_=
cap;
> > +    uint32_t sltcap =3D pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> >      PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> > =20
> >      /* Don't send event when device is enabled during qemu machine cre=
ation:
> > @@ -430,6 +431,13 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug=
_dev, DeviceState *dev,
> >          return;
> >      }
> > =20
> > +    /* Hot-plug is disabled on the slot */
> > +    if ((sltcap & PCI_EXP_SLTCAP_HPC) =3D=3D 0) {
> > +        error_setg(errp, "Device '%s' does not support hot-plug",
> > +                         DEVICE(hotplug_dev)->id);
> plug and unplug_req are synchronous. so one can skip on "Device '%s'",
> user will get this error message as response to device_add/del command.
>=20
> and more exactly it's concrete slot that does not support hotplug, how ab=
out
> "slot doesn't support ..." or just "hotlpug is not supported"

Well device name is useful here, while these commands are synchronous
others aren't so log parsing might not be synchronous.

I do think we should mention slot since that's the reason
hotplug failed:
    "Device '%s' hot-plug failed: unsupported by slot"

> > +        return;
> > +    }
> > +
> >      /* To enable multifunction hot-plug, we just ensure the function
> >       * 0 added last. When function 0 is added, we set the sltsta and
> >       * inform OS via event notification.
> > @@ -464,14 +472,24 @@ static void pcie_unplug_device(PCIBus *bus, PCIDe=
vice *dev, void *opaque)
> >      object_unparent(OBJECT(dev));
> >  }
> > =20
> > -void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
> > +void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_handler,
> >                                       DeviceState *dev, Error **errp)
> >  {
> >      Error *local_err =3D NULL;
> >      PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> >      PCIBus *bus =3D pci_get_bus(pci_dev);
> > +    PCIDevice *hotplug_dev =3D PCI_DEVICE(hotplug_handler);
> > +    uint8_t *exp_cap =3D hotplug_dev->config + hotplug_dev->exp.exp_ca=
p;
> > +    uint32_t sltcap =3D pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> > +
> > +    /* Hot-unplug is disabled on the slot */
> > +    if ((sltcap & PCI_EXP_SLTCAP_HPC) =3D=3D 0) {
> > +        error_setg(errp, "Device '%s' does not support hot-unplug",
> > +                         DEVICE(hotplug_dev)->id);
> > +        return;

Here too let's mention slot since that's the reason
hotplug failed:
    "Device '%s' hot-unplug failed: unsupported by slot"

?

> > +    }
> > =20
> > -    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &local_err=
);
> > +    pcie_cap_slot_plug_common(hotplug_dev, dev, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return;
> > @@ -490,7 +508,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler=
 *hotplug_dev,
> >          return;
> >      }
> > =20
> > -    pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
> > +    pcie_cap_slot_push_attention_button(hotplug_dev);
> >  }
> > =20
> >  /* pci express slot for pci express root/downstream port


