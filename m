Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99758C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6206E218DA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="RLlrIE5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6206E218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpYJd-0000Bu-UT
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50013)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hpYJE-0007UV-4U
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hpYJC-0003rj-Fn
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:24:55 -0400
Received: from mail-eopbgr730122.outbound.protection.outlook.com
 ([40.107.73.122]:19328 helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hpYJB-0003p7-9U
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:24:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvBOUKr4c0RXjnenB0bl8GwrkXtzms4Qzl3ndzCsO+H4yGiC/xz0qBMKXNs/YKzxbCNdLtRDE+lu2cEk4s7oZLgnrTISDTbUiMceE9w/NYY7dIXTTYsxj2QWaGUpXVJaq5NBpSxEZhqH9yBPvRMDq5nq/aYPAFa1oJ+JsGga1tSkiAvoc8A8x5sNaxNJANlLe44KmsYa+P3z9pu45m1NVBvbGTccWSqhj0E+TGMfjpj1q6R3z2mpr0CT2rTH2ROOfAqTQL83NJARV7gJ5POXRoga1Q+L7dvV/U4TtquXy34t0mT8ds23/G+venhW+ZVXnNbrNrz6DQz0YDhDSKkLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok+eCycc9CSSwvwyMltlEx3Nn6KUMUUqeqv64dBoap0=;
 b=SdlcscIN+2AMN/dFX3jpbREZr3iaPOx/S9GOhM8aXIWL2QyUdozEs2oUwI6Cnd7uH2oDiyNQKk+DmAA04+MKd2RiBZ+pEOSfHFyvHKNjGKK+INv5XcL8647niMFThdz8Kpp/rhOEEyki0MSlD6Ne1FsZkJ/8K4isPTUid3AMWjgJS1QmnZqp/ZOTidHuqNm40mHbwfAgROA+6Ju3HqPLc6u8cl1W/lL+Dj5aZBwD9zpY7tL835R3aJi2wxMDH60iYyiYtVfxSPL3Brokqe46DjDGhmpvj7+o6uFQaQ9rLvvh5F4r1WjCs7trQjpOKjp78oVe+m+NP8VBykgT1rqqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok+eCycc9CSSwvwyMltlEx3Nn6KUMUUqeqv64dBoap0=;
 b=RLlrIE5FLPmZwC1ABCKqLxda/5xEOefMj9yMifwZwP4K+QxYYiMAmGkt9rYObAsJ3LNvNKSr5cbsuHjLTwswDOFteDx/KSDstKjTnID6btNAEh846PKvP3vtGYN56f0YxHanxtcCowy+/emEGTkVVBoV8sUH7atqzn1Gm98SrVo=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 13:24:48 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 13:24:48 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 2/2] virtio-net: check that tx packet has positive size
Thread-Index: AQHVQJDWdJGlkkjH4kGonOrv/UHtcw==
Date: Mon, 22 Jul 2019 13:24:48 +0000
Message-ID: <20190722132344.30798-3-alxndr@bu.edu>
References: <20190722132344.30798-1-alxndr@bu.edu>
In-Reply-To: <20190722132344.30798-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR01CA0030.prod.exchangelabs.com (2603:10b6:208:10c::43)
 To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3a5db6b-ae85-4991-6643-08d70ea7f872
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB26465629E2F1B0EEE5AA7EA3BAC40@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(66946007)(66476007)(66446008)(64756008)(66556008)(256004)(14444005)(99286004)(1076003)(316002)(486006)(71190400001)(54906003)(2351001)(50226002)(8936002)(3846002)(6116002)(786003)(88552002)(2906002)(71200400001)(81166006)(81156014)(478600001)(7736002)(6512007)(2501003)(26005)(186003)(11346002)(8676002)(25786009)(476003)(66066001)(2616005)(305945005)(36756003)(5660300002)(53936002)(6436002)(446003)(6916009)(76176011)(4326008)(68736007)(14454004)(52116002)(75432002)(86362001)(102836004)(6486002)(6506007)(5640700003)(386003)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DBLK7yJfVUwsU7LLyhseDul90yDadaKt9LVWc12e8v21Q2kTsc15vWXhNoYF04ww/QSGttkabLT0jQ3vB1jCGJumnbCmufjRs60f+a3EYh6a/pg7t22MnYggcip51naKnyHcA0kgA3SBi2r+50IBAdFQ35vRLI8NA/A7zOJ569kJHY0uMQBkoy56QNE5g5HnJ3jT7DHaM5XFZyv32YoRG2moVP8f4xoqX42qM3NyTgYc5F1vw0WBGKSXdDNzUartewWXHaPQL1xLodEmyrdags/1XCKv0D3Jb5Dkcsapr0btXe3lLpogFrLh7ViMx8pzcz1hR7RvsVaNwlCaGIB8M+gl598f+ZIJrEw0ZLPPFQU0pDvtGvQExG6NIrtKKuVZ03HHgRM7oqsV/h33CvBiaujIBDaPqGx0ZmanYuMc63E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a5db6b-ae85-4991-6643-08d70ea7f872
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 13:24:48.7928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.122
Subject: [Qemu-devel] [PATCH v2 2/2] virtio-net: check that tx packet has
 positive size
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio_net_flush_tx does not check that the packet size is nonzero,
which causes q->aysnc_tx.elem to be set. Then, when the device is reset, th=
ere
is an assertion failure since q->aysnc_tx.elem must be flushed/cleared.
Zero-sized packets are unsupported - check packet size, prior to
sending.

Found while fuzzing virtio-net. The relevant stack-trace:
 #8 in __assert_fail (libc.so.6+0x30101)
 #9 in virtio_net_reset virtio-net.c:520:13
 #10 in virtio_reset virtio.c:1214:9
 #11 in virtio_pci_reset virtio-pci.c:1810:5
 #12 in qdev_reset_one qdev.c:259:5
 #13 in qdev_walk_children qdev.c:575:15
 #14 in qbus_walk_children bus.c:52:15
 #15 in qdev_walk_children qdev.c:567:15
 #16 in qbus_walk_children bus.c:52:15
 #17 in qemu_devices_reset reset.c:69:9
 #18 in pc_machine_reset pc.c:2628:5
 #19 in qemu_system_reset vl.c:1621:9
 #20 in LLVMFuzzerTestOneInput fuzz.c:184:4

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 hw/net/virtio-net.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b9e1cd71cf..743f1c827c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2074,12 +2074,15 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *=
q)
             out_sg =3D sg;
         }
=20
-        ret =3D qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_in=
dex),
-                                      out_sg, out_num, virtio_net_tx_compl=
ete);
-        if (ret =3D=3D 0) {
-            virtio_queue_set_notification(q->tx_vq, 0);
-            q->async_tx.elem =3D elem;
-            return -EBUSY;
+        /* Do not try to send 0-sized packets */
+        if (iov_size(out_sg, out_num)) {
+            ret =3D qemu_sendv_packet_async(qemu_get_subqueue(n->nic,
+                        queue_index), out_sg, out_num, virtio_net_tx_compl=
ete);
+            if (ret =3D=3D 0) {
+                virtio_queue_set_notification(q->tx_vq, 0);
+                q->async_tx.elem =3D elem;
+                return -EBUSY;
+            }
         }
=20
 drop:
--=20
2.20.1


