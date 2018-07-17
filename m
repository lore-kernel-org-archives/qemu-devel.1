Received: from eggs.gnu.org ([2001:4830:134:3::10]:55067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOid-0005tx-Mz
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOic-0007bu-FS
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOic-0007bT-9K
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4FF181A4EAF
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:14 +0200
Message-Id: <20180717120414.5852-15-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 14/14] check: Only test virtio-scsi when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include | 4 ++--
 tests/cdrom-test.c     | 4 ++++
 tests/drive_del-test.c | 6 ++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c4d68061e5..74ee02348c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -197,8 +197,8 @@ check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/block/virtio-blk.c
 check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
 gcov-files-virtio-$(CONFIG_VIRTIO_RNG) += hw/virtio/virtio-rng.c
-check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
-gcov-files-virtio-y += i386-softmmu/hw/scsi/virtio-scsi.c
+check-qtest-virtio-$(CONFIG_VIRTIO_SCSI) += tests/virtio-scsi-test$(EXESUF)
+gcov-files-virtio-$(CONFIG_VIRTIO_SCSI) += i386-softmmu/hw/scsi/virtio-scsi.c
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
 check-qtest-virtio-y += tests/virtio-9p-test$(EXESUF)
 gcov-files-virtio-y += hw/9pfs/virtio-9p.c
diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
index 0d7dff6da5..46ec5d43e9 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -129,9 +129,11 @@ static void test_cdboot(gconstpointer data)
 static void add_x86_tests(void)
 {
     qtest_add_data_func("cdrom/boot/default", "-cdrom ", test_cdboot);
+#ifdef CONFIG_VIRTIO_SCSI
     qtest_add_data_func("cdrom/boot/virtio-scsi",
                         "-device virtio-scsi -device scsi-cd,drive=cdr "
                         "-blockdev file,node-name=cdr,filename=", test_cdboot);
+#endif
     qtest_add_data_func("cdrom/boot/isapc", "-M isapc "
                         "-drive if=ide,media=cdrom,file=", test_cdboot);
 #ifdef CONFIG_ESP_PCI
@@ -160,9 +162,11 @@ static void add_x86_tests(void)
 static void add_s390x_tests(void)
 {
     qtest_add_data_func("cdrom/boot/default", "-cdrom ", test_cdboot);
+#ifdef CONFIG_VIRTIO_SCSI
     qtest_add_data_func("cdrom/boot/virtio-scsi",
                         "-device virtio-scsi -device scsi-cd,drive=cdr "
                         "-blockdev file,node-name=cdr,filename=", test_cdboot);
+#endif
 }
 
 int main(int argc, char **argv)
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 852fefc8f3..d6f010269a 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -31,6 +31,7 @@ static void drive_del(void)
     g_free(resp);
 }
 
+#ifdef CONFIG_VIRTIO_SCSI
 static void device_del(void)
 {
     QDict *response;
@@ -43,6 +44,7 @@ static void device_del(void)
     g_assert(qdict_haskey(response, "return"));
     qobject_unref(response);
 }
+#endif
 
 static void test_drive_without_dev(void)
 {
@@ -91,6 +93,7 @@ static void test_after_failed_device_add(void)
     qtest_end();
 }
 
+#ifdef CONFIG_VIRTIO_SCSI
 static void test_drive_del_device_del(void)
 {
     char *args;
@@ -112,6 +115,7 @@ static void test_drive_del_device_del(void)
     qtest_end();
     g_free(args);
 }
+#endif
 
 int main(int argc, char **argv)
 {
@@ -127,8 +131,10 @@ int main(int argc, char **argv)
         !strcmp(arch, "s390x")) {
         qtest_add_func("/drive_del/after_failed_device_add",
                        test_after_failed_device_add);
+#ifdef CONFIG_VIRTIO_SCSI
         qtest_add_func("/blockdev/drive_del_device_del",
                        test_drive_del_device_del);
+#endif
     }
 
     return g_test_run();
-- 
2.17.1
