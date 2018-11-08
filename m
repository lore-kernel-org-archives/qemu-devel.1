Received: from eggs.gnu.org ([2001:4830:134:3::10]:38625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrington@battelle.org>) id 1gKoV5-0001ST-6W
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrington@battelle.org>) id 1gKoUz-000746-TW
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:53:51 -0500
Received: from mx0a-0013ba01.pphosted.com ([67.231.149.77]:50068
	helo=mx0b-0013ba01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <harrington@battelle.org>)
	id 1gKoUz-0006vo-Iu
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:53:45 -0500
Received: from pps.filterd (m0084500.ppops.net [127.0.0.1])
	by mx0a-0013ba01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA8HmM15013337
	for <qemu-devel@nongnu.org>; Thu, 8 Nov 2018 12:53:40 -0500
Received: from lz-cismta01.battelle.org (lp-mail01.battelle.org
	[131.167.218.50])
	by mx0a-0013ba01.pphosted.com with ESMTP id 2nkmh024qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 12:53:40 -0500
Received: from WP-EX03.milky-way.battelle.org (wp-ex03.milky-way.battelle.org
	[10.50.8.133])
	by lz-cismta01.battelle.org (Postfix) with ESMTP id 6D00D700002
	for <qemu-devel@nongnu.org>; Thu,  8 Nov 2018 12:53:39 -0500 (EST)
From: "Harrington, Sean M" <harrington@battelle.org>
Date: Thu, 8 Nov 2018 17:53:38 +0000
Message-ID: <2ddafd9424ab4a30817b8c59e207781d@battelle.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] Added support for ASLR and PIE for target user
 mode binaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello,

I recently had to extend QEMU user mode to support PIE enabled binaries com=
piled for non-native architectures. It was also important to emulate ASLR f=
or the target binary if ASLR was enabled on the host machine. I would like =
to introduce this as a feature into QEMU mainstream as it seems like a feat=
ure others could use as well.

With the patch implementation, ASLR will be enabled if /proc/sys/kernel/ran=
domize_va_space is non-zero on the host machine. An alternative implementat=
ion could be passing an argument during runtime to enable or disable ASLR. =
PIE is automatically enabled as well if the binary has been compiled with t=
his flag.

Best regards,
Sean Harrington

Signed-off-by: Sean Harrington <harrington@battelle.org>
---
 linux-user/Makefile.objs  |  3 +-
 linux-user/elfload.c      |  3 +-
 linux-user/main.c         |  7 +++
 linux-user/randomize_va.c | 95 +++++++++++++++++++++++++++++++++++++++
 linux-user/randomize_va.h | 23 ++++++++++
 5 files changed, 129 insertions(+), 2 deletions(-)
 create mode 100644 linux-user/randomize_va.c
 create mode 100644 linux-user/randomize_va.h

diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 769b8d8336..384944a76d 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,7 +1,8 @@
 obj-y =3D main.o syscall.o strace.o mmap.o signal.o \
         elfload.o linuxload.o uaccess.o uname.o \
         safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
-        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o
+        $(TARGET_ABI_DIR)/cpu_loop.o exit.o fd-trans.o \
+        randomize_va.o

 obj-$(TARGET_HAS_BFLT) +=3D flatload.o
 obj-$(TARGET_I386) +=3D vm86.o
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5bccd2e243..5add383815 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -7,6 +7,7 @@
 #include "qemu.h"
 #include "disas/disas.h"
 #include "qemu/path.h"
+#include "randomize_va.h"

 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -2258,7 +2259,7 @@ static void load_elf_image(const char *image_name, in=
t image_fd,
            image is pre-linked, LOADDR will be non-zero.  Since we do
            not supply MAP_FIXED here we'll use that address if and
            only if it remains available.  */
-        load_addr =3D target_mmap(loaddr, hiaddr - loaddr, PROT_NONE,
+        load_addr =3D get_pie_addr(loaddr, hiaddr - loaddr, PROT_NONE,
                                 MAP_PRIVATE | MAP_ANON | MAP_NORESERVE,
                                 -1, 0);
         if (load_addr =3D=3D -1) {
diff --git a/linux-user/main.c b/linux-user/main.c
index 923cbb753a..3b789001dd 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -37,6 +37,7 @@
 #include "trace/control.h"
 #include "target_elf.h"
 #include "cpu_loop-common.h"
+#include "randomize_va.h"

 char *exec_path;

@@ -694,6 +695,12 @@ int main(int argc, char **argv, char **envp)
     target_environ =3D envlist_to_environ(envlist, NULL);
     envlist_free(envlist);

+    /*
+     * If host has randomized_va_space enabled, emulate the same for the
+     * target.
+     */
+    reserved_va =3D handle_randomized_va(reserved_va, MAX_RESERVED_VA);
+
     /*
      * Now that page sizes are configured in tcg_exec_init() we can do
      * proper page alignment for guest_base.
diff --git a/linux-user/randomize_va.c b/linux-user/randomize_va.c
new file mode 100644
index 0000000000..792212a2b8
--- /dev/null
+++ b/linux-user/randomize_va.c
@@ -0,0 +1,95 @@
+/*
+ *  QEMU user ASLR + PIE emulation
+ *
+ *  Copyright (c) 2018 Sean Harrington (harrington@battelle.org)
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+
+#include "qemu.h"
+#include "qemu-common.h"
+#include "randomize_va.h"
+
+#define PIE_MMAP_ATTEMPTS       10
+#define RANDOMIZATION_RANGE     0x00100000
+
+unsigned long handle_randomized_va(unsigned long va, unsigned long max_va_=
space) {
+
+    int randomize_va_fd =3D open("/proc/sys/kernel/randomize_va_space", O_=
RDONLY);
+    srand(time(NULL));
+
+    if (randomize_va_fd >=3D 0) {
+        int aslr;
+        if (read(randomize_va_fd, &aslr, sizeof(aslr)) < 0) {
+            return va;
+        }
+
+        if (aslr) {
+            /* At start, mmap_next_state is equal to TASK_UNMAPPED_BASE in
+             * mmap.c. Randomly choose a new random value within range
+             * [mmap_next_start - (TASK_UNMAPPED_BASE / 2),
+             *      mmap_next_start - (TASK_UNMAPPED_BASE / 2)]
+             * Also make sure we are page aligned
+             */
+
+            /* If it is possible new va could overflow, prevent it */
+            if ((va + (RANDOMIZATION_RANGE / 2)) > max_va_space)
+            {
+                va =3D max_va_space - (RANDOMIZATION_RANGE / 2);
+            }
+            /* If it is possible new va could underflow, prevent it */
+            else if ((va - (RANDOMIZATION_RANGE / 2)) > max_va_space)
+                va =3D RANDOMIZATION_RANGE / 2;
+
+            /* Perform randomization */
+            abi_ulong offset =3D va - (RANDOMIZATION_RANGE / 2);
+
+            abi_ulong range =3D RANDOMIZATION_RANGE;
+            abi_ulong random_val =3D rand();
+            va =3D (random_val % range) + offset;
+
+            /* Page align result */
+            va &=3D qemu_host_page_mask;
+        }
+    }
+
+    return va;
+}
+
+abi_ulong get_pie_addr(abi_ulong addr, abi_ulong size, int prot_opts,
+                        int map_opts, int fd, off_t offset) {
+    abi_ulong orig_addr =3D addr;
+    abi_ulong newloaddr =3D 0;
+
+    /* New seed for upcoming rand. */
+    srand(time(NULL));
+
+    /* If addr is 0, kernel handles finding a valid address. If non-zero
+     * we should honor the request for the specified mmap address.
+     */
+    if (orig_addr =3D=3D 0) {
+        while (newloaddr < size)
+            newloaddr =3D rand() & TARGET_PAGE_MASK;
+    }
+    else
+        newloaddr =3D addr;
+
+    addr =3D target_mmap(newloaddr, size, prot_opts, map_opts, fd,
+                            offset);
+
+    return addr;
+}
diff --git a/linux-user/randomize_va.h b/linux-user/randomize_va.h
new file mode 100644
index 0000000000..43b1a1a1a3
--- /dev/null
+++ b/linux-user/randomize_va.h
@@ -0,0 +1,23 @@
+/*
+ *  QEMU user ASLR + PIE emulation
+ *
+ *  Copyright (c) 2018 Sean Harrington (harrington@battelle.org)
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+unsigned long handle_randomized_va(unsigned long va, unsigned long max_va_=
space);
+
+abi_ulong get_pie_addr(abi_ulong addr, abi_ulong size, int prot_opts,
+                        int map_opts, int fd, off_t offset);
--
2.17.2 (Apple Git-113)
