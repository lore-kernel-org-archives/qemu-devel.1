Received: from eggs.gnu.org ([2001:4830:134:3::10]:34508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDwSH-0008PZ-PS
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDwSD-0004GM-N8
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:26:17 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fDwSD-0004Fo-CB
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:26:13 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  2 May 2018 20:25:52 +0200
Message-Id: <20180502182552.2892-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3] linux-user: remove useless padding in
 flock64 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

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

[I have checked aarch64, alpha, hppa, s390x]

For ARM, the target_flock64 becomes the EABI definition, so we need to
define the OABI one in place of the EABI one and use it when it is
needed.

I have also fixed the alignment value for sh4 (to align llong on 4 bytes)
(see c2e3dee6e0 "linux-user: Define target alignment size")
[We should check alignment properties for cris, nios2 and or1k]

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---

Notes:
    v3:
      - move target_oabi_flock64 to linux-user/arm/target_structs.h
    
    v2:
      - use target_flock64 for ARM EABI,
        and define target_oabi_flock64 for ARM OABI
        I missed the change in v1 because I've tested
        the result of gcc offsetof() and it uses the
        EABI whereas target_flock64 was OABI.

 include/exec/user/abitypes.h    |  2 +-
 linux-user/arm/target_structs.h |  9 +++++++++
 linux-user/syscall.c            | 14 +++++++-------
 linux-user/syscall_defs.h       | 25 ++++---------------------
 4 files changed, 21 insertions(+), 29 deletions(-)

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
 
diff --git a/linux-user/arm/target_structs.h b/linux-user/arm/target_structs.h
index 0bf034cc25..3b83d8b4c5 100644
--- a/linux-user/arm/target_structs.h
+++ b/linux-user/arm/target_structs.h
@@ -49,4 +49,13 @@ struct target_shmid_ds {
     abi_ulong __unused5;
 };
 
+#if defined(TARGET_ABI32)
+struct target_oabi_flock64 {
+    abi_short l_type;
+    abi_short l_whence;
+    abi_llong l_start;
+    abi_llong l_len;
+    abi_int   l_pid;
+} QEMU_PACKED;
+#endif
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 404be44ad5..e4825747f9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6600,10 +6600,10 @@ typedef abi_long from_flock64_fn(struct flock64 *fl, abi_ulong target_addr);
 typedef abi_long to_flock64_fn(abi_ulong target_addr, const struct flock64 *fl);
 
 #if defined(TARGET_ARM) && TARGET_ABI_BITS == 32
-static inline abi_long copy_from_user_eabi_flock64(struct flock64 *fl,
+static inline abi_long copy_from_user_oabi_flock64(struct flock64 *fl,
                                                    abi_ulong target_flock_addr)
 {
-    struct target_eabi_flock64 *target_fl;
+    struct target_oabi_flock64 *target_fl;
     short l_type;
 
     if (!lock_user_struct(VERIFY_READ, target_fl, target_flock_addr, 1)) {
@@ -6620,10 +6620,10 @@ static inline abi_long copy_from_user_eabi_flock64(struct flock64 *fl,
     return 0;
 }
 
-static inline abi_long copy_to_user_eabi_flock64(abi_ulong target_flock_addr,
+static inline abi_long copy_to_user_oabi_flock64(abi_ulong target_flock_addr,
                                                  const struct flock64 *fl)
 {
-    struct target_eabi_flock64 *target_fl;
+    struct target_oabi_flock64 *target_fl;
     short l_type;
 
     if (!lock_user_struct(VERIFY_WRITE, target_fl, target_flock_addr, 0)) {
@@ -11629,9 +11629,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         to_flock64_fn *copyto = copy_to_user_flock64;
 
 #ifdef TARGET_ARM
-        if (((CPUARMState *)cpu_env)->eabi) {
-            copyfrom = copy_from_user_eabi_flock64;
-            copyto = copy_to_user_eabi_flock64;
+        if (!((CPUARMState *)cpu_env)->eabi) {
+            copyfrom = copy_from_user_oabi_flock64;
+            copyto = copy_to_user_oabi_flock64;
         }
 #endif
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 23f5bccf0e..361bb83a29 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2649,29 +2649,12 @@ struct target_flock {
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
-    abi_llong l_start;
-    abi_llong l_len;
-    int  l_pid;
-} QEMU_PACKED;
-
-#ifdef TARGET_ARM
-struct target_eabi_flock64 {
-    short  l_type;
-    short  l_whence;
-    int __pad;
+    abi_short l_type;
+    abi_short l_whence;
     abi_llong l_start;
     abi_llong l_len;
-    int  l_pid;
-} QEMU_PACKED;
-#endif
+    abi_int   l_pid;
+};
 
 struct target_f_owner_ex {
         int type;	/* Owner type of ID.  */
-- 
2.14.3
