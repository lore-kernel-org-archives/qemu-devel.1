Received: from eggs.gnu.org ([2001:4830:134:3::10]:38131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgw-0000Ba-VG
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgv-0001Dq-T5
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIgv-0001DL-L9
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:55 +0800
Message-Id: <20170922074659.30097-33-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/36] Makefile: Add rules to run vm tests
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

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 Makefile                  |  2 ++
 configure                 |  2 +-
 tests/vm/Makefile.include | 42 +++++++++++++++++++++++++++++++++++++++++=
+
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 tests/vm/Makefile.include

diff --git a/Makefile b/Makefile
index eb831b98d1..d1501a07ee 100644
--- a/Makefile
+++ b/Makefile
@@ -811,6 +811,7 @@ endif
 -include $(wildcard *.d tests/*.d)
=20
 include $(SRC_PATH)/tests/docker/Makefile.include
+include $(SRC_PATH)/tests/vm/Makefile.include
=20
 .PHONY: help
 help:
@@ -834,6 +835,7 @@ help:
 	@echo  'Test targets:'
 	@echo  '  check           - Run all tests (check-help for details)'
 	@echo  '  docker          - Help about targets running tests inside Doc=
ker containers'
+	@echo  '  vm-test         - Help about targets running tests inside VM'
 	@echo  ''
 	@echo  'Documentation targets:'
 	@echo  '  html info pdf txt'
diff --git a/configure b/configure
index 84cdb2b0a0..f4bbc2ca21 100755
--- a/configure
+++ b/configure
@@ -6509,7 +6509,7 @@ if test "$ccache_cpp2" =3D "yes"; then
 fi
=20
 # build tree in object directory in case the source is not in the curren=
t directory
-DIRS=3D"tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests=
/qapi-schema tests/tcg/xtensa tests/qemu-iotests"
+DIRS=3D"tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests=
/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
 DIRS=3D"$DIRS docs docs/interop fsdev"
 DIRS=3D"$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS=3D"$DIRS roms/seabios roms/vgabios"
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
+IMAGES :=3D ubuntu.i386 freebsd netbsd openbsd
+IMAGE_FILES :=3D $(patsubst %, tests/vm/%.img, $(IMAGES))
+
+.PRECIOUS: $(IMAGE_FILES)
+
+vm-test:
+	@echo "vm-test: Test QEMU in preconfigured virtual machines"
+	@echo
+	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM=
"
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
--=20
2.13.5
