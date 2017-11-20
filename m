Received: from eggs.gnu.org ([2001:4830:134:3::10]:58235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVz-0004g1-1N
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVy-0007xd-1i
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:03 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:42559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVx-0007wv-QM
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:01 -0500
Received: by mail-lf0-x241.google.com with SMTP id m1so11692554lfj.9
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:22:01 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:38 +0200
Message-Id: <a8b154a637b586441bad42259a8a9b9619cd117c.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 10/15] linux-user: return EINVAL from
 prctl(PR_*_SECCOMP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: James Cowgill <james.cowgill@mips.com>

From: James Cowgill <james.cowgill@mips.com>

If an application tries to install a seccomp filter using
prctl(PR_SET_SECCOMP), the filter is likely for the target instead of the host
architecture. This will probably cause qemu to be immediately killed when it
executes another syscall.

Prevent this from happening by returning EINVAL from both seccomp prctl
calls. This is the error returned by the kernel when seccomp support is
disabled.

Fixes: https://bugs.launchpad.net/qemu/+bug/1726394
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: James Cowgill <james.cowgill@mips.com>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 84e123b67b..f31b853bb7 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10505,6 +10505,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             break;
         }
 #endif
+        case PR_GET_SECCOMP:
+        case PR_SET_SECCOMP:
+            /* Disable seccomp to prevent the target disabling syscalls we
+             * need. */
+            ret = -TARGET_EINVAL;
+            break;
         default:
             /* Most prctl options have no pointer arguments */
             ret = get_errno(prctl(arg1, arg2, arg3, arg4, arg5));
-- 
2.14.2
