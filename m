Received: from eggs.gnu.org ([2001:4830:134:3::10]:55230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Cowgill@mips.com>) id 1eBll4-0005fr-Lq
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Cowgill@mips.com>) id 1eBll0-0002k4-OL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:04:26 -0500
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:45897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Cowgill@mips.com>)
	id 1eBll0-0002iY-IZ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:04:22 -0500
From: James Cowgill <james.cowgill@mips.com>
Date: Mon, 6 Nov 2017 18:03:51 +0000
Message-ID: <20171106180351.30749-1-james.cowgill@mips.com>
In-Reply-To: <20171103120703.15749-1-james.cowgill@mips.com>
References: <20171103120703.15749-1-james.cowgill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] linux-user: return EINVAL from
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
Changes from v1:
- add comment

 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d4497dec5d..419991e834 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10482,6 +10482,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
2.15.0
