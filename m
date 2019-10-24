Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65ADCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 06:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD5220679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 06:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="bYrdL85R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD5220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33543 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNWqF-00030Z-Iy
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 02:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <parav@mellanox.com>) id 1iNVHs-0007h9-8S
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 01:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <parav@mellanox.com>) id 1iNVHq-0007d8-Mk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 01:03:51 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com
 ([40.107.1.73]:18306 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <parav@mellanox.com>) id 1iNVHq-0007ax-AA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 01:03:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buk3sp9dUrYv6BhmH6G1xjAWmfkyEDjJE0VjunOiMdpuWUavUryThUj0ocBPP7XCfEaOTucCOco5Z2yUkbma5VQc1LlVsNbgcopr+n14M8Pa4ooc0oxhiw41qWF+tSNhDxu4KCNtTiUvI4PEp48o+tmDhMGxj9j3QpzYYsMdKcqs3UNkJHEb4QEJpNiy4hywl6AXdiiBmu0VDKuKctftO21jDTmZc8WZMwbZrj2eEQGo0ajIW9vKoIpPrDUkKcSAl2iRrXq5ag/occRL7RvrzPQrthg9ZqTzsO6eg5l4hgpmmD8ntB9U4ZIryNXk253tFOHqE0kGAyB96uFtWwwDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBlVSwtKvY5DRKQN3eIV6ChJjDuFaE6Myukc6YaMa9o=;
 b=Ej362AqssNK/V6CBZ50fVOT1I5VZCxhfGOfuxVmh3e1GeFWgtXN7XGLV/0wL2TFWrwCxP6CMFGQ0yZ0WmdpyQA/VvlLkAHt4IuNzqkDeiyRnkHlOUkVoCv2ASeXQS1fyXAk931gTqyCghWwon/81zSJMLP1vfb5YECT01QhaAmsvpZYJNbSbDILMDi5uVvhmSO9kVJGA5JgxKnHtcowPTrGETd7VCu4iviNF451cGqKMnT06aaTWp4D7d3JzzF0RveeCkgdAD+bprR1j5AqdfI48ktxZ+ZWR+Ckm4mpJ9uaF5WK3nII84UegiCd0k9e643MdHXfoqwLxPax2QKzGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBlVSwtKvY5DRKQN3eIV6ChJjDuFaE6Myukc6YaMa9o=;
 b=bYrdL85RVhSD+/aEG8bbS7qlA13tAcYB4oo49wR0b+TowMzlOM85KlsEThaRGfeG/zsvg3LoIfs4TzDOzYw5Mz8h7m5M4hkmEgVGHCmVwJLVZBfo8YhX6hPH1uv4zW0EqCJR/G42TPrjXLtKGVhlK7ehr3m+Nz5uu+BLdG/kMk4=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5922.eurprd05.prod.outlook.com (20.178.119.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 24 Oct 2019 05:03:46 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.019; Thu, 24 Oct 2019
 05:03:46 +0000
From: Parav Pandit <parav@mellanox.com>
To: Jens Freimann <jfreimann@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v5 02/11] pci: add option for net failover
Thread-Topic: [PATCH v5 02/11] pci: add option for net failover
Thread-Index: AQHViXu9P2nJeuuefk+XB4EUlOmxoKdpOUUQ
Date: Thu, 24 Oct 2019 05:03:46 +0000
Message-ID: <AM0PR05MB486628D14AE740F3843CA236D16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
In-Reply-To: <20191023082711.16694-3-jfreimann@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec82:1c00:20e8:e8c9:af4:4a36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd315d87-a7ce-4328-f365-08d7583f8cdb
x-ms-traffictypediagnostic: AM0PR05MB5922:
x-microsoft-antispam-prvs: <AM0PR05MB5922C5DB34ED088C2AD90FCED16A0@AM0PR05MB5922.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(13464003)(189003)(199004)(33656002)(2906002)(99286004)(7696005)(478600001)(14454004)(76176011)(66946007)(46003)(76116006)(7416002)(66446008)(74316002)(305945005)(66476007)(66556008)(64756008)(7736002)(446003)(6116002)(11346002)(6246003)(6436002)(186003)(8936002)(9686003)(52536014)(5660300002)(229853002)(55016002)(53546011)(486006)(6506007)(256004)(25786009)(8676002)(81166006)(102836004)(81156014)(14444005)(316002)(71190400001)(71200400001)(86362001)(2501003)(476003)(110136005)(54906003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR05MB5922;
 H:AM0PR05MB4866.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKDufz+XmxXVetJdvmn9ZvydMxHLyscVCFQCYEQ+1XoRiPQrFahSgw8CIAEyQqEHHQHPa8mQkUFUyo+S+WuYUwCAFzKweYJ/ahsD9g8qEG7f7ruhRQQXSAn0srEKpSqMq9JI0Fg7KYvDVdkADAQ1KnLgRsuRajDvNLK1dn7LIlzWNAQ+2zbqIp8ckDPo4vlmQhJRQ1Fs8Sid/TCqektahqsttTKquYwUcJVqpUPPysI0cRQ0CWpYivCc4Vik4sqtdUlY31xiUR2jA0YJTRlMgBKELSSGsTlZYYfYCNlpArxaUN0xwJhSwcRSc2xpgm1MgEls0HqFaKnnHyAq5stR6kHHUxFwGTCptZISrfnD7f3u+V78r0y1L1+6BVrwfmBKD8lE8+QP3fkvp4REagb1wqvkRT0tCYOaI+Donz3tkg7XOeqb0PqPF0EUBkWXHITt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd315d87-a7ce-4328-f365-08d7583f8cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 05:03:46.4184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNqY/9rSYDbOSOAJ4Jz77chAAl8NdRSjjIY1d4BERr6pTSMy1cyiNyDRFx8JX5KRvaQptGpEIBmTTmFLxIxztg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5922
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.73
X-Mailman-Approved-At: Thu, 24 Oct 2019 02:41:22 -0400
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
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "laine@redhat.com" <laine@redhat.com>, "ailan@redhat.com" <ailan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Jens Freimann <jfreimann@redhat.com>
> Sent: Wednesday, October 23, 2019 3:27 AM
> To: qemu-devel@nongnu.org
> Cc: ehabkost@redhat.com; mst@redhat.com; berrange@redhat.com;
> pkrempa@redhat.com; laine@redhat.com; aadam@redhat.com;
> ailan@redhat.com; Parav Pandit <parav@mellanox.com>;
> dgilbert@redhat.com; alex.williamson@redhat.com
> Subject: [PATCH v5 02/11] pci: add option for net failover
>=20
> This patch adds a net_failover_pair_id property to PCIDev which is used t=
o
> link the primary device in a failover pair (the PCI dev) to a standby (a =
virtio-
> net-pci) device.
>=20
> It only supports ethernet devices. Also currently it only supports PCIe
> devices. QEMU will exit with an error message otherwise.
>=20
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  hw/pci/pci.c         | 17 +++++++++++++++++
>  include/hw/pci/pci.h |  3 +++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c index aa05c2b9b2..fa9b5219f8 100=
644
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
>=20
> @@ -2077,6 +2079,7 @@ static void pci_qdev_realize(DeviceState *qdev,
> Error **errp)
>      ObjectClass *klass =3D OBJECT_CLASS(pc);
>      Error *local_err =3D NULL;
>      bool is_default_rom;
> +    uint16_t class_id;
>=20
>      /* initialize cap_present for pci_is_express() and pci_config_size()=
,
>       * Note that hybrid PCIs are not set automatically and need to manag=
e
> @@ -2101,6 +2104,20 @@ static void pci_qdev_realize(DeviceState *qdev,
> Error **errp)
>          }
>      }
>=20
> +    if (pci_dev->net_failover_pair_id) {
> +        if (!pci_is_express(pci_dev)) {

I am testing and integrating this piece with mlx5 devices.
I see that pci_is_express() return true only for first PCI function.
Didn't yet dig the API.
Commenting out this check and below class check progresses further.

While reviewing, I realized that we shouldn't have this check for below rea=
sons.

1. It is user's responsibility to pass networking device.
But its ok to check the class, if PCI Device is passed.
So class comparison should be inside the pci_check().

2. It is limiting to only consider PCI devices.=20
Automated and regression tests should be able validate this feature without=
 PCI Device.
This will enhance the stability of feature in long run.

3. net failover driver doesn't limit it to have it over only PCI device.
So similarly hypervisor should be limiting.

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
>      if (pci_dev->romfile =3D=3D NULL && pc->romfile !=3D NULL) { diff --=
git
> a/include/hw/pci/pci.h b/include/hw/pci/pci.h index f3f0ffd5fb..def543568=
5
> 100644
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
>=20
>  void pci_register_bar(PCIDevice *pci_dev, int region_num,
> --
> 2.21.0


