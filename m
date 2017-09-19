Received: from eggs.gnu.org ([2001:4830:134:3::10]:60295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfg-0004UW-4h
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfb-0005fG-QA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:36 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfb-0005dq-Gl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:31 -0400
Received: by mail-wr0-x241.google.com with SMTP id b9so2161808wra.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:28 +0200
Message-Id: <1505824179-21541-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 39/50] Makefile: Remove libqemustub.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Using two libraries (libqemuutil.a and libqemustub.a) would sometimes
result in circular dependencies. To avoid these issues let's just
combine both into a single library that functions as both.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <54e6458745493d10901964624479a7d9a872f481.1503077821.git.alistair.francis@xilinx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                    |  7 +++----
 Makefile.target             |  2 +-
 docs/devel/build-system.txt | 18 +++++++++---------
 tests/Makefile.include      |  6 +++---
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index b53fc69..eb831b9 100644
--- a/Makefile
+++ b/Makefile
@@ -335,7 +335,7 @@ subdir-dtc:dtc/libfdt dtc/tests
 dtc/%:
 	mkdir -p $@
 
-$(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(chardev-obj-y) \
+$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
 	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
@@ -355,12 +355,11 @@ Makefile: $(version-obj-y)
 ######################################################################
 # Build libraries
 
-libqemustub.a: $(stub-obj-y)
-libqemuutil.a: $(util-obj-y) $(trace-obj-y)
+libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
 
 ######################################################################
 
-COMMON_LDADDS = libqemuutil.a libqemustub.a
+COMMON_LDADDS = libqemuutil.a
 
 qemu-img.o: qemu-img-cmds.h
 
diff --git a/Makefile.target b/Makefile.target
index 6361f95..32b0100 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -193,7 +193,7 @@ all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
 $(QEMU_PROG_BUILD): config-devices.mak
 
-COMMON_LDADDS = ../libqemuutil.a ../libqemustub.a
+COMMON_LDADDS = ../libqemuutil.a
 
 # build either PROG or PROGW
 $(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index 2af1e66..386ef36 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -232,15 +232,15 @@ The utility code that is used by all binaries is built into a
 static archive called libqemuutil.a, which is then linked to all the
 binaries. In order to provide hooks that are only needed by some of the
 binaries, code in libqemuutil.a may depend on other functions that are
-not fully implemented by all QEMU binaries. To deal with this there is a
-second library called libqemustub.a which provides dummy stubs for all
-these functions. These will get lazy linked into the binary if the real
-implementation is not present. In this way, the libqemustub.a static
-library can be thought of as a portable implementation of the weak
-symbols concept. All binaries should link to both libqemuutil.a and
-libqemustub.a. e.g.
-
- qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a libqemustub.a
+not fully implemented by all QEMU binaries.  Dummy stubs for all these
+functions are also provided by this library, and will only be linked
+into the binary if the real implementation is not present.  In a way,
+the stubs can be thought of as a portable implementation of the weak
+symbols concept.
+
+All binaries should link to libqemuutil.a, e.g.:
+
+ qemu-img$(EXESUF): qemu-img.o ..snip.. libqemuutil.a
 
 
 Windows platform portability
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 59e027f..2136036 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -561,7 +561,7 @@ QEMU_CFLAGS += -I$(SRC_PATH)/tests
 
 
 # Deps that are common to various different sets of tests below
-test-util-obj-y = libqemuutil.a libqemustub.a
+test-util-obj-y = libqemuutil.a
 test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
 	tests/test-qapi-event.o tests/test-qmp-introspect.o \
@@ -617,8 +617,8 @@ tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	$(test-io-obj-y)
 tests/test-timed-average$(EXESUF): tests/test-timed-average.o $(test-util-obj-y)
 tests/test-base64$(EXESUF): tests/test-base64.o \
-	libqemuutil.a libqemustub.a
-tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o libqemustub.a
+	libqemuutil.a
+tests/ptimer-test$(EXESUF): tests/ptimer-test.o tests/ptimer-test-stubs.o hw/core/ptimer.o $(test-util-obj-y)
 
 tests/test-logging$(EXESUF): tests/test-logging.o $(test-util-obj-y)
 
-- 
1.8.3.1
