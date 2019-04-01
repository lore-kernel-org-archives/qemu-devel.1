Received: from eggs.gnu.org ([209.51.188.92]:43543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47z-0004cJ-CZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47v-0005cP-Hu
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB47s-0005MJ-KZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:53 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L5JBZ006215
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:05:20 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkqrc08mu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:05:20 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:18 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 16:00:08 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-95-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 94/97] nvme: fix out-of-bounds access to the CMB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

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
(cherry picked from commit 87ad860c622cc8f8916b5232bd8728c08f938fce)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/block/nvme.c        |  2 +-
 tests/Makefile.include |  2 +-
 tests/nvme-test.c      | 68 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 5e508ab1b3..5f304bd098 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1192,7 +1192,7 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
     .write =3D nvme_cmb_write,
     .endianness =3D DEVICE_LITTLE_ENDIAN,
     .impl =3D {
-        .min_access_size =3D 2,
+        .min_access_size =3D 1,
         .max_access_size =3D 8,
     },
 };
diff --git a/tests/Makefile.include b/tests/Makefile.include
index a49282704e..91af385e2f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -821,7 +821,7 @@ tests/test-hmp$(EXESUF): tests/test-hmp.o
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
--=20
2.17.1
