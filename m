Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B60C3524A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F68206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F68206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyRys-0002yq-ML
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 22:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1iyRy8-0002Po-2p
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1iyRy6-00044w-PB
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:00:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38802 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1iyRy6-0003pc-EB
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:00:10 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5649A7C3B5BD4BE6A906;
 Mon,  3 Feb 2020 11:00:02 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Mon, 3 Feb 2020 10:59:54 +0800
From: <pannengyuan@huawei.com>
To: <thuth@redhat.com>, <lvivier@redhat.com>, <pbonzini@redhat.com>
Subject: [PATCH] boot-order-test: fix memleaks in boot-order-test
Date: Mon, 3 Feb 2020 10:59:35 +0800
Message-ID: <20200203025935.36228-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Euler Robot <euler.robot@huawei.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

It's not a big deal, but 'check qtest-ppc/ppc64' runs fail if sanitizers =
is enabled.
The memory leak stack is as follow:

Direct leak of 128 byte(s) in 4 object(s) allocated from:
    #0 0x7f11756f5970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
    #1 0x7f1174f2549d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x556af05aa7da in mm_fw_cfg_init /mnt/sdb/qemu/tests/libqos/fw_cfg=
.c:119
    #3 0x556af059f4f5 in read_boot_order_pmac /mnt/sdb/qemu/tests/boot-or=
der-test.c:137
    #4 0x556af059efe2 in test_a_boot_order /mnt/sdb/qemu/tests/boot-order=
-test.c:47
    #5 0x556af059f2c0 in test_boot_orders /mnt/sdb/qemu/tests/boot-order-=
test.c:59
    #6 0x556af059f52d in test_pmac_oldworld_boot_order /mnt/sdb/qemu/test=
s/boot-order-test.c:152
    #7 0x7f1174f46cb9  (/lib64/libglib-2.0.so.0+0x73cb9)
    #8 0x7f1174f46b73  (/lib64/libglib-2.0.so.0+0x73b73)
    #9 0x7f1174f46b73  (/lib64/libglib-2.0.so.0+0x73b73)
    #10 0x7f1174f46f71 in g_test_run_suite (/lib64/libglib-2.0.so.0+0x73f=
71)
    #11 0x7f1174f46f94 in g_test_run (/lib64/libglib-2.0.so.0+0x73f94)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 tests/qtest/boot-order-test.c | 6 +++---
 tests/qtest/libqos/fw_cfg.h   | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/boot-order-test.c b/tests/qtest/boot-order-test.=
c
index a725bce729..4241304ff5 100644
--- a/tests/qtest/boot-order-test.c
+++ b/tests/qtest/boot-order-test.c
@@ -134,7 +134,7 @@ static void test_prep_boot_order(void)
=20
 static uint64_t read_boot_order_pmac(QTestState *qts)
 {
-    QFWCFG *fw_cfg =3D mm_fw_cfg_init(qts, 0xf0000510);
+    g_autoptr(QFWCFG) fw_cfg =3D mm_fw_cfg_init(qts, 0xf0000510);
=20
     return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
 }
@@ -159,7 +159,7 @@ static void test_pmac_newworld_boot_order(void)
=20
 static uint64_t read_boot_order_sun4m(QTestState *qts)
 {
-    QFWCFG *fw_cfg =3D mm_fw_cfg_init(qts, 0xd00000510ULL);
+    g_autoptr(QFWCFG) fw_cfg =3D mm_fw_cfg_init(qts, 0xd00000510ULL);
=20
     return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
 }
@@ -171,7 +171,7 @@ static void test_sun4m_boot_order(void)
=20
 static uint64_t read_boot_order_sun4u(QTestState *qts)
 {
-    QFWCFG *fw_cfg =3D io_fw_cfg_init(qts, 0x510);
+    g_autoptr(QFWCFG) fw_cfg =3D io_fw_cfg_init(qts, 0x510);
=20
     return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
 }
diff --git a/tests/qtest/libqos/fw_cfg.h b/tests/qtest/libqos/fw_cfg.h
index 13325cc4ff..c6a7cf8cf0 100644
--- a/tests/qtest/libqos/fw_cfg.h
+++ b/tests/qtest/libqos/fw_cfg.h
@@ -49,4 +49,6 @@ static inline void pc_fw_cfg_uninit(QFWCFG *fw_cfg)
     io_fw_cfg_uninit(fw_cfg);
 }
=20
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QFWCFG, mm_fw_cfg_uninit)
+
 #endif
--=20
2.21.0.windows.1



