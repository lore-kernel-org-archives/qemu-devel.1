Received: from eggs.gnu.org ([2001:4830:134:3::10]:45500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ekvia-00038Y-Dk
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 12:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ekviX-0003a5-61
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 12:47:12 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:38714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ekviW-0003XU-To
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 12:47:09 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 11 Feb 2018 18:47:04 +0100
Message-Id: <20180211174704.27441-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCHv2] linux-user: Fix sched_getaffinity mask size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

We properly computed the capped mask size to be put to the application
buffer, but didn't actually used it. Also, we need to return the capped mask
size instead of 0 on success.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
Difference from v1:
- simplify fix
---
 linux-user/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 82b35a6bdf..bcda3362fc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10493,7 +10493,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     ret = arg2;
                 }
 
-                ret = host_to_target_cpu_mask(mask, mask_size, arg3, arg2);
+                if (host_to_target_cpu_mask(mask, mask_size, arg3, ret)) {
+                    goto efault;
+                }
             }
         }
         break;
-- 
2.15.1
