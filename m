Received: from eggs.gnu.org ([209.51.188.92]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX3B-0003hD-Nv
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJX2K-0000NJ-6c
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:35:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJX2J-0000MT-Sb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:35:08 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 25 Apr 2019 07:34:48 +0200
Message-Id: <1556170489-131927-13-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/13] tests: acpi: refactor
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
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>

Make initial list contain aarch64 and x86_64 targets.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2:
 * fix up error message (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
---
 tests/data/acpi/rebuild-expected-aml.sh | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/re=
build-expected-aml.sh
index abdff70..52793f3 100755
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
+        echo "Run 'make' to build the following QEMU exectutables: $qemu=
_bins"
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
