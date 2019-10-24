Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD87ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76B1205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpGBHgfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76B1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgur-0000SO-Dn
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iNgM1-0003MV-AX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iNgLy-0002LH-SD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:52:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40595
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iNgLy-0002Kh-N6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571935969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKOalkmBq3mjNvBfAexQzAOH46NlfYH1VkmM9D43+Ig=;
 b=fpGBHgfvBKtgKenuwz3Wu0ZAvmXbdWURqJVSVFZMYa8fcQOaa74SSDRCMnNiHGSpn08sWJ
 U7KN/PzUsftTchFrf0URMmwU8x9HfEx0dDWnYYPPzABuQANTKnppENGKQgIDO6GA3dvbGw
 Sny49c5cvcHIQ2hYms4w6suT532rREM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-THgXYK7qOw6Xh1CtOuOvUw-1; Thu, 24 Oct 2019 12:52:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 230171800D6B;
 Thu, 24 Oct 2019 16:52:47 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93D2C5C21A;
 Thu, 24 Oct 2019 16:52:37 +0000 (UTC)
Date: Thu, 24 Oct 2019 10:52:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
Message-ID: <20191024105236.70403a2f@x1.home>
In-Reply-To: <20191024093754.tgdd7cp5riwcsytc@jenstp.localdomain>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <AM0PR05MB486628D14AE740F3843CA236D16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191024093754.tgdd7cp5riwcsytc@jenstp.localdomain>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: THgXYK7qOw6Xh1CtOuOvUw-1
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
Cc: "pkrempa@redhat.com" <pkrempa@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Parav Pandit <parav@mellanox.com>,
 "mst@redhat.com" <mst@redhat.com>, "aadam@redhat.com" <aadam@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "laine@redhat.com" <laine@redhat.com>, "ailan@redhat.com" <ailan@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 11:37:54 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> On Thu, Oct 24, 2019 at 05:03:46AM +0000, Parav Pandit wrote:
> >> @@ -2101,6 +2104,20 @@ static void pci_qdev_realize(DeviceState *qdev,
> >> Error **errp)
> >>          }
> >>      }
> >>
> >> +    if (pci_dev->net_failover_pair_id) {
> >> +        if (!pci_is_express(pci_dev)) { =20
> >
> >I am testing and integrating this piece with mlx5 devices.
> >I see that pci_is_express() return true only for first PCI function.
> >Didn't yet dig the API.
> >Commenting out this check and below class check progresses further. =20
>=20
> First of all, thanks for testing this!
> Could you share your commandline please? I can't reproduce it.
> >
> >While reviewing, I realized that we shouldn't have this check for below =
reasons.
> >
> >1. It is user's responsibility to pass networking device.
> >But its ok to check the class, if PCI Device is passed.
> >So class comparison should be inside the pci_check(). =20
>=20
> I'm not sure I understand this point, could you please elaborate?
> You're suggesting to move the check for the class into the check for
> pci_is_express?

Seems like the suggestion is that net_failover_pair_id should be an
option on the base class of PCIDevice (DeviceState?) and only if it's a
PCI device would we check the class code.  But there are dependencies
at the hotplug controller, which I think is why this is currently
specific to PCI.

However, it's an interesting point about pci_is_express().  This test
is really just meant to check whether the hotplug controller supports
this feature, which is only implemented in pciehp via this series.
There's a bit of a mismatch though that pcie_is_express() checks
whether the device is express, not whether the bus it sits on is
express.  I think we really want the latter, so maybe this should be:

pci_bus_is_express(pci_get_bus(dev)

For example this feature should work if I plug an e1000 (not e1000e)
into an express slot, but not if I plug an e1000e into a conventional
slot.
=20
> >2. It is limiting to only consider PCI devices.
> >Automated and regression tests should be able validate this feature with=
out PCI Device.
> >This will enhance the stability of feature in long run.
> >
> >3. net failover driver doesn't limit it to have it over only PCI device.
> >So similarly hypervisor should be limiting. =20
>=20
> I agree that we don't have to limit it to PCI(e) forever. But for this
> first shot I think we should and then extend it continually. There are
> more things we can support in the future like other hotplug types etc.

Yep, long term it seems very generic, but there's a dependency in the
hotplug controller and it is beneficial that PCI has a class code
feature that allows us to error if this is specified on a non-net
device.  Thanks,

Alex


