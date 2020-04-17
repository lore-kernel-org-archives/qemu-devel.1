Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5193C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D744221EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO1zhd30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D744221EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPOvB-0001jp-K3
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 07:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jPOtj-0000JC-4d
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jPOtd-0003hh-Rq
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:11:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59415
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jPOtd-0003go-Fa
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587121856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tA3oc2IeWz8MzooaZ8atVoxF/MXKTYzxWrLN5WFRZ0o=;
 b=ZO1zhd30dzJDUrTjybtr0Qj0Th2WtPRekhmItK91XBByrEKu5HBZaVjVnN6IMAXtiIScUl
 FOD+SiFJHycbmjKvVZsg9zYljsiF+jPvQpMrsebFkGIQNqIo8BO4atKUFtkwAFHr/U9c6r
 oo6rhmNlCC03eJVVUg1GLZK5LWDPS0o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-WYdsFnpPNQGAudry-9_qvA-1; Fri, 17 Apr 2020 07:10:55 -0400
X-MC-Unique: WYdsFnpPNQGAudry-9_qvA-1
Received: by mail-wr1-f69.google.com with SMTP id j12so798367wrr.18
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 04:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6Rf//AlN3QtBrHtRXGOFcRq1gYCmqpphZZyfcGj0IbY=;
 b=ZMM5O1VSWUd3d41Gpht9w84KCFVX1t6+wz9ag4k2dw4QwtAAAcxm6PAm3OmnFjVb1S
 +fccEs70sJUX9gkG+pVJqA6Hya4vOMXuNsBFVfHA6Jvf8vj3gPTeY2xv/9PJ2W1enw81
 kX39vbMkc2811/DjVlQkLub0G7mDt//JLeh7vhMaGD0vLa5Db1FG5TdaDhnuz5RfWnZa
 hFKoZrdf5tJtcsKg8bY7emM+VUFufcqxhQEX/l9z0FIbxAorJQChNFPzRN73KzcR0imc
 9iDqoBqJrZ3dkD7yn7C1mVFCf08Xcu87PZwQWpBnoZS0TJ4EKFABt945nwS7SJkqEsl2
 NJcg==
X-Gm-Message-State: AGi0PuZuykrYqvk/3yUKM2S7w+2P0QHdrpAujLHLL+QGrLZ5VhUKkGLu
 5JGYVjz3gQWEPsKLJNe02jt79dhJ7OR4FeW7WkAwBapkXItS2sUQZHxzsANHrmZ+aXk7vwwa7O1
 r2hQvEATrCa+35DI=
X-Received: by 2002:a05:6000:12c5:: with SMTP id
 l5mr3493083wrx.185.1587121854171; 
 Fri, 17 Apr 2020 04:10:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ4jaIqVLO7H6fSYJNHaKxYMKL12OlaX21bidNV4quKuzt2PWQ7Jl4tvtgAL9iprTmmvnpjRw==
X-Received: by 2002:a05:6000:12c5:: with SMTP id
 l5mr3493050wrx.185.1587121853878; 
 Fri, 17 Apr 2020 04:10:53 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id x132sm7514454wmg.33.2020.04.17.04.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 04:10:53 -0700 (PDT)
Date: Fri, 17 Apr 2020 07:10:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] hw/pci/pcie: Forbid hot-plug via QMP if it's disabled on
 the slot
Message-ID: <20200417070818-mutt-send-email-mst@kernel.org>
References: <20200407145017.1041256-1-jusual@redhat.com>
 <20200408125120.7678d9ae@redhat.com>
 <20200413065048-mutt-send-email-mst@kernel.org>
 <CAMDeoFW8q5Er5re6PasjKQ3+3ABFiGrbjZ7WSf5zq836y_+GuA@mail.gmail.com>
 <20200417054957-mutt-send-email-mst@kernel.org>
 <CAMDeoFXZHjLQ=LZrStS6nLuLk1M9__Jy19D_TLEbtSgC1kYXUA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMDeoFXZHjLQ=LZrStS6nLuLk1M9__Jy19D_TLEbtSgC1kYXUA@mail.gmail.com>
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
Cc: qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 01:03:01PM +0200, Julia Suvorova wrote:
> On Fri, Apr 17, 2020 at 11:51 AM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> >
> > On Wed, Apr 15, 2020 at 10:20:33PM +0200, Julia Suvorova wrote:
> > > On Mon, Apr 13, 2020 at 12:55 PM Michael S. Tsirkin <mst@redhat.com> =
wrote:
> > > >
> > > > On Wed, Apr 08, 2020 at 12:51:20PM +0200, Igor Mammedov wrote:
> > > > > On Tue,  7 Apr 2020 16:50:17 +0200
> > > > > Julia Suvorova <jusual@redhat.com> wrote:
> > > > >
> > > > > > Raise an error when trying to hot-plug/unplug a device through =
QMP to a device
> > > > > > with disabled hot-plug capability. This makes the device behavi=
our more
> > > > > > consistent and provides an explanation of the failure in the ca=
se of
> > > > > > asynchronous unplug.
> > > > >
> > > > > it applies to hotplug in general (i.e. not only QMP)
> > > > >
> > > > > >
> > > > > > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > > > > > ---
> > > > > >  hw/pci/pcie.c | 24 +++++++++++++++++++++---
> > > > > >  1 file changed, 21 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > > > index 0eb3a2a5d2..e9798caa8a 100644
> > > > > > --- a/hw/pci/pcie.c
> > > > > > +++ b/hw/pci/pcie.c
> > > > > > @@ -415,6 +415,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *=
hotplug_dev, DeviceState *dev,
> > > > > >  {
> > > > > >      PCIDevice *hotplug_pdev =3D PCI_DEVICE(hotplug_dev);
> > > > > >      uint8_t *exp_cap =3D hotplug_pdev->config + hotplug_pdev->=
exp.exp_cap;
> > > > > > +    uint32_t sltcap =3D pci_get_word(exp_cap + PCI_EXP_SLTCAP)=
;
> > > > > >      PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> > > > > >
> > > > > >      /* Don't send event when device is enabled during qemu mac=
hine creation:
> > > > > > @@ -430,6 +431,13 @@ void pcie_cap_slot_plug_cb(HotplugHandler =
*hotplug_dev, DeviceState *dev,
> > > > > >          return;
> > > > > >      }
> > > > > >
> > > > > > +    /* Hot-plug is disabled on the slot */
> > > > > > +    if ((sltcap & PCI_EXP_SLTCAP_HPC) =3D=3D 0) {
> > > > > > +        error_setg(errp, "Device '%s' does not support hot-plu=
g",
> > > > > > +                         DEVICE(hotplug_dev)->id);
> > > > > plug and unplug_req are synchronous. so one can skip on "Device '=
%s'",
> > > > > user will get this error message as response to device_add/del co=
mmand.
> > > > >
> > > > > and more exactly it's concrete slot that does not support hotplug=
, how about
> > > > > "slot doesn't support ..." or just "hotlpug is not supported"
> > > >
> > > > Well device name is useful here, while these commands are synchrono=
us
> > > > others aren't so log parsing might not be synchronous.
> > > >
> > > > I do think we should mention slot since that's the reason
> > > > hotplug failed:
> > > >     "Device '%s' hot-plug failed: unsupported by slot"
> > > >
> > > > > > +        return;
> > > > > > +    }
> > > > > > +
> > > > > >      /* To enable multifunction hot-plug, we just ensure the fu=
nction
> > > > > >       * 0 added last. When function 0 is added, we set the slts=
ta and
> > > > > >       * inform OS via event notification.
> > > > > > @@ -464,14 +472,24 @@ static void pcie_unplug_device(PCIBus *bu=
s, PCIDevice *dev, void *opaque)
> > > > > >      object_unparent(OBJECT(dev));
> > > > > >  }
> > > > > >
> > > > > > -void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_d=
ev,
> > > > > > +void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_h=
andler,
> > > > > >                                       DeviceState *dev, Error *=
*errp)
> > > > > >  {
> > > > > >      Error *local_err =3D NULL;
> > > > > >      PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> > > > > >      PCIBus *bus =3D pci_get_bus(pci_dev);
> > > > > > +    PCIDevice *hotplug_dev =3D PCI_DEVICE(hotplug_handler);
> > > > > > +    uint8_t *exp_cap =3D hotplug_dev->config + hotplug_dev->ex=
p.exp_cap;
> > > > > > +    uint32_t sltcap =3D pci_get_word(exp_cap + PCI_EXP_SLTCAP)=
;
> > > > > > +
> > > > > > +    /* Hot-unplug is disabled on the slot */
> > > > > > +    if ((sltcap & PCI_EXP_SLTCAP_HPC) =3D=3D 0) {
> > > > > > +        error_setg(errp, "Device '%s' does not support hot-unp=
lug",
> > > > > > +                         DEVICE(hotplug_dev)->id);
> > > > > > +        return;
> > > >
> > > > Here too let's mention slot since that's the reason
> > > > hotplug failed:
> > > >     "Device '%s' hot-unplug failed: unsupported by slot"
> > > >
> > > > ?
> > >
> > > Just to mention, for a user it's disabled on the device,
> >
> > How?
> > I assumed this is what is used:
> >
> > commit 530a0963184e57e71a5b538e9161f115df533e96
> > Author: Julia Suvorova <jusual@redhat.com>
> > Date:   Wed Feb 26 18:46:07 2020 +0100
> >
> >     pcie_root_port: Add hotplug disabling option
> >
> >     Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvi=
rt
> >     manage it and restrict unplug for the whole machine. This is going =
to
> >     prevent user-initiated unplug in guests (Windows mostly).
> >     Hotplug is enabled by default.
> >     Usage:
> >         -device pcie-root-port,hotplug=3Doff,...
> >
> >
> > so it looks like user has to disable it on the slot.
>=20
> By device I mean root port, and it's shown in the error message. If
> you think it's not correct, I'll change it.

Oh I see. It might be confusing for user: I add device A
and get a report "Device B does not support hot-plug".
How about:
=09"Hot-plug failed: unsupported by port device %s"?

--=20
MST


