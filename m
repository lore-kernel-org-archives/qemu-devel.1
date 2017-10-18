Received: from eggs.gnu.org ([2001:4830:134:3::10]:58667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXe-0005IA-UX
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXZ-0003zT-42
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:46 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:51460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1e4nXY-0003z5-St
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:41 -0400
Received: by mail-lf0-x243.google.com with SMTP id r129so5622356lff.8
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:33:40 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 18 Oct 2017 15:33:22 +0300
Message-Id: <1847b7ba7015a7448079c2d8fd7187726c33c707.1508329282.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1508329282.git.riku.voipio@linaro.org>
References: <cover.1508329282.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 08/10] linux-user: Fix target FS_IOC_GETFLAGS
 and FS_IOC_SETFLAGS numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

We were defining TARGET_FS_IOC_GETFLAGS and TARGET_FS_IOC_SETFLAGS
using the host 'long' type in the size field, which meant that
they had the wrong values if the host and guest had different
sized longs. Switch to abi_long instead.

This fixes a bug where these ioctls don't work on 32-bit guests
on 64-bit hosts (and makes the LTP test 'setxattr03' pass
where it did not previously.)

Reported-by: pgndev <pgnet.dev@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 6e2287e918..447915cf80 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1101,8 +1101,8 @@ struct target_pollfd {
 /* Note that the ioctl numbers claim type "long" but the actual type
  * used by the kernel is "int".
  */
-#define TARGET_FS_IOC_GETFLAGS TARGET_IOR('f', 1, long)
-#define TARGET_FS_IOC_SETFLAGS TARGET_IOW('f', 2, long)
+#define TARGET_FS_IOC_GETFLAGS TARGET_IOR('f', 1, abi_long)
+#define TARGET_FS_IOC_SETFLAGS TARGET_IOW('f', 2, abi_long)
 
 #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
 
-- 
2.14.2
