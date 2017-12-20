Received: from eggs.gnu.org ([2001:4830:134:3::10]:53668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1eRSHz-0001ce-TM
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1eRSHw-0006Ir-2P
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:31:15 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:42158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1eRSHv-0006Hl-Ql
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:31:11 -0500
Received: by mail-pl0-x244.google.com with SMTP id bd8so7999766plb.9
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 16:31:11 -0800 (PST)
Date: Tue, 19 Dec 2017 16:29:41 -0800
Message-Id: <20171220002941.14560-1-palmer@dabbelt.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [Qemu-devel] [PATCH] linux-user: Implement renameat2 when defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

From: Palmer Dabbelt <palmer@sifive.com>

The RISC-V Linux port was recently accept upstream and will be released
as part of 4.15.  While working on our glibc port I discovered that
qemu's user-mode emulation doesn't support renameat2, which has replaced
rename as part of the default system call list for new architectures.
Since a bunch of commonly used functionality boils down to rename (and
now renameat2), we ended up with many failures.

This patch adds support for renameat2.  As I'm not familiar with QEMU
development, I haven't really testing anything more than a simple
"./configure; make" on the upstream codebase, but I did test this
against our (not yet upstream) QEMU port where it appears to work for
me.  I've just cobbled it together by copying the existing renameat
implementation, but as there appears to be no glibc wrapper for
renameat2 on either of the systems I've tried this on I just emited the
system call directly.

    commit b0da6d44157aa6e652de7634343708251ba64146
    Author: James Hogan <james.hogan@imgtec.com>
    Date:   Fri Apr 29 22:29:26 2016 +0100

        asm-generic: Drop renameat syscall from default list

        The newer renameat2 syscall provides all the functionality provided by
        the renameat syscall and adds flags, so future architectures won't need
        to include renameat.

        Therefore drop the renameat syscall from the generic syscall list unless
        __ARCH_WANT_RENAMEAT is defined by the architecture's unistd.h prior to
        including asm-generic/unistd.h, and adjust all architectures using the
        generic syscall list to define it so that no in-tree architectures are
        affected.

Michael, Sagar, and Bastian are the RISC-V QEMU guys, I just use it.
I've CC'd them all here to serve as sort of a surprise introduction for
everyone -- they haven't seen the patch before, so blame me for the
stupid parts :).

CC: Michael Clark <mjc@sifive.com>
CC: Sagar Karandikar <sagark@eecs.berkeley.edu>
CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 linux-user/syscall.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11c9116c4a1e..ece574f47aca 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8342,6 +8342,21 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
 #endif
+#if defined(TARGET_NR_renameat2) && defined(__NR_renameat2)
+    case TARGET_NR_renameat2:
+        {
+            void *p2;
+            p  = lock_user_string(arg2);
+            p2 = lock_user_string(arg4);
+            if (!p || !p2)
+                ret = -TARGET_EFAULT;
+            else
+                ret = get_errno(syscall(__NR_renameat2, arg1, p, arg3, p2, arg5));
+            unlock_user(p2, arg4, 0);
+            unlock_user(p, arg2, 0);
+        }
+        break;
+#endif
 #ifdef TARGET_NR_mkdir
     case TARGET_NR_mkdir:
         if (!(p = lock_user_string(arg1)))
-- 
2.13.6
