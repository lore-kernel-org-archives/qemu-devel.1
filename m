Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D86CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3F520684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdVCuWGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3F520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1GC-0001Qj-Tr
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iO11M-0004PH-9c
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iO11L-0001bc-4a
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:56:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iO11L-0001av-0W
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572015413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MEgFmb1M/DJZsvPe9JHbjdE6mVfQztvJTR5SwOp+Mqs=;
 b=KdVCuWGUnI8MNjhrh0eBSwJy+INGtniiQDY8TcrCK6xjhENSw2oyRrhbAxTI9WpMnrET4W
 wkBt2EpTqNNNubRi1pUOte8gb9Uxtt99pruV6vVJ1r3pOVMdxoUCaoJxkFZxltlGpH87UT
 c4pKeB+84z0mBz4tIpvxQN8jxGgmInE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-_zedvQKWMLCx7BnRnGo_TQ-1; Fri, 25 Oct 2019 10:56:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 669395EF;
 Fri, 25 Oct 2019 14:56:51 +0000 (UTC)
Received: from x1.home (ovpn-116-110.phx2.redhat.com [10.3.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86F085D772;
 Fri, 25 Oct 2019 14:56:49 +0000 (UTC)
Date: Fri, 25 Oct 2019 08:56:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
Message-ID: <20191025085647.5dbc2230@x1.home>
In-Reply-To: <20191025105232.gp22qlwjgpqsumie@jenstp.localdomain>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <20191023120648.57e50ae1@x1.home>
 <20191025105232.gp22qlwjgpqsumie@jenstp.localdomain>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: _zedvQKWMLCx7BnRnGo_TQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On Fri, 25 Oct 2019 12:52:32 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> On Wed, Oct 23, 2019 at 12:06:48PM -0600, Alex Williamson wrote:
> >On Wed, 23 Oct 2019 10:27:02 +0200
> >Jens Freimann <jfreimann@redhat.com> wrote: =20
> [...]
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
> >hotpluggable slot?  Are there also multi-function considerations that
> >should be prevented or documented?  For example, if a user tries to
> >configure both the primary and failover NICs in the same slot, I assume
> >bad things will happen. =20
>=20
> I added this check
>=20
>         if (!(pci_dev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION)
>             && (PCI_FUNC(pci_dev->devfn) =3D=3D 0)) {
>             qdev->allow_unplug_during_migration =3D true;
>         } else {
>             error_setg(errp, "failover: primary device must be in its own=
 "
>                               "PCI slot");
>             error_propagate(errp, local_err);
>             pci_qdev_unrealize(DEVICE(pci_dev), NULL);
>             return;
>         }
>=20
> When I first add a vfio-pci with net_failover_pair_id=3Dx,multifunction=
=3Don
> and addr=3D0.0 I will now get an error.
>=20
> (qemu) device_add vfio-pci,...,bus=3Droot2,net_failover_pair_id=3Dnet1,mu=
ltifunction=3Don,addr=3D0.0
> Error: failover: primary device must be in its own PCI slot
>=20
> If I put in a virtio-net device in slot 0 and then try to add a
> vfio-pci device in the same slot I get the following error message:
>=20
> -device virtio-net-pci,...id=3Dnet1bus=3Droot1,failover=3Don,multifunctio=
n=3Don,addr=3D0.0
> (qemu) device_add vfio-pci,id=3Dhostdev1,host=3D0000:5e:00.2,bus=3Droot1,=
net_failover_pair_id=3Dnet1,addr=3D0.1
> Error: PCI: slot 0 function 0 already ocuppied by virtio-net-pci,
>    new func vfio-pci cannot be exposed to guest.

Cool, looks good.  Thanks,

Alex


