Received: from eggs.gnu.org ([2001:4830:134:3::10]:51201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gF94Q-0001I3-7W
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 22:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gF94N-00062n-0k
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 22:38:53 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gF94M-00060G-LO
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 22:38:50 -0400
Received: by mail-lj1-x243.google.com with SMTP id x3-v6so3254808lji.13
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 19:38:47 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 23 Oct 2018 19:38:31 -0700
Message-Id: <20181024023831.2529-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] linux-user/flatload: fix initial stack pointer
 alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>

Stack pointer alignment code incorrectly adds stack_size to sp instead
of subtracting it. It also does not take flat_argvp_envp_on_stack() into
account when calculating stack_size. This results in initial stack
pointer misalignment with certain set of command line arguments and
environment variables and correct alignment for the same binary with a
different set of arguments. This misalignment causes failures in the
following tests in the testsuite of gcc built for xtensa uclinux:

  gcc.dg/torture/vshuf-v64qi.c
  gcc.dg/torture/vshuf-v8sf.c
  gcc.dg/torture/vshuf-v8si.c

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/flatload.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 2eefe55e5000..1893966b5b30 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -771,10 +771,12 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
     /* Enforce final stack alignment of 16 bytes.  This is sufficient
        for all current targets, and excess alignment is harmless.  */
     stack_len = bprm->envc + bprm->argc + 2;
-    stack_len += 3;	/* argc, arvg, argp */
+    stack_len += flat_argvp_envp_on_stack() ? 2 : 0; /* arvg, argp */
+    stack_len += 1; /* argc */
     stack_len *= sizeof(abi_ulong);
-    if ((sp + stack_len) & 15)
-        sp -= 16 - ((sp + stack_len) & 15);
+    if ((sp - stack_len) & 15) {
+        sp -= ((sp - stack_len) & 15);
+    }
     sp = loader_build_argptr(bprm->envc, bprm->argc, sp, p,
                              flat_argvp_envp_on_stack());
 
-- 
2.11.0
