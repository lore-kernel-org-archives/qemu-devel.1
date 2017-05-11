Received: from eggs.gnu.org ([2001:4830:134:3::10]:37758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc1-0002Iq-Av
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc0-0007lY-37
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tbz-0007lG-QX
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:56 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:18 -0300
Message-Id: <20170511191843.13784-5-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 04/29] tests: acpi: extend cphp and memhp
 testcase with numa distance check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, He Chen <he.chen@linux.intel.com>

From: He Chen <he.chen@linux.intel.com>

Signed-off-by: He Chen <he.chen@linux.intel.com>
Message-Id: <1493803036-4048-1-git-send-email-he.chen@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
[ehabkost: regenerated tests/acpi-tst-data, included SLIT table]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/bios-tables-test.c            |  16 ++++++++++++----
 tests/acpi-test-data/pc/SLIT.cphp   | Bin 0 -> 48 bytes
 tests/acpi-test-data/pc/SLIT.memhp  | Bin 0 -> 48 bytes
 tests/acpi-test-data/pc/SRAT.memhp  | Bin 224 -> 264 bytes
 tests/acpi-test-data/q35/SLIT.cphp  | Bin 0 -> 48 bytes
 tests/acpi-test-data/q35/SLIT.memhp | Bin 0 -> 48 bytes
 tests/acpi-test-data/q35/SRAT.memhp | Bin 224 -> 264 bytes
 7 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 tests/acpi-test-data/pc/SLIT.cphp
 create mode 100644 tests/acpi-test-data/pc/SLIT.memhp
 create mode 100644 tests/acpi-test-data/q35/SLIT.cphp
 create mode 100644 tests/acpi-test-data/q35/SLIT.memhp

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 9c96a67053..4e5c65a022 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -723,7 +723,8 @@ static void test_acpi_piix4_tcg_cphp(void)
     data.machine = MACHINE_PC;
     data.variant = ".cphp";
     test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
-                  " -numa node -numa node",
+                  " -numa node -numa node"
+                  " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
 }
@@ -736,7 +737,8 @@ static void test_acpi_q35_tcg_cphp(void)
     data.machine = MACHINE_Q35;
     data.variant = ".cphp";
     test_acpi_one(" -smp 2,cores=3,sockets=2,maxcpus=6"
-                  " -numa node -numa node",
+                  " -numa node -numa node"
+                  " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
 }
@@ -785,7 +787,10 @@ static void test_acpi_q35_tcg_memhp(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_Q35;
     data.variant = ".memhp";
-    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
+    test_acpi_one(" -m 128,slots=3,maxmem=1G"
+                  " -numa node -numa node"
+                  " -numa dist,src=0,dst=1,val=21",
+                  &data);
     free_test_data(&data);
 }
 
@@ -796,7 +801,10 @@ static void test_acpi_piix4_tcg_memhp(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_PC;
     data.variant = ".memhp";
-    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
+    test_acpi_one(" -m 128,slots=3,maxmem=1G"
+                  " -numa node -numa node"
+                  " -numa dist,src=0,dst=1,val=21",
+                  &data);
     free_test_data(&data);
 }
 
diff --git a/tests/acpi-test-data/pc/SLIT.cphp b/tests/acpi-test-data/pc/SLIT.cphp
new file mode 100644
index 0000000000000000000000000000000000000000..74ec3b4b461ffecca36d8537975c202a5f011185
GIT binary patch
literal 48
scmWIc@eDCwU|?X>aq@Te2v%^42yhMtiZKGkKx`1r1jHb~B`V4V0NaKK0RR91

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/pc/SLIT.memhp b/tests/acpi-test-data/pc/SLIT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..74ec3b4b461ffecca36d8537975c202a5f011185
GIT binary patch
literal 48
scmWIc@eDCwU|?X>aq@Te2v%^42yhMtiZKGkKx`1r1jHb~B`V4V0NaKK0RR91

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/pc/SRAT.memhp b/tests/acpi-test-data/pc/SRAT.memhp
index 66ce9a898191d1da961c0c968c04ec56810a5785..a7dddf7760698193819e60a3a96f2a57cf367522 100644
GIT binary patch
delta 63
scmaFB*ulgV9OM|n!N|bCxOgI0p(Zl}6aYowfKda^V}S~?Osq)(00EN*IRF3v

delta 23
ecmeBRdcepP9OM}CfPsO5@%KcoLPqw9OHu$-0tYz&

diff --git a/tests/acpi-test-data/q35/SLIT.cphp b/tests/acpi-test-data/q35/SLIT.cphp
new file mode 100644
index 0000000000000000000000000000000000000000..74ec3b4b461ffecca36d8537975c202a5f011185
GIT binary patch
literal 48
scmWIc@eDCwU|?X>aq@Te2v%^42yhMtiZKGkKx`1r1jHb~B`V4V0NaKK0RR91

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/SLIT.memhp b/tests/acpi-test-data/q35/SLIT.memhp
new file mode 100644
index 0000000000000000000000000000000000000000..74ec3b4b461ffecca36d8537975c202a5f011185
GIT binary patch
literal 48
scmWIc@eDCwU|?X>aq@Te2v%^42yhMtiZKGkKx`1r1jHb~B`V4V0NaKK0RR91

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/SRAT.memhp b/tests/acpi-test-data/q35/SRAT.memhp
index 66ce9a898191d1da961c0c968c04ec56810a5785..a7dddf7760698193819e60a3a96f2a57cf367522 100644
GIT binary patch
delta 63
scmaFB*ulgV9OM|n!N|bCxOgI0p(Zl}6aYowfKda^V}S~?Osq)(00EN*IRF3v

delta 23
ecmeBRdcepP9OM}CfPsO5@%KcoLPqw9OHu$-0tYz&

-- 
2.11.0.259.g40922b1
