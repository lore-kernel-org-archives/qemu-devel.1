Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704D7C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE7520721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZejhn1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE7520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb3n-00039l-C9
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyazm-0004Dr-44
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyazl-0005vt-1l
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24920
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyazk-0005vX-Ug
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580733508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aVKW4uyfDbLew3gzo21eLO4dRKn9CVLGg0EgUodmFGQ=;
 b=AZejhn1swNu0mvhXzfr8sb52X02/hw0ntUWDyKDCKBYQFCl/Kw5hGnCU6LlZvGYZ1Roj4s
 r/U6UgTtAh/AsW3CXeXWWHu0V89bnIxZ14Gh0rcqxS+4rZc4C1RqOluxLp9v8cz0GC1f8m
 2rsw6euB48PK7l3CozDhnLAeiUkntMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-_GuCSI8_Ote-iVyuvZCW4g-1; Mon, 03 Feb 2020 07:38:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 794CA100550E;
 Mon,  3 Feb 2020 12:38:23 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BB32196B1;
 Mon,  3 Feb 2020 12:38:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/13] boot-order-test: fix memleaks in boot-order-test
Date: Mon,  3 Feb 2020 13:38:03 +0100
Message-Id: <20200203123811.8651-6-thuth@redhat.com>
In-Reply-To: <20200203123811.8651-1-thuth@redhat.com>
References: <20200203123811.8651-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _GuCSI8_Ote-iVyuvZCW4g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

It's not a big deal, but 'check qtest-ppc/ppc64' runs fail if sanitizers is=
 enabled.
The memory leak stack is as follow:

Direct leak of 128 byte(s) in 4 object(s) allocated from:
    #0 0x7f11756f5970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7f1174f2549d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x556af05aa7da in mm_fw_cfg_init /mnt/sdb/qemu/tests/libqos/fw_cfg.c=
:119
    #3 0x556af059f4f5 in read_boot_order_pmac /mnt/sdb/qemu/tests/boot-orde=
r-test.c:137
    #4 0x556af059efe2 in test_a_boot_order /mnt/sdb/qemu/tests/boot-order-t=
est.c:47
    #5 0x556af059f2c0 in test_boot_orders /mnt/sdb/qemu/tests/boot-order-te=
st.c:59
    #6 0x556af059f52d in test_pmac_oldworld_boot_order /mnt/sdb/qemu/tests/=
boot-order-test.c:152
    #7 0x7f1174f46cb9  (/lib64/libglib-2.0.so.0+0x73cb9)
    #8 0x7f1174f46b73  (/lib64/libglib-2.0.so.0+0x73b73)
    #9 0x7f1174f46b73  (/lib64/libglib-2.0.so.0+0x73b73)
    #10 0x7f1174f46f71 in g_test_run_suite (/lib64/libglib-2.0.so.0+0x73f71=
)
    #11 0x7f1174f46f94 in g_test_run (/lib64/libglib-2.0.so.0+0x73f94)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200203025935.36228-1-pannengyuan@huawei.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/boot-order-test.c | 6 +++---
 tests/qtest/libqos/fw_cfg.h   | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/boot-order-test.c b/tests/qtest/boot-order-test.c
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
2.18.1


