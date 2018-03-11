Received: from eggs.gnu.org ([2001:4830:134:3::10]:48783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eupss-0003ye-3V
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eupsr-0004qz-05
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:34:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:17414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eupsq-0004nm-Jp
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:34:44 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Sun, 11 Mar 2018 09:34:25 +0800
Message-Id: <20180311013426.32610-5-haozhong.zhang@intel.com>
In-Reply-To: <20180311013426.32610-1-haozhong.zhang@intel.com>
References: <20180311013426.32610-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v5 4/5] tests/bios-tables-test: add test cases
 for DIMM proximity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

QEMU now builds one SRAT memory affinity structure for each PC-DIMM
and NVDIMM device presented at boot time with the proximity domain
specified in the device option 'node', rather than only one SRAT
memory affinity structure covering the entire hotpluggable address
space with the proximity domain of the last node.

Add test cases on PC and Q35 machines with 4 proximity domains, and
one PC-DIMM and one NVDIMM attached to the 2nd and 3rd proximity
domains respectively. Check whether the QEMU-built SRAT tables match
with the expected ones.

The following ACPI tables need to be added for this test:
  tests/acpi-test-data/pc/APIC.dimmpxm
  tests/acpi-test-data/pc/DSDT.dimmpxm
  tests/acpi-test-data/pc/NFIT.dimmpxm
  tests/acpi-test-data/pc/SRAT.dimmpxm
  tests/acpi-test-data/pc/SSDT.dimmpxm
  tests/acpi-test-data/q35/APIC.dimmpxm
  tests/acpi-test-data/q35/DSDT.dimmpxm
  tests/acpi-test-data/q35/NFIT.dimmpxm
  tests/acpi-test-data/q35/SRAT.dimmpxm
  tests/acpi-test-data/q35/SSDT.dimmpxm
New APIC and DSDT are needed because of the multiple processors
configuration. New NFIT and SSDT are needed because of NVDIMM.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 65b271a173..34b55ff812 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -869,6 +869,42 @@ static void test_acpi_piix4_tcg_numamem(void)
     free_test_data(&data);
 }
 
+static void test_acpi_tcg_dimm_pxm(const char *machine)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = machine;
+    data.variant = ".dimmpxm";
+    test_acpi_one(" -machine nvdimm=on"
+                  " -smp 4,sockets=4"
+                  " -m 128M,slots=3,maxmem=1G"
+                  " -numa node,mem=32M,nodeid=0"
+                  " -numa node,mem=32M,nodeid=1"
+                  " -numa node,mem=32M,nodeid=2"
+                  " -numa node,mem=32M,nodeid=3"
+                  " -numa cpu,node-id=0,socket-id=0"
+                  " -numa cpu,node-id=1,socket-id=1"
+                  " -numa cpu,node-id=2,socket-id=2"
+                  " -numa cpu,node-id=3,socket-id=3"
+                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -object memory-backend-ram,id=nvm0,size=128M"
+                  " -device pc-dimm,id=dimm0,memdev=ram0,node=1"
+                  " -device nvdimm,id=dimm1,memdev=nvm0,node=2",
+                  &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_q35_tcg_dimm_pxm(void)
+{
+    test_acpi_tcg_dimm_pxm(MACHINE_Q35);
+}
+
+static void test_acpi_piix4_tcg_dimm_pxm(void)
+{
+    test_acpi_tcg_dimm_pxm(MACHINE_PC);
+}
+
 int main(int argc, char *argv[])
 {
     const char *arch = qtest_get_arch();
@@ -893,6 +929,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
         qtest_add_func("acpi/piix4/numamem", test_acpi_piix4_tcg_numamem);
         qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
+        qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
+        qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.14.1
