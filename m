Received: from eggs.gnu.org ([2001:4830:134:3::10]:54601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqsxc-0004WA-MN
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 23:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqsxb-0002N3-6S
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 23:03:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:46587)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eqsxa-0002Kn-Pt
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 23:03:19 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 28 Feb 2018 12:02:59 +0800
Message-Id: <20180228040300.8914-3-haozhong.zhang@intel.com>
In-Reply-To: <20180228040300.8914-1-haozhong.zhang@intel.com>
References: <20180228040300.8914-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 2/3] tests/bios-tables-test: allow setting
 extra machine options
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

Some test cases may require extra machine options than the those
used in the current test_acpi_ones(), e.g., nvdimm test cases require
the machine option 'nvdimm=on'.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 tests/bios-tables-test.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 65b271a173..d45181aa51 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -654,17 +654,22 @@ static void test_smbios_structs(test_data *data)
     }
 }
 
-static void test_acpi_one(const char *params, test_data *data)
+static void test_acpi_one(const char *extra_machine_opts,
+                          const char *params, test_data *data)
 {
     char *args;
 
     /* Disable kernel irqchip to be able to override apic irq0. */
-    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
+    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off",
+                           data->machine, "kvm:tcg");
+    if (extra_machine_opts) {
+        args = g_strdup_printf("%s,%s", args, extra_machine_opts);
+    }
+    args = g_strdup_printf("%s "
                            "-net none -display none %s "
                            "-drive id=hd0,if=none,file=%s,format=raw "
                            "-device ide-hd,drive=hd0 ",
-                           data->machine, "kvm:tcg",
-                           params ? params : "", disk);
+                           args, params ? params : "", disk);
 
     qtest_start(args);
 
@@ -711,7 +716,7 @@ static void test_acpi_piix4_tcg(void)
     data.machine = MACHINE_PC;
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
-    test_acpi_one(NULL, &data);
+    test_acpi_one(NULL, NULL, &data);
     free_test_data(&data);
 }
 
@@ -724,7 +729,7 @@ static void test_acpi_piix4_tcg_bridge(void)
     data.variant = ".bridge";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
-    test_acpi_one("-device pci-bridge,chassis_nr=1", &data);
+    test_acpi_one(NULL, "-device pci-bridge,chassis_nr=1", &data);
     free_test_data(&data);
 }
 
@@ -736,7 +741,7 @@ static void test_acpi_q35_tcg(void)
     data.machine = MACHINE_Q35;
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
-    test_acpi_one(NULL, &data);
+    test_acpi_one(NULL, NULL, &data);
     free_test_data(&data);
 }
 
@@ -749,7 +754,7 @@ static void test_acpi_q35_tcg_bridge(void)
     data.variant = ".bridge";
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
-    test_acpi_one("-device pci-bridge,chassis_nr=1",
+    test_acpi_one(NULL, "-device pci-bridge,chassis_nr=1",
                   &data);
     free_test_data(&data);
 }
@@ -761,7 +766,8 @@ static void test_acpi_piix4_tcg_cphp(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_PC;
     data.variant = ".cphp";
-    test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
+    test_acpi_one(NULL,
+                  "-smp 2,cores=3,sockets=2,maxcpus=6"
                   " -numa node -numa node"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
@@ -775,7 +781,8 @@ static void test_acpi_q35_tcg_cphp(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_Q35;
     data.variant = ".cphp";
-    test_acpi_one(" -smp 2,cores=3,sockets=2,maxcpus=6"
+    test_acpi_one(NULL,
+                  " -smp 2,cores=3,sockets=2,maxcpus=6"
                   " -numa node -numa node"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
@@ -795,7 +802,8 @@ static void test_acpi_q35_tcg_ipmi(void)
     data.variant = ".ipmibt";
     data.required_struct_types = ipmi_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(ipmi_required_struct_types);
-    test_acpi_one("-device ipmi-bmc-sim,id=bmc0"
+    test_acpi_one(NULL,
+                  "-device ipmi-bmc-sim,id=bmc0"
                   " -device isa-ipmi-bt,bmc=bmc0",
                   &data);
     free_test_data(&data);
@@ -813,7 +821,8 @@ static void test_acpi_piix4_tcg_ipmi(void)
     data.variant = ".ipmikcs";
     data.required_struct_types = ipmi_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(ipmi_required_struct_types);
-    test_acpi_one("-device ipmi-bmc-sim,id=bmc0"
+    test_acpi_one(NULL,
+                  "-device ipmi-bmc-sim,id=bmc0"
                   " -device isa-ipmi-kcs,irq=0,bmc=bmc0",
                   &data);
     free_test_data(&data);
@@ -826,7 +835,8 @@ static void test_acpi_q35_tcg_memhp(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_Q35;
     data.variant = ".memhp";
-    test_acpi_one(" -m 128,slots=3,maxmem=1G"
+    test_acpi_one(NULL,
+                  " -m 128,slots=3,maxmem=1G"
                   " -numa node -numa node"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
@@ -840,7 +850,8 @@ static void test_acpi_piix4_tcg_memhp(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_PC;
     data.variant = ".memhp";
-    test_acpi_one(" -m 128,slots=3,maxmem=1G"
+    test_acpi_one(NULL,
+                  " -m 128,slots=3,maxmem=1G"
                   " -numa node -numa node"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
@@ -854,7 +865,8 @@ static void test_acpi_q35_tcg_numamem(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_Q35;
     data.variant = ".numamem";
-    test_acpi_one(" -numa node -numa node,mem=128", &data);
+    test_acpi_one(NULL,
+                  " -numa node -numa node,mem=128", &data);
     free_test_data(&data);
 }
 
@@ -865,7 +877,8 @@ static void test_acpi_piix4_tcg_numamem(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_PC;
     data.variant = ".numamem";
-    test_acpi_one(" -numa node -numa node,mem=128", &data);
+    test_acpi_one(NULL,
+                  " -numa node -numa node,mem=128", &data);
     free_test_data(&data);
 }
 
-- 
2.14.1
