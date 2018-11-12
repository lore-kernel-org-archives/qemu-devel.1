Received: from eggs.gnu.org ([2001:4830:134:3::10]:48760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMHZq-0005Ji-KL
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 14:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMHZo-00049L-73
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 14:08:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gMHZn-0003yL-Sk
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 14:08:48 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 12 Nov 2018 20:08:07 +0100
Message-Id: <1542049690-12826-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1542049690-12826-1-git-send-email-thuth@redhat.com>
References: <1542049690-12826-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.2 4/7] ivshmem-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ben Warren <ben@skyportsystems.com>

From: Eric Blake <eblake@redhat.com>

Managing parallel connections to two different monitors via
the implicit global_qtest makes it hard to copy-and-paste code
to tests that are not aware of the implicit state.  Since we
have already fixed qpci to avoid global_qtest, we can now
simplify by not using global_qtest anywhere in ivshmem-test.

We can assert that the conversion is correct by checking that
global_qtest remains NULL throughout the test (a later patch
that changes global_qtest to not be a public global variable
will drop the assertions).

Signed-off-by: Eric Blake <eblake@redhat.com>
[thuth: Dropped the changes to test_ivshmem_hotplug() - will be fixed later]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/ivshmem-test.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index c37b196..089e268 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -71,13 +71,10 @@ static const char* reg2str(enum Reg reg) {
 static inline unsigned in_reg(IVState *s, enum Reg reg)
 {
     const char *name = reg2str(reg);
-    QTestState *qtest = global_qtest;
     unsigned res;
 
-    global_qtest = s->qs->qts;
     res = qpci_io_readl(s->dev, s->reg_bar, reg);
     g_test_message("*%s -> %x\n", name, res);
-    global_qtest = qtest;
 
     return res;
 }
@@ -85,35 +82,25 @@ static inline unsigned in_reg(IVState *s, enum Reg reg)
 static inline void out_reg(IVState *s, enum Reg reg, unsigned v)
 {
     const char *name = reg2str(reg);
-    QTestState *qtest = global_qtest;
 
-    global_qtest = s->qs->qts;
     g_test_message("%x -> *%s\n", v, name);
     qpci_io_writel(s->dev, s->reg_bar, reg, v);
-    global_qtest = qtest;
 }
 
 static inline void read_mem(IVState *s, uint64_t off, void *buf, size_t len)
 {
-    QTestState *qtest = global_qtest;
-
-    global_qtest = s->qs->qts;
     qpci_memread(s->dev, s->mem_bar, off, buf, len);
-    global_qtest = qtest;
 }
 
 static inline void write_mem(IVState *s, uint64_t off,
                              const void *buf, size_t len)
 {
-    QTestState *qtest = global_qtest;
-
-    global_qtest = s->qs->qts;
     qpci_memwrite(s->dev, s->mem_bar, off, buf, len);
-    global_qtest = qtest;
 }
 
 static void cleanup_vm(IVState *s)
 {
+    assert(!global_qtest);
     g_free(s->dev);
     qtest_shutdown(s->qs);
 }
@@ -131,7 +118,6 @@ static void setup_vm_cmd(IVState *s, const char *cmd, bool msix)
         g_printerr("ivshmem-test tests are only available on x86 or ppc64\n");
         exit(EXIT_FAILURE);
     }
-    global_qtest = s->qs->qts;
     s->dev = get_device(s->qs->pcibus);
 
     s->reg_bar = qpci_iomap(s->dev, 0, &barsize);
@@ -354,7 +340,6 @@ static void test_ivshmem_server(bool msi)
     g_assert_cmpint(vm1, !=, vm2);
 
     /* check number of MSI-X vectors */
-    global_qtest = s1->qs->qts;
     if (msi) {
         ret = qpci_msix_table_size(s1->dev);
         g_assert_cmpuint(ret, ==, nvectors);
@@ -377,7 +362,6 @@ static void test_ivshmem_server(bool msi)
     g_assert_cmpuint(ret, !=, 0);
 
     /* ping vm1 -> vm2 on vector 1 */
-    global_qtest = s2->qs->qts;
     if (msi) {
         ret = qpci_msix_pending(s2->dev, 1);
         g_assert_cmpuint(ret, ==, 0);
-- 
1.8.3.1
