Received: from eggs.gnu.org ([2001:4830:134:3::10]:53663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1enoxs-0004tz-0Z
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1enoxp-0005SE-30
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:10:55 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:40223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1enoxo-0005RE-Pu
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:10:53 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 19 Feb 2018 18:10:32 +0100
Message-Id: <20180219171037.24539-4-laurent@vivier.eu>
In-Reply-To: <20180219171037.24539-1-laurent@vivier.eu>
References: <20180219171037.24539-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 3/8] linux-user: Fix sched_getaffinity mask size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Laurent Vivier <laurent@vivier.eu>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

We properly computed the capped mask size to be put to the application
buffer, but didn't actually used it. Also, we need to return the capped mask
size instead of 0 on success.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180211174704.27441-1-samuel.thibault@ens-lyon.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index effc3a0881..e24f43c4a2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10502,7 +10502,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
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
2.14.3
