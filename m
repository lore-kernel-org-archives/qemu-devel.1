Received: from eggs.gnu.org ([2001:4830:134:3::10]:39263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPd-0008W3-Si
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPc-0001o9-IT
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:21 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:20 -0500
Message-Id: <20170911172022.4738-37-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 36/38] libqtest: Merge qtest_memset() with
 qmemset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

Maintaining two layers of libqtest APIs, one that takes an explicit
QTestState object, and the other that uses the implicit global_qtest,
is annoying.  In the interest of getting rid of global implicit
state and having less code to maintain, merge:
 qtest_memset()
with its short counterpart.  All callers that previously used the
short form now make it explicit that they are relying on
global_qtest, and later patches can then clean things up to remove
the global variable.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h    | 17 ++---------------
 tests/libqtest.c    |  2 +-
 tests/ahci-test.c   |  2 +-
 tests/libqos/ahci.c | 12 ++++++------
 4 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index adf04327b7..8f2946ff5e 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -405,7 +405,7 @@ void memwrite(QTestState *s, uint64_t addr, const void *data, size_t size);
 void bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size);

 /**
- * qtest_memset:
+ * qmemset:
  * @s: #QTestState instance to operate on.
  * @addr: Guest address to write to.
  * @patt: Byte pattern to fill the guest memory region with.
@@ -413,7 +413,7 @@ void bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size);
  *
  * Write a pattern to guest memory.
  */
-void qtest_memset(QTestState *s, uint64_t addr, uint8_t patt, size_t size);
+void qmemset(QTestState *s, uint64_t addr, uint8_t patt, size_t size);

 /**
  * clock_step_next:
@@ -592,19 +592,6 @@ static inline QDict *qmp_eventwait_ref(const char *event)
  */
 char *hmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);

-/**
- * qmemset:
- * @addr: Guest address to write to.
- * @patt: Byte pattern to fill the guest memory region with.
- * @size: Number of bytes to write.
- *
- * Write a pattern to guest memory.
- */
-static inline void qmemset(uint64_t addr, uint8_t patt, size_t size)
-{
-    qtest_memset(global_qtest, addr, patt, size);
-}
-
 QDict *qmp_fd_receive(int fd);
 void qmp_fd_sendv(int fd, const char *fmt, va_list ap);
 void qmp_fd_send(int fd, const char *fmt, ...);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index a52dc635f4..ac38f6d4bb 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -929,7 +929,7 @@ void memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
     g_free(enc);
 }

-void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
+void qmemset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
 {
     qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x\n", addr, size, pattern);
     qtest_rsp(s, 0);
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 4b5f0b23fb..18af01501f 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -873,7 +873,7 @@ static void ahci_test_io_rw_simple(AHCIQState *ahci, unsigned bufsize,

     /* Write this buffer to disk, then read it back to the DMA buffer. */
     ahci_guest_io(ahci, port, write_cmd, ptr, bufsize, sector);
-    qtest_memset(ahci->parent->qts, ptr, 0x00, bufsize);
+    qmemset(ahci->parent->qts, ptr, 0x00, bufsize);
     ahci_guest_io(ahci, port, read_cmd, ptr, bufsize, sector);

     /*** Read back the Data ***/
diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index 433952c11a..f60f60fff5 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -283,8 +283,8 @@ void ahci_hba_enable(AHCIQState *ahci)
         /* Allocate Memory for the Command List Buffer & FIS Buffer */
         /* PxCLB space ... 0x20 per command, as in 4.2.2 p 36 */
         ahci->port[i].clb = ahci_alloc(ahci, num_cmd_slots * 0x20);
-        qtest_memset(ahci->parent->qts, ahci->port[i].clb, 0x00,
-                     num_cmd_slots * 0x20);
+        qmemset(ahci->parent->qts, ahci->port[i].clb, 0x00,
+                num_cmd_slots * 0x20);
         g_test_message("CLB: 0x%08" PRIx64, ahci->port[i].clb);
         ahci_px_wreg(ahci, i, AHCI_PX_CLB, ahci->port[i].clb);
         g_assert_cmphex(ahci->port[i].clb, ==,
@@ -292,7 +292,7 @@ void ahci_hba_enable(AHCIQState *ahci)

         /* PxFB space ... 0x100, as in 4.2.1 p 35 */
         ahci->port[i].fb = ahci_alloc(ahci, 0x100);
-        qtest_memset(ahci->parent->qts, ahci->port[i].fb, 0x00, 0x100);
+        qmemset(ahci->parent->qts, ahci->port[i].fb, 0x00, 0x100);
         g_test_message("FB: 0x%08" PRIx64, ahci->port[i].fb);
         ahci_px_wreg(ahci, i, AHCI_PX_FB, ahci->port[i].fb);
         g_assert_cmphex(ahci->port[i].fb, ==,
@@ -398,7 +398,7 @@ void ahci_port_clear(AHCIQState *ahci, uint8_t port)
     g_assert_cmphex(ahci_px_rreg(ahci, port, AHCI_PX_IS), ==, 0);

     /* Wipe the FIS-Receive Buffer */
-    qtest_memset(ahci->parent->qts, ahci->port[port].fb, 0x00, 0x100);
+    qmemset(ahci->parent->qts, ahci->port[port].fb, 0x00, 0x100);
 }

 /**
@@ -637,7 +637,7 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
     if (opts->size && !opts->buffer) {
         opts->buffer = ahci_alloc(ahci, opts->size);
         g_assert(opts->buffer);
-        qtest_memset(ahci->parent->qts, opts->buffer, 0x00, opts->size);
+        qmemset(ahci->parent->qts, opts->buffer, 0x00, opts->size);
     }

     /* Command creation */
@@ -755,7 +755,7 @@ void ahci_io(AHCIQState *ahci, uint8_t port, uint8_t ide_cmd,
     g_assert(props);
     ptr = ahci_alloc(ahci, bufsize);
     g_assert(!bufsize || ptr);
-    qtest_memset(ahci->parent->qts, ptr, 0x00, bufsize);
+    qmemset(ahci->parent->qts, ptr, 0x00, bufsize);

     if (bufsize && props->write) {
         bufwrite(ahci->parent->qts, ptr, buffer, bufsize);
-- 
2.13.5
