Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E146C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDA620659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="T5SdU+tM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDA620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cRd-0007NZ-4j
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFy-0006Ww-2x
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFw-0008Mf-A1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:41 -0500
Received: from mail-bn8nam11on2135.outbound.protection.outlook.com
 ([40.107.236.135]:55392 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFv-0008Dh-CP
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l51DC3a+oHYkqNqTbkS04/ZDqEPHiDHocvaXZ3LNNmpiuG6eWGp+Yh50NR6VevvpI/mivhs3npQAmleBUHys4oS/Wkm6zVi2uxgBUnZWa4d2neamAgLWPKbpLJ+fbr4rvZn2U3nmDWESDd0OQyHJ8DiwdU4isoTNKnvy2afQRSM3zaw4dTAVDGEgPOEyxIZKU2YKEz9AZdetVW4Yu7rW4QqSrTU2tFUFOl3BGFZWCj2JMPsgrLyweHHgGJ1etpRAgKUNQjSx5trYCMtV/wHVRk5BwEBURMbCnA7ptf8FJNFOAkc3OKJkZfBkD7vf5Kztl6L3OWQuZ+CWJxtuj3FMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YXO4KxSPPP4hgjTRMldQ4BoMfOC/VUpzyw0Wj+2Xdc=;
 b=eiR8+bjrk14nYOBnDqPwU7h+fdpuAOOw5Ck6ulymKKSEHKNuNt3YOpnPfpq7j/67pqA6o/Hg974HUJ78rOaD7pvblufTWTeQLxsAEB51LQoFXKQ63kbJTECM39dViBBbc+y/pmXhTzc8g5Gr8tJpr94mm9qYzKC9le7IBH1CagdjrIFftk4BIR1mco1jACMoK759jew1n/z/ZzXL1VeMNWEOOm4GfoAz2WVmULOb+21MhzkMO1DK8iaNqrjrQng8EjVUWPyi+gBJKRF3sLkW8otZE3vqI0M4NZaKIqdE79bk7btei6bqOeAEQKtAGIHiLAj/Wmj91fflh8NT67dcpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YXO4KxSPPP4hgjTRMldQ4BoMfOC/VUpzyw0Wj+2Xdc=;
 b=T5SdU+tM8xYPnQ70gYU/C1dG6LMf9mJkU3bSan9Hy/bxFLeb2T+lrOFWlKCyZagnNNxzX9PPc1s+lmSNzbhQ31HhE1sNEI1AIdzdLm0VwkhUuQlGjRdLm/1yKUVDCstt3Q2Om6fTQnn0aSekDzg64KcaJJh8BxskYz3pJDxiwyQ=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB3599.namprd03.prod.outlook.com (52.135.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 20:35:31 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:30 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 10/23] libqos: rename i2c_send and i2c_recv
Date: Tue, 11 Feb 2020 15:34:57 -0500
Message-ID: <20200211203510.3534-11-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:30 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0238c406-a2b3-4575-7888-08d7af31efcc
X-MS-TrafficTypeDiagnostic: SN6PR03MB3599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB359960304D80BAB02126B2F5BA180@SN6PR03MB3599.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(36756003)(52116002)(7696005)(478600001)(6666004)(54906003)(316002)(786003)(8676002)(8936002)(956004)(2616005)(4326008)(81156014)(5660300002)(75432002)(1076003)(81166006)(2906002)(66556008)(66476007)(66946007)(6486002)(26005)(186003)(16526019)(86362001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3599;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4KSd4cOIR2ZeHcdr7nNkTwYMvlu9jhjR/YuNXSthpeMFN530TYBaTIVB1wKtzj8ox3SnLEm9lSvFJCqJAECFgyEHs1hlCuTlOWeXzStx6NT9QH/p2XLG5EIReJNs9iGnWtM7CtHk+q1FF372jpUpQsxjznawneq4B4dvMyvV1t9SuuN/0BfUGJMQy7YbHOqCRSBzvjbPmA7ibWRpYddgkxSo43pO5nf1NpaDQhxfnWBiNPfRzjDqR4gkjDZ/HhE9Ll6yDhSLjUjg3UaEgOIHgWWWwvHCrQ+shAXd+SRNAStt+6k6St1ApeFqPtYHHo02s5gnu5Rvgiv2wlZITMXcXmFlv+LWR2irl/viQ9mknmReKGGRoz3v0z3kuyP/28f7JtN4seL4PIlT8a4YgXg4qQ3SlGr09i5YPez1LHhksDznc2nZ8dRrb/QqyBikWor
X-MS-Exchange-AntiSpam-MessageData: 0pHevM19qkC+ZehOeAWg787nBKJSCHNbTx208e8AXTrMc++grHbjZEqfCcBPnasVu1u2fevMsrNc1IVABiLbjdtAGjUtpWNqYwQLVLa50qCw4ApWlFfdm132NCmvP4iuERyqVnih9PRyb5exF0eopg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0238c406-a2b3-4575-7888-08d7af31efcc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:30.9356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvkrthODVQv/8A2+SCD2Rbq3oCZf+eEsTFD0VvdLE0hQ1hQUIyscnj4ZRDTi35To
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3599
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Received-From: 40.107.236.135
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The names i2c_send and i2c_recv collide with functions defined in
hw/i2c/core.c. This causes an error when linking against libqos and
softmmu simultaneously (for example when using qtest inproc). Rename the
libqos functions to avoid this.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqos/i2c.c   | 10 +++++-----
 tests/qtest/libqos/i2c.h   |  4 ++--
 tests/qtest/pca9552-test.c | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/libqos/i2c.c b/tests/qtest/libqos/i2c.c
index 156114e745..38f800dbab 100644
--- a/tests/qtest/libqos/i2c.c
+++ b/tests/qtest/libqos/i2c.c
@@ -10,12 +10,12 @@
 #include "libqos/i2c.h"
 #include "libqtest.h"
=20
-void i2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
+void qi2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
 {
     i2cdev->bus->send(i2cdev->bus, i2cdev->addr, buf, len);
 }
=20
-void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
+void qi2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
 {
     i2cdev->bus->recv(i2cdev->bus, i2cdev->addr, buf, len);
 }
@@ -23,8 +23,8 @@ void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t =
len)
 void i2c_read_block(QI2CDevice *i2cdev, uint8_t reg,
                     uint8_t *buf, uint16_t len)
 {
-    i2c_send(i2cdev, &reg, 1);
-    i2c_recv(i2cdev, buf, len);
+    qi2c_send(i2cdev, &reg, 1);
+    qi2c_recv(i2cdev, buf, len);
 }
=20
 void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
@@ -33,7 +33,7 @@ void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
     uint8_t *cmd =3D g_malloc(len + 1);
     cmd[0] =3D reg;
     memcpy(&cmd[1], buf, len);
-    i2c_send(i2cdev, cmd, len + 1);
+    qi2c_send(i2cdev, cmd, len + 1);
     g_free(cmd);
 }
=20
diff --git a/tests/qtest/libqos/i2c.h b/tests/qtest/libqos/i2c.h
index 945b65b34c..c65f087834 100644
--- a/tests/qtest/libqos/i2c.h
+++ b/tests/qtest/libqos/i2c.h
@@ -47,8 +47,8 @@ struct QI2CDevice {
 void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr)=
;
 void add_qi2c_address(QOSGraphEdgeOptions *opts, QI2CAddress *addr);
=20
-void i2c_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
-void i2c_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
+void qi2c_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
+void qi2c_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
=20
 void i2c_read_block(QI2CDevice *dev, uint8_t reg,
                     uint8_t *buf, uint16_t len);
diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
index 4b800d3c3e..d80ed93cd3 100644
--- a/tests/qtest/pca9552-test.c
+++ b/tests/qtest/pca9552-test.c
@@ -32,22 +32,22 @@ static void receive_autoinc(void *obj, void *data, QGue=
stAllocator *alloc)
=20
     pca9552_init(i2cdev);
=20
-    i2c_send(i2cdev, &reg, 1);
+    qi2c_send(i2cdev, &reg, 1);
=20
     /* PCA9552_LS0 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x54);
=20
     /* PCA9552_LS1 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x55);
=20
     /* PCA9552_LS2 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x55);
=20
     /* PCA9552_LS3 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x54);
 }
=20
--=20
2.25.0


