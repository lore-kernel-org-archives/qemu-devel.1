Received: from eggs.gnu.org ([2001:4830:134:3::10]:39552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Cowgill@mips.com>) id 1eAapH-0006gR-MV
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Cowgill@mips.com>) id 1eAapD-0007bE-Ma
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:11:55 -0400
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:40400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Cowgill@mips.com>)
	id 1eAapD-0007Vd-E9
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:11:51 -0400
From: James Cowgill <james.cowgill@mips.com>
Date: Fri, 3 Nov 2017 12:07:03 +0000
Message-ID: <20171103120703.15749-1-james.cowgill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] linux-user: return EINVAL from
 prctl(PR_*_SECCOMP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, James Cowgill <james.cowgill@mips.com>

If an application tries to install a seccomp filter using
prctl(PR_SET_SECCOMP), the filter is likely for the target instead of the host
architecture. This will probably cause qemu to be immediately killed when it
executes another syscall.

Prevent this from happening by returning EINVAL from both seccomp prctl
calls. This is the error returned by the kernel when seccomp support is
disabled.

Fixes: https://bugs.launchpad.net/qemu/+bug/1726394
Signed-off-by: James Cowgill <james.cowgill@mips.com>
---
 linux-user/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d4497dec5d..43cd5fb2bb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10482,6 +10482,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             break;
         }
 #endif
+        case PR_GET_SECCOMP:
+        case PR_SET_SECCOMP:
+            ret = -TARGET_EINVAL;
+            break;
         default:
             /* Most prctl options have no pointer arguments */
             ret = get_errno(prctl(arg1, arg2, arg3, arg4, arg5));
-- 
2.15.0
