Received: from eggs.gnu.org ([2001:4830:134:3::10]:43877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPt-0003P9-9Y
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPk-0003iN-AG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:25 -0500
Received: from clearmind.me ([178.32.49.9]:43007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cilPj-0003gs-Li
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:16 -0500
From: Alessandro Di Federico <ale+qemu@clearmind.me>
Date: Tue, 28 Feb 2017 18:19:21 +0100
Message-Id: <20170228171921.21602-8-ale+qemu@clearmind.me>
In-Reply-To: <20170228171921.21602-1-ale+qemu@clearmind.me>
References: <20170228171921.21602-1-ale+qemu@clearmind.me>
Sender: ale@clearmind.me
Subject: [Qemu-devel] [PATCH 7/7] Introduce libtcg infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

* Extend the build system to build libtcg-$arch.so dynamic libraries.
* Introduce --enable-libtcg and --disable-libtcg the *-libtcg target,
  similar to *-linux-user and *-bsd-user, since it enables
  CONFIG_USER_ONLY, but uses only the TCG frontends (in particular the
  various target/$arch/translate.c files).
* If there's at least a *-libtcg target, compile everything as position
  independent code and with -fvisibility=hidden.
* In case we're building libtcg, install the output binary in the
  $PREFIX/lib directory instead of $PREFIX/bin.
* Reduce the number of object files linked into libtcg-$arch.so to the
  minimum. To achieve this, we break some dependency edges among
  translation units, for instance by replacing references to helper
  functions with NULL pointers (see the HELPER_REF macro). We also
  disable some portions of the code uninteresting to libtcg users (e.g.,
  the various cpu_*_dump functions).
* Introduce and install the libtcg.h header to use libtcg. Note that the
  only function exported by the libtcg library is libtcg_init, all the
  others have to be accessed through an interface data structure.
* Introduce tests to load all the compiled versions of the libtcg
  library and try to translate the code for some architectures.
* Make the tb_alloc function available outside translate-all.c.
---
 Makefile                                |   9 ++
 Makefile.target                         |  45 +++++-
 configure                               |  20 +++
 crypto/Makefile.objs                    |   2 +-
 default-configs/aarch64-libtcg.mak      |   0
 default-configs/alpha-libtcg.mak        |   0
 default-configs/arm-libtcg.mak          |   0
 default-configs/armeb-libtcg.mak        |   0
 default-configs/cris-libtcg.mak         |   0
 default-configs/hppa-libtcg.mak         |   0
 default-configs/i386-libtcg.mak         |   0
 default-configs/m68k-libtcg.mak         |   0
 default-configs/microblaze-libtcg.mak   |   0
 default-configs/microblazeel-libtcg.mak |   0
 default-configs/mips-libtcg.mak         |   0
 default-configs/mips64-libtcg.mak       |   0
 default-configs/mips64el-libtcg.mak     |   0
 default-configs/mipsel-libtcg.mak       |   0
 default-configs/mipsn32-libtcg.mak      |   0
 default-configs/mipsn32el-libtcg.mak    |   0
 default-configs/nios2-libtcg.mak        |   0
 default-configs/or1k-libtcg.mak         |   0
 default-configs/or32-libtcg.mak         |   0
 default-configs/ppc-libtcg.mak          |   1 +
 default-configs/ppc64-libtcg.mak        |   1 +
 default-configs/ppc64abi32-libtcg.mak   |   1 +
 default-configs/ppc64le-libtcg.mak      |   1 +
 default-configs/s390x-libtcg.mak        |   0
 default-configs/sh4-libtcg.mak          |   0
 default-configs/sh4eb-libtcg.mak        |   0
 default-configs/sparc-libtcg.mak        |   0
 default-configs/sparc32plus-libtcg.mak  |   0
 default-configs/sparc64-libtcg.mak      |   0
 default-configs/tilegx-libtcg.mak       |   0
 default-configs/unicore32-libtcg.mak    |   0
 default-configs/x86_64-libtcg.mak       |   0
 hw/core/Makefile.objs                   |   5 +-
 include/exec/helper-gen.h               |  12 +-
 include/exec/helper-head.h              |   8 ++
 include/exec/helper-tcg.h               |  12 +-
 include/libtcg.h                        | 109 +++++++++++++++
 include/tcg-common.h                    |   3 +
 libtcg/Makefile.objs                    |   1 +
 libtcg/libtcg.c                         | 226 ++++++++++++++++++++++++++++++
 libtcg/qemu.h                           |   7 +
 qom/cpu.c                               |   4 +-
 target/alpha/Makefile.objs              |   8 +-
 target/alpha/cpu.c                      |   6 +-
 target/alpha/translate.c                |   2 +
 target/arm/Makefile.objs                |  21 ++-
 target/arm/coprocessors.c               |  12 ++
 target/arm/cpu.c                        |  20 ++-
 target/arm/cpu64.c                      |   2 +
 target/arm/translate.c                  |   2 +
 target/cris/Makefile.objs               |   9 +-
 target/cris/cpu.c                       |  28 +++-
 target/cris/translate.c                 |   2 +
 target/hppa/Makefile.objs               |   6 +-
 target/hppa/cpu.c                       |  10 +-
 target/hppa/translate.c                 |   2 +
 target/i386/Makefile.objs               |  15 +-
 target/i386/cpu.c                       |  24 +++-
 target/i386/translate.c                 |   2 +
 target/lm32/Makefile.objs               |  11 +-
 target/lm32/translate.c                 |   2 +
 target/m68k/Makefile.objs               |   6 +-
 target/m68k/cpu.c                       |  12 +-
 target/m68k/translate.c                 |   2 +
 target/microblaze/Makefile.objs         |   9 +-
 target/microblaze/cpu.c                 |   6 +-
 target/microblaze/translate.c           |   2 +
 target/mips/Makefile.objs               |  10 +-
 target/mips/cpu.c                       |   8 +-
 target/mips/translate.c                 |   2 +
 target/moxie/Makefile.objs              |   8 +-
 target/moxie/translate.c                |   2 +
 target/nios2/Makefile.objs              |   6 +-
 target/nios2/cpu.c                      |  17 ++-
 target/nios2/translate.c                |   2 +
 target/openrisc/Makefile.objs           |  11 +-
 target/openrisc/cpu.c                   |   7 +-
 target/openrisc/translate.c             |   2 +
 target/ppc/Makefile.objs                |  19 +--
 target/ppc/translate.c                  |   2 +
 target/ppc/translate_init.c             |  16 ++-
 target/s390x/Makefile.objs              |  16 ++-
 target/s390x/cpu.c                      |   8 +-
 target/s390x/translate.c                |   2 +
 target/sh4/Makefile.objs                |   7 +-
 target/sh4/cpu.c                        |  10 +-
 target/sh4/translate.c                  |   2 +
 target/sparc/Makefile.objs              |  13 +-
 target/sparc/cpu.c                      |  12 +-
 target/sparc/translate.c                |   2 +
 target/tilegx/Makefile.objs             |   6 +-
 target/tilegx/cpu.c                     |  12 +-
 target/tilegx/translate.c               |  12 +-
 target/tricore/Makefile.objs            |   6 +-
 target/tricore/translate.c              |   2 +
 target/unicore32/Makefile.objs          |   7 +-
 target/unicore32/cpu.c                  |   6 +-
 target/unicore32/translate.c            |   2 +
 target/xtensa/Makefile.objs             |  13 +-
 target/xtensa/translate.c               |   2 +
 tcg/tcg.c                               |   8 +-
 tcg/tcg.h                               |   1 +
 tests/Makefile.include                  |   7 +-
 tests/test-libtcg.c                     | 238 ++++++++++++++++++++++++++++++++
 trace/Makefile.objs                     |   2 +-
 translate-all.c                         |   2 +-
 110 files changed, 1068 insertions(+), 130 deletions(-)
 create mode 100644 default-configs/aarch64-libtcg.mak
 create mode 100644 default-configs/alpha-libtcg.mak
 create mode 100644 default-configs/arm-libtcg.mak
 create mode 100644 default-configs/armeb-libtcg.mak
 create mode 100644 default-configs/cris-libtcg.mak
 create mode 100644 default-configs/hppa-libtcg.mak
 create mode 100644 default-configs/i386-libtcg.mak
 create mode 100644 default-configs/m68k-libtcg.mak
 create mode 100644 default-configs/microblaze-libtcg.mak
 create mode 100644 default-configs/microblazeel-libtcg.mak
 create mode 100644 default-configs/mips-libtcg.mak
 create mode 100644 default-configs/mips64-libtcg.mak
 create mode 100644 default-configs/mips64el-libtcg.mak
 create mode 100644 default-configs/mipsel-libtcg.mak
 create mode 100644 default-configs/mipsn32-libtcg.mak
 create mode 100644 default-configs/mipsn32el-libtcg.mak
 create mode 100644 default-configs/nios2-libtcg.mak
 create mode 100644 default-configs/or1k-libtcg.mak
 create mode 100644 default-configs/or32-libtcg.mak
 create mode 100644 default-configs/ppc-libtcg.mak
 create mode 100644 default-configs/ppc64-libtcg.mak
 create mode 100644 default-configs/ppc64abi32-libtcg.mak
 create mode 100644 default-configs/ppc64le-libtcg.mak
 create mode 100644 default-configs/s390x-libtcg.mak
 create mode 100644 default-configs/sh4-libtcg.mak
 create mode 100644 default-configs/sh4eb-libtcg.mak
 create mode 100644 default-configs/sparc-libtcg.mak
 create mode 100644 default-configs/sparc32plus-libtcg.mak
 create mode 100644 default-configs/sparc64-libtcg.mak
 create mode 100644 default-configs/tilegx-libtcg.mak
 create mode 100644 default-configs/unicore32-libtcg.mak
 create mode 100644 default-configs/x86_64-libtcg.mak
 create mode 100644 include/libtcg.h
 create mode 100644 libtcg/Makefile.objs
 create mode 100644 libtcg/libtcg.c
 create mode 100644 libtcg/qemu.h
 create mode 100644 tests/test-libtcg.c

diff --git a/Makefile b/Makefile
index 1c4c04f6f2..5c5ac8ae80 100644
--- a/Makefile
+++ b/Makefile
@@ -26,7 +26,16 @@ endif
 
 CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
 CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_DIRS)),y)
+CONFIG_LIBTCG := $(if $(filter %-libtcg,$(TARGET_DIRS)),y)
 CONFIG_ALL=y
+
+# If there's at least a *-libtcg target we need to build everything with -fPIC
+# and with default visibility hidden, so that we don't export symbols that are
+# not needed
+ifeq ($(CONFIG_LIBTCG),y)
+QEMU_CFLAGS += -fPIC -fvisibility=hidden
+endif
+
 -include config-all-devices.mak
 -include config-all-disas.mak
 
diff --git a/Makefile.target b/Makefile.target
index cf8adc3ced..c02cb679cd 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -15,10 +15,24 @@ QEMU_CFLAGS += -I.. -I$(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEED_CPU_H
 
 QEMU_CFLAGS+=-I$(SRC_PATH)/include
 
+# By default install in bindir
+PROGS_INSTALL_DIR := $(bindir)
+
 ifdef CONFIG_USER_ONLY
+ifdef CONFIG_LIBTCG
+# libtcg
+QEMU_PROG=libtcg-$(TARGET_NAME)$(DSOSUF).$(VERSION)
+QEMU_PROG_BUILD = $(QEMU_PROG)
+QEMU_CFLAGS += -fPIC -fvisibility=hidden
+LIBTCG_SONAME=libtcg-$(TARGET_NAME)$(DSOSUF).0
+
+# Change the install directory
+PROGS_INSTALL_DIR := $(libdir)
+else
 # user emulator name
 QEMU_PROG=qemu-$(TARGET_NAME)
 QEMU_PROG_BUILD = $(QEMU_PROG)
+endif
 else
 # system emulator name
 QEMU_PROG=qemu-system-$(TARGET_NAME)$(EXESUF)
@@ -88,18 +102,22 @@ all: $(PROGS) stap
 
 #########################################################
 # cpu emulator library
-obj-y = exec.o translate-all.o cpu-exec.o
+obj-y = exec.o translate-all.o
 obj-$(call land,$(CONFIG_USER_ONLY),$(call lnot,$(CONFIG_BSD_USER))) += mmap.o
+ifndef CONFIG_LIBTCG
+obj-y += cpu-exec.o
+obj-y += tcg-runtime.o
+obj-y += fpu/softfloat.o
+obj-y += tcg/optimize.o
+endif
 obj-y += translate-common.o
 obj-y += cpu-exec-common.o
-obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
+obj-y += tcg/tcg.o tcg/tcg-op.o
 obj-$(CONFIG_TCG_INTERPRETER) += tci.o
 obj-y += tcg/tcg-common.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
-obj-y += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
-obj-y += tcg-runtime.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
@@ -138,6 +156,19 @@ obj-y += gdbstub.o user-exec.o user-exec-stub.o
 endif #CONFIG_BSD_USER
 
 #########################################################
+# libtcg target
+
+ifdef CONFIG_LIBTCG
+
+QEMU_CFLAGS+=-I$(SRC_PATH)/libtcg
+
+obj-y += libtcg/
+
+LDFLAGS+=$(LDFLAGS_SHARED) -Wl,-soname,$(LIBTCG_SONAME)
+
+endif #CONFIG_LIBTCG
+
+#########################################################
 # System emulator target
 ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
@@ -230,8 +261,12 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 endif
 
 install: all
+ifdef CONFIG_LIBTCG
+	mkdir -p "$(DESTDIR)$(includedir)"
+	$(INSTALL_DATA) $(SRC_PATH)/include/tcg-opc.h $(SRC_PATH)/include/libtcg.h $(SRC_PATH)/include/tcg-common.h "$(DESTDIR)$(includedir)"
+endif
 ifneq ($(PROGS),)
-	$(call install-prog,$(PROGS),$(DESTDIR)$(bindir))
+	$(call install-prog,$(PROGS),$(DESTDIR)$(PROGS_INSTALL_DIR))
 endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset"
diff --git a/configure b/configure
index 4b68861992..d848a4f0be 100755
--- a/configure
+++ b/configure
@@ -265,6 +265,7 @@ cocoa="no"
 softmmu="yes"
 linux_user="no"
 bsd_user="no"
+libtcg="no"
 aix="no"
 blobs="yes"
 pkgversion=""
@@ -678,6 +679,7 @@ Haiku)
   audio_possible_drivers="oss alsa sdl pa"
   linux="yes"
   linux_user="yes"
+  libtcg="yes"
   kvm="yes"
   vhost_net="yes"
   vhost_scsi="yes"
@@ -971,6 +973,10 @@ for opt do
   ;;
   --enable-bsd-user) bsd_user="yes"
   ;;
+  --disable-libtcg) libtcg="no"
+  ;;
+  --enable-libtcg) libtcg="yes"
+  ;;
   --enable-pie) pie="yes"
   ;;
   --disable-pie) pie="no"
@@ -1247,6 +1253,7 @@ EXTRA_CFLAGS="$CPU_CFLAGS $EXTRA_CFLAGS"
 if [ "$ARCH" = "unknown" ]; then
   bsd_user="no"
   linux_user="no"
+  libtcg="no"
 fi
 
 default_target_list=""
@@ -1262,6 +1269,9 @@ fi
 if [ "$bsd_user" = "yes" ]; then
     mak_wilds="${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
 fi
+if [ "$libtcg" = "yes" ]; then
+    mak_wilds="${mak_wilds} $source_path/default-configs/*-libtcg.mak"
+fi
 
 for config in $mak_wilds; do
     default_target_list="${default_target_list} $(basename "$config" .mak)"
@@ -1403,6 +1413,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   tcmalloc        tcmalloc support
   jemalloc        jemalloc support
   replication     replication support
+  libtcg          standalone TCG library
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -5114,6 +5125,7 @@ echo "tcmalloc support  $tcmalloc"
 echo "jemalloc support  $jemalloc"
 echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
+echo "libtcg enabled    $libtcg"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -5851,6 +5863,7 @@ target_softmmu="no"
 target_user_only="no"
 target_linux_user="no"
 target_bsd_user="no"
+target_libtcg="no"
 case "$target" in
   ${target_name}-softmmu)
     target_softmmu="yes"
@@ -5869,6 +5882,10 @@ case "$target" in
     target_user_only="yes"
     target_bsd_user="yes"
     ;;
+  ${target_name}-libtcg)
+    target_user_only="yes"
+    target_libtcg="yes"
+    ;;
   *)
     error_exit "Target '$target' not recognised"
     exit 1
@@ -6074,6 +6091,9 @@ fi
 if test "$target_linux_user" = "yes" ; then
   echo "CONFIG_LINUX_USER=y" >> $config_target_mak
 fi
+if test "$target_libtcg" = "yes" ; then
+  echo "CONFIG_LIBTCG=y" >> $config_target_mak
+fi
 list=""
 if test ! -z "$gdb_xml_files" ; then
   for x in $gdb_xml_files; do
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 1f749f2087..2f654db9af 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -7,7 +7,7 @@ crypto-obj-y += hmac.o
 crypto-obj-$(CONFIG_NETTLE) += hmac-nettle.o
 crypto-obj-$(CONFIG_GCRYPT_HMAC) += hmac-gcrypt.o
 crypto-obj-$(if $(CONFIG_NETTLE),n,$(if $(CONFIG_GCRYPT_HMAC),n,y)) += hmac-glib.o
-crypto-obj-y += aes.o
+crypto-obj-$(call lnot,$(CONFIG_LIBTCG)) += aes.o
 crypto-obj-y += desrfb.o
 crypto-obj-y += cipher.o
 crypto-obj-y += tlscreds.o
diff --git a/default-configs/aarch64-libtcg.mak b/default-configs/aarch64-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/alpha-libtcg.mak b/default-configs/alpha-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/arm-libtcg.mak b/default-configs/arm-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/armeb-libtcg.mak b/default-configs/armeb-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/cris-libtcg.mak b/default-configs/cris-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/hppa-libtcg.mak b/default-configs/hppa-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/i386-libtcg.mak b/default-configs/i386-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/m68k-libtcg.mak b/default-configs/m68k-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/microblaze-libtcg.mak b/default-configs/microblaze-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/microblazeel-libtcg.mak b/default-configs/microblazeel-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/mips-libtcg.mak b/default-configs/mips-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/mips64-libtcg.mak b/default-configs/mips64-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/mips64el-libtcg.mak b/default-configs/mips64el-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/mipsel-libtcg.mak b/default-configs/mipsel-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/mipsn32-libtcg.mak b/default-configs/mipsn32-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/mipsn32el-libtcg.mak b/default-configs/mipsn32el-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/nios2-libtcg.mak b/default-configs/nios2-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/or1k-libtcg.mak b/default-configs/or1k-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/or32-libtcg.mak b/default-configs/or32-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/ppc-libtcg.mak b/default-configs/ppc-libtcg.mak
new file mode 100644
index 0000000000..7235c56d55
--- /dev/null
+++ b/default-configs/ppc-libtcg.mak
@@ -0,0 +1 @@
+CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppc64-libtcg.mak b/default-configs/ppc64-libtcg.mak
new file mode 100644
index 0000000000..7235c56d55
--- /dev/null
+++ b/default-configs/ppc64-libtcg.mak
@@ -0,0 +1 @@
+CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppc64abi32-libtcg.mak b/default-configs/ppc64abi32-libtcg.mak
new file mode 100644
index 0000000000..7235c56d55
--- /dev/null
+++ b/default-configs/ppc64abi32-libtcg.mak
@@ -0,0 +1 @@
+CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/ppc64le-libtcg.mak b/default-configs/ppc64le-libtcg.mak
new file mode 100644
index 0000000000..7235c56d55
--- /dev/null
+++ b/default-configs/ppc64le-libtcg.mak
@@ -0,0 +1 @@
+CONFIG_LIBDECNUMBER=y
diff --git a/default-configs/s390x-libtcg.mak b/default-configs/s390x-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/sh4-libtcg.mak b/default-configs/sh4-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/sh4eb-libtcg.mak b/default-configs/sh4eb-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/sparc-libtcg.mak b/default-configs/sparc-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/sparc32plus-libtcg.mak b/default-configs/sparc32plus-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/sparc64-libtcg.mak b/default-configs/sparc64-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/tilegx-libtcg.mak b/default-configs/tilegx-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/unicore32-libtcg.mak b/default-configs/unicore32-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/x86_64-libtcg.mak b/default-configs/x86_64-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 91450b2eab..71d5f65ccb 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -1,11 +1,14 @@
 # core qdev-related obj files, also used by *-user:
-common-obj-y += qdev.o qdev-properties.o
+common-obj-y += qdev-properties.o
+#ifndef CONFIG_LIBTCG
 common-obj-y += bus.o reset.o
+common-obj-y += qdev.o
 common-obj-y += fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y += irq.o
 common-obj-y += hotplug.o
 obj-y += nmi.o
+#endif
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) += stream.o
diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 8239ffc77c..ac290180b3 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -9,7 +9,7 @@
 #define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 0, NULL);       \
+  tcg_gen_callN(&tcg_ctx, HELPER_REF(name), dh_retvar(ret), 0, NULL);   \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
@@ -17,7 +17,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
   TCGArg args[1] = { dh_arg(t1, 1) };                                   \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 1, args);       \
+  tcg_gen_callN(&tcg_ctx, HELPER_REF(name), dh_retvar(ret), 1, args);   \
 }
 
 #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
@@ -25,7 +25,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
   TCGArg args[2] = { dh_arg(t1, 1), dh_arg(t2, 2) };                    \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 2, args);       \
+  tcg_gen_callN(&tcg_ctx, HELPER_REF(name), dh_retvar(ret), 2, args);   \
 }
 
 #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
@@ -33,7 +33,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
   TCGArg args[3] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3) };     \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 3, args);       \
+  tcg_gen_callN(&tcg_ctx, HELPER_REF(name), dh_retvar(ret), 3, args);   \
 }
 
 #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
@@ -43,7 +43,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 {                                                                       \
   TCGArg args[4] = { dh_arg(t1, 1), dh_arg(t2, 2),                      \
                      dh_arg(t3, 3), dh_arg(t4, 4) };                    \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 4, args);       \
+  tcg_gen_callN(&tcg_ctx, HELPER_REF(name), dh_retvar(ret), 4, args);   \
 }
 
 #define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
@@ -53,7 +53,7 @@ static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
 {                                                                       \
   TCGArg args[5] = { dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),       \
                      dh_arg(t4, 4), dh_arg(t5, 5) };                    \
-  tcg_gen_callN(&tcg_ctx, HELPER(name), dh_retvar(ret), 5, args);       \
+  tcg_gen_callN(&tcg_ctx, HELPER_REF(name), dh_retvar(ret), 5, args);   \
 }
 
 #include "helper.h"
diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index 1cfc43b9ff..26bd3a47b1 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -20,6 +20,14 @@
 
 #define HELPER(name) glue(helper_, name)
 
+/* In libtcg we don't want helpers, therefore we leave these fields empty so
+ * that we don't needlessly introduce a dependency towards the helper. */
+#ifdef CONFIG_LIBTCG
+# define HELPER_REF(helper) (NULL)
+#else
+# define HELPER_REF(helper) (HELPER(helper))
+#endif
+
 #define GET_TCGV_i32 GET_TCGV_I32
 #define GET_TCGV_i64 GET_TCGV_I64
 #define GET_TCGV_ptr GET_TCGV_PTR
diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
index bb9287727c..ebc7b45d1a 100644
--- a/include/exec/helper-tcg.h
+++ b/include/exec/helper-tcg.h
@@ -7,30 +7,30 @@
 #include "exec/helper-head.h"
 
 #define DEF_HELPER_FLAGS_0(NAME, FLAGS, ret) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER_REF(NAME), .name = #NAME, .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) },
 
 #define DEF_HELPER_FLAGS_1(NAME, FLAGS, ret, t1) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER_REF(NAME), .name = #NAME, .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) },
 
 #define DEF_HELPER_FLAGS_2(NAME, FLAGS, ret, t1, t2) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER_REF(NAME), .name = #NAME, .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) },
 
 #define DEF_HELPER_FLAGS_3(NAME, FLAGS, ret, t1, t2, t3) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER_REF(NAME), .name = #NAME, .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) },
 
 #define DEF_HELPER_FLAGS_4(NAME, FLAGS, ret, t1, t2, t3, t4) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER_REF(NAME), .name = #NAME, .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) },
 
 #define DEF_HELPER_FLAGS_5(NAME, FLAGS, ret, t1, t2, t3, t4, t5) \
-  { .func = HELPER(NAME), .name = #NAME, .flags = FLAGS, \
+  { .func = HELPER_REF(NAME), .name = #NAME, .flags = FLAGS, \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) \
     | dh_sizemask(t5, 5) },
diff --git a/include/libtcg.h b/include/libtcg.h
new file mode 100644
index 0000000000..8996742cbd
--- /dev/null
+++ b/include/libtcg.h
@@ -0,0 +1,109 @@
+#ifndef LIBTCG_H
+#define LIBTCG_H
+
+#include <stdint.h>
+#include <sys/mman.h>
+
+#define PREFIX(x) LibTCG ## x
+#define PREFIX2(x) LIBTCG_ ## x
+#define PREFIX3(x) LIBTCG_ ## x
+
+typedef uint8_t PREFIX(Reg);
+
+#include "tcg-common.h"
+
+#undef PREFIX
+#undef PREFIX2
+#undef PREFIX3
+
+/**
+ * This is a reduced version of TCGOp
+ */
+typedef struct LibTCGOp {
+    LibTCGOpcode opc:8;
+
+    /* The number of out and in parameter for a call. */
+    unsigned calli:4;
+    unsigned callo:2;
+
+    LibTCGArg *args;
+} LibTCGOp;
+
+/**
+ * Data structure holding a list of instructions, along with their arguments,
+ * global and local variables
+ */
+typedef struct {
+    LibTCGOp *instructions;
+    unsigned instruction_count;
+
+    /* Additional data, do not access this directly */
+    LibTCGArg *arguments;
+    LibTCGTemp *temps;
+    unsigned global_temps;
+    unsigned total_temps;
+} LibTCGInstructions;
+
+/**
+ * Pair of an address in the emulated address space, and the corresponding
+ * address in the host address space
+ */
+typedef struct {
+    uint64_t virtual_address;
+    void *pointer;
+} address_pair;
+
+/**
+ * Maps a page in the emulated address space, if possible at @start. See mmap(2)
+ * for further documentation.
+ *
+ * @return an address pair, i.e., the start of the mmap'd region in terms of the
+ *         host and emulated address space.
+ */
+typedef address_pair (*libtcg_mmap_func)(uint64_t start, uint64_t len, int prot,
+                                         int flags, int fd, off_t offset);
+
+/**
+ * Translates the basic block starting at @virtual_address into tiny code
+ * instructions.
+ *
+ * @param virtual_address: the starting address of the basic block, in terms of
+ *        the emulated address space.
+ *
+ * @return an instance of LibTCGInstructions containing the list generated of
+ *         tiny code instructions. The caller is responsible to call
+ *         free_instructions on this object when it's no longer needed.
+ */
+typedef LibTCGInstructions (*libtcg_translate_func)(uint64_t virtual_address);
+
+/**
+ * Releases the memory hold by @instructions.
+ */
+typedef void (*libtcg_free_instructions_func)(LibTCGInstructions *instructions);
+
+typedef struct {
+    libtcg_mmap_func mmap;
+    libtcg_translate_func translate;
+    libtcg_free_instructions_func free_instructions;
+} LibTCGInterface;
+
+/**
+ * Initializes libtcg to generate code for @cpu_name.
+ *
+ * This is the only function exported by libtcg. Users are supposed to obtain
+ * its address through dlsym(3), in this way multiple versions of libtcg can be
+ * used at the same time by initializing them and using the appropriate
+ * LibTCGInterface object.
+ *
+ * @param cpu_name: the name of the CPU to emulate. For a complete list invoke
+ *        the qemu-user binary (e.g., qemu-arm) with the -cpu help option.
+ * @param start_address: starting point for the guest address space, if in
+ *        doubt, 0xb0000000 is usually a good value.
+ *
+ * @return an pointer to LibTCGInterface, which the caller can use to call the
+ *         other functions exposed by libtcg.
+ */
+typedef const LibTCGInterface *(*libtcg_init_func)(const char *cpu_name,
+                                                   intptr_t start_address);
+
+#endif /* LIBTCG_H */
diff --git a/include/tcg-common.h b/include/tcg-common.h
index 856c4974a0..86face7f8a 100644
--- a/include/tcg-common.h
+++ b/include/tcg-common.h
@@ -71,12 +71,15 @@ typedef enum PREFIX(Type) {
 #endif
 
     /* An alias for the size of the target "long", aka register.  */
+#ifdef TARGET_LONG_BITS
 #if TARGET_LONG_BITS == 64
     PREFIX2(TYPE_TL) = PREFIX2(TYPE_I64),
 #else
     PREFIX2(TYPE_TL) = PREFIX2(TYPE_I32),
 #endif
 #endif
+
+#endif
 } PREFIX(Type);
 
 typedef struct PREFIX(Temp) {
diff --git a/libtcg/Makefile.objs b/libtcg/Makefile.objs
new file mode 100644
index 0000000000..b08a87d936
--- /dev/null
+++ b/libtcg/Makefile.objs
@@ -0,0 +1 @@
+obj-y += libtcg.o
diff --git a/libtcg/libtcg.c b/libtcg/libtcg.c
new file mode 100644
index 0000000000..0b451c75ce
--- /dev/null
+++ b/libtcg/libtcg.c
@@ -0,0 +1,226 @@
+#include "qemu/osdep.h"
+#include <assert.h>
+#include <glib.h>
+#include "qemu.h"
+#include "exec/exec-all.h"
+
+#include "libtcg.h"
+
+#define REINTERPRET(type, value) (*((type *) &(value)))
+
+/* Functions and global variables we need to provide */
+unsigned long guest_base;
+int singlestep;
+unsigned long mmap_min_addr;
+unsigned long reserved_va;
+
+void cpu_resume(CPUState *cpu)
+{
+    abort();
+}
+
+bool qemu_cpu_is_self(CPUState *cpu)
+{
+    abort();
+}
+
+void qemu_cpu_kick(CPUState *cpu)
+{
+}
+
+void qemu_init_vcpu(CPUState *cpu)
+{
+}
+
+static CPUState *cpu;
+
+/* Interface functions */
+const LibTCGInterface *libtcg_init(const char *cpu_name,
+                                   intptr_t start_address);
+static address_pair libtcg_mmap(uint64_t start, uint64_t len, int prot,
+                                int flags, int fd, off_t offset);
+static LibTCGInstructions libtcg_translate(uint64_t virtual_address);
+static void libtcg_free_instructions(LibTCGInstructions *instructions);
+
+/* The interface object return by libtcg_init */
+static LibTCGInterface interface;
+
+/* This is the only function exposed by the library */
+__attribute__((visibility("default")))
+const LibTCGInterface *libtcg_init(const char *cpu_name,
+                                   intptr_t start_address)
+{
+    /* TODO: support changing CPU */
+    assert(cpu == NULL);
+
+    /* Initialize guest_base. Since libtcg only translates buffers of code, and
+     * doesn't have the full view over the program being translated as
+     * {linux,bsd}-user have, we let the user mmap the code. */
+    assert(start_address <= UINT_MAX);
+    guest_base = (unsigned long) start_address;
+
+    /* Initialize the TCG subsystem using the default translation buffer size */
+    tcg_exec_init(0);
+
+    /* Initialize the QOM subsystem */
+    module_call_init(MODULE_INIT_QOM);
+
+    /* Initialize the CPU with the given name. This is a call to the
+     * cpu_*_init function */
+    cpu = cpu_init(cpu_name);
+    assert(cpu != NULL);
+
+    /* Initialize the interface object */
+    interface.mmap = libtcg_mmap;
+    interface.translate = libtcg_translate;
+    interface.free_instructions = libtcg_free_instructions;
+
+    /* Return a reference to the interface object */
+    return &interface;
+}
+
+static address_pair libtcg_mmap(uint64_t start, uint64_t len, int prot,
+                                int flags, int fd, off_t offset)
+{
+    address_pair result;
+    result.virtual_address = target_mmap(start, len, prot, flags, fd, offset);
+    result.pointer = g2h(result.virtual_address);
+    return result;
+}
+
+static TranslationBlock *do_gen_code(TCGContext *context, CPUState *cpu,
+                                     target_ulong pc, target_ulong cs_base,
+                                     int flags, int cflags)
+{
+    CPUArchState *env = cpu->env_ptr;
+
+    /* We don't care about caching translation blocks, flush out the cache */
+    tb_flush(cpu);
+
+    /* Allocate a new translation block and get a pointer to it */
+    TranslationBlock *tb = tb_alloc(pc);
+
+    /* Configure translation options */
+    tb->cs_base = cs_base;
+    tb->flags = flags;
+    tb->cflags = cflags;
+
+    /* Clean the translation context */
+    tcg_func_start(context);
+
+    /* Invoke the frontend-specific gen_intermediate_code function to perform
+     * the actual translation to tiny code instructions */
+    gen_intermediate_code(env, tb);
+
+    /* Return the TranslationBlock */
+    return tb;
+}
+
+static LibTCGInstructions libtcg_translate(uint64_t virtual_address)
+{
+    TCGContext *context = &tcg_ctx;
+
+    /* Get the flags defining in which context the code was generated */
+    target_ulong temp;
+    uint32_t flags = 0;
+    cpu_get_tb_cpu_state(cpu->env_ptr, &temp, &temp, &flags);
+
+    /* Perform the translation forcing the pc and with cs_base and cflags set to
+     * 0 */
+    TranslationBlock *tb = do_gen_code(context, cpu,
+                                       (target_ulong) virtual_address, 0, flags,
+                                       0);
+
+    LibTCGInstructions result;
+    unsigned arguments_count = 0;
+
+    /* First, count the instructions and the arguments, so we can allocate an
+     * appropriate amount of space */
+    TCGOp *op = NULL;
+    for (unsigned i = context->gen_op_buf[0].next; i != 0; i = op->next) {
+        result.instruction_count++;
+
+        op = &context->gen_op_buf[i];
+        TCGOpcode c = op->opc;
+        const TCGOpDef *def = &tcg_op_defs[c];
+
+        if (c == INDEX_op_insn_start) {
+            arguments_count += 2;
+        } else if (c == INDEX_op_call) {
+            arguments_count += op->callo + op->calli + def->nb_cargs;
+        } else {
+            arguments_count += def->nb_oargs + def->nb_iargs + def->nb_cargs;
+        }
+    }
+
+    /* Allocate space for the instructions and arguments data structures */
+    result.instructions = (LibTCGOp *) g_new0(LibTCGOp,
+                                              result.instruction_count);
+    result.arguments = (LibTCGArg *) g_new0(LibTCGArg, arguments_count);
+
+    /* Copy the temp values */
+    result.total_temps = context->nb_temps;
+    result.global_temps = context->nb_globals;
+    result.temps = (LibTCGTemp *) g_new0(LibTCGTemp, result.total_temps);
+
+    for (unsigned i = 0; i < result.total_temps; i++) {
+        result.temps[i] = REINTERPRET(LibTCGTemp, context->temps[i]);
+    }
+
+    /* Go through all the instructions again and copy to the output buffers */
+    result.instruction_count = 0;
+    unsigned total_arguments_count = 0;
+    op = NULL;
+    for (unsigned i = context->gen_op_buf[0].next; i != 0; i = op->next) {
+        /* Get the pointer to the output LibTCGOp object */
+        LibTCGOp *current_instruction = NULL;
+        current_instruction = &result.instructions[result.instruction_count];
+        result.instruction_count++;
+
+        op = &context->gen_op_buf[i];
+        TCGArg *args = &context->gen_opparam_buf[op->args];
+
+        current_instruction->opc = (LibTCGOpcode) op->opc;
+        current_instruction->callo = op->callo;
+        current_instruction->calli = op->calli;
+        current_instruction->args = &result.arguments[total_arguments_count];
+
+        /* Compute the number of arguments for this instruction */
+        TCGOpcode opcode = current_instruction->opc;
+        const TCGOpDef *def = &tcg_op_defs[opcode];
+        unsigned arguments_count = 0;
+        if (opcode == INDEX_op_insn_start) {
+            arguments_count = 2;
+        } else if (opcode == INDEX_op_call) {
+            arguments_count += current_instruction->callo;
+            arguments_count += current_instruction->calli;
+            arguments_count += def->nb_cargs;
+        } else {
+            arguments_count = def->nb_oargs + def->nb_iargs + def->nb_cargs;
+        }
+
+        /* Copy all the new arguments to the output buffer */
+        for (unsigned j = 0; j < arguments_count; j++) {
+            LibTCGArg argument = REINTERPRET(LibTCGArg, args[j]);
+            result.arguments[total_arguments_count + j] = argument;
+        }
+
+        /* Increment the counter of the total number of arguments */
+        total_arguments_count += arguments_count;
+    }
+
+    /* Free the TranslationBlock */
+    tb_free(tb);
+
+    return result;
+}
+
+void libtcg_free_instructions(LibTCGInstructions *instructions)
+{
+    assert(instructions != NULL);
+    g_free(instructions->instructions);
+    g_free(instructions->arguments);
+    g_free(instructions->temps);
+}
+
+#undef REINTERPRET
diff --git a/libtcg/qemu.h b/libtcg/qemu.h
new file mode 100644
index 0000000000..b32486959a
--- /dev/null
+++ b/libtcg/qemu.h
@@ -0,0 +1,7 @@
+#ifndef QEMU_H
+#define QEMU_H
+
+/* Everything we need is currently provided by qemu-user-common.h */
+#include "qemu-user-common.h"
+
+#endif /* QEMU_H */
diff --git a/qom/cpu.c b/qom/cpu.c
index ed87c50cea..6e97e98b7c 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -386,7 +386,9 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
-    cpu->trace_dstate = bitmap_new(trace_get_vcpu_event_count());
+    uint32_t event_count = trace_get_vcpu_event_count();
+    if (event_count > 0)
+        cpu->trace_dstate = bitmap_new(event_count);
 
     cpu_exec_initfn(cpu);
 }
diff --git a/target/alpha/Makefile.objs b/target/alpha/Makefile.objs
index 63664629f6..476edf1b60 100644
--- a/target/alpha/Makefile.objs
+++ b/target/alpha/Makefile.objs
@@ -1,4 +1,8 @@
+obj-y += translate.o cpu.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o
-obj-y += translate.o helper.o cpu.o
-obj-y += int_helper.o fpu_helper.o vax_helper.o sys_helper.o mem_helper.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o int_helper.o fpu_helper.o vax_helper.o sys_helper.o mem_helper.o
 obj-y += gdbstub.o
+endif
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index a1125fca93..9e57be75e0 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -336,12 +336,14 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = alpha_cpu_class_by_name;
     cc->has_work = alpha_cpu_has_work;
+    cc->set_pc = alpha_cpu_set_pc;
+#ifndef CONFIG_LIBTCG
     cc->do_interrupt = alpha_cpu_do_interrupt;
     cc->cpu_exec_interrupt = alpha_cpu_exec_interrupt;
     cc->dump_state = alpha_cpu_dump_state;
-    cc->set_pc = alpha_cpu_set_pc;
     cc->gdb_read_register = alpha_cpu_gdb_read_register;
     cc->gdb_write_register = alpha_cpu_gdb_write_register;
+
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = alpha_cpu_handle_mmu_fault;
 #else
@@ -350,6 +352,8 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_phys_page_debug = alpha_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_alpha_cpu;
 #endif
+
+#endif
     cc->disas_set_info = alpha_cpu_disas_set_info;
 
     cc->gdb_num_core_regs = 67;
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index df06591997..92c011f597 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -3026,6 +3026,7 @@ void restore_state_to_opc(CPUAlphaState *env, TranslationBlock *tb,
     env->pc = data[0];
 }
 
+#ifndef CONFIG_LIBTCG
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                           int flags)
 {
@@ -3059,3 +3060,4 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     }
     cpu_fprintf(f, "\n");
 }
+#endif
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 82898a6a68..b7957fc3ce 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -1,12 +1,21 @@
-obj-y += arm-semi.o
+obj-y += translate.o cpu.o coprocessors.o
+obj-$(TARGET_AARCH64) += translate-a64.o
+obj-$(TARGET_AARCH64) += cpu64.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o psci.o arch_dump.o monitor.o
+obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) += kvm32.o
 obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) += kvm64.o
+
+ifndef CONFIG_LIBTCG
+
+obj-y += helper.o op_helper.o neon_helper.o iwmmxt_helper.o crypto_helper.o
+obj-$(TARGET_AARCH64) += helper-a64.o
+
+obj-y += arm-semi.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-obj-y += translate.o op_helper.o helper.o coprocessors.o cpu.o
-obj-y += neon_helper.o iwmmxt_helper.o
+
 obj-y += gdbstub.o
-obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
-obj-y += crypto_helper.o
-obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
+obj-$(TARGET_AARCH64) += gdbstub64.o
+endif
diff --git a/target/arm/coprocessors.c b/target/arm/coprocessors.c
index c2819f7ea2..53d99f220f 100644
--- a/target/arm/coprocessors.c
+++ b/target/arm/coprocessors.c
@@ -16,6 +16,7 @@
 #define PMCRE   0x1
 #endif
 
+#ifndef CONFIG_LIBTCG
 static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
 {
     int nregs;
@@ -109,6 +110,7 @@ static int aarch64_fpu_gdb_set_reg(CPUARMState *env, uint8_t *buf, int reg)
         return 0;
     }
 }
+#endif
 
 static uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
@@ -169,6 +171,7 @@ static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+#ifndef CONFIG_LIBTCG
 static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
 {
    /* Return true if the regdef would cause an assertion if you called
@@ -189,6 +192,7 @@ static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
     }
     return true;
 }
+#endif
 
 bool write_cpustate_to_list(ARMCPU *cpu)
 {
@@ -5225,6 +5229,7 @@ ARMCPU *cpu_arm_init(const char *cpu_model)
     return ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, cpu_model));
 }
 
+#ifndef CONFIG_LIBTCG
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -5245,6 +5250,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                  19, "arm-vfp.xml", 0);
     }
 }
+#endif
 
 /* Sort alphabetically by type name, except for "any". */
 static gint arm_cpu_list_compare(gconstpointer a, gconstpointer b)
@@ -5437,6 +5443,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
         r2->type |= ARM_CP_ALIAS;
     }
 
+#ifndef CONFIG_LIBTCG
     /* Check that raw accesses are either forbidden or handled. Note that
      * we can't assert this earlier because the setup of fieldoffset for
      * banked registers has to be done first.
@@ -5444,6 +5451,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     if (!(r2->type & ARM_CP_NO_RAW)) {
         assert(!raw_accessors_invalid(r2));
     }
+#endif
 
     /* Overriding of an existing definition must be explicitly
      * requested.
@@ -5545,6 +5553,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
         assert((r->access & ~mask) == 0);
     }
 
+#ifndef CONFIG_LIBTCG
     /* Check that the register definition has enough info to handle
      * reads and writes if they are permitted.
      */
@@ -5560,6 +5569,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                    r->writefn);
         }
     }
+#endif
     /* Bad type field probably means missing sentinel at end of reg list */
     assert(cptype_valid(r->type));
     for (crm = crmmin; crm <= crmmax; crm++) {
@@ -5629,6 +5639,7 @@ void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *opaque)
     /* Helper coprocessor reset function for do-nothing-on-reset registers */
 }
 
+#ifndef CONFIG_LIBTCG
 static int bad_mode_switch(CPUARMState *env, int mode, CPSRWriteType write_type)
 {
     /* Return true if it is not valid for us to switch to
@@ -5800,3 +5811,4 @@ void cpsr_write(CPUARMState *env, uint32_t val, uint32_t mask,
     mask &= ~CACHED_CPSR_BITS;
     env->uncached_cpsr = (env->uncached_cpsr & ~mask) | (val & mask);
 }
+#endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4a069f6985..be0a8fd04a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -249,6 +249,15 @@ static void arm_cpu_reset(CPUState *s)
     hw_watchpoint_update_all(cpu);
 }
 
+#ifdef CONFIG_LIBTCG
+
+bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    abort();
+}
+
+#else
+
 bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUClass *cc = CPU_GET_CLASS(cs);
@@ -302,6 +311,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
     return ret;
 }
+#endif
 
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
 static void arm_v7m_unassigned_access(CPUState *cpu, hwaddr addr,
@@ -820,7 +830,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     register_cp_regs_for_features(cpu);
+#ifndef CONFIG_LIBTCG
     arm_cpu_register_gdb_regs_for_features(cpu);
+#endif
 
     init_cpreg_list(cpu);
 
@@ -1653,10 +1665,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = arm_cpu_class_by_name;
     cc->has_work = arm_cpu_has_work;
     cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
-    cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
-    cc->gdb_read_register = arm_cpu_gdb_read_register;
-    cc->gdb_write_register = arm_cpu_gdb_write_register;
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = arm_cpu_handle_mmu_fault;
 #else
@@ -1673,8 +1682,13 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_core_xml_file = "arm-core.xml";
     cc->gdb_arch_name = arm_gdb_arch_name;
     cc->gdb_stop_before_watchpoint = true;
+#ifndef CONFIG_LIBTCG
+    cc->dump_state = arm_cpu_dump_state;
     cc->debug_excp_handler = arm_debug_excp_handler;
+    cc->gdb_read_register = arm_cpu_gdb_read_register;
+    cc->gdb_write_register = arm_cpu_gdb_write_register;
     cc->debug_check_watchpoint = arm_debug_check_watchpoint;
+#endif
 #if !defined(CONFIG_USER_ONLY)
     cc->adjust_watchpoint_address = arm_adjust_watchpoint_address;
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 670c07ab6e..fbf018d522 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -313,8 +313,10 @@ static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
     cc->set_pc = aarch64_cpu_set_pc;
+#ifndef CONFIG_LIBTCG
     cc->gdb_read_register = aarch64_cpu_gdb_read_register;
     cc->gdb_write_register = aarch64_cpu_gdb_write_register;
+#endif
     cc->gdb_num_core_regs = 34;
     cc->gdb_core_xml_file = "aarch64-core.xml";
     cc->gdb_arch_name = aarch64_gdb_arch_name;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 495f967eb6..990d44b257 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12085,6 +12085,7 @@ done_generating:
     tb->icount = num_insns;
 }
 
+#ifndef CONFIG_LIBTCG
 static const char *cpu_mode_names[16] = {
   "usr", "fiq", "irq", "svc", "???", "???", "mon", "abt",
   "???", "???", "hyp", "und", "???", "???", "???", "sys"
@@ -12148,6 +12149,7 @@ void arm_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         cpu_fprintf(f, "FPSCR: %08x\n", (int)env->vfp.xregs[ARM_VFP_FPSCR]);
     }
 }
+#endif
 
 void restore_state_to_opc(CPUARMState *env, TranslationBlock *tb,
                           target_ulong *data)
diff --git a/target/cris/Makefile.objs b/target/cris/Makefile.objs
index 7779227fc4..ec06586d23 100644
--- a/target/cris/Makefile.objs
+++ b/target/cris/Makefile.objs
@@ -1,3 +1,8 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
+obj-y += translate.o cpu.o
+
 obj-$(CONFIG_SOFTMMU) += mmu.o machine.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o op_helper.o
+obj-y += gdbstub.o
+endif
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 5f766f09d6..d3152a0cc9 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -213,52 +213,62 @@ static void cris_cpu_initfn(Object *obj)
 
 static void crisv8_cpu_class_init(ObjectClass *oc, void *data)
 {
-    CPUClass *cc = CPU_CLASS(oc);
     CRISCPUClass *ccc = CRIS_CPU_CLASS(oc);
 
     ccc->vr = 8;
+#ifndef CONFIG_LIBTCG
+    CPUClass *cc = CPU_CLASS(oc);
     cc->do_interrupt = crisv10_cpu_do_interrupt;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
+#endif
 }
 
 static void crisv9_cpu_class_init(ObjectClass *oc, void *data)
 {
-    CPUClass *cc = CPU_CLASS(oc);
     CRISCPUClass *ccc = CRIS_CPU_CLASS(oc);
 
     ccc->vr = 9;
+#ifndef CONFIG_LIBTCG
+    CPUClass *cc = CPU_CLASS(oc);
     cc->do_interrupt = crisv10_cpu_do_interrupt;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
+#endif
 }
 
 static void crisv10_cpu_class_init(ObjectClass *oc, void *data)
 {
-    CPUClass *cc = CPU_CLASS(oc);
     CRISCPUClass *ccc = CRIS_CPU_CLASS(oc);
 
     ccc->vr = 10;
+#ifndef CONFIG_LIBTCG
+    CPUClass *cc = CPU_CLASS(oc);
     cc->do_interrupt = crisv10_cpu_do_interrupt;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
+#endif
 }
 
 static void crisv11_cpu_class_init(ObjectClass *oc, void *data)
 {
-    CPUClass *cc = CPU_CLASS(oc);
     CRISCPUClass *ccc = CRIS_CPU_CLASS(oc);
 
     ccc->vr = 11;
+#ifndef CONFIG_LIBTCG
+    CPUClass *cc = CPU_CLASS(oc);
     cc->do_interrupt = crisv10_cpu_do_interrupt;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
+#endif
 }
 
 static void crisv17_cpu_class_init(ObjectClass *oc, void *data)
 {
-    CPUClass *cc = CPU_CLASS(oc);
     CRISCPUClass *ccc = CRIS_CPU_CLASS(oc);
 
     ccc->vr = 17;
+#ifndef CONFIG_LIBTCG
+    CPUClass *cc = CPU_CLASS(oc);
     cc->do_interrupt = crisv10_cpu_do_interrupt;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
+#endif
 }
 
 static void crisv32_cpu_class_init(ObjectClass *oc, void *data)
@@ -314,12 +324,14 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = cris_cpu_class_by_name;
     cc->has_work = cris_cpu_has_work;
+    cc->set_pc = cris_cpu_set_pc;
+#ifndef CONFIG_LIBTCG
+    cc->dump_state = cris_cpu_dump_state;
     cc->do_interrupt = cris_cpu_do_interrupt;
     cc->cpu_exec_interrupt = cris_cpu_exec_interrupt;
-    cc->dump_state = cris_cpu_dump_state;
-    cc->set_pc = cris_cpu_set_pc;
     cc->gdb_read_register = cris_cpu_gdb_read_register;
     cc->gdb_write_register = cris_cpu_gdb_write_register;
+
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = cris_cpu_handle_mmu_fault;
 #else
@@ -327,6 +339,8 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     dc->vmsd = &vmstate_cris_cpu;
 #endif
 
+#endif
+
     cc->gdb_num_core_regs = 49;
     cc->gdb_stop_before_watchpoint = true;
 
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0ee05ca02d..8274fd8186 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3303,6 +3303,7 @@ void gen_intermediate_code(CPUCRISState *env, struct TranslationBlock *tb)
 #endif
 }
 
+#ifndef CONFIG_LIBTCG
 void cris_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                          int flags)
 {
@@ -3359,6 +3360,7 @@ void cris_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     cpu_fprintf(f, "\n\n");
 
 }
+#endif
 
 void cris_initialize_tcg(void)
 {
diff --git a/target/hppa/Makefile.objs b/target/hppa/Makefile.objs
index 263446fa0b..d06e1b6bba 100644
--- a/target/hppa/Makefile.objs
+++ b/target/hppa/Makefile.objs
@@ -1 +1,5 @@
-obj-y += translate.o helper.o cpu.o op_helper.o gdbstub.o
+obj-y += translate.o cpu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o op_helper.o gdbstub.o
+endif
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 1d791d0f80..2e74a15fa9 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -107,7 +107,9 @@ static void hppa_cpu_initfn(Object *obj)
     CPUHPPAState *env = &cpu->env;
 
     cs->env_ptr = env;
+#ifndef CONFIG_LIBTCG
     cpu_hppa_loaded_fr0(env);
+#endif
     set_snan_bit_is_one(true, &env->fp_status);
 
     hppa_translate_init();
@@ -133,14 +135,16 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     acc->parent_realize = dc->realize;
     dc->realize = hppa_cpu_realizefn;
 
+#ifndef CONFIG_LIBTCG
     cc->do_interrupt = hppa_cpu_do_interrupt;
     cc->cpu_exec_interrupt = hppa_cpu_exec_interrupt;
     cc->dump_state = hppa_cpu_dump_state;
-    cc->set_pc = hppa_cpu_set_pc;
-    cc->synchronize_from_tb = hppa_cpu_synchronize_from_tb;
+    cc->handle_mmu_fault = hppa_cpu_handle_mmu_fault;
     cc->gdb_read_register = hppa_cpu_gdb_read_register;
     cc->gdb_write_register = hppa_cpu_gdb_write_register;
-    cc->handle_mmu_fault = hppa_cpu_handle_mmu_fault;
+#endif
+    cc->set_pc = hppa_cpu_set_pc;
+    cc->synchronize_from_tb = hppa_cpu_synchronize_from_tb;
     cc->disas_set_info = hppa_cpu_disas_set_info;
 
     cc->gdb_num_core_regs = 128;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5eeb35abc3..7b0c0d88f1 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3938,6 +3938,7 @@ void restore_state_to_opc(CPUHPPAState *env, TranslationBlock *tb,
     env->psw_n = 0;
 }
 
+#ifndef CONFIG_LIBTCG
 void hppa_cpu_dump_state(CPUState *cs, FILE *f,
                          fprintf_function cpu_fprintf, int flags)
 {
@@ -3962,3 +3963,4 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f,
 
     /* ??? FR */
 }
+#endif
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 4fcb7f3df0..8201ed5470 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -1,10 +1,15 @@
-obj-y += translate.o helper.o cpu.o bpt_helper.o
-obj-y += excp_helper.o fpu_helper.o cc_helper.o int_helper.o svm_helper.o
-obj-y += smm_helper.o misc_helper.o mem_helper.o seg_helper.o mpx_helper.o
-obj-y += gdbstub.o
+obj-y += translate.o cpu.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o hyperv.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o bpt_helper.o int_helper.o misc_helper.o mem_helper.o \
+         excp_helper.o fpu_helper.o cc_helper.o svm_helper.o smm_helper.o \
+         seg_helper.o mpx_helper.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+obj-y += gdbstub.o
+
 # HAX support
 ifdef CONFIG_WIN32
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
@@ -12,3 +17,5 @@ endif
 ifdef CONFIG_DARWIN
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
 endif
+
+endif
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fd7add2521..88b2fa05f8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2807,7 +2807,9 @@ static void x86_cpu_reset(CPUState *s)
 
     env->hflags2 |= HF2_GIF_MASK;
 
+#ifndef CONFIG_LIBTCG
     cpu_x86_update_cr0(env, 0x60000010);
+#endif
     env->a20_mask = ~0x0;
     env->smbase = 0x30000;
 
@@ -2846,7 +2848,9 @@ static void x86_cpu_reset(CPUState *s)
     for (i = 0; i < 8; i++) {
         env->fptags[i] = 1;
     }
+#ifndef CONFIG_LIBTCG
     cpu_set_fpuc(env, 0x37f);
+#endif
 
     env->mxcsr = 0x1f80;
     /* All units are in INIT state.  */
@@ -2885,7 +2889,9 @@ static void x86_cpu_reset(CPUState *s)
 #endif
 
     env->xcr0 = xcr0;
+#ifndef CONFIG_LIBTCG
     cpu_x86_update_cr4(env, cr4);
+#endif
 
     /*
      * SDM 11.11.5 requires:
@@ -3731,16 +3737,20 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = x86_cpu_class_by_name;
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->has_work = x86_cpu_has_work;
-    cc->do_interrupt = x86_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
-    cc->dump_state = x86_cpu_dump_state;
     cc->get_crash_info = x86_cpu_get_crash_info;
     cc->set_pc = x86_cpu_set_pc;
     cc->synchronize_from_tb = x86_cpu_synchronize_from_tb;
-    cc->gdb_read_register = x86_cpu_gdb_read_register;
-    cc->gdb_write_register = x86_cpu_gdb_write_register;
     cc->get_arch_id = x86_cpu_get_arch_id;
     cc->get_paging_enabled = x86_cpu_get_paging_enabled;
+#ifndef CONFIG_LIBTCG
+    cc->dump_state = x86_cpu_dump_state;
+    cc->do_interrupt = x86_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
+    cc->gdb_read_register = x86_cpu_gdb_read_register;
+    cc->gdb_write_register = x86_cpu_gdb_write_register;
+    cc->cpu_exec_enter = x86_cpu_exec_enter;
+    cc->cpu_exec_exit = x86_cpu_exec_exit;
+
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = x86_cpu_handle_mmu_fault;
 #else
@@ -3752,6 +3762,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->write_elf32_qemunote = x86_cpu_write_elf32_qemunote;
     cc->vmsd = &vmstate_x86_cpu;
 #endif
+
+#endif
     /* CPU_NB_REGS * 2 = general regs + xmm regs
      * 25 = eip, eflags, 6 seg regs, st[0-7], fctrl,...,fop, mxcsr.
      */
@@ -3759,8 +3771,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->debug_excp_handler = breakpoint_handler;
 #endif
-    cc->cpu_exec_enter = x86_cpu_exec_enter;
-    cc->cpu_exec_exit = x86_cpu_exec_exit;
 
     dc->cannot_instantiate_with_device_add_yet = false;
 }
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5623ee65a6..7111242c78 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8527,6 +8527,7 @@ void restore_state_to_opc(CPUX86State *env, TranslationBlock *tb,
     }
 }
 
+#ifndef CONFIG_LIBTCG
 /***********************************************************/
 /* x86 debug */
 
@@ -8849,3 +8850,4 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         cpu_fprintf(f, "\n");
     }
 }
+#endif
diff --git a/target/lm32/Makefile.objs b/target/lm32/Makefile.objs
index c3e1bd6bd6..2d00071430 100644
--- a/target/lm32/Makefile.objs
+++ b/target/lm32/Makefile.objs
@@ -1,4 +1,9 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
-obj-y += lm32-semi.o
+obj-y += translate.o cpu.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o op_helper.o
+obj-y += lm32-semi.o
+obj-y += gdbstub.o
+endif
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 692882f447..2cfed2f893 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1158,6 +1158,7 @@ void gen_intermediate_code(CPULM32State *env, struct TranslationBlock *tb)
 #endif
 }
 
+#ifndef CONFIG_LIBTCG
 void lm32_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                          int flags)
 {
@@ -1191,6 +1192,7 @@ void lm32_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     }
     cpu_fprintf(f, "\n\n");
 }
+#endif
 
 void restore_state_to_opc(CPULM32State *env, TranslationBlock *tb,
                           target_ulong *data)
diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
index 02cf616a78..9d8ca84220 100644
--- a/target/m68k/Makefile.objs
+++ b/target/m68k/Makefile.objs
@@ -1,3 +1,7 @@
+obj-y += translate.o cpu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o op_helper.o
 obj-y += m68k-semi.o
-obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += gdbstub.o
+endif
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 3b00d00461..7434eb097d 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -258,7 +258,6 @@ static const M68kCPUInfo m68k_cpus[] = {
 static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    M68kCPU *cpu = M68K_CPU(dev);
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
@@ -268,7 +267,10 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+#ifndef CONFIG_LIBTCG
+    M68kCPU *cpu = M68K_CPU(dev);
     m68k_cpu_init_gdb(cpu);
+#endif
 
     cpu_reset(cs);
     qemu_init_vcpu(cs);
@@ -330,17 +332,21 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
 
     cc->class_by_name = m68k_cpu_class_by_name;
     cc->has_work = m68k_cpu_has_work;
+    cc->set_pc = m68k_cpu_set_pc;
+#ifndef CONFIG_LIBTCG
+    cc->dump_state = m68k_cpu_dump_state;
     cc->do_interrupt = m68k_cpu_do_interrupt;
     cc->cpu_exec_interrupt = m68k_cpu_exec_interrupt;
-    cc->dump_state = m68k_cpu_dump_state;
-    cc->set_pc = m68k_cpu_set_pc;
     cc->gdb_read_register = m68k_cpu_gdb_read_register;
     cc->gdb_write_register = m68k_cpu_gdb_write_register;
+
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = m68k_cpu_handle_mmu_fault;
 #else
     cc->get_phys_page_debug = m68k_cpu_get_phys_page_debug;
 #endif
+
+#endif
     cc->disas_set_info = m68k_cpu_disas_set_info;
 
     cc->gdb_num_core_regs = 18;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 9f60fbc0db..c1b5bc7a27 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5136,6 +5136,7 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
     tb->icount = num_insns;
 }
 
+#ifndef CONFIG_LIBTCG
 void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                          int flags)
 {
@@ -5158,6 +5159,7 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                 (sr & CCF_V) ? 'V' : '-', (sr & CCF_C) ? 'C' : '-');
     cpu_fprintf (f, "FPRESULT = %12g\n", *(double *)&env->fp_result);
 }
+#endif
 
 void restore_state_to_opc(CPUM68KState *env, TranslationBlock *tb,
                           target_ulong *data)
diff --git a/target/microblaze/Makefile.objs b/target/microblaze/Makefile.objs
index f3d7b44c89..ba4efbe606 100644
--- a/target/microblaze/Makefile.objs
+++ b/target/microblaze/Makefile.objs
@@ -1,3 +1,8 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
+obj-y += translate.o cpu.o
+
 obj-$(CONFIG_SOFTMMU) += mmu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o op_helper.o
+obj-y += gdbstub.o
+endif
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 3d58869716..5719fe4ee9 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -255,18 +255,22 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->reset = mb_cpu_reset;
 
     cc->has_work = mb_cpu_has_work;
+#ifndef CONFIG_LIBTCG
     cc->do_interrupt = mb_cpu_do_interrupt;
     cc->cpu_exec_interrupt = mb_cpu_exec_interrupt;
     cc->dump_state = mb_cpu_dump_state;
-    cc->set_pc = mb_cpu_set_pc;
     cc->gdb_read_register = mb_cpu_gdb_read_register;
     cc->gdb_write_register = mb_cpu_gdb_write_register;
+
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = mb_cpu_handle_mmu_fault;
 #else
     cc->do_unassigned_access = mb_cpu_unassigned_access;
     cc->get_phys_page_debug = mb_cpu_get_phys_page_debug;
 #endif
+
+#endif
+    cc->set_pc = mb_cpu_set_pc;
     dc->vmsd = &vmstate_mb_cpu;
     dc->props = mb_properties;
     cc->gdb_num_core_regs = 32 + 5;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0bb609513c..4837d64d53 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1784,6 +1784,7 @@ void gen_intermediate_code(CPUMBState *env, struct TranslationBlock *tb)
     assert(!dc->abort_at_next_insn);
 }
 
+#ifndef CONFIG_LIBTCG
 void mb_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                        int flags)
 {
@@ -1813,6 +1814,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         }
     cpu_fprintf(f, "\n\n");
 }
+#endif
 
 MicroBlazeCPU *cpu_mb_init(const char *cpu_model)
 {
diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
index bc5ed8511f..1c0ae09d4e 100644
--- a/target/mips/Makefile.objs
+++ b/target/mips/Makefile.objs
@@ -1,4 +1,10 @@
-obj-y += translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o cpu.o
-obj-y += gdbstub.o msa_helper.o mips-semi.o
+obj-y += translate.o cpu.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o
 obj-$(CONFIG_KVM) += kvm.o
+
+ifndef CONFIG_LIBTCG
+obj-y += dsp_helper.o op_helper.o lmi_helper.o helper.o msa_helper.o
+obj-y += mips-semi.o
+obj-y += gdbstub.o
+endif
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 1bb66b7a5a..e0fcb60eb1 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -163,11 +163,12 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->reset = mips_cpu_reset;
 
     cc->has_work = mips_cpu_has_work;
-    cc->do_interrupt = mips_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
-    cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->synchronize_from_tb = mips_cpu_synchronize_from_tb;
+#ifndef CONFIG_LIBTCG
+    cc->dump_state = mips_cpu_dump_state;
+    cc->do_interrupt = mips_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
     cc->gdb_read_register = mips_cpu_gdb_read_register;
     cc->gdb_write_register = mips_cpu_gdb_write_register;
 #ifdef CONFIG_USER_ONLY
@@ -178,6 +179,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->get_phys_page_debug = mips_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_mips_cpu;
 #endif
+#endif
     cc->disas_set_info = mips_cpu_disas_set_info;
 
     cc->gdb_num_core_regs = 73;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 5077099a78..9cc609a03f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20071,6 +20071,7 @@ done_generating:
 #endif
 }
 
+#ifndef CONFIG_LIBTCG
 static void fpu_dump_state(CPUMIPSState *env, FILE *f, fprintf_function fpu_fprintf,
                            int flags)
 {
@@ -20143,6 +20144,7 @@ void mips_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     if (env->hflags & MIPS_HFLAG_FPU)
         fpu_dump_state(env, f, cpu_fprintf, flags);
 }
+#endif
 
 void mips_tcg_init(void)
 {
diff --git a/target/moxie/Makefile.objs b/target/moxie/Makefile.objs
index 6381d4d636..095992c742 100644
--- a/target/moxie/Makefile.objs
+++ b/target/moxie/Makefile.objs
@@ -1,2 +1,8 @@
-obj-y += translate.o helper.o machine.o cpu.o machine.o
+obj-y += translate.o cpu.o
+
 obj-$(CONFIG_SOFTMMU) += mmu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += machine.o
+obj-y += helper.o
+endif
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 0660b44c08..28930c4d5e 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -70,6 +70,7 @@ static int extract_branch_offset(int opcode)
   return (((signed short)((opcode & ((1 << 10) - 1)) << 6)) >> 6) << 1;
 }
 
+#ifndef CONFIG_LIBTCG
 void moxie_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                           int flags)
 {
@@ -90,6 +91,7 @@ void moxie_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                     i, env->sregs[i + 2], i+1, env->sregs[i + 3]);
     }
 }
+#endif
 
 void moxie_translate_init(void)
 {
diff --git a/target/nios2/Makefile.objs b/target/nios2/Makefile.objs
index 2a11c5ce08..d50466788d 100644
--- a/target/nios2/Makefile.objs
+++ b/target/nios2/Makefile.objs
@@ -1,4 +1,8 @@
-obj-y += translate.o op_helper.o helper.o cpu.o mmu.o
+obj-y += translate.o cpu.o
 obj-$(CONFIG_SOFTMMU) += monitor.o
 
+ifndef CONFIG_LIBTCG
+obj-y += helper.o op_helper.o
+obj-y += mmu.o
 $(obj)/op_helper.o: QEMU_CFLAGS += $(HELPER_CFLAGS)
+endif
\ No newline at end of file
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index d56bb7245a..03e1809c05 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -110,6 +110,7 @@ static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
     ncc->parent_realize(dev, errp);
 }
 
+#ifndef CONFIG_LIBTCG
 static bool nios2_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
@@ -123,6 +124,7 @@ static bool nios2_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+#endif
 
 
 static void nios2_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
@@ -136,6 +138,7 @@ static void nios2_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
+#ifndef CONFIG_LIBTCG
 static int nios2_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
@@ -178,6 +181,7 @@ static int nios2_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 
     return 4;
 }
+#endif
 
 static Property nios2_properties[] = {
     DEFINE_PROP_BOOL("mmu_present", Nios2CPU, mmu_present, true),
@@ -204,19 +208,22 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     cc->reset = nios2_cpu_reset;
 
     cc->has_work = nios2_cpu_has_work;
-    cc->do_interrupt = nios2_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = nios2_cpu_exec_interrupt;
-    cc->dump_state = nios2_cpu_dump_state;
     cc->set_pc = nios2_cpu_set_pc;
     cc->disas_set_info = nios2_cpu_disas_set_info;
+#ifndef CONFIG_LIBTCG
+    cc->do_interrupt = nios2_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = nios2_cpu_exec_interrupt;
+    cc->gdb_read_register = nios2_cpu_gdb_read_register;
+    cc->gdb_write_register = nios2_cpu_gdb_write_register;
+
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = nios2_cpu_handle_mmu_fault;
 #else
     cc->do_unaligned_access = nios2_cpu_do_unaligned_access;
     cc->get_phys_page_debug = nios2_cpu_get_phys_page_debug;
 #endif
-    cc->gdb_read_register = nios2_cpu_gdb_read_register;
-    cc->gdb_write_register = nios2_cpu_gdb_write_register;
+
+#endif
     cc->gdb_num_core_regs = 49;
 }
 
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 2d738391ad..c0fd3df689 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -909,6 +909,7 @@ void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
 #endif
 }
 
+#ifndef CONFIG_LIBTCG
 void nios2_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                           int flags)
 {
@@ -937,6 +938,7 @@ void nios2_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 #endif
     cpu_fprintf(f, "\n\n");
 }
+#endif
 
 void nios2_tcg_init(void)
 {
diff --git a/target/openrisc/Makefile.objs b/target/openrisc/Makefile.objs
index 918b1c6e9c..2b1656dccb 100644
--- a/target/openrisc/Makefile.objs
+++ b/target/openrisc/Makefile.objs
@@ -1,5 +1,10 @@
+obj-y += translate.o cpu.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o
-obj-y += cpu.o exception.o interrupt.o mmu.o translate.o
-obj-y += exception_helper.o fpu_helper.o \
-         interrupt_helper.o mmu_helper.o sys_helper.o
+
+ifndef CONFIG_LIBTCG
+obj-y += exception.o interrupt.o mmu.o
+obj-y += exception_helper.o fpu_helper.o interrupt_helper.o \
+         mmu_helper.o sys_helper.o
 obj-y += gdbstub.o
+endif
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 7fd2b9a216..ba96f1cf8c 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -167,18 +167,23 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = openrisc_cpu_class_by_name;
     cc->has_work = openrisc_cpu_has_work;
+    cc->set_pc = openrisc_cpu_set_pc;
+#ifndef CONFIG_LIBTCG
     cc->do_interrupt = openrisc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = openrisc_cpu_exec_interrupt;
     cc->dump_state = openrisc_cpu_dump_state;
-    cc->set_pc = openrisc_cpu_set_pc;
     cc->gdb_read_register = openrisc_cpu_gdb_read_register;
     cc->gdb_write_register = openrisc_cpu_gdb_write_register;
+
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = openrisc_cpu_handle_mmu_fault;
 #else
     cc->get_phys_page_debug = openrisc_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_openrisc_cpu;
 #endif
+
+#endif
+
     cc->gdb_num_core_regs = 32 + 3;
 }
 
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7c4cbf205f..b4b1913afd 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1652,6 +1652,7 @@ void gen_intermediate_code(CPUOpenRISCState *env, struct TranslationBlock *tb)
     }
 }
 
+#ifndef CONFIG_LIBTCG
 void openrisc_cpu_dump_state(CPUState *cs, FILE *f,
                              fprintf_function cpu_fprintf,
                              int flags)
@@ -1666,6 +1667,7 @@ void openrisc_cpu_dump_state(CPUState *cs, FILE *f,
                     (i % 4) == 3 ? '\n' : ' ');
     }
 }
+#endif
 
 void restore_state_to_opc(CPUOpenRISCState *env, TranslationBlock *tb,
                           target_ulong *data)
diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
index a8c7a30cde..54b6e4b2a7 100644
--- a/target/ppc/Makefile.objs
+++ b/target/ppc/Makefile.objs
@@ -1,17 +1,18 @@
-obj-y += cpu-models.o
 obj-y += translate.o
+obj-y += cpu-models.o
+
 ifeq ($(CONFIG_SOFTMMU),y)
-obj-y += machine.o mmu_helper.o mmu-hash32.o monitor.o
+obj-y += machine.o mmu-hash32.o monitor.o
+obj-y += mmu_helper.o
 obj-$(TARGET_PPC64) += mmu-hash64.o arch_dump.o compat.o
 endif
+
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-obj-y += dfp_helper.o
-obj-y += excp_helper.o
-obj-y += fpu_helper.o
-obj-y += int_helper.o
-obj-y += timebase_helper.o
-obj-y += misc_helper.o
-obj-y += mem_helper.o
+
+ifndef CONFIG_LIBTCG
+obj-y += int_helper.o dfp_helper.o timebase_helper.o mem_helper.o \
+         misc_helper.o fpu_helper.o excp_helper.o
 obj-$(CONFIG_USER_ONLY) += user_only_helper.o
 obj-y += gdbstub.o
+endif
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3ba2616b8a..2393031069 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6863,6 +6863,7 @@ GEN_HANDLER2_E(trechkpt, "trechkpt", 0x1F, 0x0E, 0x1F, 0x03FFF800, \
 #include "helper_regs.h"
 #include "translate_init.c"
 
+#ifndef CONFIG_LIBTCG
 /*****************************************************************************/
 /* Misc PowerPC helpers */
 void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
@@ -7032,6 +7033,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 #undef RGPL
 #undef RFPL
 }
+#endif
 
 void ppc_cpu_dump_statistics(CPUState *cs, FILE*f,
                              fprintf_function cpu_fprintf, int flags)
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 12ef379d50..fede933461 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9449,6 +9449,7 @@ static void dump_ppc_insns (CPUPPCState *env)
 }
 #endif
 
+#ifndef CONFIG_LIBTCG
 static bool avr_need_swap(CPUPPCState *env)
 {
 #ifdef HOST_WORDS_BIGENDIAN
@@ -9634,6 +9635,7 @@ static int gdb_set_vsx_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     }
     return 0;
 }
+#endif
 
 static int ppc_fixup_cpu(PowerPCCPU *cpu)
 {
@@ -9736,6 +9738,7 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     init_ppc_proc(cpu);
 
+#ifndef CONFIG_LIBTCG
     if (pcc->insns_flags & PPC_FLOAT) {
         gdb_register_coprocessor(cs, gdb_get_float_reg, gdb_set_float_reg,
                                  33, "power-fpu.xml", 0);
@@ -9752,6 +9755,7 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
         gdb_register_coprocessor(cs, gdb_get_vsx_reg, gdb_set_vsx_reg,
                                  32, "power-vsx.xml", 0);
     }
+#endif
 
     qemu_init_vcpu(cs);
 
@@ -10497,11 +10501,12 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = ppc_cpu_class_by_name;
     cc->has_work = ppc_cpu_has_work;
+    cc->dump_statistics = ppc_cpu_dump_statistics;
+    cc->set_pc = ppc_cpu_set_pc;
+#ifndef CONFIG_LIBTCG
     cc->do_interrupt = ppc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt;
     cc->dump_state = ppc_cpu_dump_state;
-    cc->dump_statistics = ppc_cpu_dump_statistics;
-    cc->set_pc = ppc_cpu_set_pc;
     cc->gdb_read_register = ppc_cpu_gdb_read_register;
     cc->gdb_write_register = ppc_cpu_gdb_write_register;
 #ifdef CONFIG_USER_ONLY
@@ -10511,8 +10516,11 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->vmsd = &vmstate_ppc_cpu;
 #if defined(TARGET_PPC64)
     cc->write_elf64_note = ppc64_cpu_write_elf64_note;
-#endif
-#endif
+#endif /* TARGET_PPC64 */
+#endif /* CONFIG_USER_ONLY */
+
+#endif /* CONFIG_LIBTCG */
+
     cc->cpu_exec_enter = ppc_cpu_exec_enter;
 
     cc->gdb_num_core_regs = 71;
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index c573633bd1..b0aa2d563f 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -1,9 +1,17 @@
-obj-y += translate.o helper.o cpu.o interrupt.o
-obj-y += int_helper.o fpu_helper.o cc_helper.o mem_helper.o misc_helper.o
-obj-y += gdbstub.o cpu_models.o cpu_features.o
-obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o
+obj-y += translate.o cpu.o
+obj-y += cpu_models.o cpu_features.o
+
+obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o
+obj-$(CONFIG_SOFTMMU) += mmu_helper.o
 obj-$(CONFIG_KVM) += kvm.o
 
+ifndef CONFIG_LIBTCG
+obj-y += interrupt.o
+obj-y += helper.o int_helper.o fpu_helper.o cc_helper.o mem_helper.o \
+         misc_helper.o
+obj-y += gdbstub.o
+endif
+
 # build and run feature list generator
 feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
 feat-dst = $(BUILD_DIR)/$(TARGET_DIR)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 2101d1dbf1..e402504cd4 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -214,7 +214,9 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     qemu_register_reset(s390_cpu_machine_reset_cb, cpu);
 #endif
     env->cpu_num = cpu->id;
+#ifndef CONFIG_LIBTCG
     s390_cpu_gdb_init(cs);
+#endif
     qemu_init_vcpu(cs);
 #if !defined(CONFIG_USER_ONLY)
     run_on_cpu(cs, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
@@ -417,11 +419,13 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->reset = s390_cpu_full_reset;
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work = s390_cpu_has_work;
+    cc->set_pc = s390_cpu_set_pc;
+#ifndef CONFIG_LIBTCG
     cc->do_interrupt = s390_cpu_do_interrupt;
     cc->dump_state = s390_cpu_dump_state;
-    cc->set_pc = s390_cpu_set_pc;
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
+
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = s390_cpu_handle_mmu_fault;
 #else
@@ -431,6 +435,8 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_interrupt = s390_cpu_exec_interrupt;
     cc->debug_excp_handler = s390x_cpu_debug_excp_handler;
 #endif
+
+#endif
     cc->disas_set_info = s390_cpu_disas_set_info;
 
     cc->gdb_num_core_regs = S390_NUM_CORE_REGS;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 01c62176bf..08b5e2db23 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -91,6 +91,7 @@ static uint64_t pc_to_link_info(DisasContext *s, uint64_t pc)
     return pc;
 }
 
+#ifndef CONFIG_LIBTCG
 void s390_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                          int flags)
 {
@@ -150,6 +151,7 @@ void s390_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 
     cpu_fprintf(f, "\n");
 }
+#endif
 
 static TCGv_i64 psw_addr;
 static TCGv_i64 psw_mask;
diff --git a/target/sh4/Makefile.objs b/target/sh4/Makefile.objs
index 2c25d96e65..381e4ed899 100644
--- a/target/sh4/Makefile.objs
+++ b/target/sh4/Makefile.objs
@@ -1,3 +1,8 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
+obj-y += translate.o cpu.o
+
 obj-$(CONFIG_SOFTMMU) += monitor.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o op_helper.o
 obj-y += gdbstub.o
+endif
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 9a481c35dc..e3849eae17 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -291,18 +291,22 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = superh_cpu_class_by_name;
     cc->has_work = superh_cpu_has_work;
-    cc->do_interrupt = superh_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = superh_cpu_exec_interrupt;
-    cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
     cc->synchronize_from_tb = superh_cpu_synchronize_from_tb;
+#ifndef CONFIG_LIBTCG
+    cc->dump_state = superh_cpu_dump_state;
+    cc->do_interrupt = superh_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = superh_cpu_exec_interrupt;
     cc->gdb_read_register = superh_cpu_gdb_read_register;
     cc->gdb_write_register = superh_cpu_gdb_write_register;
+
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = superh_cpu_handle_mmu_fault;
 #else
     cc->get_phys_page_debug = superh_cpu_get_phys_page_debug;
 #endif
+
+#endif
     cc->disas_set_info = superh_cpu_disas_set_info;
 
     cc->gdb_num_core_regs = 59;
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index c89a14733f..0d4cbbda12 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -157,6 +157,7 @@ void sh4_translate_init(void)
     done_init = 1;
 }
 
+#ifndef CONFIG_LIBTCG
 void superh_cpu_dump_state(CPUState *cs, FILE *f,
                            fprintf_function cpu_fprintf, int flags)
 {
@@ -182,6 +183,7 @@ void superh_cpu_dump_state(CPUState *cs, FILE *f,
 		    env->delayed_pc);
     }
 }
+#endif
 
 static void gen_read_sr(TCGv dst)
 {
diff --git a/target/sparc/Makefile.objs b/target/sparc/Makefile.objs
index ec905698c5..dbf04188f3 100644
--- a/target/sparc/Makefile.objs
+++ b/target/sparc/Makefile.objs
@@ -1,7 +1,12 @@
+obj-y += translate.o cpu.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o monitor.o
-obj-y += translate.o helper.o cpu.o
-obj-y += fop_helper.o cc_helper.o win_helper.o mmu_helper.o ldst_helper.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o fop_helper.o cc_helper.o win_helper.o mmu_helper.o \
+         ldst_helper.o
 obj-$(TARGET_SPARC) += int32_helper.o
-obj-$(TARGET_SPARC64) += int64_helper.o
-obj-$(TARGET_SPARC64) += vis_helper.o
+obj-$(TARGET_SPARC64) += int64_helper.o vis_helper.o
+
 obj-y += gdbstub.o
+endif
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 652cbef425..bbd2aa6c77 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -76,6 +76,7 @@ static void sparc_cpu_reset(CPUState *s)
     env->cache_control = 0;
 }
 
+#ifndef CONFIG_LIBTCG
 static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
@@ -95,6 +96,7 @@ static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+#endif
 
 static void cpu_sparc_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
@@ -770,16 +772,18 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->reset = sparc_cpu_reset;
 
     cc->has_work = sparc_cpu_has_work;
-    cc->do_interrupt = sparc_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
-    cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
     cc->memory_rw_debug = sparc_cpu_memory_rw_debug;
 #endif
     cc->set_pc = sparc_cpu_set_pc;
     cc->synchronize_from_tb = sparc_cpu_synchronize_from_tb;
+#ifndef CONFIG_LIBTCG
+    cc->dump_state = sparc_cpu_dump_state;
+    cc->do_interrupt = sparc_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
     cc->gdb_read_register = sparc_cpu_gdb_read_register;
     cc->gdb_write_register = sparc_cpu_gdb_write_register;
+
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = sparc_cpu_handle_mmu_fault;
 #else
@@ -788,6 +792,8 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_phys_page_debug = sparc_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_sparc_cpu;
 #endif
+
+#endif
     cc->disas_set_info = cpu_sparc_disas_set_info;
 
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 248ff9018d..10f05bef1a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5965,6 +5965,7 @@ void restore_state_to_opc(CPUSPARCState *env, TranslationBlock *tb,
     }
 }
 
+#ifndef CONFIG_LIBTCG
 static void cpu_print_cc(FILE *f, fprintf_function cpu_fprintf,
                          uint32_t cc)
 {
@@ -6049,3 +6050,4 @@ void sparc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 #endif
     cpu_fprintf(f, "\n");
 }
+#endif
diff --git a/target/tilegx/Makefile.objs b/target/tilegx/Makefile.objs
index 0db778f407..b3c0e1ec1c 100644
--- a/target/tilegx/Makefile.objs
+++ b/target/tilegx/Makefile.objs
@@ -1 +1,5 @@
-obj-y += cpu.o translate.o helper.o simd_helper.o
+obj-y += translate.o cpu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o simd_helper.o
+endif
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index b79868e1e4..1925de4271 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -24,7 +24,11 @@
 #include "qemu-common.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "linux-user/syscall_defs.h"
+#ifdef CONFIG_LIBTCG
+# define TARGET_SIGSEGV 0
+#else
+# include "linux-user/syscall_defs.h"
+#endif
 #include "exec/exec-all.h"
 
 TileGXCPU *cpu_tilegx_init(const char *cpu_model)
@@ -94,6 +98,7 @@ static void tilegx_cpu_initfn(Object *obj)
     }
 }
 
+#ifndef CONFIG_LIBTCG
 static void tilegx_cpu_do_interrupt(CPUState *cs)
 {
     cs->exception_index = -1;
@@ -121,6 +126,7 @@ static bool tilegx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+#endif
 
 static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
 {
@@ -135,11 +141,13 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
     cc->reset = tilegx_cpu_reset;
 
     cc->has_work = tilegx_cpu_has_work;
+#ifndef CONFIG_LIBTCG
     cc->do_interrupt = tilegx_cpu_do_interrupt;
     cc->cpu_exec_interrupt = tilegx_cpu_exec_interrupt;
     cc->dump_state = tilegx_cpu_dump_state;
-    cc->set_pc = tilegx_cpu_set_pc;
     cc->handle_mmu_fault = tilegx_cpu_handle_mmu_fault;
+#endif
+    cc->set_pc = tilegx_cpu_set_pc;
     cc->gdb_num_core_regs = 0;
 }
 
diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index a170b744f4..843e25bc80 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -26,7 +26,15 @@
 #include "exec/exec-all.h"
 #include "tcg-op.h"
 #include "exec/cpu_ldst.h"
-#include "linux-user/syscall_defs.h"
+
+#ifdef CONFIG_LIBTCG
+# define TARGET_SIGTRAP 0
+# define TARGET_TRAP_BRKPT 0
+# define TARGET_SIGILL 0
+# define TARGET_ILL_ILLOPC 0
+#else
+# include "linux-user/syscall_defs.h"
+#endif
 
 #include "opcode_tilegx.h"
 #include "spr_def_64.h"
@@ -2456,6 +2464,7 @@ void tilegx_tcg_init(void)
     }
 }
 
+#ifndef CONFIG_LIBTCG
 void tilegx_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                            int flags)
 {
@@ -2481,3 +2490,4 @@ void tilegx_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     cpu_fprintf(f, "PC  " TARGET_FMT_lx " CEX " TARGET_FMT_lx "\n\n",
                 env->pc, env->spregs[TILEGX_SPR_CMPEXCH]);
 }
+#endif
diff --git a/target/tricore/Makefile.objs b/target/tricore/Makefile.objs
index 7a05670718..e68f251d62 100644
--- a/target/tricore/Makefile.objs
+++ b/target/tricore/Makefile.objs
@@ -1 +1,5 @@
-obj-y += translate.o helper.o cpu.o op_helper.o fpu_helper.o
+obj-y += translate.o cpu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o op_helper.o fpu_helper.o
+endif
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ddd2dd07dd..245cd6d17d 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -90,6 +90,7 @@ enum {
     MODE_UU = 3,
 };
 
+#ifndef CONFIG_LIBTCG
 void tricore_cpu_dump_state(CPUState *cs, FILE *f,
                             fprintf_function cpu_fprintf, int flags)
 {
@@ -121,6 +122,7 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f,
     }
     cpu_fprintf(f, "\n");
 }
+#endif
 
 /*
  * Functions to generate micro-ops
diff --git a/target/unicore32/Makefile.objs b/target/unicore32/Makefile.objs
index 6b41b1e9ef..6013189869 100644
--- a/target/unicore32/Makefile.objs
+++ b/target/unicore32/Makefile.objs
@@ -1,4 +1,7 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += ucf64_helper.o
+obj-y += translate.o cpu.o
 
 obj-$(CONFIG_SOFTMMU) += softmmu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o op_helper.o ucf64_helper.o
+endif
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index bab718af7b..f1ac24cf89 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -162,15 +162,19 @@ static void uc32_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = uc32_cpu_class_by_name;
     cc->has_work = uc32_cpu_has_work;
+    cc->set_pc = uc32_cpu_set_pc;
+#ifndef CONFIG_LIBTCG
     cc->do_interrupt = uc32_cpu_do_interrupt;
     cc->cpu_exec_interrupt = uc32_cpu_exec_interrupt;
     cc->dump_state = uc32_cpu_dump_state;
-    cc->set_pc = uc32_cpu_set_pc;
+
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = uc32_cpu_handle_mmu_fault;
 #else
     cc->get_phys_page_debug = uc32_cpu_get_phys_page_debug;
 #endif
+
+#endif
     dc->vmsd = &vmstate_uc32_cpu;
 }
 
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 666a2016a8..456338123b 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -2036,6 +2036,7 @@ done_generating:
     tb->icount = num_insns;
 }
 
+#ifndef CONFIG_LIBTCG
 static const char *cpu_mode_names[16] = {
     "USER", "REAL", "INTR", "PRIV", "UM14", "UM15", "UM16", "TRAP",
     "UM18", "UM19", "UM1A", "EXTN", "UM1C", "UM1D", "UM1E", "SUSR"
@@ -2103,6 +2104,7 @@ void uc32_cpu_dump_state(CPUState *cs, FILE *f,
 
     cpu_dump_state_ucf64(env, f, cpu_fprintf, flags);
 }
+#endif
 
 void restore_state_to_opc(CPUUniCore32State *env, TranslationBlock *tb,
                           target_ulong *data)
diff --git a/target/xtensa/Makefile.objs b/target/xtensa/Makefile.objs
index 481de91973..51516b4a2a 100644
--- a/target/xtensa/Makefile.objs
+++ b/target/xtensa/Makefile.objs
@@ -1,7 +1,10 @@
-obj-y += xtensa-semi.o
-obj-y += core-dc232b.o
-obj-y += core-dc233c.o
-obj-y += core-fsf.o
+obj-y += translate.o cpu.o
+
 obj-$(CONFIG_SOFTMMU) += monitor.o
-obj-y += translate.o op_helper.o helper.o cpu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += helper.o op_helper.o
+obj-y += xtensa-semi.o
+obj-y += core-dc232b.o core-dc233c.o core-fsf.o
 obj-y += gdbstub.o
+endif
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 263002486c..617e9ad897 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -3256,6 +3256,7 @@ done:
     tb->icount = insn_count;
 }
 
+#ifndef CONFIG_LIBTCG
 void xtensa_cpu_dump_state(CPUState *cs, FILE *f,
                            fprintf_function cpu_fprintf, int flags)
 {
@@ -3306,6 +3307,7 @@ void xtensa_cpu_dump_state(CPUState *cs, FILE *f,
         }
     }
 }
+#endif
 
 void restore_state_to_opc(CPUXtensaState *env, TranslationBlock *tb,
                           target_ulong *data)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 652131e5e9..d834a536b9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -22,11 +22,13 @@
  * THE SOFTWARE.
  */
 
-/* define it to use liveness analysis (better code) */
-#define USE_TCG_OPTIMIZATIONS
-
 #include "qemu/osdep.h"
 
+/* define it to use liveness analysis (better code) */
+#ifndef CONFIG_LIBTCG
+# define USE_TCG_OPTIMIZATIONS
+#endif
+
 /* Define to jump the ELF file used to communicate with GDB.  */
 #undef DEBUG_JIT
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 09e452ca46..884ff9f20f 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -593,6 +593,7 @@ void tcg_pool_reset(TCGContext *s);
 void tb_lock(void);
 void tb_unlock(void);
 void tb_lock_reset(void);
+TranslationBlock *tb_alloc(target_ulong pc);
 
 /* Called with tb_lock held.  */
 static inline void *tcg_malloc(int size)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e60bb6ce58..21030600c2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -8,6 +8,8 @@ SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
 
 check-unit-y = tests/check-qdict$(EXESUF)
 gcov-files-check-qdict-y = qobject/qdict.c
+check-unit-y += tests/test-libtcg$(EXESUF)
+gcov-files-test-libtcg-y = libtcg/tcg.c
 check-unit-y += tests/test-char$(EXESUF)
 gcov-files-check-qdict-y = chardev/char.c
 check-unit-y += tests/check-qfloat$(EXESUF)
@@ -495,7 +497,9 @@ test-obj-y = tests/check-qint.o tests/check-qstring.o tests/check-qdict.o \
 	tests/rcutorture.o tests/test-rcu-list.o \
 	tests/test-qdist.o tests/test-shift128.o \
 	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
-	tests/atomic_add-bench.o
+	tests/atomic_add-bench.o tests/test-libtcg.o
+
+tests/test-libtcg: QEMU_CFLAGS += -ldl
 
 $(test-obj-y): QEMU_INCLUDES += -Itests
 QEMU_CFLAGS += -I$(SRC_PATH)/tests
@@ -514,6 +518,7 @@ test-block-obj-y = $(block-obj-y) $(test-io-obj-y) tests/iothread.o
 tests/check-qint$(EXESUF): tests/check-qint.o $(test-util-obj-y)
 tests/check-qstring$(EXESUF): tests/check-qstring.o $(test-util-obj-y)
 tests/check-qdict$(EXESUF): tests/check-qdict.o $(test-util-obj-y)
+tests/check-libtcg$(EXESUF): tests/check-libtcg.o $(test-util-obj-y)
 tests/check-qlist$(EXESUF): tests/check-qlist.o $(test-util-obj-y)
 tests/check-qfloat$(EXESUF): tests/check-qfloat.o $(test-util-obj-y)
 tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
diff --git a/tests/test-libtcg.c b/tests/test-libtcg.c
new file mode 100644
index 0000000000..4b5e142aec
--- /dev/null
+++ b/tests/test-libtcg.c
@@ -0,0 +1,238 @@
+/*
+ * libtcg unit-tests.
+ *
+ * Copyright (C) 2017 Alessandro Di Federico
+ *
+ * Authors:
+ *  Alessandro Di Federico <ale+qemu@clearmind.me>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+#include <glib.h>
+#include <glob.h>
+#include <dlfcn.h>
+
+#include "libtcg.h"
+
+static const char *get_default_cpu(const char *architecture)
+{
+    if (strcmp(architecture, "arm") == 0) {
+        return "any";
+    } else if (strcmp(architecture, "armeb") == 0) {
+        return "any";
+    } else if (strcmp(architecture, "cris") == 0) {
+        return "crisv17";
+    } else if (strcmp(architecture, "aarch64") == 0) {
+        return "any";
+    } else if (strcmp(architecture, "or1k") == 0) {
+        return "any";
+    } else if (strcmp(architecture, "hppa") == 0) {
+        return "any";
+    } else if (strcmp(architecture, "microblaze") == 0) {
+        return "any";
+    } else if (strcmp(architecture, "microblazeel") == 0) {
+        return "any";
+    } else if (strcmp(architecture, "nios2") == 0) {
+        return "any";
+    } else if (strcmp(architecture, "m68k") == 0) {
+        return "any";
+    } else if (strcmp(architecture, "tilegx") == 0) {
+        return "any";
+    } else if (strcmp(architecture, "alpha") == 0) {
+        return "ev4-alpha-cpu";
+    } else if (strcmp(architecture, "mips") == 0) {
+        return "mips32r6-generic";
+    } else if (strcmp(architecture, "mips64el") == 0) {
+        return "mips32r6-generic";
+    } else if (strcmp(architecture, "mips64") == 0) {
+        return "mips32r6-generic";
+    } else if (strcmp(architecture, "mipsel") == 0) {
+        return "mips32r6-generic";
+    } else if (strcmp(architecture, "mipsn32el") == 0) {
+        return "mips32r6-generic";
+    } else if (strcmp(architecture, "mipsn32") == 0) {
+        return "mips32r6-generic";
+    } else if (strcmp(architecture, "x86_64") == 0) {
+        return "qemu64";
+    } else if (strcmp(architecture, "i386") == 0) {
+        return "qemu64";
+    } else if (strcmp(architecture, "ppc64abi32") == 0) {
+        return "default";
+    } else if (strcmp(architecture, "ppc64le") == 0) {
+        return "default";
+    } else if (strcmp(architecture, "ppc64") == 0) {
+        return "default";
+    } else if (strcmp(architecture, "ppc") == 0) {
+        return "default";
+    } else if (strcmp(architecture, "s390x") == 0) {
+        return "qemu";
+    } else if (strcmp(architecture, "sh4") == 0) {
+        return "SH7785";
+    } else if (strcmp(architecture, "sh4eb") == 0) {
+        return "SH7785";
+    } else if (strcmp(architecture, "sparc") == 0) {
+        return "TI MicroSparc II";
+    } else if (strcmp(architecture, "sparc64") == 0) {
+        return "Fujitsu Sparc64 V";
+    } else if (strcmp(architecture, "sparc32plus") == 0) {
+        return "Sun UltraSparc IV";
+    }
+
+    g_assert(false);
+}
+
+static const char *get_architecture(char *path)
+{
+    size_t length = strlen(path);
+    path += length;
+
+    while (*path != '-') {
+        path--;
+    }
+
+    char *start = path + 1;
+
+    while (*path != '.') {
+        path++;
+    }
+
+    *path = '\0';
+    return start;
+}
+
+typedef struct {
+    char *path;
+    char *name;
+    const char *cpu;
+} Architecture;
+
+static void test_libtcg(gconstpointer argument)
+{
+    const Architecture *architecture = (const Architecture *) argument;
+
+    /* Load the library */
+    void *handle = dlopen(architecture->path, RTLD_LAZY);
+    if (handle == NULL) {
+        fprintf(stderr, "Couldn't load %s: %s\n",
+                architecture->path, dlerror());
+    }
+    g_assert(handle != NULL);
+
+    /* Obtain a reference to the libtcg_init entry point */
+    libtcg_init_func libtcg_init = dlsym(handle, "libtcg_init");
+    g_assert(libtcg_init != NULL);
+
+    /* For some architectures, actually test the translation */
+    bool translate = true;
+    uint32_t buffer[8] = { 0 };
+    unsigned expected_instruction_count = 0;
+    if (strcmp(architecture->name, "arm") == 0) {
+        buffer[0] = 0xe3a0b000;
+        buffer[1] = 0xe3a0e000;
+        buffer[2] = 0xe12fff1e;
+        expected_instruction_count = 3;
+    } else if (strcmp(architecture->name, "mips") == 0) {
+        buffer[0] = 0x8fbf001c;
+        buffer[1] = 0x03e00008;
+        buffer[2] = 0x27bd0020;
+        expected_instruction_count = 3;
+    } else if (strcmp(architecture->name, "x86_64") == 0) {
+        buffer[0] = 0x9090c3;
+        expected_instruction_count = 1;
+    } else if (strcmp(architecture->name, "s390x") == 0) {
+        /* s390x is currently broken, disable it */
+        return;
+    } else {
+        translate = false;
+    }
+
+    /* Initialize libtcg */
+    const LibTCGInterface *libtcg = libtcg_init(architecture->cpu, 0xb0000000);
+    g_assert(libtcg != NULL);
+
+
+    if (translate) {
+        /* mmap a page */
+        address_pair mmapd_address = { 0 };
+        mmapd_address = libtcg->mmap(0, 4096, PROT_READ | PROT_WRITE,
+                                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        g_assert(mmapd_address.pointer != NULL
+                 && mmapd_address.virtual_address != 0);
+
+        /* Copy the code to the mmap'd page */
+        memcpy(mmapd_address.pointer,
+               buffer,
+               8 * sizeof(uint32_t));
+
+        /* Perform the translation */
+        LibTCGInstructions instructions;
+        instructions = libtcg->translate(mmapd_address.virtual_address);
+
+        /* Count the instructions (in terms of the input architectures, not tiny
+         * code instructions) */
+        unsigned tci_count = instructions.instruction_count;
+        unsigned instruction_count = 0;
+        for (unsigned i = 0; i < tci_count; i++) {
+            LibTCGOpcode opcode = instructions.instructions[i].opc;
+            if (opcode == LIBTCG_INDEX_op_insn_start) {
+                instruction_count++;
+            }
+        }
+
+        /* Check the expected amount of instructions have been met */
+        g_assert(instruction_count == expected_instruction_count);
+
+        /* Cleanup */
+        libtcg->free_instructions(&instructions);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    /* Enumerate all the versions of libtcg that have been compiled */
+    glob_t results;
+    int result = glob("*-libtcg/libtcg-*.so*", 0, NULL, &results);
+    if (result == GLOB_NOMATCH) {
+        return 0;
+    }
+    g_assert(result == 0);
+
+    /* Collect path to the library, name of the architecture and default CPU
+     * for the architecture in a data structure */
+    unsigned architectures_count = results.gl_pathc;
+    Architecture *architectures = g_malloc0_n(sizeof(Architecture),
+                                              architectures_count);
+
+    for (unsigned i = 0; i < architectures_count; i++) {
+        char *path = results.gl_pathv[i];
+        architectures[i].path = g_strdup(path);
+        architectures[i].name = g_strdup(get_architecture(path));
+        architectures[i].cpu = get_default_cpu(architectures[i].name);
+
+        /* Create a test for each architecture */
+        gchar *name = g_strdup_printf("/libtcg/%s", architectures[i].name);
+        g_test_add_data_func(name, &architectures[i], test_libtcg);
+        g_free(name);
+    }
+
+    globfree(&results);
+
+    /* Run the tests */
+    result = g_test_run();
+
+    /* Perform cleanup operations */
+    for (unsigned i = 0; i < architectures_count; i++) {
+        g_free(architectures[i].path);
+        g_free(architectures[i].name);
+    }
+    g_free(architectures);
+
+    return result;
+}
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index 7de840ad7e..297edd515a 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -44,7 +44,7 @@ $(obj)/generated-helpers.c-timestamp: $(trace-events-files) $(BUILD_DIR)/config-
 
 $(obj)/generated-helpers.o: $(obj)/generated-helpers.c
 
-target-obj-y += generated-helpers.o
+target-obj-$(call lnot,$(CONFIG_LIBTCG)) += generated-helpers.o
 
 
 $(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
diff --git a/translate-all.c b/translate-all.c
index 5f44ec844e..38e10a34eb 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -843,7 +843,7 @@ bool tcg_enabled(void)
  *
  * Called with tb_lock held.
  */
-static TranslationBlock *tb_alloc(target_ulong pc)
+TranslationBlock *tb_alloc(target_ulong pc)
 {
     TranslationBlock *tb;
 
-- 
2.11.1
