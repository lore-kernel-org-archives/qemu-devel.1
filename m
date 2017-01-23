Received: from eggs.gnu.org ([2001:4830:134:3::10]:47839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVmvD-0004Ov-TT
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVmvC-0007qU-M3
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:17:07 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVmvC-0007qF-J9
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:17:06 -0500
Received: by mail-qt0-x244.google.com with SMTP id n13so20516614qtc.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 14:17:06 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 23 Jan 2017 14:16:50 -0800
Message-Id: <20170123221650.9267-8-rth@twiddle.net>
In-Reply-To: <20170123221650.9267-1-rth@twiddle.net>
References: <20170123221650.9267-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 7/7] nios2: Add support for Nios-II R1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>, Jeff Da Silva <jdasilva@altera.com>, Ley Foon Tan <lftan@altera.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>

From: Marek Vasut <marex@denx.de>

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
Reviewed-by: Alexander Graf <agraf@suse.de>
Message-Id: <20170118220146.489-8-marex@denx.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
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
index ad10004..69047e0 100644
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
index 6c4e287..828a271 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -63,6 +63,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_MIPS
 #elif defined(TARGET_MOXIE)
 #define QEMU_ARCH QEMU_ARCH_MOXIE
+#elif defined(TARGET_NIOS2)
+#define QEMU_ARCH QEMU_ARCH_NIOS2
 #elif defined(TARGET_OPENRISC)
 #define QEMU_ARCH QEMU_ARCH_OPENRISC
 #elif defined(TARGET_PPC)
diff --git a/configure b/configure
index 53a39ba..baacbb0 100755
--- a/configure
+++ b/configure
@@ -5933,6 +5933,8 @@ case "$target_name" in
   ;;
   moxie)
   ;;
+  nios2)
+  ;;
   or32)
     TARGET_ARCH=openrisc
     TARGET_BASE_ARCH=openrisc
@@ -6135,6 +6137,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
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
index 0000000..5be3eb7
--- /dev/null
+++ b/default-configs/nios2-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for nios2-linux-user
diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
new file mode 100644
index 0000000..74dc70c
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
index 20b01e3..2bf16b2 100644
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
index 0b2746f..fe7b69b 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2901,6 +2901,9 @@ The binary format is detected automatically.
 @command{qemu-mips} TODO.
 @command{qemu-mipsel} TODO.
 
+@cindex user mode (NiosII)
+@command{qemu-nios2} TODO.
+
 @cindex user mode (PowerPC)
 @command{qemu-ppc64abi32} TODO.
 @command{qemu-ppc64} TODO.
-- 
2.9.3
