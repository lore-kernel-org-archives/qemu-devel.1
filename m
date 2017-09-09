Received: from eggs.gnu.org ([2001:4830:134:3::10]:33730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbQ-000695-Ad
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbP-0006PR-GS
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqYbP-0006Ot-7g
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:47 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat,  9 Sep 2017 13:45:52 +0800
Message-Id: <20170909054613.19148-17-famz@redhat.com>
In-Reply-To: <20170909054613.19148-1-famz@redhat.com>
References: <20170909054613.19148-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v2 16/37] Makefile: Add rules to run vm tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170905021201.25684-10-famz@redhat.com>
---
 Makefile                  |  2 ++
 configure                 |  2 +-
 tests/vm/Makefile.include | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 tests/vm/Makefile.include

diff --git a/Makefile b/Makefile
index 337a1f6f9b..946eb2ce35 100644
--- a/Makefile
+++ b/Makefile
@@ -822,6 +822,7 @@ endif
 -include $(wildcard *.d tests/*.d)
 
 include $(SRC_PATH)/tests/docker/Makefile.include
+include $(SRC_PATH)/tests/vm/Makefile.include
 
 .PHONY: help
 help:
@@ -845,6 +846,7 @@ help:
 	@echo  'Test targets:'
 	@echo  '  check           - Run all tests (check-help for details)'
 	@echo  '  docker          - Help about targets running tests inside Docker containers'
+	@echo  '  vm-test         - Help about targets running tests inside VM'
 	@echo  ''
 	@echo  'Documentation targets:'
 	@echo  '  html info pdf txt'
diff --git a/configure b/configure
index fd7e3a5e81..3918c47cd8 100755
--- a/configure
+++ b/configure
@@ -6546,7 +6546,7 @@ if test "$ccache_cpp2" = "yes"; then
 fi
 
 # build tree in object directory in case the source is not in the current directory
-DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests"
+DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
 DIRS="$DIRS docs docs/interop fsdev"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
new file mode 100644
index 0000000000..5daa2a3b73
--- /dev/null
+++ b/tests/vm/Makefile.include
@@ -0,0 +1,42 @@
+# Makefile for VM tests
+
+.PHONY: vm-build-all
+
+IMAGES := ubuntu.i386 freebsd netbsd openbsd
+IMAGE_FILES := $(patsubst %, tests/vm/%.img, $(IMAGES))
+
+.PRECIOUS: $(IMAGE_FILES)
+
+vm-test:
+	@echo "vm-test: Test QEMU in preconfigured virtual machines"
+	@echo
+	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
+	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
+	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
+	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
+
+vm-build-all: $(addprefix vm-build-, $(IMAGES))
+
+tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
+		$(SRC_PATH)/tests/vm/basevm.py \
+		$(SRC_PATH)/tests/vm/Makefile.include
+	$(call quiet-command, \
+		$< \
+		$(if $(V)$(DEBUG), --debug) \
+		--image "$@" \
+		--force \
+		--build-image $@, \
+		"  VM-IMAGE $*")
+
+
+# Build in VM $(IMAGE)
+vm-build-%: tests/vm/%.img
+	$(call quiet-command, \
+		$(SRC_PATH)/tests/vm/$* \
+		$(if $(V)$(DEBUG), --debug) \
+		$(if $(DEBUG), --interactive) \
+		$(if $(J),--jobs $(J)) \
+		--image "$<" \
+		--build-qemu $(SRC_PATH), \
+		"  VM-BUILD $*")
+
-- 
2.13.5
