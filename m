Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E5AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8C92072C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaPolFwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8C92072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSI0I-0007Fs-4v
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyK-0005VS-LE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyF-0006DT-VF
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmvYzk3Q+mQZIivB4qQj8qVT1/8TWTO4ycO4Ll8fyoI=;
 b=ZaPolFwjvSoakQLQdwVC22TrTSsjQ+H0fFgCitfolmTUcuUx2NMptxndS/Tema3C2uXuXS
 MmYnebG/cZjdppaTImvfhb6LieGbC2zo5GA8k85QHCBMhPgJiEFth47hCePacJ0ZXBWNTm
 BMKJPugEgCoFQ0EESWI61x2tyZ3A78k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-q0okHD6UOrScVfIf6pZHCw-1; Tue, 13 Oct 2020 06:55:51 -0400
X-MC-Unique: q0okHD6UOrScVfIf6pZHCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE9E08030B6;
 Tue, 13 Oct 2020 10:55:50 +0000 (UTC)
Received: from thuth.com (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE4A6EF41;
 Tue, 13 Oct 2020 10:55:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/23] qtest: add fuzz test case
Date: Tue, 13 Oct 2020 12:55:10 +0200
Message-Id: <20201013105527.20088-7-thuth@redhat.com>
In-Reply-To: <20201013105527.20088-1-thuth@redhat.com>
References: <20201013105527.20088-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

Currently the device fuzzer finds more and more issues.
For every fuzz case, we need not only the fixes but also
the corresponding test case. We can analysis the reproducer
for every case and find what happened in where and write
a beautiful test case. However the raw data of reproducer is not
friendly to analysis. It will take a very long time, even far more
than the fixes itself. So let's create a new file to hold all of
the fuzz test cases and just use the raw data to act as the test
case. This way nobody will be afraid of writing a test case for
the fuzz reproducer.

This patch adds the issue LP#1878263 test case.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20200921160605.19329-1-liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
[thuth: Slightly adjusted commit message, removed empty lines]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz-test.c | 49 +++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 tests/qtest/fuzz-test.c

diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c
new file mode 100644
index 0000000000..2f38bb1ec2
--- /dev/null
+++ b/tests/qtest/fuzz-test.c
@@ -0,0 +1,49 @@
+/*
+ * QTest testcase for fuzz case
+ *
+ * Copyright (c) 2020 Li Qiang <liq3ea@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqos/libqtest.h"
+
+/*
+ * This used to trigger the assert in scsi_dma_complete
+ * https://bugs.launchpad.net/qemu/+bug/1878263
+ */
+static void test_lp1878263_megasas_zero_iov_cnt(void)
+{
+    QTestState *s;
+
+    s = qtest_init("-nographic -monitor none -serial none "
+                   "-M q35 -device megasas -device scsi-cd,drive=null0 "
+                   "-blockdev driver=null-co,read-zeroes=on,node-name=null0");
+    qtest_outl(s, 0xcf8, 0x80001818);
+    qtest_outl(s, 0xcfc, 0xc101);
+    qtest_outl(s, 0xcf8, 0x8000181c);
+    qtest_outl(s, 0xcf8, 0x80001804);
+    qtest_outw(s, 0xcfc, 0x7);
+    qtest_outl(s, 0xcf8, 0x8000186a);
+    qtest_writeb(s, 0x14, 0xfe);
+    qtest_writeb(s, 0x0, 0x02);
+    qtest_outb(s, 0xc1c0, 0x17);
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    const char *arch = qtest_get_arch();
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        qtest_add_func("fuzz/test_lp1878263_megasas_zero_iov_cnt",
+                       test_lp1878263_megasas_zero_iov_cnt);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 0f32ca0895..6c6bfb5e2e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -54,6 +54,7 @@ qtests_i386 = \
    'bios-tables-test',
    'rtc-test',
    'i440fx-test',
+   'fuzz-test',
    'fw_cfg-test',
    'device-plug-test',
    'drive_del-test',
-- 
2.18.2


