Received: from eggs.gnu.org ([2001:4830:134:3::10]:45460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1VG5-0005rG-Na
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d1VG4-0002WK-Iz
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:53:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d1VG4-0002W5-9z
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:53:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 21 Apr 2017 10:53:33 +0100
Message-Id: <20170421095334.26692-3-stefanha@redhat.com>
In-Reply-To: <20170421095334.26692-1-stefanha@redhat.com>
References: <20170421095334.26692-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 2/3] trace: Put all trace.o into
 libqemuutil.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Xu, Anthony" <anthony.xu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Xu, Anthony" <anthony.xu@intel.com>

Currently all trace.o are linked into qemu-system, qemu-img,
qemu-nbd, qemu-io etc., even the corresponding components
are not included.
Put all trace.o into libqemuutil.a that the linker would only pull in .o
files containing symbols that are actually referenced by the
program.

Signed-off -by: Anthony Xu <anthony.xu@intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile               | 6 +++---
 Makefile.target        | 5 ++---
 tests/Makefile.include | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 6c359b2..31d41a7 100644
--- a/Makefile
+++ b/Makefile
@@ -346,7 +346,7 @@ dtc/%:
 	mkdir -p $@
 
 $(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(chardev-obj-y) \
-	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY)) $(trace-obj-y)
+	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
@@ -366,11 +366,11 @@ Makefile: $(version-obj-y)
 # Build libraries
 
 libqemustub.a: $(stub-obj-y)
-libqemuutil.a: $(util-obj-y)
+libqemuutil.a: $(util-obj-y) $(trace-obj-y)
 
 ######################################################################
 
-COMMON_LDADDS = $(trace-obj-y) libqemuutil.a libqemustub.a
+COMMON_LDADDS = libqemuutil.a libqemustub.a
 
 qemu-img.o: qemu-img-cmds.h
 
diff --git a/Makefile.target b/Makefile.target
index 7df2b8c..e62021d 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -188,8 +188,7 @@ dummy := $(call unnest-vars,.., \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
-               common-obj-m \
-               trace-obj-y)
+               common-obj-m)
 target-obj-y := $(target-obj-y-save)
 all-obj-y += $(common-obj-y)
 all-obj-y += $(target-obj-y)
@@ -201,7 +200,7 @@ all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
 $(QEMU_PROG_BUILD): config-devices.mak
 
-COMMON_LDADDS = $(trace-obj-y) ../libqemuutil.a ../libqemustub.a
+COMMON_LDADDS = ../libqemuutil.a ../libqemustub.a
 
 # build either PROG or PROGW
 $(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f3de81f..579ec07 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -519,7 +519,7 @@ QEMU_CFLAGS += -I$(SRC_PATH)/tests
 
 
 # Deps that are common to various different sets of tests below
-test-util-obj-y = $(trace-obj-y) libqemuutil.a libqemustub.a
+test-util-obj-y = libqemuutil.a libqemustub.a
 test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
 	tests/test-qapi-event.o tests/test-qmp-introspect.o \
-- 
2.9.3
