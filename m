Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96A2C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 12:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F05B206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 12:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F05B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs541-00080d-K8
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 08:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hs52j-0007WF-CK
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hs52h-0004ST-QF
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:46:21 -0400
Received: from relay.sw.ru ([185.231.240.75]:56098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hs52h-0004OJ-JE; Mon, 29 Jul 2019 08:46:19 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hs52Z-0001Ai-5P; Mon, 29 Jul 2019 15:46:11 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 29 Jul 2019 15:46:00 +0300
Message-Id: <1564404360-733987-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH] tests: Set read-zeroes on for null-co driver
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
Cc: kwolf@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 vsementsov@virtuozzo.com, hare@suse.com, armbru@redhat.com,
 keith.busch@intel.com, andrey.shinkevich@virtuozzo.com, kraxel@redhat.com,
 stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, fam@euphon.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is to reduce the number of Valgrind report messages about
using uninitialized memory with the null-co driver. It helps to filter
real memory issues and is the same work done for the iotests with the
commit ID a6862418fec4072.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/drive_del-test.c     | 3 ++-
 tests/libqos/virtio-scsi.c | 3 ++-
 tests/megasas-test.c       | 3 ++-
 tests/nvme-test.c          | 3 ++-
 tests/qmp-test.c           | 2 +-
 tests/test-blockjob-txn.c  | 5 ++++-
 tests/test-blockjob.c      | 5 ++++-
 tests/usb-hcd-uhci-test.c  | 3 ++-
 tests/usb-hcd-xhci-test.c  | 3 ++-
 tests/virtio-blk-test.c    | 6 ++++--
 tests/virtio-ccw-test.c    | 9 ++++++---
 tests/virtio-scsi-test.c   | 6 ++++--
 12 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index b56b223..5f8839b 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -121,7 +121,8 @@ static void test_drive_del_device_del(void)
     QTestState *qts;
 
     /* Start with a drive used by a device that unplugs instantaneously */
-    qts = qtest_initf("-drive if=none,id=drive0,file=null-co://,format=raw"
+    qts = qtest_initf("-drive if=none,id=drive0,file=null-co://,"
+                      "file.read-zeroes=on,format=raw"
                       " -device virtio-scsi-%s"
                       " -device scsi-hd,drive=drive0,id=dev0",
                       qvirtio_get_dev_type());
diff --git a/tests/libqos/virtio-scsi.c b/tests/libqos/virtio-scsi.c
index 94842ec..de739be 100644
--- a/tests/libqos/virtio-scsi.c
+++ b/tests/libqos/virtio-scsi.c
@@ -95,7 +95,8 @@ static void virtio_scsi_register_nodes(void)
     };
 
     QOSGraphEdgeOptions opts = {
-        .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,format=raw",
+        .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,"
+                           "file.read-zeroes=on,format=raw",
         .after_cmd_line = "-device scsi-hd,bus=vs0.0,drive=drv0",
     };
 
diff --git a/tests/megasas-test.c b/tests/megasas-test.c
index c3e4ab6..d6796b9 100644
--- a/tests/megasas-test.c
+++ b/tests/megasas-test.c
@@ -75,7 +75,8 @@ static void megasas_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
         .extra_device_opts = "addr=04.0,id=scsi0",
-        .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,format=raw",
+        .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,"
+                           "file.read-zeroes=on,format=raw",
         .after_cmd_line = "-device scsi-hd,bus=scsi0.0,drive=drv0",
     };
 
diff --git a/tests/nvme-test.c b/tests/nvme-test.c
index 5052993..ff04421 100644
--- a/tests/nvme-test.c
+++ b/tests/nvme-test.c
@@ -70,7 +70,8 @@ static void nvme_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
         .extra_device_opts = "addr=04.0,drive=drv0,serial=foo",
-        .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,format=raw",
+        .before_cmd_line = "-drive id=drv0,if=none,file=null-co://,"
+                           "file.read-zeroes=on,format=raw",
     };
 
     add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 48a4fa7..1b0eb69 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -187,7 +187,7 @@ static void send_cmd_that_blocks(QTestState *s, const char *id)
                    " 'arguments': {"
                    " 'driver': 'blkdebug', 'node-name': %s,"
                    " 'config': %s,"
-                   " 'image': { 'driver': 'null-co' } } }",
+                   " 'image': { 'driver': 'null-co', 'read-zeroes': true } } }",
                    id, id, fifo_name);
 }
 
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 86606f9..7da9216 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -15,6 +15,7 @@
 #include "qemu/main-loop.h"
 #include "block/blockjob_int.h"
 #include "sysemu/block-backend.h"
+#include "qapi/qmp/qdict.h"
 
 typedef struct {
     BlockJob common;
@@ -96,7 +97,9 @@ static BlockJob *test_block_job_start(unsigned int iterations,
 
     data = g_new0(TestBlockJobCBData, 1);
 
-    bs = bdrv_open("null-co://", NULL, NULL, 0, &error_abort);
+    QDict *opt = qdict_new();
+    qdict_put_str(opt, "file.read-zeroes", "on");
+    bs = bdrv_open("null-co://", NULL, opt, 0, &error_abort);
     g_assert_nonnull(bs);
 
     snprintf(job_id, sizeof(job_id), "job%u", counter++);
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index b33f899..68a0819 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -15,6 +15,7 @@
 #include "qemu/main-loop.h"
 #include "block/blockjob_int.h"
 #include "sysemu/block-backend.h"
+#include "qapi/qmp/qdict.h"
 
 static const BlockJobDriver test_block_job_driver = {
     .job_driver = {
@@ -71,7 +72,9 @@ static BlockBackend *create_blk(const char *name)
     BlockBackend *blk = blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
     BlockDriverState *bs;
 
-    bs = bdrv_open("null-co://", NULL, NULL, 0, &error_abort);
+    QDict *opt = qdict_new();
+    qdict_put_str(opt, "file.read-zeroes", "on");
+    bs = bdrv_open("null-co://", NULL, opt, 0, &error_abort);
     g_assert_nonnull(bs);
 
     blk_insert_bs(blk, bs, &error_abort);
diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
index a119d6d..6d355c2 100644
--- a/tests/usb-hcd-uhci-test.c
+++ b/tests/usb-hcd-uhci-test.c
@@ -57,7 +57,8 @@ int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
     const char *cmd = "-device piix3-usb-uhci,id=uhci,addr=1d.0"
-                      " -drive id=drive0,if=none,file=null-co://,format=raw"
+                      " -drive id=drive0,if=none,file=null-co://,"
+                      "file.read-zeroes=on,format=raw"
                       " -device usb-tablet,bus=uhci.0,port=1";
     int ret;
 
diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index 9eb24b0..b15a511 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -56,7 +56,8 @@ int main(int argc, char **argv)
     qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
 
     qtest_start("-device nec-usb-xhci,id=xhci"
-                " -drive id=drive0,if=none,file=null-co://,format=raw");
+                " -drive id=drive0,if=none,file=null-co://,"
+                "file.read-zeroes=on,format=raw");
     ret = g_test_run();
     qtest_end();
 
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 1b02714..1589ab0 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -753,8 +753,10 @@ static void *virtio_blk_test_setup(GString *cmd_line, void *arg)
     char *tmp_path = drive_create();
 
     g_string_append_printf(cmd_line,
-                           " -drive if=none,id=drive0,file=%s,format=raw,auto-read-only=off "
-                           "-drive if=none,id=drive1,file=null-co://,format=raw ",
+                           " -drive if=none,id=drive0,file=%s,"
+                           "format=raw,auto-read-only=off "
+                           "-drive if=none,id=drive1,file=null-co://,"
+                           "file.read-zeroes=on,format=raw ",
                            tmp_path);
 
     return arg;
diff --git a/tests/virtio-ccw-test.c b/tests/virtio-ccw-test.c
index 48c714d..6be4e6a 100644
--- a/tests/virtio-ccw-test.c
+++ b/tests/virtio-ccw-test.c
@@ -53,7 +53,8 @@ static void virtio_serial_hotplug(void)
 
 static void virtio_blk_nop(void)
 {
-    global_qtest = qtest_initf("-drive if=none,id=drv0,file=null-co://,format=raw "
+    global_qtest = qtest_initf("-drive if=none,id=drv0,file=null-co://,"
+                               "file.read-zeroes=on,format=raw "
                                 "-device virtio-blk-ccw,drive=drv0");
     qtest_end();
 }
@@ -78,8 +79,10 @@ static void virtio_scsi_nop(void)
 
 static void virtio_scsi_hotplug(void)
 {
-    global_qtest = qtest_initf("-drive if=none,id=drv0,file=null-co://,format=raw "
-                                "-drive if=none,id=drv1,file=null-co://,format=raw "
+    global_qtest = qtest_initf("-drive if=none,id=drv0,file=null-co://,"
+                               "file.read-zeroes=on,format=raw "
+                                "-drive if=none,id=drv1,file=null-co://,"
+                                "file.read-zeroes=on,format=raw "
                                 "-device virtio-scsi-ccw "
                                 "-device scsi-hd,drive=drv0");
     qtest_qmp_device_add("scsi-hd", "scsihd", "{'drive': 'drv1'}");
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 1ad9f75..ae6698d 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -239,7 +239,8 @@ fail:
 static void *virtio_scsi_hotplug_setup(GString *cmd_line, void *arg)
 {
     g_string_append(cmd_line,
-                    " -drive id=drv1,if=none,file=null-co://,format=raw");
+                    " -drive id=drv1,if=none,file=null-co://,"
+                    "file.read-zeroes=on,format=raw");
     return arg;
 }
 
@@ -247,6 +248,7 @@ static void *virtio_scsi_setup(GString *cmd_line, void *arg)
 {
     g_string_append(cmd_line,
                     " -drive file=blkdebug::null-co://,"
+                    "file.image.read-zeroes=on,"
                     "if=none,id=dr1,format=raw,file.align=4k "
                     "-device scsi-hd,drive=dr1,lun=0,scsi-id=1");
     return arg;
@@ -256,7 +258,7 @@ static void *virtio_scsi_setup_iothread(GString *cmd_line, void *arg)
 {
     g_string_append(cmd_line,
                     " -object iothread,id=thread0"
-                    " -blockdev driver=null-co,node-name=null0"
+                    " -blockdev driver=null-co,read-zeroes=on,node-name=null0"
                     " -device scsi-hd,drive=null0");
     return arg;
 }
-- 
1.8.3.1


