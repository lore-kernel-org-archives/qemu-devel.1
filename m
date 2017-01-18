Received: from eggs.gnu.org ([2001:4830:134:3::10]:46847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTyIw-0004uh-OO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTyIt-0001fZ-EI
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:06 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:58424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cTyIt-0001dx-4r
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:03 -0500
From: Marek Vasut <marex@denx.de>
Date: Wed, 18 Jan 2017 23:01:46 +0100
Message-Id: <20170118220146.489-8-marex@denx.de>
In-Reply-To: <20170118220146.489-1-marex@denx.de>
References: <20170118220146.489-1-marex@denx.de>
Subject: [Qemu-devel] [PATCH V6 7/7] nios2: Add support for Nios-II R1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>, Jeff Da Silva <jdasilva@altera.com>, Ley Foon Tan <lftan@altera.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

Add remaining bits of the Altera NiosII R1 support into qemu, which
is documentation, MAINTAINERS file entry, configure bits, arch_init
and configuration files for both linux-user (userland binaries) and
softmmu (hardware emulation).

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: Jeff Da Silva <jdasilva@altera.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Sandra Loosemore <sandra@codesourcery.com>
Cc: Yves Vandervennet <yvanderv@altera.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alexander Graf <agraf@suse.de>
---
V3: Checkpatch cleanup
V4: Rebase on top of qemu/master
V5: Rebase on top of qemu/master
V6: Pathname change in MAINTAINERS
---
 MAINTAINERS                          | 8 ++++++++
 arch_init.c                          | 2 ++
 configure                            | 5 +++++
 default-configs/nios2-linux-user.mak | 1 +
 default-configs/nios2-softmmu.mak    | 6 ++++++
 include/sysemu/arch_init.h           | 1 +
 qemu-doc.texi                        | 3 +++
 7 files changed, 26 insertions(+)
 create mode 100644 default-configs/nios2-linux-user.mak
 create mode 100644 default-configs/nios2-softmmu.mak

diff --git a/MAINTAINERS b/MAINTAINERS
index 1444b26dc0..515f9fd31a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -181,6 +181,14 @@ F: disas/moxie.c
 F: hw/moxie/
 F: default-configs/moxie-softmmu.mak
 
+NiosII
+M: Chris Wulff <crwulff@gmail.com>
+M: Marek Vasut <marex@denx.de>
+S: Maintained
+F: target/nios2/
+F: hw/nios2/
+F: disas/nios2.c
+
 OpenRISC
 M: Jia Liu <proljc@gmail.com>
 S: Maintained
diff --git a/arch_init.c b/arch_init.c
index 5cc58b2c35..20d83ff5c0 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -64,6 +64,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_MIPS
 #elif defined(TARGET_MOXIE)
 #define QEMU_ARCH QEMU_ARCH_MOXIE
+#elif defined(TARGET_NIOS2)
+#define QEMU_ARCH QEMU_ARCH_NIOS2
 #elif defined(TARGET_OPENRISC)
 #define QEMU_ARCH QEMU_ARCH_OPENRISC
 #elif defined(TARGET_PPC)
diff --git a/configure b/configure
index 86f5214dd0..48e7088948 100755
--- a/configure
+++ b/configure
@@ -5935,6 +5935,8 @@ case "$target_name" in
   ;;
   moxie)
   ;;
+  nios2)
+  ;;
   or32)
     TARGET_ARCH=openrisc
     TARGET_BASE_ARCH=openrisc
@@ -6128,6 +6130,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   moxie*)
     disas_config "MOXIE"
   ;;
+  nios2)
+    disas_config "NIOS2"
+  ;;
   or32)
     disas_config "OPENRISC"
   ;;
diff --git a/default-configs/nios2-linux-user.mak b/default-configs/nios2-linux-user.mak
new file mode 100644
index 0000000000..5be3eb795d
--- /dev/null
+++ b/default-configs/nios2-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for nios2-linux-user
diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
new file mode 100644
index 0000000000..74dc70caae
--- /dev/null
+++ b/default-configs/nios2-softmmu.mak
@@ -0,0 +1,6 @@
+# Default configuration for nios2-softmmu
+
+CONFIG_NIOS2=y
+CONFIG_SERIAL=y
+CONFIG_PTIMER=y
+CONFIG_ALTERA_TIMER=y
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 1c9dad1b72..fe60e114b3 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -23,6 +23,7 @@ enum {
     QEMU_ARCH_UNICORE32 = (1 << 14),
     QEMU_ARCH_MOXIE = (1 << 15),
     QEMU_ARCH_TRICORE = (1 << 16),
+    QEMU_ARCH_NIOS2 = (1 << 17),
 };
 
 extern const uint32_t arch_type;
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 02cb39d430..672ed3a1dd 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2891,6 +2891,9 @@ The binary format is detected automatically.
 @command{qemu-mips} TODO.
 @command{qemu-mipsel} TODO.
 
+@cindex user mode (NiosII)
+@command{qemu-nios2} TODO.
+
 @cindex user mode (PowerPC)
 @command{qemu-ppc64abi32} TODO.
 @command{qemu-ppc64} TODO.
-- 
2.11.0
