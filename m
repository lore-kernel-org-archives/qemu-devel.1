Received: from eggs.gnu.org ([2001:4830:134:3::10]:54852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiO-0005Un-8v
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiK-00070y-Vi
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiK-00070X-RH
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C44D81A4EAF
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:01 +0200
Message-Id: <20180717120414.5852-2-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 01/14] check: Only test ipmi when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/Makefile.include   | 4 ++--
 tests/bios-tables-test.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0ac4b960bc..bb1080ecb5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -260,8 +260,8 @@ check-qtest-i386-y += tests/bios-tables-test$(EXESUF)
 check-qtest-i386-y += tests/boot-serial-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-i386-y += tests/rtc-test$(EXESUF)
-check-qtest-i386-y += tests/ipmi-kcs-test$(EXESUF)
-check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
+check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += tests/ipmi-kcs-test$(EXESUF)
+check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
 check-qtest-i386-y += tests/i440fx-test$(EXESUF)
 check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
 check-qtest-i386-y += tests/drive_del-test$(EXESUF)
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 4e24930c4b..fd59c7f9a2 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -736,6 +736,7 @@ static void test_acpi_q35_tcg_cphp(void)
     free_test_data(&data);
 }
 
+#ifdef CONFIG_IPMI
 static uint8_t ipmi_required_struct_types[] = {
     0, 1, 3, 4, 16, 17, 19, 32, 38, 127
 };
@@ -772,6 +773,7 @@ static void test_acpi_piix4_tcg_ipmi(void)
                   &data);
     free_test_data(&data);
 }
+#endif
 
 static void test_acpi_q35_tcg_memhp(void)
 {
@@ -875,8 +877,10 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
+#ifdef CONFIG_IPMI
         qtest_add_func("acpi/piix4/ipmi", test_acpi_piix4_tcg_ipmi);
         qtest_add_func("acpi/q35/ipmi", test_acpi_q35_tcg_ipmi);
+#endif
         qtest_add_func("acpi/piix4/cpuhp", test_acpi_piix4_tcg_cphp);
         qtest_add_func("acpi/q35/cpuhp", test_acpi_q35_tcg_cphp);
         qtest_add_func("acpi/piix4/memhp", test_acpi_piix4_tcg_memhp);
-- 
2.17.1
