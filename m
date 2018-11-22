Received: from eggs.gnu.org ([2001:4830:134:3::10]:37390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFa-0001uI-Pe
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFX-00011q-VI
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 22 Nov 2018 17:54:14 +0100
Message-Id: <20181122165417.23894-11-kwolf@redhat.com>
In-Reply-To: <20181122165417.23894-1-kwolf@redhat.com>
References: <20181122165417.23894-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/13] nvme: fix out-of-bounds access to the CMB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Because the CMB BAR has a min_access_size of 2, if you read the last
byte it will try to memcpy *2* bytes from n->cmbuf, causing an off-by-one
error.  This is CVE-2018-16847.

Another way to fix this might be to register the CMB as a RAM memory
region, which would also be more efficient.  However, that might be a
change for big-endian machines; I didn't think this through and I don't
know how real hardware works.  Add a basic testcase for the CMB in case
somebody does this change later on.

Cc: Keith Busch <keith.busch@intel.com>
Cc: qemu-block@nongnu.org
Reported-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Tested-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c        |  2 +-
 tests/nvme-test.c      | 68 +++++++++++++++++++++++++++++++++++-------
 tests/Makefile.include |  2 +-
 3 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 28d284346d..8c35cab2b4 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1201,7 +1201,7 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
     .write =3D nvme_cmb_write,
     .endianness =3D DEVICE_LITTLE_ENDIAN,
     .impl =3D {
-        .min_access_size =3D 2,
+        .min_access_size =3D 1,
         .max_access_size =3D 8,
     },
 };
diff --git a/tests/nvme-test.c b/tests/nvme-test.c
index 7674a446e4..2700ba838a 100644
--- a/tests/nvme-test.c
+++ b/tests/nvme-test.c
@@ -8,25 +8,73 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "libqtest.h"
+#include "libqos/libqos-pc.h"
+
+static QOSState *qnvme_start(const char *extra_opts)
+{
+    QOSState *qs;
+    const char *arch =3D qtest_get_arch();
+    const char *cmd =3D "-drive id=3Ddrv0,if=3Dnone,file=3Dnull-co://,fo=
rmat=3Draw "
+                      "-device nvme,addr=3D0x4.0,serial=3Dfoo,drive=3Ddr=
v0 %s";
+
+    if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0=
) {
+        qs =3D qtest_pc_boot(cmd, extra_opts ? : "");
+        global_qtest =3D qs->qts;
+        return qs;
+    }
+
+    g_printerr("nvme tests are only available on x86\n");
+    exit(EXIT_FAILURE);
+}
+
+static void qnvme_stop(QOSState *qs)
+{
+    qtest_shutdown(qs);
+}
=20
-/* Tests only initialization so far. TODO: Replace with functional tests=
 */
 static void nop(void)
 {
+    QOSState *qs;
+
+    qs =3D qnvme_start(NULL);
+    qnvme_stop(qs);
 }
=20
-int main(int argc, char **argv)
+static void nvmetest_cmb_test(void)
 {
-    int ret;
+    const int cmb_bar_size =3D 2 * MiB;
+    QOSState *qs;
+    QPCIDevice *pdev;
+    QPCIBar bar;
=20
-    g_test_init(&argc, &argv, NULL);
-    qtest_add_func("/nvme/nop", nop);
+    qs =3D qnvme_start("-global nvme.cmb_size_mb=3D2");
+    pdev =3D qpci_device_find(qs->pcibus, QPCI_DEVFN(4,0));
+    g_assert(pdev !=3D NULL);
+
+    qpci_device_enable(pdev);
+    bar =3D qpci_iomap(pdev, 2, NULL);
+
+    qpci_io_writel(pdev, bar, 0, 0xccbbaa99);
+    g_assert_cmpint(qpci_io_readb(pdev, bar, 0), =3D=3D, 0x99);
+    g_assert_cmpint(qpci_io_readw(pdev, bar, 0), =3D=3D, 0xaa99);
+
+    /* Test partially out-of-bounds accesses.  */
+    qpci_io_writel(pdev, bar, cmb_bar_size - 1, 0x44332211);
+    g_assert_cmpint(qpci_io_readb(pdev, bar, cmb_bar_size - 1), =3D=3D, =
0x11);
+    g_assert_cmpint(qpci_io_readw(pdev, bar, cmb_bar_size - 1), !=3D, 0x=
2211);
+    g_assert_cmpint(qpci_io_readl(pdev, bar, cmb_bar_size - 1), !=3D, 0x=
44332211);
+    g_free(pdev);
=20
-    qtest_start("-drive id=3Ddrv0,if=3Dnone,file=3Dnull-co://,format=3Dr=
aw "
-                "-device nvme,drive=3Ddrv0,serial=3Dfoo");
-    ret =3D g_test_run();
+    qnvme_stop(qs);
+}
=20
-    qtest_end();
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/nvme/nop", nop);
+    qtest_add_func("/nvme/cmb_test", nvmetest_cmb_test);
=20
-    return ret;
+    return g_test_run();
 }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 613242bc6e..fb0b449c02 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -730,7 +730,7 @@ tests/test-hmp$(EXESUF): tests/test-hmp.o
 tests/machine-none-test$(EXESUF): tests/machine-none-test.o
 tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-ob=
j-y)
 tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-=
obj-y)
-tests/nvme-test$(EXESUF): tests/nvme-test.o
+tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
 tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
 tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
 tests/ac97-test$(EXESUF): tests/ac97-test.o
--=20
2.19.1
