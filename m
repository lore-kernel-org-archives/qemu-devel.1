Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0762CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:00:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79012064B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgFl+hIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79012064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZAe-00081h-Oc
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iMZ9D-0006e6-1K
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iMZ9B-000540-UN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:59:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iMZ9B-00053N-R7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571669940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZwxjcHK8GW3s9FpwNH5AWR75uHG+TIGtw4yLVxfxZUM=;
 b=dgFl+hIzKlGAc74S9G35Y5+9J6Q9JVzx/6Smf/BFYQtMEV4kS/1pxOitVN0jvanpmEWltP
 66OrApJE/QdW99K6pLxz2EApagPyf/RFs1gy+biyaXXifoUjUVimcolT0Rs9SJ2YGqHgYU
 dH8YSbhULkps+F8UBAt3seNUHk3rtwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-oAcpccw-PD-a-aQTw3zp2w-1; Mon, 21 Oct 2019 10:58:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEE401800D79;
 Mon, 21 Oct 2019 14:58:57 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46F3260606;
 Mon, 21 Oct 2019 14:58:24 +0000 (UTC)
Date: Mon, 21 Oct 2019 08:58:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH 02/11] pci: add option for net failover
Message-ID: <20191021085823.72ac4b37@x1.home>
In-Reply-To: <20191018202040.30349-3-jfreimann@redhat.com>
References: <20191018202040.30349-1-jfreimann@redhat.com>
 <20191018202040.30349-3-jfreimann@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: oAcpccw-PD-a-aQTw3zp2w-1
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

On Fri, 18 Oct 2019 22:20:31 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> This patch adds a net_failover_pair_id property to PCIDev which is
> used to link the primary device in a failover pair (the PCI dev) to
> a standby (a virtio-net-pci) device.
>=20
> It only supports ethernet devices. Also currently it only supports
> PCIe devices. QEMU will exit with an error message otherwise.

Doesn't the PCIe device also need to be hotpluggable?  We can have PCIe
devices attached to the root bus where we don't currently support
hotplug.  Thanks,

Alex
=20
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  hw/pci/pci.c         | 17 +++++++++++++++++
>  include/hw/pci/pci.h |  3 +++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index aa05c2b9b2..fa9b5219f8 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -75,6 +75,8 @@ static Property pci_props[] =3D {
>                      QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
>      DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
>                      QEMU_PCIE_EXTCAP_INIT_BITNR, true),
> +    DEFINE_PROP_STRING("net_failover_pair_id", PCIDevice,
> +            net_failover_pair_id),
>      DEFINE_PROP_END_OF_LIST()
>  };
> =20
> @@ -2077,6 +2079,7 @@ static void pci_qdev_realize(DeviceState *qdev, Err=
or **errp)
>      ObjectClass *klass =3D OBJECT_CLASS(pc);
>      Error *local_err =3D NULL;
>      bool is_default_rom;
> +    uint16_t class_id;
> =20
>      /* initialize cap_present for pci_is_express() and pci_config_size()=
,
>       * Note that hybrid PCIs are not set automatically and need to manag=
e
> @@ -2101,6 +2104,20 @@ static void pci_qdev_realize(DeviceState *qdev, Er=
ror **errp)
>          }
>      }
> =20
> +    if (pci_dev->net_failover_pair_id) {
> +        if (!pci_is_express(pci_dev)) {
> +            error_setg(errp, "failover device is not a PCIExpress device=
");
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +        class_id =3D pci_get_word(pci_dev->config + PCI_CLASS_DEVICE);
> +        if (class_id !=3D PCI_CLASS_NETWORK_ETHERNET) {
> +            error_setg(errp, "failover device is not an Ethernet device"=
);
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +
>      /* rom loading */
>      is_default_rom =3D false;
>      if (pci_dev->romfile =3D=3D NULL && pc->romfile !=3D NULL) {
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index f3f0ffd5fb..def5435685 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -352,6 +352,9 @@ struct PCIDevice {
>      MSIVectorUseNotifier msix_vector_use_notifier;
>      MSIVectorReleaseNotifier msix_vector_release_notifier;
>      MSIVectorPollNotifier msix_vector_poll_notifier;
> +
> +    /* ID of standby device in net_failover pair */
> +    char *net_failover_pair_id;
>  };
> =20
>  void pci_register_bar(PCIDevice *pci_dev, int region_num,


