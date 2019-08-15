Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8D1C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD542064A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD542064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKFE-0002eb-VS
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hyK2V-0000HA-0L
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hyK2S-00023R-J0
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hyK2S-00021E-Bt
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC7A37FDCA;
 Thu, 15 Aug 2019 17:59:51 +0000 (UTC)
Received: from thuth.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA3F417CDF;
 Thu, 15 Aug 2019 17:59:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 19:59:22 +0200
Message-Id: <20190815175922.3475-10-thuth@redhat.com>
In-Reply-To: <20190815175922.3475-1-thuth@redhat.com>
References: <20190815175922.3475-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 15 Aug 2019 17:59:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 9/9] tests/libqtest: Make qmp_assert_success()
 independent from global_qtest
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The normal libqtest library functions should never depend on global_qtest.
Pass in the test state via parameter instead. And while we're at it,
also rename this function to qtest_qmp_assert_success() to make it clear
that it is part of libqtest.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190813093047.27948-7-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c         |  4 ++--
 tests/libqtest.h         |  6 ++++--
 tests/virtio-scsi-test.c | 10 ++++++----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 19c1fc2e97..eb971d0d11 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1111,13 +1111,13 @@ QDict *qmp(const char *fmt, ...)
     return response;
 }
 
-void qmp_assert_success(const char *fmt, ...)
+void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
 {
     va_list ap;
     QDict *response;
 
     va_start(ap, fmt);
-    response = qtest_vqmp(global_qtest, fmt, ap);
+    response = qtest_vqmp(qts, fmt, ap);
     va_end(ap);
 
     g_assert(response);
diff --git a/tests/libqtest.h b/tests/libqtest.h
index d93144fb74..7833148358 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -666,7 +666,8 @@ static inline void qtest_end(void)
 QDict *qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 /**
- * qmp_assert_success:
+ * qtest_qmp_assert_success:
+ * @qts: QTestState instance to operate on
  * @fmt...: QMP message to send to qemu, formatted like
  * qobject_from_jsonf_nofail().  See parse_escape() for what's
  * supported after '%'.
@@ -674,7 +675,8 @@ QDict *qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
  * Sends a QMP message to QEMU and asserts that a 'return' key is present in
  * the response.
  */
-void qmp_assert_success(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
 
 /*
  * qmp_eventwait:
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 16481491e3..09348765d7 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -225,10 +225,12 @@ static void test_iothread_attach_node(void *obj, void *data,
     mkqcow2(tmp_path, 64);
 
     /* Attach the overlay to the null0 node */
-    qmp_assert_success("{'execute': 'blockdev-add', 'arguments': {"
-                       "   'driver': 'qcow2', 'node-name': 'overlay',"
-                       "   'backing': 'null0', 'file': {"
-                       "     'driver': 'file', 'filename': %s}}}", tmp_path);
+    qtest_qmp_assert_success(scsi_pci->pci_vdev.pdev->bus->qts,
+                             "{'execute': 'blockdev-add', 'arguments': {"
+                             "   'driver': 'qcow2', 'node-name': 'overlay',"
+                             "   'backing': 'null0', 'file': {"
+                             "     'driver': 'file', 'filename': %s}}}",
+                             tmp_path);
 
     /* Send a request to see if the AioContext is still right */
     ret = virtio_scsi_do_command(vs, write_cdb, NULL, 0, buf, 512, NULL);
-- 
2.18.1


