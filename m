Received: from eggs.gnu.org ([209.51.188.92]:34017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR2P-00023c-7P
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gjR2O-0006aw-AT
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:54:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gjR2O-0006an-0g
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:54:00 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 15 Jan 2019 16:41:04 +0100
Message-Id: <1547566866-129386-13-git-send-email-imammedo@redhat.com>
In-Reply-To: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
References: <1547566866-129386-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 12/14] tests: acpi: prepare AVMF firmware blobs
 to be used by bios-tables-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Jones <drjones@redhat.com>

Copy blobs in ACPI test data directory and pad them up to 64Mb
so that QEMU run by test could use them.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/Makefile.include | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index aa68eb5..e1201d9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -295,6 +295,7 @@ check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-aarch64-y += tests/migration-test$(EXESUF)
+qtest-uefi-images-aarch64 = avmf.img avmf_vars.img
 
 check-qtest-microblazeel-y += $(check-qtest-microblaze-y)
 
@@ -710,7 +711,8 @@ tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
 tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-y)
 tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
 tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
-	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
+	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y) \
+	| prep-uefi-images
 tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-obj-y)
 tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
 tests/pca9552-test$(EXESUF): tests/pca9552-test.o $(libqos-omap-obj-y)
@@ -936,6 +938,18 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
 	@diff -u $(SRC_PATH)/$*.out $*.test.out
 	@diff -u $(SRC_PATH)/$*.exit $*.test.exit
 
+qtest-uefi-images = $(foreach target,$(QTEST_TARGETS), $(strip $(qtest-uefi-images-$(target))))
+# Suppress implicit pc-bios/foo rules
+$(patsubst %,pc-bios/%,$(qtest-uefi-images)): ;
+
+# create rules for expanding UEFI images for configured targets
+$(foreach uefi-img, $(qtest-uefi-images), \
+    $(eval tests/data/acpi/$(uefi-img): pc-bios/$(uefi-img) ; \
+              $(call quiet-command, cat $$< /dev/zero | head -c 67108864 > $$@)))
+
+.PHONY: prep-uefi-images
+prep-uefi-images: $(patsubst %, tests/data/acpi/%, $(qtest-uefi-images))
+
 .PHONY: check-tests/qapi-schema/doc-good.texi
 check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
 	@diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
@@ -999,6 +1013,7 @@ check-clean:
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
 	rm -f tests/test-qapi-gen-timestamp
 	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
+	rm -f $(patsubst %,tests/data/acpi/%, $(qtest-uefi-images))
 
 clean: check-clean
 
@@ -1009,4 +1024,5 @@ all: $(QEMU_IOTESTS_HELPERS-y)
 -include $(wildcard tests/*.d)
 -include $(wildcard tests/libqos/*.d)
 
+
 endif
-- 
2.7.4
