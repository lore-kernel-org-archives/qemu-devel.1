Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E066CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5A620659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2CQ0Hz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5A620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhLB-0004Ea-Rr
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iNgZW-0002Cj-SY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iNgZU-0007nT-Ev
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:06:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iNgZU-0007nJ-6c
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571936807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjKbnJkCtSXQ93ayBSJU8375lRy7SsnfaMys+x25s54=;
 b=A2CQ0Hz6GUU/9zaxRYFZr1+fjc6m2+HfUTky72SyQgU3UwnRwwtaACrPK6Kzns8brsUacd
 h/109mUOSqGSSnpa8tN7tSjoWArA7YG49R0VnYPlk80LQq1FqPF1do346IcyrJ6uYKcock
 lY9YyRkiNGlHcE/hc/H5Srx6rIyTzjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-SePw55aWPsyZpf1aRuV5Tg-1; Thu, 24 Oct 2019 13:06:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4C48476;
 Thu, 24 Oct 2019 17:06:42 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1932A5D717;
 Thu, 24 Oct 2019 17:06:35 +0000 (UTC)
Date: Thu, 24 Oct 2019 11:06:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
Message-ID: <20191024110634.35b5203f@x1.home>
In-Reply-To: <AM0PR05MB4866F6873AF47CB6D92C200ED16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <AM0PR05MB486628D14AE740F3843CA236D16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191024093754.tgdd7cp5riwcsytc@jenstp.localdomain>
 <AM0PR05MB4866F6873AF47CB6D92C200ED16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: SePw55aWPsyZpf1aRuV5Tg-1
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
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "aadam@redhat.com" <aadam@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "laine@redhat.com" <laine@redhat.com>, Jens Freimann <jfreimann@redhat.com>,
 "ailan@redhat.com" <ailan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 16:34:01 +0000
Parav Pandit <parav@mellanox.com> wrote:

> > -----Original Message-----
> > From: Jens Freimann <jfreimann@redhat.com>
> > Sent: Thursday, October 24, 2019 4:38 AM
> > To: Parav Pandit <parav@mellanox.com>
> > Cc: qemu-devel@nongnu.org; ehabkost@redhat.com; mst@redhat.com;
> > berrange@redhat.com; pkrempa@redhat.com; laine@redhat.com;
> > aadam@redhat.com; ailan@redhat.com; dgilbert@redhat.com;
> > alex.williamson@redhat.com
> > Subject: Re: [PATCH v5 02/11] pci: add option for net failover
> >=20
> > On Thu, Oct 24, 2019 at 05:03:46AM +0000, Parav Pandit wrote: =20
> > >> @@ -2101,6 +2104,20 @@ static void pci_qdev_realize(DeviceState
> > >> *qdev, Error **errp)
> > >>          }
> > >>      }
> > >>
> > >> +    if (pci_dev->net_failover_pair_id) {
> > >> +        if (!pci_is_express(pci_dev)) { =20
> > >
> > >I am testing and integrating this piece with mlx5 devices.
> > >I see that pci_is_express() return true only for first PCI function.
> > >Didn't yet dig the API.
> > >Commenting out this check and below class check progresses further. =
=20
> >=20
> > First of all, thanks for testing this!
> > Could you share your commandline please? I can't reproduce it. =20
> > > =20
> I added debug prints to get the difference between VF1 and VF2 behavior.
> What I see is, vfio_populate_device() below code is activated for VF2 whe=
re qemu claims that its not a PCIe device.
>=20
>     vdev->config_size =3D reg_info->size;
>     if (vdev->config_size =3D=3D PCI_CONFIG_SPACE_SIZE) {
>         vdev->pdev.cap_present &=3D ~QEMU_PCI_CAP_EXPRESS;
>         printf("%s clearing QEMU PCI bits\n", __func__);
>     }
>=20
> Command line:
> /usr/local/bin/qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
>                -machine q35,usb=3Doff,vmport=3Doff,dump-guest-core=3Doff =
-cpu Haswell-noTSX-IBRS \
>            -net none \
>                -qmp unix:/tmp/qmp.socket,server,nowait \
>         -monitor telnet:127.0.0.1:5556,server,nowait \
>         -device pcie-root-port,id=3Droot0,multifunction=3Don,chassis=3D0,=
addr=3D0xa \
>         -device pcie-root-port,id=3Droot1,bus=3Dpcie.0,chassis=3D1 \
>         -device pcie-root-port,id=3Droot2,bus=3Dpcie.0,chassis=3D2 \
>         -netdev tap,id=3Dhostnet1,fd=3D4 4<>/dev/tap49\
>         -device virtio-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D52:54:00=
:02:02:02,bus=3Droot2,failover=3Don \
>         -device vfio-pci,id=3Dhostdev0,host=3D05:00.2,bus=3Droot1,net_fai=
lover_pair_id=3Dnet1 \
>         /var/lib/libvirt/images/sriov-lm-02.qcow2
>=20
> > >While reviewing, I realized that we shouldn't have this check for belo=
w =20
> > reasons. =20
> > >
> > >1. It is user's responsibility to pass networking device.
> > >But its ok to check the class, if PCI Device is passed.
> > >So class comparison should be inside the pci_check(). =20
> >=20
> > I'm not sure I understand this point, could you please elaborate?
> > You're suggesting to move the check for the class into the check for
> > pci_is_express?
> >  =20
> No. Below is the suggestion.
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 8fbf32d68c..8004309973 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2105,17 +2105,14 @@ static void pci_qdev_realize(DeviceState *qdev, E=
rror **errp)
>      }
>=20
>      if (pci_dev->net_failover_pair_id) {
> -        if (!pci_is_express(pci_dev)) {
> -            error_setg(errp, "failover device is not a PCIExpress device=
");
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -        class_id =3D pci_get_word(pci_dev->config + PCI_CLASS_DEVICE);
> -        if (class_id !=3D PCI_CLASS_NETWORK_ETHERNET) {
> -            error_setg(errp, "failover device is not an Ethernet device"=
);
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        if (pci_is_express(pci_dev)) {
> +            class_id =3D pci_get_word(pci_dev->config + PCI_CLASS_DEVICE=
);
> +            if (class_id !=3D PCI_CLASS_NETWORK_ETHERNET) {
> +                error_setg(errp, "failover device is not an Ethernet dev=
ice");
> +                error_propagate(errp, local_err);
> +                return;
> +            }
> +       }
>=20
> This will allow to map non PCI device as failover too.

As in previous email, the point of the check was to exclude devices
when the hotplug controller is known not to support the feature.  It's
a topology check masked as a device check, it only exists because
support at the hotplug controller is not ubiquitous.  Thanks,

Alex

> After writing above hunk I think that when code reaches to check for=20
> If (pci_dev->net_failover_pair_id),... it is already gone gone through do=
_pci_register_device().
> There should not be any check needed again for pci_is_express().
> Isn't it?
>=20
>=20
> > >2. It is limiting to only consider PCI devices.
> > >Automated and regression tests should be able validate this feature wi=
thout =20
> > PCI Device. =20
> > >This will enhance the stability of feature in long run.
> > >
> > >3. net failover driver doesn't limit it to have it over only PCI devic=
e.
> > >So similarly hypervisor should be limiting. =20
> >=20
> > I agree that we don't have to limit it to PCI(e) forever. But for this =
first shot I
> > think we should and then extend it continually. There are more things w=
e can
> > support in the future like other hotplug types etc.
> >  =20
> o.k. But probably net_failover_pair_id field should be in DeviceState ins=
tead of PCIDevice at minimum?
> Or you want to refactor it later?


