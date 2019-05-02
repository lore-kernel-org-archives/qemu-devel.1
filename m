Received: from eggs.gnu.org ([209.51.188.92]:49741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4v-0005im-05
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4t-00039X-4X
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD4s-00038U-33
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:51 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  2 May 2019 16:52:02 +0200
Message-Id: <1556808723-226478-15-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 14/15] tests: acpi: refactor
 rebuild-expected-aml.sh to dump ACPI tables for a specified list of targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>, xuwei5@hisilicon.com, xuwei5@huawei.com, linuxarm@huawei.com

Make initial list contain aarch64 and x86_64 targets.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v4:
 * fix typo (Wei Yang <richardw.yang@linux.intel.com>)
v2:
 * fix up error message (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
---
 tests/data/acpi/rebuild-expected-aml.sh | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/re=
build-expected-aml.sh
index abdff70..07f7e3f 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -7,21 +7,12 @@
 #
 # Authors:
 #  Marcel Apfelbaum <marcel.a@redhat.com>
+#  Igor Mammedov <imammedo@redhat.com>
 #
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
=20
-qemu=3D
-
-if [ -e x86_64-softmmu/qemu-system-x86_64 ]; then
-    qemu=3D"x86_64-softmmu/qemu-system-x86_64"
-elif [ -e i386-softmmu/qemu-system-i386 ]; then
-    qemu=3D"i386-softmmu/qemu-system-i386"
-else
-    echo "Run 'make' to build the qemu exectutable!"
-    echo "Run this script from the build directory."
-    exit 1;
-fi
+qemu_bins=3D"aarch64-softmmu/qemu-system-aarch64 x86_64-softmmu/qemu-sys=
tem-x86_64"
=20
 if [ ! -e "tests/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this=
 script."
@@ -29,6 +20,14 @@ if [ ! -e "tests/bios-tables-test" ]; then
     exit 1;
 fi
=20
-TEST_ACPI_REBUILD_AML=3Dy QTEST_QEMU_BINARY=3D$qemu tests/bios-tables-te=
st
+for qemu in $qemu_bins; do
+    if [ ! -e $qemu ]; then
+        echo "Run 'make' to build the following QEMU executables: $qemu_=
bins"
+        echo "Also, run this script from the build directory."
+        exit 1;
+    fi
+    TEST_ACPI_REBUILD_AML=3Dy QTEST_QEMU_BINARY=3D$qemu tests/bios-table=
s-test
+done
+
=20
 echo "The files were rebuilt and can be added to git."
--=20
2.7.4
