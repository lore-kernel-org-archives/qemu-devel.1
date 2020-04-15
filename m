Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28616C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 20:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F5C2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 20:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uk6NBrju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F5C2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOoQy-0003fT-3T
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 16:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1jOoPs-0002mW-Ci
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 16:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1jOoPq-00027z-MM
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 16:13:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1jOoPq-00027J-JX
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 16:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586981625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2CWhv9QLnp35cyhaWz7MnUd9oOKFCN9SPa/G9J7QOHA=;
 b=Uk6NBrjudzQepfue8rVRhE/RC0PRcBpO9TAKu1653uBIbTW4dmVhTo8s1ZZOUTa+Ov9mh6
 qtmQf1UACfDhROJLKLOOsEAsknPxQoWGPeMClXF8fIrlNHhWSLevbSr8qLN/LvM1XbQqOh
 3lRjPRe8PtYtpTlis2Xw8rnQGG/QRTc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-3ppQQdnGM3CSLwkdILH7Zg-1; Wed, 15 Apr 2020 16:13:43 -0400
X-MC-Unique: 3ppQQdnGM3CSLwkdILH7Zg-1
Received: by mail-lj1-f197.google.com with SMTP id j15so672679lja.14
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 13:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eyCp7eEjyppw9eWOZzlxpSQTXuWD1b63cqFn01SfvnA=;
 b=ZGscn3lPMRWYM0fbs5vY1ZT+XxAvOzUzsw/cPkNfizotltZREs2ENOqeU8BhzWirzF
 coNmSMF6x4lADJi3TREYm5fTlz2rjLXfWNfZmiu85NQi75sWFB/keT7wLXlynS3F/j2n
 EYcXspCUbKQgUof0i4TJPfHI8ijg0KsMElWXsBWjkFXXHvyNr6fOYadxCWc75SS3pj+j
 wUaa9kV89Xr4FFpfbqYzX1B5F7WIY0b38l4H3thpfmdF9RDUzdaAosWcrdOEI93N/kb4
 Y8BNVVrVRgvJTDDkrH2NAMs7ZR3pOYmFOQsqnF0Dsz6JW3acO5oFt3oxJ08/isv913Kc
 w2QA==
X-Gm-Message-State: AGi0PubHFGkuh0JrZKie1aHCYexWkvdIwNgqCgtqxrQYc34BKzn0rdXy
 V8aCly1ShZsyw2obXloCngRjsjMZGpgpIXpzFTO7Q4aZDM5bKtI7p5omGLbHsL0k3AJZJL1rGy/
 Es/XZDM13M+MEHsOnWEy4ongVrQamGOM=
X-Received: by 2002:a2e:9652:: with SMTP id z18mr4598163ljh.79.1586981621723; 
 Wed, 15 Apr 2020 13:13:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypIn4NnzYJPCWRkJDJVyDtil26oof+y2zCId8CiwdSawkGC/6J2aiH2qZIEmawrmXFAmARFZU4qPZjTSuJfTETo=
X-Received: by 2002:a2e:9652:: with SMTP id z18mr4598148ljh.79.1586981621441; 
 Wed, 15 Apr 2020 13:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200407145017.1041256-1-jusual@redhat.com>
 <d942234c-df99-c7c3-bddd-ea1a2daf097d@gmail.com>
In-Reply-To: <d942234c-df99-c7c3-bddd-ea1a2daf097d@gmail.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 15 Apr 2020 22:13:30 +0200
Message-ID: <CAMDeoFV2LJWMP-V=HiCbB-bVYMfW+oJ2DktXV8U0DAk6xZNfOA@mail.gmail.com>
Subject: Re: [PATCH] hw/pci/pcie: Forbid hot-plug via QMP if it's disabled on
 the slot
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laine Stump <laine@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 10:07 AM Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
> Hi Julia,
>
> On 4/7/20 5:50 PM, Julia Suvorova wrote:
> > Raise an error when trying to hot-plug/unplug a device through QMP to a=
 device
> > with disabled hot-plug capability. This makes the device behaviour more
> > consistent and provides an explanation of the failure in the case of
> > asynchronous unplug.
> >
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >   hw/pci/pcie.c | 24 +++++++++++++++++++++---
> >   1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index 0eb3a2a5d2..e9798caa8a 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -415,6 +415,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_=
dev, DeviceState *dev,
> >   {
> >       PCIDevice *hotplug_pdev =3D PCI_DEVICE(hotplug_dev);
> >       uint8_t *exp_cap =3D hotplug_pdev->config + hotplug_pdev->exp.exp=
_cap;
> > +    uint32_t sltcap =3D pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> >       PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> >
> >       /* Don't send event when device is enabled during qemu machine cr=
eation:
> > @@ -430,6 +431,13 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug=
_dev, DeviceState *dev,
> >           return;
> >       }
> >
> > +    /* Hot-plug is disabled on the slot */
> > +    if ((sltcap & PCI_EXP_SLTCAP_HPC) =3D=3D 0) {
> > +        error_setg(errp, "Device '%s' does not support hot-plug",
> > +                         DEVICE(hotplug_dev)->id);
> > +        return;
> > +    }
> > +
> >       /* To enable multifunction hot-plug, we just ensure the function
> >        * 0 added last. When function 0 is added, we set the sltsta and
> >        * inform OS via event notification.
> > @@ -464,14 +472,24 @@ static void pcie_unplug_device(PCIBus *bus, PCIDe=
vice *dev, void *opaque)
> >       object_unparent(OBJECT(dev));
> >   }
> >
> > -void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
> > +void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_handler,
> >                                        DeviceState *dev, Error **errp)
> >   {
> >       Error *local_err =3D NULL;
> >       PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> >       PCIBus *bus =3D pci_get_bus(pci_dev);
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
> > +    }
>
> Since this chunk appears twice I would consider refactoring it into
> a helper function. (I see the error message is different, but I suppose
> it can be tweaked)

Okay.

> >
> > -    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &local_err=
);
> > +    pcie_cap_slot_plug_common(hotplug_dev, dev, &local_err);
>
> It doesn't seems related to this patch.
>
> >       if (local_err) {
> >           error_propagate(errp, local_err);
> >           return;
> > @@ -490,7 +508,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler=
 *hotplug_dev,
> >           return;
> >       }
> >
> > -    pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
> > +    pcie_cap_slot_push_attention_button(hotplug_dev);
>
> Same here, maybe you can split it in 2 patches.

Yes, but it doesn't make sense by itself. Just cleaning necessary with
a new variable introduced.

Best regards, Julia Suvorova.


