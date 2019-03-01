Received: from eggs.gnu.org ([209.51.188.92]:38165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzee9-0002E6-AB
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzee8-0004Tg-JH
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:40:01 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  1 Mar 2019 10:39:48 +0100
Message-Id: <20190301093949.27955-2-cohuck@redhat.com>
In-Reply-To: <20190301093949.27955-1-cohuck@redhat.com>
References: <20190301093949.27955-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] vfio-ccw: new capability chain support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>

To be replaced with a real linux-headers update.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 linux-headers/linux/vfio.h     |  4 ++++
 linux-headers/linux/vfio_ccw.h | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 12a7b1dc53c8..24f505199f83 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -353,6 +353,10 @@ struct vfio_region_gfx_edid {
 #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
 };
 
+#define VFIO_REGION_TYPE_CCW			(2)
+/* ccw sub-types */
+#define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
+
 /*
  * 10de vendor sub-type
  *
diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_ccw.h
index 5bf96c3812d2..fcc3e69ef526 100644
--- a/linux-headers/linux/vfio_ccw.h
+++ b/linux-headers/linux/vfio_ccw.h
@@ -12,6 +12,7 @@
 
 #include <linux/types.h>
 
+/* used for START SUBCHANNEL, always present */
 struct ccw_io_region {
 #define ORB_AREA_SIZE 12
 	__u8	orb_area[ORB_AREA_SIZE];
@@ -22,4 +23,15 @@ struct ccw_io_region {
 	__u32	ret_code;
 } __attribute__((packed));
 
+/*
+ * used for processing commands that trigger asynchronous actions
+ * Note: this is controlled by a capability
+ */
+#define VFIO_CCW_ASYNC_CMD_HSCH (1 << 0)
+#define VFIO_CCW_ASYNC_CMD_CSCH (1 << 1)
+struct ccw_cmd_region {
+	__u32 command;
+	__u32 ret_code;
+} __attribute__((packed));
+
 #endif
-- 
2.17.2
