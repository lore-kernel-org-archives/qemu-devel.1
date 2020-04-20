Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05597C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C068F20722
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8M2Krf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C068F20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQeBq-0006QT-Qm
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 17:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1jQeBB-0005zX-NK
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1jQeBA-0007Q9-JM
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:42:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1jQeBA-0007NM-39
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587418930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAra9vI2rG932LrSCjNUPyht6K4Q++iynYFNsuRTtWc=;
 b=H8M2Krf73XuvxbEFw9VH7Tl82ylIdPWGUwZJ/2Omv579diIvEu/UTsBVinJqaCEnbrdhPp
 Alupm7AeMuleEPxokuq9hgLo4GwHVFESuZaKugaCWzrqzVb6LBzlgj3JWRb152XDxFo2ei
 MxSxkGrb05uAv/YhnUM7bporCcpBuX8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-37-fBnVrNLi9svpwtTq8cA-1; Mon, 20 Apr 2020 17:42:08 -0400
X-MC-Unique: 37-fBnVrNLi9svpwtTq8cA-1
Received: by mail-lf1-f70.google.com with SMTP id s1so4821151lfd.16
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 14:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=84ojyv61/a9im7nj+x3SDZyVchGZUJKCAaimSfhjk9g=;
 b=NwVAawQortV8Kn1tyCMhGkx42fCIT6d9F9BJ5Fj5mOiHZwVIjsXgPty3FA6ZKlj8tb
 d8mJgAoAl2vNNTPtF20bXOVmEHGiGXBLVePRP5nMJCwj9tgezPH39Du4d+vacWIJ6KOm
 /FaTA+T33+X5uypTUWbLe/XaVePT4diiVVjs5JYRVEAoAeNwH9qu6SA9oxvhaC5GuDAW
 MG7hm1eSsp6Jweh/xBN4Mg+ExzZmYObXwIXo56i4k1+xX6SSHxKdgoWha9IZT3tHF/Xn
 qtXGe7Jn6VBMis7T2Wr1bJYRf8zuab1p5D9khnpvzh5kmJhejEIAwxuV6XcAf7Zqg1BN
 PX9g==
X-Gm-Message-State: AGi0PuYMGzMS4MHrMXzPcyuM0qI8x3XBgF3gn9aXRDjkjyjmNVJkeL6W
 QzZmHVcgCX/x28N3M6yCvCHfH9cpXL6ck/RIus8Nt5mzAnO2IGLU4d8AEGPAoITrmdTU14XKxqN
 xhNYzRKW/HbwxXbKdLc3fNxShiZe9ALE=
X-Received: by 2002:a05:651c:515:: with SMTP id
 o21mr11617030ljp.91.1587418926985; 
 Mon, 20 Apr 2020 14:42:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypKeTKtkVsENsKCw1+Fx0C7iC3lIF68JK/yaJ6q9HQpleDgf1B64JvVmobDT2uQd1sdyDN2eDS4Pnm+DGqUF2n8=
X-Received: by 2002:a05:651c:515:: with SMTP id
 o21mr11617012ljp.91.1587418926700; 
 Mon, 20 Apr 2020 14:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200407145017.1041256-1-jusual@redhat.com>
 <d942234c-df99-c7c3-bddd-ea1a2daf097d@gmail.com>
In-Reply-To: <d942234c-df99-c7c3-bddd-ea1a2daf097d@gmail.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Mon, 20 Apr 2020 23:41:55 +0200
Message-ID: <CAMDeoFWn7o0LH50a6BMWPzA=rOsPMY_gTWbwS=rgKF5CVmYJXg@mail.gmail.com>
Subject: Re: [PATCH] hw/pci/pcie: Forbid hot-plug via QMP if it's disabled on
 the slot
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 17:42:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
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

This only increases the amount of code, since you need to do
error_propagate() after the function call.


