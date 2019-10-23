Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBEBCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A7121906
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQKzr8KS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A7121906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNOpK-00052m-C2
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iNMq2-0008QZ-9i
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 16:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iNMpz-0007fv-Dq
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 16:02:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30988
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iNMpz-0007fM-8F
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 16:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571860948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqDExiXzTMiAOX5/u5TZPgpduavpJDhOAHilmlQa/g8=;
 b=hQKzr8KS//iWdZiU8Gxjl48ze8f0mr63UqBHncgKr8+Aj49f/iVS4/votKaC/pFH9rd7os
 E2/689UllCx/mSI1qWsTW583OAwHkEPGn8Rybtx+y4orVRgxNsfMUuOoTHBHYcV9c1GHm3
 RKIkh/9QrLlJTKDruKcZ8NOS95nRZBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-ZBAP488yMf6aqW9_9dhk0w-1; Wed, 23 Oct 2019 16:02:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0731F107AD33;
 Wed, 23 Oct 2019 20:02:24 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D2985DD7A;
 Wed, 23 Oct 2019 20:02:12 +0000 (UTC)
Date: Wed, 23 Oct 2019 14:02:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
Message-ID: <20191023140211.4ada7ff3@x1.home>
In-Reply-To: <20191023193035.tlcumzmgjw242hgw@jenstp.localdomain>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <20191023120648.57e50ae1@x1.home>
 <20191023193035.tlcumzmgjw242hgw@jenstp.localdomain>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ZBAP488yMf6aqW9_9dhk0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 laine@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 21:30:35 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> On Wed, Oct 23, 2019 at 12:06:48PM -0600, Alex Williamson wrote:
> >On Wed, 23 Oct 2019 10:27:02 +0200
> >Jens Freimann <jfreimann@redhat.com> wrote:
> > =20
> >> This patch adds a net_failover_pair_id property to PCIDev which is
> >> used to link the primary device in a failover pair (the PCI dev) to
> >> a standby (a virtio-net-pci) device.
> >>
> >> It only supports ethernet devices. Also currently it only supports
> >> PCIe devices. QEMU will exit with an error message otherwise.
> >>
> >> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> >> ---
> >>  hw/pci/pci.c         | 17 +++++++++++++++++
> >>  include/hw/pci/pci.h |  3 +++
> >>  2 files changed, 20 insertions(+)
> >>
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index aa05c2b9b2..fa9b5219f8 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -75,6 +75,8 @@ static Property pci_props[] =3D {
> >>                      QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
> >>      DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
> >>                      QEMU_PCIE_EXTCAP_INIT_BITNR, true),
> >> +    DEFINE_PROP_STRING("net_failover_pair_id", PCIDevice,
> >> +            net_failover_pair_id), =20
> >
> >Nit, white space appears broken here. =20
>=20
> I'll fix it.
>=20
> >>      DEFINE_PROP_END_OF_LIST()
> >>  };
> >>
> >> @@ -2077,6 +2079,7 @@ static void pci_qdev_realize(DeviceState *qdev, =
Error **errp)
> >>      ObjectClass *klass =3D OBJECT_CLASS(pc);
> >>      Error *local_err =3D NULL;
> >>      bool is_default_rom;
> >> +    uint16_t class_id;
> >>
> >>      /* initialize cap_present for pci_is_express() and pci_config_siz=
e(),
> >>       * Note that hybrid PCIs are not set automatically and need to ma=
nage
> >> @@ -2101,6 +2104,20 @@ static void pci_qdev_realize(DeviceState *qdev,=
 Error **errp)
> >>          }
> >>      }
> >>
> >> +    if (pci_dev->net_failover_pair_id) {
> >> +        if (!pci_is_express(pci_dev)) {
> >> +            error_setg(errp, "failover device is not a PCIExpress dev=
ice");
> >> +            error_propagate(errp, local_err);
> >> +            return;
> >> +        } =20
> >
> >Did we decide we don't need to test that the device is also in a
> >hotpluggable slot?   =20
>=20
> Hmm, my reply to you was never sent. I thought the check for
> qdev_device_add() was sufficient but you said that works only
> after qdev_hotplug is set (after machine creation). I modified
> the check to this:
>=20
>     hide =3D should_hide_device(opts);                                   =
                                  =20
>                                                                          =
                                =20
>     if ((hide || qdev_hotplug) && bus && !qbus_is_hotpluggable(bus)) {   =
                                =20
>         error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);                =
                                =20
>         return NULL;                                                     =
                                =20
>     }                                                                    =
                                =20
>                                                                          =
                                =20
>     if (hide) {                                                          =
                                =20
>         return NULL;                                                     =
                                =20
>     }
>=20
> This will make qemu fail when we have the device in the initial
> configuration or when we hotplug it to a bus that doesn't support it.
> I tested both with a device on pcie.0. Am I missing something?=20

Nope, sorry, I was expecting the check here and didn't see that you
perform it elsewhere.  Seems good enough for me.
=20
> >Are there also multi-function considerations that
> >should be prevented or documented?  For example, if a user tries to
> >configure both the primary and failover NICs in the same slot, I assume
> >bad things will happen. =20
>=20
>   I would have expected that this is already checked in pci code, but
> it is not. I tried it and when I put both devices into the same slot
> they are both unplugged from the guest during boot but nothing else
> happens. I don't know what triggers that unplug of the devices.
>=20
> I'm not aware of any other problems regarding multi-function, which
> doesn't mean there aren't any.=20

Hmm, was the hidden device at function #0?  The guest won't find any
functions if function #0 isn't present, but I don't know what would
trigger the hotplug.  The angle I'm thinking is that we only have slot
level granularity for hotplug, so any sort of automatic hotplug of a
slot should probably think about bystander devices within the slot.
Thanks,

Alex

> >> +        class_id =3D pci_get_word(pci_dev->config + PCI_CLASS_DEVICE)=
;
> >> +        if (class_id !=3D PCI_CLASS_NETWORK_ETHERNET) {
> >> +            error_setg(errp, "failover device is not an Ethernet devi=
ce");
> >> +            error_propagate(errp, local_err);
> >> +            return;
> >> +        }
> >> +    } =20
> >
> >Looks like cleanup is missing both both error cases, the option rom
> >error path below this does a pci_qdev_unrealize() before returning so
> >I'd assume we want the same here.  Thanks, =20
>=20
> Thanks, I'll fix this too.
>=20
> regards,
> Jens=20


