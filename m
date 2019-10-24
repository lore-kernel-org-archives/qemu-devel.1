Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99D7CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67F5205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYtMcWPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67F5205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhQI-0002If-EI
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNgp5-0006Pl-ES
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNgp3-0004iC-Ee
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:22:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21999
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNgp3-0004hy-AG
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571937772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdZLOf6Th0JKeeCafRGoYONyUrpGQYqJzPp/wUQCUE8=;
 b=PYtMcWPgdU6X3NsBRH9w7nPN7l8giqFVO4tuW5qPf8PLVzNFzOEw8v6xT9iWIvkQ5X0Wyv
 t755qosWdahdBC2abR4umizzbGRvBOFaZTxLIB3FC1WJa5eKl0SvRKXABForS7YrhHlO43
 d920uGXtOr2helOKhwL0fgyVtiDjsCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-LB7sNrDtOOCFvAcpCrKZGw-1; Thu, 24 Oct 2019 13:22:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F9F0100550E;
 Thu, 24 Oct 2019 17:22:50 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C306260E1C;
 Thu, 24 Oct 2019 17:22:29 +0000 (UTC)
Date: Thu, 24 Oct 2019 18:22:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v5 02/11] pci: add option for net failover
Message-ID: <20191024172227.GO2877@work-vm>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191023082711.16694-3-jfreimann@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: LB7sNrDtOOCFvAcpCrKZGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jens Freimann (jfreimann@redhat.com) wrote:
> This patch adds a net_failover_pair_id property to PCIDev which is
> used to link the primary device in a failover pair (the PCI dev) to
> a standby (a virtio-net-pci) device.
>=20
> It only supports ethernet devices. Also currently it only supports
> PCIe devices. QEMU will exit with an error message otherwise.
>=20
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

Should we just make this 'failover_pair_id' - then when someone in the
future figures out how to make it work for something else (e.g.
multipath block devices) then it's all good?

Dave

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
> --=20
> 2.21.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


