Received: from eggs.gnu.org ([2001:4830:134:3::10]:53865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ef8rg-00061U-KA
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ef8rf-0003lM-MD
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:36:40 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:33960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ef8rf-0003kb-9h
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:36:39 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri, 26 Jan 2018 19:36:36 +0100
Message-Id: <20180126183636.7586-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PATCH] linux-user: Fix sched_getaffinity mask size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

We properly computed the capped mask size to be put to the application
buffer, but didn't actually it. Also, we need to return the capped mask
size instead of 0 on success.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 linux-user/syscall.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 74378947f0..cf2369aac2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10496,10 +10496,15 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                         ret = -TARGET_EINVAL;
                         break;
                     }
-                    ret = arg2;
+                } else if (arg2 > ret) {
+                    arg2 = ret;
                 }
 
                 ret = host_to_target_cpu_mask(mask, mask_size, arg3, arg2);
+
+                if (ret == 0) {
+                    ret = arg2;
+                }
             }
         }
         break;
-- 
2.15.1
