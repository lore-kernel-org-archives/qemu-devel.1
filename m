Received: from eggs.gnu.org ([2001:4830:134:3::10]:43751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cUrIH-00054j-9B
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 03:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cUrIC-0002em-QM
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 03:45:05 -0500
Received: from clearmind.me ([178.32.49.9]:50157)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cUrIC-0002c0-CK
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 03:45:00 -0500
From: Alessandro Di Federico <ale+qemu@clearmind.me>
Date: Sat, 21 Jan 2017 09:46:00 +0100
Message-Id: <20170121084600.5860-4-ale+qemu@clearmind.me>
In-Reply-To: <20170121084600.5860-1-ale+qemu@clearmind.me>
References: <20170121084600.5860-1-ale+qemu@clearmind.me>
Sender: ale@clearmind.me
Subject: [Qemu-devel] [RFC PATCH 3/3] Introduce libtcg infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[This is a draft patch is for review purposes only]

* Extend the build system to build libtcg-$arch.so dynamic libraries.
* Introduce --enable-libtcg and --disable-libtcg the *-libtcg target,
  similar to *-linux-user and *-bsd-user, since it enables
  CONFIG_USER_ONLY, but uses only the TCG frontends (in particular the
  various /target/$arch/translate.c).
* If there's at least a *-libtcg, compile everything as position
  independent code.
* In case we're building libtcg, install the output binary in the
  $PREFIX/lib directory instead of $PREFIX/bin.
* Reduce the number of object files linked into libtcg-$arch.so to the
  minimum.
* Install the tcg.h header to use libtcg.
* Create libtcg/, with a draft function referencing the functions that
  libtcg would use.
---
 Makefile                                |  7 +++++
 Makefile.target                         | 40 +++++++++++++++++++++---
 configure                               | 20 ++++++++++++
 crypto/Makefile.objs                    |  2 +-
 default-configs/aarch64-libtcg.mak      |  0
 default-configs/alpha-libtcg.mak        |  0
 default-configs/arm-libtcg.mak          |  0
 default-configs/armeb-libtcg.mak        |  0
 default-configs/cris-libtcg.mak         |  0
 default-configs/i386-libtcg.mak         |  0
 default-configs/m68k-libtcg.mak         |  0
 default-configs/microblaze-libtcg.mak   |  0
 default-configs/microblazeel-libtcg.mak |  0
 default-configs/mips-libtcg.mak         |  0
 default-configs/mips64-libtcg.mak       |  0
 default-configs/mips64el-libtcg.mak     |  0
 default-configs/mipsel-libtcg.mak       |  0
 default-configs/mipsn32-libtcg.mak      |  0
 default-configs/mipsn32el-libtcg.mak    |  0
 default-configs/or32-libtcg.mak         |  0
 default-configs/ppc-libtcg.mak          |  1 +
 default-configs/ppc64-libtcg.mak        |  1 +
 default-configs/ppc64abi32-libtcg.mak   |  1 +
 default-configs/ppc64le-libtcg.mak      |  1 +
 default-configs/s390x-libtcg.mak        |  0
 default-configs/sh4-libtcg.mak          |  0
 default-configs/sh4eb-libtcg.mak        |  0
 default-configs/sparc-libtcg.mak        |  0
 default-configs/sparc32plus-libtcg.mak  |  0
 default-configs/sparc64-libtcg.mak      |  0
 default-configs/unicore32-libtcg.mak    |  0
 default-configs/x86_64-libtcg.mak       |  0
 hw/core/Makefile.objs                   |  5 ++-
 include/exec/helper-gen.h               | 12 +++----
 include/exec/helper-head.h              |  8 +++++
 include/exec/helper-tcg.h               | 12 +++----
 libtcg/Makefile.objs                    |  1 +
 libtcg/qemu.h                           |  6 ++++
 libtcg/tcg.c                            | 55 +++++++++++++++++++++++++++++++++
 libtcg/tcg.h                            |  0
 target/alpha/Makefile.objs              |  9 ++++--
 target/arm/Makefile.objs                | 22 +++++++++----
 target/cris/Makefile.objs               | 10 ++++--
 target/i386/Makefile.objs               | 14 ++++++---
 target/lm32/Makefile.objs               | 12 +++++--
 target/m68k/Makefile.objs               |  7 ++++-
 target/microblaze/Makefile.objs         | 10 ++++--
 target/mips/Makefile.objs               | 11 +++++--
 target/moxie/Makefile.objs              |  8 ++++-
 target/openrisc/Makefile.objs           | 11 +++++--
 target/ppc/Makefile.objs                | 18 +++++------
 target/ppc/translate.c                  |  2 ++
 target/ppc/translate_init.c             |  8 +++++
 target/s390x/Makefile.objs              | 16 +++++++---
 target/sh4/Makefile.objs                |  8 ++++-
 target/sparc/Makefile.objs              | 15 ++++++---
 target/tilegx/Makefile.objs             |  7 ++++-
 target/tricore/Makefile.objs            |  7 ++++-
 target/unicore32/Makefile.objs          |  8 +++--
 target/xtensa/Makefile.objs             | 14 ++++++---
 trace/Makefile.objs                     |  2 +-
 translate-all.c                         |  4 ++-
 62 files changed, 322 insertions(+), 73 deletions(-)
 create mode 100644 default-configs/aarch64-libtcg.mak
 create mode 100644 default-configs/alpha-libtcg.mak
 create mode 100644 default-configs/arm-libtcg.mak
 create mode 100644 default-configs/armeb-libtcg.mak
 create mode 100644 default-configs/cris-libtcg.mak
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
 create mode 100644 default-configs/unicore32-libtcg.mak
 create mode 100644 default-configs/x86_64-libtcg.mak
 create mode 100644 libtcg/Makefile.objs
 create mode 100644 libtcg/qemu.h
 create mode 100644 libtcg/tcg.c
 create mode 100644 libtcg/tcg.h

diff --git a/Makefile b/Makefile
index 1a8bfb225c..0e6925e04f 100644
--- a/Makefile
+++ b/Makefile
@@ -26,7 +26,14 @@ endif
 
 CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
 CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_DIRS)),y)
+CONFIG_LIBTCG := $(if $(filter %-libtcg,$(TARGET_DIRS)),y)
 CONFIG_ALL=y
+
+# If there's at least a *-libtcg target we need to build everything with -fPIC
+ifeq ($(CONFIG_LIBTCG),y)
+QEMU_CFLAGS+=-fPIC
+endif
+
 -include config-all-devices.mak
 -include config-all-disas.mak
 
diff --git a/Makefile.target b/Makefile.target
index 8ae82cb311..6e3df541e0 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -15,10 +15,23 @@ QEMU_CFLAGS += -I.. -I$(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEED_CPU_H
 
 QEMU_CFLAGS+=-I$(SRC_PATH)/include
 
+# By default install in bindir
+PROGS_INSTALL_DIR := $(bindir)
+
 ifdef CONFIG_USER_ONLY
+ifdef CONFIG_LIBTCG
+# libtcg
+QEMU_PROG=libtcg-$(TARGET_NAME)$(DSOSUF)
+QEMU_PROG_BUILD = $(QEMU_PROG)
+QEMU_CFLAGS+=-fPIC
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
@@ -85,17 +98,20 @@ all: $(PROGS) stap
 
 #########################################################
 # cpu emulator library
-obj-y = exec.o translate-all.o cpu-exec.o
+obj-y = exec.o translate-all.o
+ifndef CONFIG_LIBTCG
+obj-y += cpu-exec.o
+obj-y += tcg-runtime.o
+obj-y += fpu/softfloat.o
+endif
 obj-y += translate-common.o
 obj-y += cpu-exec-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) += tci.o
 obj-y += tcg/tcg-common.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
-obj-y += fpu/softfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
-obj-y += tcg-runtime.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 
@@ -133,6 +149,19 @@ obj-y += gdbstub.o user-exec.o
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
+QEMU_LDFLAGS+=-shared
+
+endif #CONFIG_LIBTCG
+
+#########################################################
 # System emulator target
 ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
@@ -220,8 +249,11 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 endif
 
 install: all
+ifdef CONFIG_LIBTINYCODE
+	$(INSTALL_DATA) $(SRC_PATH)/tcg/tcg-opc.h $(SRC_PATH)/libtcg/tcg.h "$(DESTDIR)$(includedir)"
+endif
 ifneq ($(PROGS),)
-	$(call install-prog,$(PROGS),$(DESTDIR)$(bindir))
+	$(call install-prog,$(PROGS),$(DESTDIR)$(PROGS_INSTALL_DIR))
 endif
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset"
diff --git a/configure b/configure
index 86f5214dd0..352a74cec8 100755
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
@@ -676,6 +677,7 @@ Haiku)
   audio_possible_drivers="oss alsa sdl pa"
   linux="yes"
   linux_user="yes"
+  libtcg="yes"
   kvm="yes"
   vhost_net="yes"
   vhost_scsi="yes"
@@ -969,6 +971,10 @@ for opt do
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
@@ -1245,6 +1251,7 @@ EXTRA_CFLAGS="$CPU_CFLAGS $EXTRA_CFLAGS"
 if [ "$ARCH" = "unknown" ]; then
   bsd_user="no"
   linux_user="no"
+  libtcg="no"
 fi
 
 default_target_list=""
@@ -1260,6 +1267,9 @@ fi
 if [ "$bsd_user" = "yes" ]; then
     mak_wilds="${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
 fi
+if [ "$libtcg" = "yes" ]; then
+    mak_wilds="${mak_wilds} $source_path/default-configs/*-libtcg.mak"
+fi
 
 for config in $mak_wilds; do
     default_target_list="${default_target_list} $(basename "$config" .mak)"
@@ -1401,6 +1411,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   tcmalloc        tcmalloc support
   jemalloc        jemalloc support
   replication     replication support
+  libtcg          standalone TCG library
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -5112,6 +5123,7 @@ echo "tcmalloc support  $tcmalloc"
 echo "jemalloc support  $jemalloc"
 echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
+echo "libtcg enabled    $libtcg"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -5853,6 +5865,7 @@ target_softmmu="no"
 target_user_only="no"
 target_linux_user="no"
 target_bsd_user="no"
+target_libtcg="no"
 case "$target" in
   ${target_name}-softmmu)
     target_softmmu="yes"
@@ -5871,6 +5884,10 @@ case "$target" in
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
@@ -6063,6 +6080,9 @@ fi
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
diff --git a/default-configs/unicore32-libtcg.mak b/default-configs/unicore32-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/default-configs/x86_64-libtcg.mak b/default-configs/x86_64-libtcg.mak
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index a4c94e522d..a58d7c404c 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -1,11 +1,14 @@
 # core qdev-related obj files, also used by *-user:
-common-obj-y += qdev.o qdev-properties.o
+common-obj-y += qdev-properties.o
+#ifndef CONFIG_LIBTCG
+common-obj-y += qdev.o
 common-obj-y += bus.o
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
index 1cfc43b9ff..fa68de92db 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -20,6 +20,14 @@
 
 #define HELPER(name) glue(helper_, name)
 
+/* In libtcg we don't want helpers, therefore we leave these fields empty so
+   that we don't needlessly introduce a dependency towards the helper. */
+#ifdef CONFIG_LIBTCG
+# define HELPER_REF(helper) (0)
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
diff --git a/libtcg/Makefile.objs b/libtcg/Makefile.objs
new file mode 100644
index 0000000000..a1e7720ce3
--- /dev/null
+++ b/libtcg/Makefile.objs
@@ -0,0 +1 @@
+obj-y += tcg.o
diff --git a/libtcg/qemu.h b/libtcg/qemu.h
new file mode 100644
index 0000000000..cc2131493a
--- /dev/null
+++ b/libtcg/qemu.h
@@ -0,0 +1,6 @@
+#ifndef QEMU_H
+#define QEMU_H
+
+#include "qemu-user-common.h"
+
+#endif /* QEMU_H */
diff --git a/libtcg/tcg.c b/libtcg/tcg.c
new file mode 100644
index 0000000000..f1ce37c77b
--- /dev/null
+++ b/libtcg/tcg.c
@@ -0,0 +1,55 @@
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "exec/exec-all.h"
+#include "qemu/cutils.h"
+
+unsigned long guest_base;
+int singlestep;
+
+void mmap_lock(void)
+{
+    abort();
+}
+
+void mmap_unlock(void)
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
+    abort();
+}
+
+#include "disas/disas.h"
+#include "cpu.h"
+
+void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
+                  tb_page_addr_t phys_page2);
+
+void test(void);
+void test(void) {
+  void *x = target_disas;
+  x = &guest_base;
+  x = &tcg_exec_init;
+  x = &module_call_init;
+  // cpu_init("");
+#ifdef TARGET_X86_64
+  X86_CPU(cpu_generic_init(TYPE_X86_CPU, ""));
+#endif
+  x = &cpu_reset;
+  x = &qemu_set_log;
+  x = &g_hash_table_foreach;
+  x = &get_page_addr_code;
+  x = &tcg_func_start;
+  x = &gen_intermediate_code;
+  x = &tb_link_page;
+  // x = &target_mmap;
+  x = &cpu_get_tb_cpu_state;
+  (void) x;
+}
diff --git a/libtcg/tcg.h b/libtcg/tcg.h
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/target/alpha/Makefile.objs b/target/alpha/Makefile.objs
index 63664629f6..5ee1bacf27 100644
--- a/target/alpha/Makefile.objs
+++ b/target/alpha/Makefile.objs
@@ -1,4 +1,9 @@
+obj-y += translate.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o
-obj-y += translate.o helper.o cpu.o
-obj-y += int_helper.o fpu_helper.o vax_helper.o sys_helper.o mem_helper.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += helper.o int_helper.o fpu_helper.o vax_helper.o sys_helper.o mem_helper.o
 obj-y += gdbstub.o
+endif
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 847fb52ee0..75a6fc637a 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -1,12 +1,22 @@
-obj-y += arm-semi.o
+obj-y += translate.o
+obj-$(TARGET_AARCH64) += translate-a64.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o psci.o arch_dump.o monitor.o
+obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
 obj-$(CONFIG_KVM) += kvm.o
 obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) += kvm32.o
 obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) += kvm64.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-$(TARGET_AARCH64) += cpu64.o
+
+obj-y += helper.o op_helper.o neon_helper.o iwmmxt_helper.o crypto_helper.o
+obj-$(TARGET_AARCH64) += helper-a64.o
+
+obj-y += arm-semi.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += neon_helper.o iwmmxt_helper.o
+
 obj-y += gdbstub.o
-obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
-obj-y += crypto_helper.o
-obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
+obj-$(TARGET_AARCH64) += gdbstub64.o
+endif
diff --git a/target/cris/Makefile.objs b/target/cris/Makefile.objs
index 7779227fc4..1270edca79 100644
--- a/target/cris/Makefile.objs
+++ b/target/cris/Makefile.objs
@@ -1,3 +1,9 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
+obj-y += translate.o
+
 obj-$(CONFIG_SOFTMMU) += mmu.o machine.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += helper.o op_helper.o
+obj-y += gdbstub.o
+endif
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index b223d7932b..6653f1c9dd 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -1,7 +1,13 @@
-obj-y += translate.o helper.o cpu.o bpt_helper.o
-obj-y += excp_helper.o fpu_helper.o cc_helper.o int_helper.o svm_helper.o
-obj-y += smm_helper.o misc_helper.o mem_helper.o seg_helper.o mpx_helper.o
-obj-y += gdbstub.o
+obj-y += translate.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o hyperv.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += helper.o bpt_helper.o int_helper.o misc_helper.o mem_helper.o \
+         excp_helper.o fpu_helper.o cc_helper.o svm_helper.o smm_helper.o \
+         seg_helper.o mpx_helper.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+obj-y += gdbstub.o
+endif
diff --git a/target/lm32/Makefile.objs b/target/lm32/Makefile.objs
index c3e1bd6bd6..737a6b252d 100644
--- a/target/lm32/Makefile.objs
+++ b/target/lm32/Makefile.objs
@@ -1,4 +1,10 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
-obj-y += lm32-semi.o
+obj-y += translate.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += helper.o op_helper.o
+obj-y += lm32-semi.o
+obj-y += gdbstub.o
+endif
diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
index 02cf616a78..9f1bd5de59 100644
--- a/target/m68k/Makefile.objs
+++ b/target/m68k/Makefile.objs
@@ -1,3 +1,8 @@
+obj-y += translate.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += helper.o op_helper.o
 obj-y += m68k-semi.o
-obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += gdbstub.o
+endif
diff --git a/target/microblaze/Makefile.objs b/target/microblaze/Makefile.objs
index f3d7b44c89..898ddbcb0e 100644
--- a/target/microblaze/Makefile.objs
+++ b/target/microblaze/Makefile.objs
@@ -1,3 +1,9 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += gdbstub.o
+obj-y += translate.o
+
 obj-$(CONFIG_SOFTMMU) += mmu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += helper.o op_helper.o
+obj-y += gdbstub.o
+endif
diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
index bc5ed8511f..d7eae8b9c5 100644
--- a/target/mips/Makefile.objs
+++ b/target/mips/Makefile.objs
@@ -1,4 +1,11 @@
-obj-y += translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o cpu.o
-obj-y += gdbstub.o msa_helper.o mips-semi.o
+obj-y += translate.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o
 obj-$(CONFIG_KVM) += kvm.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += dsp_helper.o op_helper.o lmi_helper.o helper.o msa_helper.o
+obj-y += mips-semi.o
+obj-y += gdbstub.o
+endif
diff --git a/target/moxie/Makefile.objs b/target/moxie/Makefile.objs
index 6381d4d636..5afe63852d 100644
--- a/target/moxie/Makefile.objs
+++ b/target/moxie/Makefile.objs
@@ -1,2 +1,8 @@
-obj-y += translate.o helper.o machine.o cpu.o machine.o
+obj-y += translate.o
+
 obj-$(CONFIG_SOFTMMU) += mmu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o machine.o
+obj-y += helper.o
+endif
diff --git a/target/openrisc/Makefile.objs b/target/openrisc/Makefile.objs
index 397d01650e..ea466e9224 100644
--- a/target/openrisc/Makefile.objs
+++ b/target/openrisc/Makefile.objs
@@ -1,5 +1,10 @@
+obj-y += translate.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o
-obj-y += cpu.o exception.o interrupt.o mmu.o translate.o
-obj-y += exception_helper.o fpu_helper.o int_helper.o \
-         interrupt_helper.o mmu_helper.o sys_helper.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o exception.o interrupt.o mmu.o
+obj-y += exception_helper.o fpu_helper.o int_helper.o interrupt_helper.o \
+         mmu_helper.o sys_helper.o
 obj-y += gdbstub.o
+endif
diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
index e667e69701..0b179acd0e 100644
--- a/target/ppc/Makefile.objs
+++ b/target/ppc/Makefile.objs
@@ -1,17 +1,17 @@
-obj-y += cpu-models.o
 obj-y += translate.o
+obj-y += cpu-models.o
+
 ifeq ($(CONFIG_SOFTMMU),y)
-obj-y += machine.o mmu_helper.o mmu-hash32.o monitor.o
+obj-y += machine.o mmu-hash32.o monitor.o
+obj-y += mmu_helper.o
 obj-$(TARGET_PPC64) += mmu-hash64.o arch_dump.o
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
+obj-y += int_helper.o dfp_helper.o timebase_helper.o mem_helper.o misc_helper.o fpu_helper.o excp_helper.o
 obj-$(CONFIG_USER_ONLY) += user_only_helper.o
 obj-y += gdbstub.o
+endif
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 59e9552d2b..bc9363e9e2 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6766,6 +6766,7 @@ GEN_HANDLER2_E(trechkpt, "trechkpt", 0x1F, 0x0E, 0x1F, 0x03FFF800, \
 #include "helper_regs.h"
 #include "translate_init.c"
 
+#ifndef CONFIG_LIBTCG
 /*****************************************************************************/
 /* Misc PowerPC helpers */
 void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
@@ -6932,6 +6933,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 #undef RGPL
 #undef RFPL
 }
+#endif
 
 void ppc_cpu_dump_statistics(CPUState *cs, FILE*f,
                              fprintf_function cpu_fprintf, int flags)
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 74e3339bd8..7919ebe700 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9453,6 +9453,7 @@ static void dump_ppc_insns (CPUPPCState *env)
 }
 #endif
 
+#ifndef CONFIG_LIBTCG
 static bool avr_need_swap(CPUPPCState *env)
 {
 #ifdef HOST_WORDS_BIGENDIAN
@@ -9638,6 +9639,7 @@ static int gdb_set_vsx_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     }
     return 0;
 }
+#endif
 
 static int ppc_fixup_cpu(PowerPCCPU *cpu)
 {
@@ -9740,6 +9742,7 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     init_ppc_proc(cpu);
 
+#ifndef CONFIG_LIBTCG
     if (pcc->insns_flags & PPC_FLOAT) {
         gdb_register_coprocessor(cs, gdb_get_float_reg, gdb_set_float_reg,
                                  33, "power-fpu.xml", 0);
@@ -9756,6 +9759,7 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
         gdb_register_coprocessor(cs, gdb_get_vsx_reg, gdb_set_vsx_reg,
                                  32, "power-vsx.xml", 0);
     }
+#endif
 
     qemu_init_vcpu(cs);
 
@@ -10564,11 +10568,14 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = ppc_cpu_class_by_name;
     cc->has_work = ppc_cpu_has_work;
+#ifndef CONFIG_LIBTCG
     cc->do_interrupt = ppc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt;
     cc->dump_state = ppc_cpu_dump_state;
+#endif
     cc->dump_statistics = ppc_cpu_dump_statistics;
     cc->set_pc = ppc_cpu_set_pc;
+#ifndef CONFIG_LIBTCG
     cc->gdb_read_register = ppc_cpu_gdb_read_register;
     cc->gdb_write_register = ppc_cpu_gdb_write_register;
 #ifdef CONFIG_USER_ONLY
@@ -10580,6 +10587,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->write_elf64_note = ppc64_cpu_write_elf64_note;
 #endif
 #endif
+#endif
     cc->cpu_exec_enter = ppc_cpu_exec_enter;
 
     cc->gdb_num_core_regs = 71;
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index c573633bd1..97986fca4e 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -1,9 +1,17 @@
-obj-y += translate.o helper.o cpu.o interrupt.o
-obj-y += int_helper.o fpu_helper.o cc_helper.o mem_helper.o misc_helper.o
-obj-y += gdbstub.o cpu_models.o cpu_features.o
-obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o
+obj-y += translate.o
+
+obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o
+obj-$(CONFIG_SOFTMMU) += mmu_helper.o
 obj-$(CONFIG_KVM) += kvm.o
 
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o interrupt.o
+obj-y += helper.o int_helper.o fpu_helper.o cc_helper.o mem_helper.o \
+         misc_helper.o
+obj-y += cpu_models.o cpu_features.o
+obj-y += gdbstub.o
+endif
+
 # build and run feature list generator
 feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
 feat-dst = $(BUILD_DIR)/$(TARGET_DIR)
diff --git a/target/sh4/Makefile.objs b/target/sh4/Makefile.objs
index 2c25d96e65..cfbc95fd46 100644
--- a/target/sh4/Makefile.objs
+++ b/target/sh4/Makefile.objs
@@ -1,3 +1,9 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
+obj-y += translate.o
+
 obj-$(CONFIG_SOFTMMU) += monitor.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += helper.o op_helper.o
 obj-y += gdbstub.o
+endif
diff --git a/target/sparc/Makefile.objs b/target/sparc/Makefile.objs
index ec905698c5..fa824d541c 100644
--- a/target/sparc/Makefile.objs
+++ b/target/sparc/Makefile.objs
@@ -1,7 +1,14 @@
+obj-y += translate.o
+
 obj-$(CONFIG_SOFTMMU) += machine.o monitor.o
-obj-y += translate.o helper.o cpu.o
-obj-y += fop_helper.o cc_helper.o win_helper.o mmu_helper.o ldst_helper.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+
+obj-y += helper.o fop_helper.o cc_helper.o win_helper.o mmu_helper.o \
+         ldst_helper.o
 obj-$(TARGET_SPARC) += int32_helper.o
-obj-$(TARGET_SPARC64) += int64_helper.o
-obj-$(TARGET_SPARC64) += vis_helper.o
+obj-$(TARGET_SPARC64) += int64_helper.o vis_helper.o
+
 obj-y += gdbstub.o
+endif
diff --git a/target/tilegx/Makefile.objs b/target/tilegx/Makefile.objs
index 0db778f407..ddf2e41c51 100644
--- a/target/tilegx/Makefile.objs
+++ b/target/tilegx/Makefile.objs
@@ -1 +1,6 @@
-obj-y += cpu.o translate.o helper.o simd_helper.o
+obj-y += translate.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += helper.o simd_helper.o
+endif
diff --git a/target/tricore/Makefile.objs b/target/tricore/Makefile.objs
index 7a05670718..9b12c51db0 100644
--- a/target/tricore/Makefile.objs
+++ b/target/tricore/Makefile.objs
@@ -1 +1,6 @@
-obj-y += translate.o helper.o cpu.o op_helper.o fpu_helper.o
+obj-y += translate.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += helper.o op_helper.o fpu_helper.o
+endif
diff --git a/target/unicore32/Makefile.objs b/target/unicore32/Makefile.objs
index 6b41b1e9ef..c936429f94 100644
--- a/target/unicore32/Makefile.objs
+++ b/target/unicore32/Makefile.objs
@@ -1,4 +1,8 @@
-obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += ucf64_helper.o
+obj-y += translate.o
 
 obj-$(CONFIG_SOFTMMU) += softmmu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += helper.o op_helper.o ucf64_helper.o
+endif
diff --git a/target/xtensa/Makefile.objs b/target/xtensa/Makefile.objs
index 481de91973..393a12caea 100644
--- a/target/xtensa/Makefile.objs
+++ b/target/xtensa/Makefile.objs
@@ -1,7 +1,11 @@
-obj-y += xtensa-semi.o
-obj-y += core-dc232b.o
-obj-y += core-dc233c.o
-obj-y += core-fsf.o
+obj-y += translate.o
+
 obj-$(CONFIG_SOFTMMU) += monitor.o
-obj-y += translate.o op_helper.o helper.o cpu.o
+
+ifndef CONFIG_LIBTCG
+obj-y += cpu.o
+obj-y += helper.o op_helper.o
+obj-y += xtensa-semi.o
+obj-y += core-dc232b.o core-dc233c.o core-fsf.o
 obj-y += gdbstub.o
+endif
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index 1e1ce7479d..a6874d769b 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -118,7 +118,7 @@ $(obj)/generated-helpers.c-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)
 
 $(obj)/generated-helpers.o: $(obj)/generated-helpers.c
 
-target-obj-y += generated-helpers.o
+target-obj-$(call lnot,$(CONFIG_LIBTCG)) += generated-helpers.o
 
 
 $(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
diff --git a/translate-all.c b/translate-all.c
index 20262938bb..c952271651 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -1239,7 +1239,9 @@ static inline void tb_alloc_page(TranslationBlock *tb,
  *
  * Called with mmap_lock held for user-mode emulation.
  */
-static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
+void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
+                  tb_page_addr_t phys_page2);
+void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
                          tb_page_addr_t phys_page2)
 {
     uint32_t h;
-- 
2.11.0
