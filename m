Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5063CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F80B205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="q0OynXgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F80B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNh2L-0003ZY-2C
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <parav@mellanox.com>) id 1iNg3q-0001lT-Ny
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <parav@mellanox.com>) id 1iNg3p-0002vk-23
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:34:06 -0400
Received: from mail-eopbgr40070.outbound.protection.outlook.com
 ([40.107.4.70]:9230 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <parav@mellanox.com>) id 1iNg3o-0002vS-M6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:34:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yh5BmX1KjxcmAUDcTY+bUXMhhTLtULikyjFxV1oPZryC0gAr9Cx3yBNh8W3QQN8s8ljvluRB8m7pFPTTK9dr6bTvz5yp8KOyTi08uqdWSEz3QZfFY3PAKiiQBmG5CXWBAB5i/I7eDR84+JIq1LepXE3Xm+kY8aNOKWHwKivR4yXC13kFVK8Cti1krYl9vhtsZGPfxYMr+nlY8XUSIMdpcO9N5+EyoHinX+eXjjOB3NW6VxZm3F3bPCeoR++FKWofegeu/pHcHOFmkAtfNoKdZVp4fWgCoqCdjGpUoQPe6MBtVjli9Q85z9TzdeHsmQYYDStscnYrqsy5PUl2K3zsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wyvwuJnnBj153Yq7FPQYnUm6CPz/j6kciI5nCobsXo=;
 b=m8v71wcuZnXiVY/VQU+ND17Mg6WKgxbMpcONxlv4GRkpNQiw8UJORM7Ik3DSYKocBk4D91/1jusRCRPVuSTqT0RlyNl6/g3QDv2aJCHjN5o+TMibjllxujrTG11ebQ2aL/9qQ0MYzyzSLf6n8m1AWJAp2zcjuvdSGcWjQp32/CcrMTNB6JIzKGO7pJu69C8NPGeY4cf/GK1mCLBtyT/aQzeTVyQAj9eP0A9APNFfvXgHjxn2KdQkS1EEvPsiCTi72vFs91cKjWeZitlK8ukM3uQPdPDqRqu9/AV3XITF0HhFGYpsLPmnvQBdR+luveD44YjPXdILnyXffSehJKMedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wyvwuJnnBj153Yq7FPQYnUm6CPz/j6kciI5nCobsXo=;
 b=q0OynXgI2tbaUWsVp+YjU23G+90gWlTE23ckxEPFehodM84PNTJx2bTLtykn6DAyoLxXjBUB1p7NzHifa+ThLvdVXvTkyzKgYUp3Ap5VYAhmLMkZBnP2K1xro8kgPX8cC0myDL78hAB9hZZOZ4sb+Tq+2KAlSoPXWFd26zHpgaI=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4305.eurprd05.prod.outlook.com (52.134.125.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 24 Oct 2019 16:34:02 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.019; Thu, 24 Oct 2019
 16:34:02 +0000
From: Parav Pandit <parav@mellanox.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: RE: [PATCH v5 02/11] pci: add option for net failover
Thread-Topic: [PATCH v5 02/11] pci: add option for net failover
Thread-Index: AQHViXu9P2nJeuuefk+XB4EUlOmxoKdpOUUQgABRLwCAAHCfoA==
Date: Thu, 24 Oct 2019 16:34:01 +0000
Message-ID: <AM0PR05MB4866F6873AF47CB6D92C200ED16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191023082711.16694-1-jfreimann@redhat.com>
 <20191023082711.16694-3-jfreimann@redhat.com>
 <AM0PR05MB486628D14AE740F3843CA236D16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191024093754.tgdd7cp5riwcsytc@jenstp.localdomain>
In-Reply-To: <20191024093754.tgdd7cp5riwcsytc@jenstp.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 937baabf-375a-4acd-d351-08d7589ffa6c
x-ms-traffictypediagnostic: AM0PR05MB4305:
x-microsoft-antispam-prvs: <AM0PR05MB4305EDB0D956777E8198434ED16A0@AM0PR05MB4305.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(13464003)(199004)(189003)(51444003)(66946007)(486006)(76116006)(66446008)(64756008)(6436002)(66556008)(66476007)(256004)(6246003)(14444005)(229853002)(55016002)(478600001)(71190400001)(71200400001)(66066001)(14454004)(25786009)(76176011)(102836004)(53546011)(6506007)(99286004)(7696005)(33656002)(316002)(11346002)(446003)(186003)(4326008)(26005)(7416002)(7736002)(305945005)(74316002)(6916009)(476003)(81166006)(81156014)(54906003)(2906002)(9686003)(86362001)(8676002)(52536014)(5660300002)(8936002)(6116002)(3846002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR05MB4305;
 H:AM0PR05MB4866.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LeyxZPUd/Pb6HrX1DIYzxrY4RfDMjePb6owp6FQ5kItcCz1VhUykNYZmNyynLyKguk+MJzQt8vq/Cc8lP0r1lgpbpA5qvwXKlGZsajo3l3xXkO/Ajh+6r0YWW85t3l0gHJCOOBH2aFj3ZLpeLEkrJ7dhzup1SI05KbPfdkHKP5+O3szC1S9u3jhFzcq0nU/Kyf+KQCTAvHYik+/5mnlllTHNR2HyYly63RxAX0hgRkBYZwmUzT6TKdZaEyxyS8ksdPvlSlRJSs+oyvkbUL0lYYrBy0fpPKp8ozeyK1Uq6AH1hLf4cI/9y84v4FqstGMK6BZpWXyefNUI7sCgo5oJQUf+J5Kv/9z25gnDBBq4FCRuU3j74klWEmiqEZjvtwBtsc3X/xR/+M9jzgQthJGjDOyAuH9Jedim44jU/V791nHM/C0d6ZPaOSqeA054v2Q9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937baabf-375a-4acd-d351-08d7589ffa6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 16:34:01.9155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nT2T6Sqmt874rPl+h021YZLVkTDOJStXkZ+9lQvTFrt3CRr5YO7RFYvaS6C84PF+u7915x88GxDevVOvCZob3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4305
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.70
X-Mailman-Approved-At: Thu, 24 Oct 2019 13:29:07 -0400
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
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "laine@redhat.com" <laine@redhat.com>, "ailan@redhat.com" <ailan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Jens Freimann <jfreimann@redhat.com>
> Sent: Thursday, October 24, 2019 4:38 AM
> To: Parav Pandit <parav@mellanox.com>
> Cc: qemu-devel@nongnu.org; ehabkost@redhat.com; mst@redhat.com;
> berrange@redhat.com; pkrempa@redhat.com; laine@redhat.com;
> aadam@redhat.com; ailan@redhat.com; dgilbert@redhat.com;
> alex.williamson@redhat.com
> Subject: Re: [PATCH v5 02/11] pci: add option for net failover
>=20
> On Thu, Oct 24, 2019 at 05:03:46AM +0000, Parav Pandit wrote:
> >> @@ -2101,6 +2104,20 @@ static void pci_qdev_realize(DeviceState
> >> *qdev, Error **errp)
> >>          }
> >>      }
> >>
> >> +    if (pci_dev->net_failover_pair_id) {
> >> +        if (!pci_is_express(pci_dev)) {
> >
> >I am testing and integrating this piece with mlx5 devices.
> >I see that pci_is_express() return true only for first PCI function.
> >Didn't yet dig the API.
> >Commenting out this check and below class check progresses further.
>=20
> First of all, thanks for testing this!
> Could you share your commandline please? I can't reproduce it.
> >
I added debug prints to get the difference between VF1 and VF2 behavior.
What I see is, vfio_populate_device() below code is activated for VF2 where=
 qemu claims that its not a PCIe device.

    vdev->config_size =3D reg_info->size;
    if (vdev->config_size =3D=3D PCI_CONFIG_SPACE_SIZE) {
        vdev->pdev.cap_present &=3D ~QEMU_PCI_CAP_EXPRESS;
        printf("%s clearing QEMU PCI bits\n", __func__);
    }

Command line:
/usr/local/bin/qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
               -machine q35,usb=3Doff,vmport=3Doff,dump-guest-core=3Doff -c=
pu Haswell-noTSX-IBRS \
           -net none \
               -qmp unix:/tmp/qmp.socket,server,nowait \
        -monitor telnet:127.0.0.1:5556,server,nowait \
        -device pcie-root-port,id=3Droot0,multifunction=3Don,chassis=3D0,ad=
dr=3D0xa \
        -device pcie-root-port,id=3Droot1,bus=3Dpcie.0,chassis=3D1 \
        -device pcie-root-port,id=3Droot2,bus=3Dpcie.0,chassis=3D2 \
        -netdev tap,id=3Dhostnet1,fd=3D4 4<>/dev/tap49\
        -device virtio-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D52:54:00:0=
2:02:02,bus=3Droot2,failover=3Don \
        -device vfio-pci,id=3Dhostdev0,host=3D05:00.2,bus=3Droot1,net_failo=
ver_pair_id=3Dnet1 \
        /var/lib/libvirt/images/sriov-lm-02.qcow2

> >While reviewing, I realized that we shouldn't have this check for below
> reasons.
> >
> >1. It is user's responsibility to pass networking device.
> >But its ok to check the class, if PCI Device is passed.
> >So class comparison should be inside the pci_check().
>=20
> I'm not sure I understand this point, could you please elaborate?
> You're suggesting to move the check for the class into the check for
> pci_is_express?
>=20
No. Below is the suggestion.

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8fbf32d68c..8004309973 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2105,17 +2105,14 @@ static void pci_qdev_realize(DeviceState *qdev, Err=
or **errp)
     }

     if (pci_dev->net_failover_pair_id) {
-        if (!pci_is_express(pci_dev)) {
-            error_setg(errp, "failover device is not a PCIExpress device")=
;
-            error_propagate(errp, local_err);
-            return;
-        }
-        class_id =3D pci_get_word(pci_dev->config + PCI_CLASS_DEVICE);
-        if (class_id !=3D PCI_CLASS_NETWORK_ETHERNET) {
-            error_setg(errp, "failover device is not an Ethernet device");
-            error_propagate(errp, local_err);
-            return;
-        }
+        if (pci_is_express(pci_dev)) {
+            class_id =3D pci_get_word(pci_dev->config + PCI_CLASS_DEVICE);
+            if (class_id !=3D PCI_CLASS_NETWORK_ETHERNET) {
+                error_setg(errp, "failover device is not an Ethernet devic=
e");
+                error_propagate(errp, local_err);
+                return;
+            }
+       }

This will allow to map non PCI device as failover too.
After writing above hunk I think that when code reaches to check for=20
If (pci_dev->net_failover_pair_id),... it is already gone gone through do_p=
ci_register_device().
There should not be any check needed again for pci_is_express().
Isn't it?


> >2. It is limiting to only consider PCI devices.
> >Automated and regression tests should be able validate this feature with=
out
> PCI Device.
> >This will enhance the stability of feature in long run.
> >
> >3. net failover driver doesn't limit it to have it over only PCI device.
> >So similarly hypervisor should be limiting.
>=20
> I agree that we don't have to limit it to PCI(e) forever. But for this fi=
rst shot I
> think we should and then extend it continually. There are more things we =
can
> support in the future like other hotplug types etc.
>=20
o.k. But probably net_failover_pair_id field should be in DeviceState inste=
ad of PCIDevice at minimum?
Or you want to refactor it later?

