Received: from eggs.gnu.org ([2001:4830:134:3::10]:55862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDf61-0000iP-Go
	for qemu-devel@nongnu.org; Tue, 01 May 2018 19:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDf5w-0002gV-HF
	for qemu-devel@nongnu.org; Tue, 01 May 2018 19:54:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fDf5w-0002ei-6Q
	for qemu-devel@nongnu.org; Tue, 01 May 2018 19:54:04 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  2 May 2018 01:53:32 +0200
Message-Id: <20180501235332.31245-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] linux-user: remove useless padding in flock64
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Since commit 8efb2ed5ec ("linux-user: Correct signedness of
target_flock l_start and l_len fields"), flock64 structure uses
abi_llong for l_start and l_len in place of "unsigned long long"
this should force them to be aligned accordingly to the target
rules. So we can remove the padding field and the QEMU_PACKED
attribute.

I have compared the result of the following program before and
after the change:

    cat -> flock64_dump  <<EOF
    p/d sizeof(struct target_flock64)
    p/d &((struct target_flock64 *)0)->l_type
    p/d &((struct target_flock64 *)0)->l_whence
    p/d &((struct target_flock64 *)0)->l_start
    p/d &((struct target_flock64 *)0)->l_len
    p/d &((struct target_flock64 *)0)->l_pid
    quit
    EOF

    for file in build/all/*-linux-user/qemu-* ; do
    echo $file
    gdb -batch -nx -x flock64_dump $file 2> /dev/null
    done

The sizeof() changes because we remove the QEMU_PACKED.
The new size is 32 (except for i386 and m68k) and this is
the real size of "struct flock64" on the target architecture.

The following architectures differ:
aarch64_be, aarch64, alpha, armeb, arm, cris, hppa, nios2, or1k,
riscv32, riscv64, s390x.

For a subset of these architectures, I have checked with the following
program the new structure is the correct one:

  #include <stdio.h>
  #define __USE_LARGEFILE64
  #include <fcntl.h>

  int main(void)
  {
	  printf("struct flock64 %d\n", sizeof(struct flock64));
	  printf("l_type %d\n", &((struct flock64 *)0)->l_type);
	  printf("l_whence %d\n", &((struct flock64 *)0)->l_whence);
	  printf("l_start %d\n", &((struct flock64 *)0)->l_start);
	  printf("l_len %d\n", &((struct flock64 *)0)->l_len);
	  printf("l_pid %d\n", &((struct flock64 *)0)->l_pid);
  }

[I have checked aarch64, alpha, arm, s390x]

I have also fixed the alignment value for sh4 (to align llong on 4 bytes)
(see c2e3dee6e0 "linux-user: Define target alignment size")

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/exec/user/abitypes.h |  2 +-
 linux-user/syscall_defs.h    | 23 ++++++++---------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index ba188608c2..743b8bb9ea 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -15,7 +15,7 @@
 #define ABI_LLONG_ALIGNMENT 2
 #endif
 
-#if defined(TARGET_I386) && !defined(TARGET_X86_64)
+#if (defined(TARGET_I386) && !defined(TARGET_X86_64)) || defined(TARGET_SH4)
 #define ABI_LLONG_ALIGNMENT 4
 #endif
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 23f5bccf0e..df3847bc16 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2649,28 +2649,21 @@ struct target_flock {
 };
 
 struct target_flock64 {
-    short  l_type;
-    short  l_whence;
-#if defined(TARGET_PPC) || defined(TARGET_X86_64) || defined(TARGET_MIPS) \
-    || defined(TARGET_SPARC) || defined(TARGET_HPPA) \
-    || defined(TARGET_MICROBLAZE) || defined(TARGET_TILEGX) \
-    || defined(TARGET_XTENSA)
-    int __pad;
-#endif
+    abi_short l_type;
+    abi_short l_whence;
     abi_llong l_start;
     abi_llong l_len;
-    int  l_pid;
-} QEMU_PACKED;
+    abi_int   l_pid;
+};
 
 #ifdef TARGET_ARM
 struct target_eabi_flock64 {
-    short  l_type;
-    short  l_whence;
-    int __pad;
+    abi_short l_type;
+    abi_short l_whence;
     abi_llong l_start;
     abi_llong l_len;
-    int  l_pid;
-} QEMU_PACKED;
+    abi_int   l_pid;
+};
 #endif
 
 struct target_f_owner_ex {
-- 
2.14.3
