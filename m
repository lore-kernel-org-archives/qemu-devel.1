Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCA4C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFF52184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="eYP/dCCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFF52184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoUk8-0003Kk-UY
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59568)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hoUjx-0002tO-OG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hoUjp-0002nd-Ly
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:24:06 -0400
Received: from mail-eopbgr750122.outbound.protection.outlook.com
 ([40.107.75.122]:18286 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hoUjn-00015C-ED
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:23:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVsOvTYfjqG3ik5gErutm1Y564zLF4qHVUbg0aWSHPlExudg5DUyF4lp/+rznCM9urWHP8/vB2Gk5AxxRHHXTJUyjDfATY6ZPdyLresufrJyzyZ6f7KhDKzuH9lAfejptDpmrODznVwIbPLyfWCioDWr3o8XX3dcAkRJcMvgxhF++xMjz4c7FYtZa2iWrPIBrCrym6mzF2OFHOy3GCQ/cCS2RgIn6gPUJHIncdMNhGGVTB8Xp2NwfPiOzxSo+VX1MqhTAFxZh0PqtostzNe57l6jNJ/rINKMZlP1MP8QS2qYVw7pFWoY+TfdUShOvnCWUouoeCTGHCrBjag3OY6q+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeNkgQ5Zf/wXNw1yjGfi3mO5a1zBF+O8Okd0VAPP0Fk=;
 b=f4uqbzW7LxkOexiPRIwlLtNtYlZUltfEOCaCO7ijZv7OcLD/WYf30dzWbucy9RgFFWJLdHywKkzgDHGUnmZx7vLI1TbeoJw65VxJLqrQkHW7vEAjq22JuwuGJsV9Kd/ACUZVDcGHiml+erzE8EIVWDnrD0ivWenj76S5x+0vbipDP2a4NXDtnodAuW3WzhAwtFEReQ0E7IRt9zPTHuvu1uXrhCImCYc1423oVAR2+OlgJMP8DOqWviygrHm1TrMrDnHOhy3n0JPC+9DnbhQshuUv+78zAdWbDBKlhIyNKQuW1iLPIMETjdxEDaavAl0h5Iizp1ZxozePik4InW4NBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeNkgQ5Zf/wXNw1yjGfi3mO5a1zBF+O8Okd0VAPP0Fk=;
 b=eYP/dCCJFwO+etnAdWWml9FpIzYJgIShytdMnQQ7KFYkNXWxjUrDBpd38DPIOrjEGhCTLvG3nwS3GWMU6wbn3+sHQZ9e4VAU9JXIHZ3PLpM//VzP8zKPPGD+qHBSlo7cpJOFNoKd32ZVYSDk3GA5fzgtmhiEtTn9OLjDT26waRM=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2645.namprd03.prod.outlook.com (10.173.39.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.12; Fri, 19 Jul 2019 15:21:15 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 15:21:15 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2] virtio-net: Always check for guest header length
Thread-Index: AQHVPkWbvXBPe0/pDU6Ndyb5nRODqA==
Date: Fri, 19 Jul 2019 15:21:15 +0000
Message-ID: <20190719151920.22586-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BN6PR10CA0041.namprd10.prod.outlook.com
 (2603:10b6:404:109::27) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 135be6a0-4584-44e3-73a7-08d70c5cbd94
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2645; 
x-ms-traffictypediagnostic: CY4PR03MB2645:
x-microsoft-antispam-prvs: <CY4PR03MB2645554727C7271A22F772A4BACB0@CY4PR03MB2645.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(6116002)(8936002)(305945005)(3846002)(5640700003)(6512007)(4326008)(50226002)(2906002)(75432002)(7736002)(316002)(786003)(186003)(6486002)(54906003)(53936002)(68736007)(8676002)(6436002)(26005)(102836004)(36756003)(1076003)(66556008)(2501003)(71190400001)(71200400001)(99286004)(486006)(66446008)(478600001)(6506007)(66946007)(52116002)(5660300002)(81156014)(81166006)(25786009)(386003)(66476007)(66066001)(64756008)(14454004)(256004)(14444005)(88552002)(86362001)(6916009)(476003)(2351001)(2616005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2645;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mc62OaCG9AwOvBPZ23qx3p0P1gaFrmjX0rA/iczzxNCCjyVlGL+CZR3UQBvFmR2inCz4I9LWmA3ooz41SBynD+y0lsuOKTtNeRcigUOF9v+mvWGj+/VGkOsQIbOKN93KrmS3hFXfMUaDacUGjJUrFVJPwQgPpTziAldh14wO3D9xrhU6QsFLXwJ9C1FizW7q4dxm/6jCo4lnSfNAu2wSpUVAAOXTgBqIwNR+l2g7QnekL33qyAGUOS7s/R/0OnLKstCV2O3ZXDUO5z2GZySZwRiawP6qqihgoVsOHFiYn9Bz7X/Fkjy6I17hIe8w4eDr2lEC3iGcDVDkUyl/5jYPs2dXhIrSX073X1pgmjeDAI+b1mX9juL44+/BNgapi+91XhqTBLqmIipKhv/8otrJ7mL5IKCQRNOQmzrb8pPtoXA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 135be6a0-4584-44e3-73a7-08d70c5cbd94
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 15:21:15.6910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2645
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.122
Subject: [Qemu-devel] [PATCH v2] virtio-net: Always check for guest header
 length
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

While fuzzing the virtio-net tx vq, I ran into an assertion failure due
to iov_copy offsets larger than the total iov size. Though there is
a check to cover this, it does not execute when !n->has_vnet_hdr. This
change always copies the guest header into the mhdr buffer and checks its
length, even if mhdr is not needed.

The call stack for the assertion failure:

 #8 in __assert_fail (libc.so.6+0x300f1)
 #9 in iov_copy iov.c:266:5
 #10 in virtio_net_flush_tx virtio-net.c:2073:23
 #11 in virtio_net_tx_bh virtio-net.c:2197:11
 #12 in aio_bh_poll async.c:118:13
 #13 in aio_dispatch aio-posix.c:460:5
 #14 in aio_ctx_dispatch async.c:261:5
 #15 in g_main_context_dispatch (libglib-2.0.so.0+0x4df2d)
 #16 in glib_pollfds_poll main-loop.c:213:9
 #17 in os_host_main_loop_wait main-loop.c:236
 #18 in main_loop_wait main-loop.c:512
 #19 in virtio_net_tx_fuzz virtio-net-fuzz.c:160:3

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 hw/net/virtio-net.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b9e1cd71cf..003436b53c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2035,14 +2035,19 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *=
q)
             return -EINVAL;
         }
=20
-        if (n->has_vnet_hdr) {
-            if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
+        /*
+         * Even if !n->has_vnet_hdr and we dont need mhdr, we still need t=
his
+         * to check that out_sg contains at least guest_hdr_len bytes
+         */
+        if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
-                virtio_error(vdev, "virtio-net header incorrect");
-                virtqueue_detach_element(q->tx_vq, elem, 0);
-                g_free(elem);
-                return -EINVAL;
-            }
+            virtio_error(vdev, "virtio-net header incorrect");
+            virtqueue_detach_element(q->tx_vq, elem, 0);
+            g_free(elem);
+            return -EINVAL;
+        }
+
+        if (n->has_vnet_hdr) {
             if (n->needs_vnet_hdr_swap) {
                 virtio_net_hdr_swap(vdev, (void *) &mhdr);
                 sg2[0].iov_base =3D &mhdr;
--=20
2.20.1


