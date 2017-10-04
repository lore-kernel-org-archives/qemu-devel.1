Received: from eggs.gnu.org ([2001:4830:134:3::10]:38316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <malbarbo@gmail.com>) id 1dzroC-0000M0-R3
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 18:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <malbarbo@gmail.com>) id 1dzroB-0000su-Aw
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 18:06:28 -0400
MIME-Version: 1.0
From: Marco A L Barbosa <malbarbo@gmail.com>
Date: Wed, 4 Oct 2017 19:06:24 -0300
Message-ID: <CAHpsRN-XzxjJZb=rb0iHMv4Afv=2H3N5U7p4+NNJFPkxgSLMXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] linux-user: Add random ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

I don't know how (and if it is necessary) to add buf field to
rand_pool_info struct. See
https://github.com/torvalds/linux/blob/5924bbecd0267d87c24110cbe2041b5075173a25/include/uapi/linux/random.h#L17

Signed-off-by: Marco A L Barbosa <malbarbo@gmail.com>
---
 linux-user/ioctls.h        | 7 +++++++
 linux-user/syscall.c       | 1 +
 linux-user/syscall_defs.h  | 9 +++++++++
 linux-user/syscall_types.h | 4 ++++
 4 files changed, 21 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index e6997ff230..9240a83f30 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -173,6 +173,13 @@
   IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
   IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))

+  IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rand_pool_info)))
+  IOCTL(RNDGETPOOL, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(RNDADDENTROPY, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rand_pool_info)))
+  IOCTL(RNDZAPENTCNT, 0, TYPE_NULL)
+  IOCTL(RNDCLEARPOOL, 0, TYPE_NULL)
+
   IOCTL(CDROMPAUSE, 0, TYPE_NULL)
   IOCTL(CDROMSTART, 0, TYPE_NULL)
   IOCTL(CDROMSTOP, 0, TYPE_NULL)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a266..d4c21a557c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -59,6 +59,7 @@ int __clone2(int (*fn)(void *), void *child_stack_base,
 #include <linux/icmp.h>
 #include <linux/icmpv6.h>
 #include <linux/errqueue.h>
+#include <linux/random.h>
 #include "qemu-common.h"
 #ifdef CONFIG_TIMERFD
 #include <sys/timerfd.h>
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 40c5027e93..d14fdd82ce 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1060,6 +1060,15 @@ struct target_pollfd {

 #define TARGET_SIOCGIWNAME     0x8B01          /* get name == wireless
protocol */

+/* From <linux/random.h> */
+
+#define TARGET_RNDGETENTCNT    TARGET_IOR('R', 0x00, int)
+#define TARGET_RNDADDTOENTCNT  TARGET_IOW('R', 0x01, int)
+#define TARGET_RNDGETPOOL      TARGET_IOR('R', 0x02, struct rand_pool_info)
+#define TARGET_RNDADDENTROPY   TARGET_IOW('R', 0x03, struct rand_pool_info)
+#define TARGET_RNDZAPENTCNT    TARGET_IO('R', 0x04)
+#define TARGET_RNDCLEARPOOL    TARGET_IO('R', 0x06)
+
 /* From <linux/fs.h> */

 #define TARGET_BLKROSET   TARGET_IO(0x12,93) /* set device read-only (0 =
read-write) */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 24631b09be..2e2e000424 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -266,3 +266,7 @@ STRUCT(blkpg_ioctl_arg,
        TYPE_INT, /* flags */
        TYPE_INT, /* datalen */
        TYPE_PTRVOID) /* data */
+
+STRUCT(rand_pool_info,
+       TYPE_INT, /* entropy_count */
+       TYPE_INT) /* buf_size */
-- 
2.11.0

-- 
Marco A L Barbosa
http://malbarbo.pro.br
--
