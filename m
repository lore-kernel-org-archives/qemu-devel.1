Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25F0C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5F6208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3SZmOKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5F6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPOnZ-0003SP-SQ
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 07:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1jPOmM-0002wc-A8
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1jPOmD-0005b7-2P
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:03:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28263
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1jPOmC-0005Yf-Um
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587121396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O/U/ynZrJMghtJHwEZhXCYR3W8XeYnp5IfXrRhaJXXY=;
 b=S3SZmOKQdb5BuAjjdiWPekZuZyOoZ/ylusfBxfRCLZkB3g74MMd56eJFTAyveD1jCDTSch
 cjPSqt9GxUG979TViIQ9Q0n1Gm8xQvZbr4Cq/SD0/bWxXWbkfgGMZSyLqEQZgTPj5T1S6A
 JdPZi6eTr8GZ0a8ILWFuOnIfBh2bbeA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-YP3mpmBQO2GQEdbx9EMeMQ-1; Fri, 17 Apr 2020 07:03:13 -0400
X-MC-Unique: YP3mpmBQO2GQEdbx9EMeMQ-1
Received: by mail-lj1-f198.google.com with SMTP id p17so226672ljn.12
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 04:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UdG4SCMT33wNYx/PZRkzTQBaw7emn9F5YDTTwDmXoTw=;
 b=GjRpPMAwYian+1ZaOIcfKWCKat6RbR3EkLmkqDMPxn9lybrDpbAsxvnt0UQwol209/
 HU/1rxi9WnkL1I2xUKiHqaZz8ymlvOxj1P/Q7OMHrl5VYkBtMBeG/SSZcH0O1p2aumjQ
 5jwgSCfOYaTwvfrQNF+Tu9No9gjL5XfobhLYcxrdTFFjuX07T5ssk/2ZXXlKye5Yro5b
 MJngCA9bkoZu4CRyHuGoxMXAAEapxw1V8apjvGrcwJMBarRXgw1m1wf9mf8qjnRyqtVz
 7lgIc1E/jt/3SraNlEFU8XoraX5NCKnob+Iwgks64tFS1XY0sEoozJRnrypTZHvFYwLA
 PP8A==
X-Gm-Message-State: AGi0PuaKILPQ9rP4uRxdv/ysc5wc4rgDQDCij4EFGi4OHBqTFpMVaNyI
 MaNT5u7XEPoyndx+GklZPY/kIfc+acSpCBbgZ9qwkRsmG4C5JEpDO71TZm5DWhtSG+B5sdT78yC
 SsfQmEgxG47B40KGNHoGQzIETyOvqmJ0=
X-Received: by 2002:ac2:4a76:: with SMTP id q22mr1708582lfp.157.1587121392343; 
 Fri, 17 Apr 2020 04:03:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypKZW5QdL+bCMsMfMxfZVnMf/i5iYYvUNUNk+3IA2WHTmn1t51ttubEmg2L1ZKodcGIbzQGpFyzRdH/sCdV5Yx8=
X-Received: by 2002:ac2:4a76:: with SMTP id q22mr1708567lfp.157.1587121392048; 
 Fri, 17 Apr 2020 04:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200407145017.1041256-1-jusual@redhat.com>
 <20200408125120.7678d9ae@redhat.com>
 <20200413065048-mutt-send-email-mst@kernel.org>
 <CAMDeoFW8q5Er5re6PasjKQ3+3ABFiGrbjZ7WSf5zq836y_+GuA@mail.gmail.com>
 <20200417054957-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200417054957-mutt-send-email-mst@kernel.org>
From: Julia Suvorova <jusual@redhat.com>
Date: Fri, 17 Apr 2020 13:03:01 +0200
Message-ID: <CAMDeoFXZHjLQ=LZrStS6nLuLk1M9__Jy19D_TLEbtSgC1kYXUA@mail.gmail.com>
Subject: Re: [PATCH] hw/pci/pcie: Forbid hot-plug via QMP if it's disabled on
 the slot
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Cc: qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 11:51 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Apr 15, 2020 at 10:20:33PM +0200, Julia Suvorova wrote:
> > On Mon, Apr 13, 2020 at 12:55 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> > >
> > > On Wed, Apr 08, 2020 at 12:51:20PM +0200, Igor Mammedov wrote:
> > > > On Tue,  7 Apr 2020 16:50:17 +0200
> > > > Julia Suvorova <jusual@redhat.com> wrote:
> > > >
> > > > > Raise an error when trying to hot-plug/unplug a device through QM=
P to a device
> > > > > with disabled hot-plug capability. This makes the device behaviou=
r more
> > > > > consistent and provides an explanation of the failure in the case=
 of
> > > > > asynchronous unplug.
> > > >
> > > > it applies to hotplug in general (i.e. not only QMP)
> > > >
> > > > >
> > > > > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > > > > ---
> > > > >  hw/pci/pcie.c | 24 +++++++++++++++++++++---
> > > > >  1 file changed, 21 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > > index 0eb3a2a5d2..e9798caa8a 100644
> > > > > --- a/hw/pci/pcie.c
> > > > > +++ b/hw/pci/pcie.c
> > > > > @@ -415,6 +415,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
> > > > >  {
> > > > >      PCIDevice *hotplug_pdev =3D PCI_DEVICE(hotplug_dev);
> > > > >      uint8_t *exp_cap =3D hotplug_pdev->config + hotplug_pdev->ex=
p.exp_cap;
> > > > > +    uint32_t sltcap =3D pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> > > > >      PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> > > > >
> > > > >      /* Don't send event when device is enabled during qemu machi=
ne creation:
> > > > > @@ -430,6 +431,13 @@ void pcie_cap_slot_plug_cb(HotplugHandler *h=
otplug_dev, DeviceState *dev,
> > > > >          return;
> > > > >      }
> > > > >
> > > > > +    /* Hot-plug is disabled on the slot */
> > > > > +    if ((sltcap & PCI_EXP_SLTCAP_HPC) =3D=3D 0) {
> > > > > +        error_setg(errp, "Device '%s' does not support hot-plug"=
,
> > > > > +                         DEVICE(hotplug_dev)->id);
> > > > plug and unplug_req are synchronous. so one can skip on "Device '%s=
'",
> > > > user will get this error message as response to device_add/del comm=
and.
> > > >
> > > > and more exactly it's concrete slot that does not support hotplug, =
how about
> > > > "slot doesn't support ..." or just "hotlpug is not supported"
> > >
> > > Well device name is useful here, while these commands are synchronous
> > > others aren't so log parsing might not be synchronous.
> > >
> > > I do think we should mention slot since that's the reason
> > > hotplug failed:
> > >     "Device '%s' hot-plug failed: unsupported by slot"
> > >
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > >      /* To enable multifunction hot-plug, we just ensure the func=
tion
> > > > >       * 0 added last. When function 0 is added, we set the sltsta=
 and
> > > > >       * inform OS via event notification.
> > > > > @@ -464,14 +472,24 @@ static void pcie_unplug_device(PCIBus *bus,=
 PCIDevice *dev, void *opaque)
> > > > >      object_unparent(OBJECT(dev));
> > > > >  }
> > > > >
> > > > > -void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev=
,
> > > > > +void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_han=
dler,
> > > > >                                       DeviceState *dev, Error **e=
rrp)
> > > > >  {
> > > > >      Error *local_err =3D NULL;
> > > > >      PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> > > > >      PCIBus *bus =3D pci_get_bus(pci_dev);
> > > > > +    PCIDevice *hotplug_dev =3D PCI_DEVICE(hotplug_handler);
> > > > > +    uint8_t *exp_cap =3D hotplug_dev->config + hotplug_dev->exp.=
exp_cap;
> > > > > +    uint32_t sltcap =3D pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> > > > > +
> > > > > +    /* Hot-unplug is disabled on the slot */
> > > > > +    if ((sltcap & PCI_EXP_SLTCAP_HPC) =3D=3D 0) {
> > > > > +        error_setg(errp, "Device '%s' does not support hot-unplu=
g",
> > > > > +                         DEVICE(hotplug_dev)->id);
> > > > > +        return;
> > >
> > > Here too let's mention slot since that's the reason
> > > hotplug failed:
> > >     "Device '%s' hot-unplug failed: unsupported by slot"
> > >
> > > ?
> >
> > Just to mention, for a user it's disabled on the device,
>
> How?
> I assumed this is what is used:
>
> commit 530a0963184e57e71a5b538e9161f115df533e96
> Author: Julia Suvorova <jusual@redhat.com>
> Date:   Wed Feb 26 18:46:07 2020 +0100
>
>     pcie_root_port: Add hotplug disabling option
>
>     Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
>     manage it and restrict unplug for the whole machine. This is going to
>     prevent user-initiated unplug in guests (Windows mostly).
>     Hotplug is enabled by default.
>     Usage:
>         -device pcie-root-port,hotplug=3Doff,...
>
>
> so it looks like user has to disable it on the slot.

By device I mean root port, and it's shown in the error message. If
you think it's not correct, I'll change it.


