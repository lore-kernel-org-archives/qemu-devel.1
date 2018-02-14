Received: from eggs.gnu.org ([2001:4830:134:3::10]:43514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7O-0006L6-MY
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7M-0007B4-Pn
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elv7M-0007Ap-KZ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:20:52 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 12:20:24 +0100
Message-Id: <1518607234-17739-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1518607234-17739-1-git-send-email-thuth@redhat.com>
References: <1518607234-17739-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 08/18] libqos: Use explicit QTestState for
 remaining libqos operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Drop one more client of global_qtest by teaching all remaining
libqos stragglers to pass in an explicit QTestState.  Change the
setting of global_qtest from being implicit in libqos' call to
qtest_start() to instead be explicit in all clients that are
still relying on global_qtest.

Note that qmp_execute() can be greatly simplified in the process,
and that we also get rid of interpolation of a JSON string into a
temporary variable when qtest_qmp() can do it more reliably.

Signed-off-by: Eric Blake <eblake@redhat.com>
Acked-by: Greg Kurz <groug@kaod.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/ahci-test.c         |  1 +
 tests/ivshmem-test.c      |  1 +
 tests/libqos/libqos-pc.c  |  2 +-
 tests/libqos/libqos.c     | 30 ++++++++++--------------------
 tests/megasas-test.c      |  5 ++++-
 tests/rtas-test.c         |  1 +
 tests/usb-hcd-uhci-test.c |  1 +
 tests/virtio-9p-test.c    |  1 +
 tests/virtio-blk-test.c   |  1 +
 tests/virtio-net-test.c   | 15 +++++++++------
 tests/virtio-scsi-test.c  | 16 +++++++++-------
 11 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index e847c98..2342fe3 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -158,6 +158,7 @@ static AHCIQState *ahci_vboot(const char *cli, va_list ap)
 
     s = g_new0(AHCIQState, 1);
     s->parent = qtest_pc_vboot(cli, ap);
+    global_qtest = s->parent->qts;
     alloc_set_flags(s->parent->alloc, ALLOC_LEAK_ASSERT);
 
     /* Verify that we have an AHCI device present. */
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 3776342..8af16ee 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -131,6 +131,7 @@ static void setup_vm_cmd(IVState *s, const char *cmd, bool msix)
         g_printerr("ivshmem-test tests are only available on x86 or ppc64\n");
         exit(EXIT_FAILURE);
     }
+    global_qtest = s->qs->qts;
     s->dev = get_device(s->qs->pcibus);
 
     s->reg_bar = qpci_iomap(s->dev, 0, &barsize);
diff --git a/tests/libqos/libqos-pc.c b/tests/libqos/libqos-pc.c
index b554758..a9c1ace 100644
--- a/tests/libqos/libqos-pc.c
+++ b/tests/libqos/libqos-pc.c
@@ -25,7 +25,7 @@ QOSState *qtest_pc_boot(const char *cmdline_fmt, ...)
     qs = qtest_vboot(&qos_ops, cmdline_fmt, ap);
     va_end(ap);
 
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    qtest_irq_intercept_in(qs->qts, "ioapic");
 
     return qs;
 }
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 5729a06..5124e98 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -21,7 +21,7 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdline_fmt, va_list ap)
     QOSState *qs = g_new0(QOSState, 1);
 
     cmdline = g_strdup_vprintf(cmdline_fmt, ap);
-    qs->qts = qtest_start(cmdline);
+    qs->qts = qtest_init(cmdline);
     qs->ops = ops;
     if (ops) {
         qs->alloc = ops->init_allocator(qs->qts, ALLOC_NO_FLAGS);
@@ -81,29 +81,21 @@ void set_context(QOSState *s)
     global_qtest = s->qts;
 }
 
-static QDict *qmp_execute(const char *command)
+static QDict *qmp_execute(QTestState *qts, const char *command)
 {
-    char *fmt;
-    QDict *rsp;
-
-    fmt = g_strdup_printf("{ 'execute': '%s' }", command);
-    rsp = qmp(fmt);
-    g_free(fmt);
-
-    return rsp;
+    return qtest_qmp(qts, "{ 'execute': %s }", command);
 }
 
 void migrate(QOSState *from, QOSState *to, const char *uri)
 {
     const char *st;
-    char *s;
     QDict *rsp, *sub;
     bool running;
 
     set_context(from);
 
     /* Is the machine currently running? */
-    rsp = qmp_execute("query-status");
+    rsp = qmp_execute(from->qts, "query-status");
     g_assert(qdict_haskey(rsp, "return"));
     sub = qdict_get_qdict(rsp, "return");
     g_assert(qdict_haskey(sub, "running"));
@@ -111,30 +103,28 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     QDECREF(rsp);
 
     /* Issue the migrate command. */
-    s = g_strdup_printf("{ 'execute': 'migrate',"
-                        "'arguments': { 'uri': '%s' } }",
-                        uri);
-    rsp = qmp(s);
-    g_free(s);
+    rsp = qtest_qmp(from->qts,
+                    "{ 'execute': 'migrate', 'arguments': { 'uri': %s }}",
+                    uri);
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);
 
     /* Wait for STOP event, but only if we were running: */
     if (running) {
-        qmp_eventwait("STOP");
+        qtest_qmp_eventwait(from->qts, "STOP");
     }
 
     /* If we were running, we can wait for an event. */
     if (running) {
         migrate_allocator(from->alloc, to->alloc);
         set_context(to);
-        qmp_eventwait("RESUME");
+        qtest_qmp_eventwait(to->qts, "RESUME");
         return;
     }
 
     /* Otherwise, we need to wait: poll until migration is completed. */
     while (1) {
-        rsp = qmp_execute("query-migrate");
+        rsp = qmp_execute(from->qts, "query-migrate");
         g_assert(qdict_haskey(rsp, "return"));
         sub = qdict_get_qdict(rsp, "return");
         g_assert(qdict_haskey(sub, "status"));
diff --git a/tests/megasas-test.c b/tests/megasas-test.c
index ce960e7..81837e1 100644
--- a/tests/megasas-test.c
+++ b/tests/megasas-test.c
@@ -15,13 +15,16 @@
 
 static QOSState *qmegasas_start(const char *extra_opts)
 {
+    QOSState *qs;
     const char *arch = qtest_get_arch();
     const char *cmd = "-drive id=hd0,if=none,file=null-co://,format=raw "
                       "-device megasas,id=scsi0,addr=04.0 "
                       "-device scsi-hd,bus=scsi0.0,drive=hd0 %s";
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        return qtest_pc_boot(cmd, extra_opts ? : "");
+        qs = qtest_pc_boot(cmd, extra_opts ? : "");
+        global_qtest = qs->qts;
+        return qs;
     }
 
     g_printerr("virtio-scsi tests are only available on x86 or ppc64\n");
diff --git a/tests/rtas-test.c b/tests/rtas-test.c
index 34a6921..009bda6 100644
--- a/tests/rtas-test.c
+++ b/tests/rtas-test.c
@@ -14,6 +14,7 @@ static void test_rtas_get_time_of_day(void)
     time_t t1, t2;
 
     qs = qtest_spapr_boot("-machine pseries");
+    global_qtest = qs->qts;
 
     t1 = time(NULL);
     ret = qrtas_get_time_of_day(qs->qts, qs->alloc, &tm, &ns);
diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
index 62e0c78..6a7e5a2 100644
--- a/tests/usb-hcd-uhci-test.c
+++ b/tests/usb-hcd-uhci-test.c
@@ -77,6 +77,7 @@ int main(int argc, char **argv)
                    "available on x86 or ppc64\n");
         exit(EXIT_FAILURE);
     }
+    global_qtest = qs->qts;
     ret = g_test_run();
     qtest_shutdown(qs);
 
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 54edcb9..a2b3108 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -44,6 +44,7 @@ static QVirtIO9P *qvirtio_9p_start(const char *driver)
         g_printerr("virtio-9p tests are only available on x86 or ppc64\n");
         exit(EXIT_FAILURE);
     }
+    global_qtest = v9p->qs->qts;
 
     return v9p;
 }
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 2ac64e5..9be9ffb 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -77,6 +77,7 @@ static QOSState *pci_test_start(void)
         g_printerr("virtio-blk tests are only available on x86 or ppc64\n");
         exit(EXIT_FAILURE);
     }
+    global_qtest = qs->qts;
     unlink(tmp_path);
     g_free(tmp_path);
     return qs;
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 4114839..0a3c5dd 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -54,18 +54,21 @@ static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus *bus, int slot)
 
 static QOSState *pci_test_start(int socket)
 {
+    QOSState *qs;
     const char *arch = qtest_get_arch();
     const char *cmd = "-netdev socket,fd=%d,id=hs0 -device "
                       "virtio-net-pci,netdev=hs0";
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        return qtest_pc_boot(cmd, socket);
-    }
-    if (strcmp(arch, "ppc64") == 0) {
-        return qtest_spapr_boot(cmd, socket);
+        qs = qtest_pc_boot(cmd, socket);
+    } else if (strcmp(arch, "ppc64") == 0) {
+        qs = qtest_spapr_boot(cmd, socket);
+    } else {
+        g_printerr("virtio-net tests are only available on x86 or ppc64\n");
+        exit(EXIT_FAILURE);
     }
-    g_printerr("virtio-net tests are only available on x86 or ppc64\n");
-    exit(EXIT_FAILURE);
+    global_qtest = qs->qts;
+    return qs;
 }
 
 static void driver_init(QVirtioDevice *dev)
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index bcf408f..7393d69 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -34,20 +34,22 @@ typedef struct {
 
 static QOSState *qvirtio_scsi_start(const char *extra_opts)
 {
+    QOSState *qs;
     const char *arch = qtest_get_arch();
     const char *cmd = "-drive id=drv0,if=none,file=null-co://,format=raw "
                       "-device virtio-scsi-pci,id=vs0 "
                       "-device scsi-hd,bus=vs0.0,drive=drv0 %s";
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        return qtest_pc_boot(cmd, extra_opts ? : "");
-    }
-    if (strcmp(arch, "ppc64") == 0) {
-        return qtest_spapr_boot(cmd, extra_opts ? : "");
+        qs = qtest_pc_boot(cmd, extra_opts ? : "");
+    } else if (strcmp(arch, "ppc64") == 0) {
+        qs = qtest_spapr_boot(cmd, extra_opts ? : "");
+    } else {
+        g_printerr("virtio-scsi tests are only available on x86 or ppc64\n");
+        exit(EXIT_FAILURE);
     }
-
-    g_printerr("virtio-scsi tests are only available on x86 or ppc64\n");
-    exit(EXIT_FAILURE);
+    global_qtest = qs->qts;
+    return qs;
 }
 
 static void qvirtio_scsi_stop(QOSState *qs)
-- 
1.8.3.1
