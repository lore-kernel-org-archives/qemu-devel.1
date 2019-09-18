Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C7BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01AB218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="NGZUiBMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01AB218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjMY-0001Uy-Gt
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEb-0000PT-H0
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEa-0002a2-0o
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:41 -0400
Received: from mail-eopbgr710133.outbound.protection.outlook.com
 ([40.107.71.133]:31520 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEZ-0002XS-PE
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvIs9TGto3nXa9MQGYqeMOcqn03d+Rb18VDd+1inUFHfzet2Ngz+X3ifQfzDLp0pEMENwXXa1BAvyzppWix2xXfGcseZ4jRnN0q4fItlGBxdQmGrmczvtDK5y4WcYVXleOPTuWGwv85lgaNlGCcBVkJH9+Yu9ET+a48YfKNJdz4lgeTQzV+owoVRgx7HPGRpYnrQLaVjqNqQO3cH5URkfR6QJTayS/vDGwGBK1HjFDWXgkOJ9lI7mk7DcOUbkvCf3DMkauclVrkr1FqSQpLIwV+reXvQiSC3KXIywmZzWRork4AeQuF2G3m+VXJIZ6WGEgtktmQx5CgO79S74LTD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sfnJq6ByXF9F31MH8yL3+7KkAM2NItGiWj53YvImZA=;
 b=ERkRbGG9hkOz+B5rnaV6C+RWrCPSZzqxj4iKCwGnqASLmgcpb+JeWyOZiOVui7PqD2eNMFKwDfkfdhtLtrzY72QT5ebH9IrloyZySI8ZP8iM43kLhaLLo1DbO3dMVCWT7mrm/5yGIYfcFEr6ywnjCudRXIZwR7kiFnyRyHqGH00JpqoLXFSjYr+/13iFk8wWxVi+S/yAw5ALxUZ7q5GUYBok6rEjc4ElYdcCKaPeLsQd2vVpnZqJg2Tx4cgShTcK12a6BPtulLyepj2ynSWR33UfPxcCKYXt4dMdN0Wq01BpnOvHMsjylNtEJ3xj2KBHfp640WJGQ4dvSM6rQ/ANvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sfnJq6ByXF9F31MH8yL3+7KkAM2NItGiWj53YvImZA=;
 b=NGZUiBMfbz/R6fbTKU+436Wi9GNGylI9z7xQwzGshIxN56oWAkF2F2EHZHmc9DalDDLQD7Q9KIgjCNWALh5lcr19NFrjJcg5NvT5LgmxAPfaw7tdiEP14dGIwDGHTX+6CWhkdkxVv8hg5mjFZxTZi91p04TiuI6d1X62QmtELd0=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:38 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:38 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 11/22] libqos: split qos-test and libqos makefile vars
Thread-Index: AQHVbneK8atkP2NG50ioy6pVD31Geg==
Date: Wed, 18 Sep 2019 23:19:38 +0000
Message-ID: <20190918231846.22538-12-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d088dde-b377-4d88-3473-08d73c8ead14
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB30168A3FA3559686A4556172BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TKiUTbioU8HHb5TS8OzblQqlvt/GrgBxYLei87tOJb51LupwoKx/4JIOvkft29a2AMRAKc80bGOOi7AJ8LAUSwIIL8fEDWDvgCaYAlNZSimjsFrAWMLs4+SqtjaHwPHwvaCPqVmYWm2AiwwK3lIDpkj4AE3JIaGbLB3vJVlEK1zQaK/q3/3VLs1Dmil029Ee8wp0S9p6f43tKAZA8ze57qr7AQypsMkiUMTBxtM8ST0bMJwfmPUqsPT0HGWInQIuc0QCSBZI73teRwVN6jjoddCIdIfaLM/2+lUKCkCLFIQEp+YyCUHl7gy1AKvIwjZ7nJYa4HJGhz3r2VMEOIdapGUCvQ6chaVgFyBqt/WUdeL5YvHQ2NoPGoSivBdLeVdq1GKtMHw7GTbErB2nKGxB2nFAo0H6R5AJtzc5KLt6EE4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d088dde-b377-4d88-3473-08d73c8ead14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:38.4968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjEoljEKcpB/sbaVDQJ5MnEnVFihmKIjouB9hwvNqOpf9WpgHNLmtdL1fRwkV+1p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.133
Subject: [Qemu-devel] [PATCH v3 11/22] libqos: split qos-test and libqos
 makefile vars
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most qos-related objects were specified in the qos-test-obj-y variable.
qos-test-obj-y also included qos-test.o which defines a main().
This made it difficult to repurpose qos-test-obj-y to link anything
beside tests/qos-test against libqos. This change separates objects that
are libqos-specific and ones that are qos-test specific into different
variables.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/Makefile.include | 70 ++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a9b3c36259..da665ca7eb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -687,51 +687,53 @@ tests/test-crypto-block$(EXESUF): tests/test-crypto-b=
lock.o $(test-crypto-obj-y)
=20
 libqgraph-obj-y =3D tests/libqos/qgraph.o
=20
-libqos-obj-y =3D $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_cfg=
.o
-libqos-obj-y +=3D tests/libqos/malloc.o
-libqos-obj-y +=3D tests/libqos/libqos.o
-libqos-spapr-obj-y =3D $(libqos-obj-y) tests/libqos/malloc-spapr.o
+libqos-core-obj-y =3D $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/f=
w_cfg.o
+libqos-core-obj-y +=3D tests/libqos/malloc.o
+libqos-core-obj-y +=3D tests/libqos/libqos.o
+libqos-spapr-obj-y =3D $(libqos-core-obj-y) tests/libqos/malloc-spapr.o
 libqos-spapr-obj-y +=3D tests/libqos/libqos-spapr.o
 libqos-spapr-obj-y +=3D tests/libqos/rtas.o
 libqos-spapr-obj-y +=3D tests/libqos/pci-spapr.o
-libqos-pc-obj-y =3D $(libqos-obj-y) tests/libqos/pci-pc.o
+libqos-pc-obj-y =3D $(libqos-core-obj-y) tests/libqos/pci-pc.o
 libqos-pc-obj-y +=3D tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
 libqos-pc-obj-y +=3D tests/libqos/ahci.o
 libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos=
/usb.o
=20
 # Devices
-qos-test-obj-y =3D tests/qos-test.o $(libqgraph-obj-y)
-qos-test-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-qos-test-obj-y +=3D tests/libqos/e1000e.o
-qos-test-obj-y +=3D tests/libqos/i2c.o
-qos-test-obj-y +=3D tests/libqos/i2c-imx.o
-qos-test-obj-y +=3D tests/libqos/i2c-omap.o
-qos-test-obj-y +=3D tests/libqos/sdhci.o
-qos-test-obj-y +=3D tests/libqos/tpci200.o
-qos-test-obj-y +=3D tests/libqos/virtio.o
-qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/libqos/virtio-9p.o
-qos-test-obj-y +=3D tests/libqos/virtio-balloon.o
-qos-test-obj-y +=3D tests/libqos/virtio-blk.o
-qos-test-obj-y +=3D tests/libqos/virtio-mmio.o
-qos-test-obj-y +=3D tests/libqos/virtio-net.o
-qos-test-obj-y +=3D tests/libqos/virtio-pci.o
-qos-test-obj-y +=3D tests/libqos/virtio-rng.o
-qos-test-obj-y +=3D tests/libqos/virtio-scsi.o
-qos-test-obj-y +=3D tests/libqos/virtio-serial.o
+libqos-obj-y =3D $(libqos-core-obj-y)
+libqos-obj-y +=3D $(libqgraph-obj-y)
+libqos-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+libqos-obj-y +=3D tests/libqos/e1000e.o
+libqos-obj-y +=3D tests/libqos/i2c.o
+libqos-obj-y +=3D tests/libqos/i2c-imx.o
+libqos-obj-y +=3D tests/libqos/i2c-omap.o
+libqos-obj-y +=3D tests/libqos/sdhci.o
+libqos-obj-y +=3D tests/libqos/tpci200.o
+libqos-obj-y +=3D tests/libqos/virtio.o
+libqos-obj-$(CONFIG_VIRTFS) +=3D tests/libqos/virtio-9p.o
+libqos-obj-y +=3D tests/libqos/virtio-balloon.o
+libqos-obj-y +=3D tests/libqos/virtio-blk.o
+libqos-obj-y +=3D tests/libqos/virtio-mmio.o
+libqos-obj-y +=3D tests/libqos/virtio-net.o
+libqos-obj-y +=3D tests/libqos/virtio-pci.o
+libqos-obj-y +=3D tests/libqos/virtio-rng.o
+libqos-obj-y +=3D tests/libqos/virtio-scsi.o
+libqos-obj-y +=3D tests/libqos/virtio-serial.o
=20
 # Machines
-qos-test-obj-y +=3D tests/libqos/aarch64-xlnx-zcu102-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-imx25-pdk-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-n800-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-raspi2-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-sabrelite-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-smdkc210-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-virt-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-xilinx-zynq-a9-machine.o
-qos-test-obj-y +=3D tests/libqos/ppc64_pseries-machine.o
-qos-test-obj-y +=3D tests/libqos/x86_64_pc-machine.o
+libqos-obj-y +=3D tests/libqos/aarch64-xlnx-zcu102-machine.o
+libqos-obj-y +=3D tests/libqos/arm-imx25-pdk-machine.o
+libqos-obj-y +=3D tests/libqos/arm-n800-machine.o
+libqos-obj-y +=3D tests/libqos/arm-raspi2-machine.o
+libqos-obj-y +=3D tests/libqos/arm-sabrelite-machine.o
+libqos-obj-y +=3D tests/libqos/arm-smdkc210-machine.o
+libqos-obj-y +=3D tests/libqos/arm-virt-machine.o
+libqos-obj-y +=3D tests/libqos/arm-xilinx-zynq-a9-machine.o
+libqos-obj-y +=3D tests/libqos/ppc64_pseries-machine.o
+libqos-obj-y +=3D tests/libqos/x86_64_pc-machine.o
=20
 # Tests
+qos-test-obj-y =3D tests/qos-test.o
 qos-test-obj-y +=3D tests/ac97-test.o
 qos-test-obj-y +=3D tests/ds1338-test.o
 qos-test-obj-y +=3D tests/e1000-test.o
@@ -763,7 +765,7 @@ check-unit-y +=3D tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
=20
 check-qtest-generic-y +=3D tests/qos-test$(EXESUF)
-tests/qos-test$(EXESUF): $(qos-test-obj-y)
+tests/qos-test$(EXESUF): $(qos-test-obj-y) $(libqos-obj-y)
=20
 tests/qmp-test$(EXESUF): tests/qmp-test.o
 tests/qmp-cmd-test$(EXESUF): tests/qmp-cmd-test.o
--=20
2.23.0


