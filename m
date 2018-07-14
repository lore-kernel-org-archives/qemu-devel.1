Received: from eggs.gnu.org ([2001:4830:134:3::10]:55528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1feQLE-0004jn-LX
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 15:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1feQL9-0005tS-OK
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 15:36:28 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1feQL9-0005s7-Dz
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 15:36:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 14 Jul 2018 21:35:53 +0200
Message-Id: <20180714193553.30846-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v3] linux-user: fix mmap_find_vma_reserved()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

The value given by mmap_find_vma_reserved() is used with mmap(),
so it is needed to be aligned with the host page size.

Since commit 18e80c55bb, reserved_va is only aligned to TARGET_PAGE_SIZE,
and it works well if this size is greater or equal to the host page size.

But ppc64 hosts have 64kB page size and when we start a 4kiB page size
guest (like i386), it fails when it tries to mmap the stack:

    mmap stack: Invalid argument

Fixes: 18e80c55bb (linux-user: Tidy and enforce reserved_va initialization)
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v3:
      move initialization of reserved_va to main()
    
    v2:
      fix typo s/has/as/

 linux-user/main.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 52b5a618fe..ea00dd9057 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -78,14 +78,7 @@ int have_guest_base;
 # endif
 #endif
 
-/* That said, reserving *too* much vm space via mmap can run into problems
-   with rlimits, oom due to page table creation, etc.  We will still try it,
-   if directed by the command-line option, but not by default.  */
-#if HOST_LONG_BITS == 64 && TARGET_VIRT_ADDR_SPACE_BITS <= 32
-unsigned long reserved_va = MAX_RESERVED_VA;
-#else
 unsigned long reserved_va;
-#endif
 
 static void usage(int exitcode);
 
@@ -672,6 +665,18 @@ int main(int argc, char **argv, char **envp)
     /* init tcg before creating CPUs and to get qemu_host_page_size */
     tcg_exec_init(0);
 
+    /* Reserving *too* much vm space via mmap can run into problems
+       with rlimits, oom due to page table creation, etc.  We will still try it,
+       if directed by the command-line option, but not by default.  */
+    if (HOST_LONG_BITS == 64 &&
+        TARGET_VIRT_ADDR_SPACE_BITS <= 32 &&
+        reserved_va == 0) {
+        /* reserved_va must be aligned with the host page size
+         * as it is used with mmap()
+         */
+        reserved_va = MAX_RESERVED_VA & qemu_host_page_mask;
+    }
+
     cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
     cpu_reset(cpu);
-- 
2.17.1
