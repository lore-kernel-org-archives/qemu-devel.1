Received: from eggs.gnu.org ([2001:4830:134:3::10]:34632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDTiP-0005QT-3f
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDTiJ-0003eN-2W
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:17:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gDTiI-0003cX-OE
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:17:10 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 19 Oct 2018 14:16:22 +0200
Message-Id: <20181019121623.29148-3-laurent@vivier.eu>
In-Reply-To: <20181019121623.29148-1-laurent@vivier.eu>
References: <20181019121623.29148-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [2 2/3] linux-user: Define ordinary usbfs ioctls.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Cortland=20T=C3=B6lva?= <cst@tolva.net>

From: Cortland Tölva <cst@tolva.net>

Provide ioctl definitions for the generic thunk mechanism to
convert most usbfs calls.  Calculate arg size at runtime.

Signed-off-by: Cortland Tölva <cst@tolva.net>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20181008163521.17341-3-cst@tolva.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 38 ++++++++++++++++++++++++++++++
 linux-user/syscall.c       |  3 +++
 linux-user/syscall_defs.h  | 24 +++++++++++++++++++
 linux-user/syscall_types.h | 48 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 586c794639..92f6177f1d 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -131,6 +131,44 @@
      IOCTL(FS_IOC_GETFLAGS, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
 
+#ifdef CONFIG_USBFS
+  /* USB ioctls */
+  IOCTL(USBDEVFS_CONTROL, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_usbdevfs_ctrltransfer)))
+  IOCTL(USBDEVFS_BULK, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_usbdevfs_bulktransfer)))
+  IOCTL(USBDEVFS_RESETEP, IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(USBDEVFS_SETINTERFACE, IOC_W,
+        MK_PTR(MK_STRUCT(STRUCT_usbdevfs_setinterface)))
+  IOCTL(USBDEVFS_SETCONFIGURATION, IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(USBDEVFS_GETDRIVER, IOC_R,
+        MK_PTR(MK_STRUCT(STRUCT_usbdevfs_getdriver)))
+  IOCTL(USBDEVFS_DISCSIGNAL, IOC_W,
+        MK_PTR(MK_STRUCT(STRUCT_usbdevfs_disconnectsignal)))
+  IOCTL(USBDEVFS_CLAIMINTERFACE, IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(USBDEVFS_RELEASEINTERFACE, IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(USBDEVFS_CONNECTINFO, IOC_R,
+        MK_PTR(MK_STRUCT(STRUCT_usbdevfs_connectinfo)))
+  IOCTL(USBDEVFS_IOCTL, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_usbdevfs_ioctl)))
+  IOCTL(USBDEVFS_HUB_PORTINFO, IOC_R,
+        MK_PTR(MK_STRUCT(STRUCT_usbdevfs_hub_portinfo)))
+  IOCTL(USBDEVFS_RESET, 0, TYPE_NULL)
+  IOCTL(USBDEVFS_CLEAR_HALT, IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(USBDEVFS_DISCONNECT, 0, TYPE_NULL)
+  IOCTL(USBDEVFS_CONNECT, 0, TYPE_NULL)
+  IOCTL(USBDEVFS_CLAIM_PORT, IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(USBDEVFS_RELEASE_PORT, IOC_W, MK_PTR(TYPE_INT))
+  IOCTL(USBDEVFS_GET_CAPABILITIES, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(USBDEVFS_DISCONNECT_CLAIM, IOC_W,
+        MK_PTR(MK_STRUCT(STRUCT_usbdevfs_disconnect_claim)))
+#ifdef USBDEVFS_DROP_PRIVILEGES
+  IOCTL(USBDEVFS_DROP_PRIVILEGES, IOC_W, MK_PTR(TYPE_INT))
+#endif
+#ifdef USBDEVFS_GET_SPEED
+  IOCTL(USBDEVFS_GET_SPEED, 0, TYPE_NULL)
+#endif
+#endif /* CONFIG_USBFS */
+
   IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
   IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d2cc971143..6eb20c14c9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -94,6 +94,9 @@
 #include <linux/fiemap.h>
 #endif
 #include <linux/fb.h>
+#if defined(CONFIG_USBFS)
+#include <linux/usbdevice_fs.h>
+#endif
 #include <linux/vt.h>
 #include <linux/dm-ioctl.h>
 #include <linux/reboot.h>
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 18d434d6dc..2daa5ebdcc 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -863,6 +863,30 @@ struct target_pollfd {
 
 #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
 
+/* usb ioctls */
+#define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
+#define TARGET_USBDEVFS_BULK TARGET_IOWRU('U', 2)
+#define TARGET_USBDEVFS_RESETEP TARGET_IORU('U', 3)
+#define TARGET_USBDEVFS_SETINTERFACE TARGET_IORU('U', 4)
+#define TARGET_USBDEVFS_SETCONFIGURATION TARGET_IORU('U',  5)
+#define TARGET_USBDEVFS_GETDRIVER TARGET_IOWU('U', 8)
+#define TARGET_USBDEVFS_DISCSIGNAL TARGET_IORU('U', 14)
+#define TARGET_USBDEVFS_CLAIMINTERFACE TARGET_IORU('U', 15)
+#define TARGET_USBDEVFS_RELEASEINTERFACE TARGET_IORU('U', 16)
+#define TARGET_USBDEVFS_CONNECTINFO TARGET_IOWU('U', 17)
+#define TARGET_USBDEVFS_IOCTL TARGET_IOWRU('U', 18)
+#define TARGET_USBDEVFS_HUB_PORTINFO TARGET_IORU('U', 19)
+#define TARGET_USBDEVFS_RESET TARGET_IO('U', 20)
+#define TARGET_USBDEVFS_CLEAR_HALT TARGET_IORU('U', 21)
+#define TARGET_USBDEVFS_DISCONNECT TARGET_IO('U', 22)
+#define TARGET_USBDEVFS_CONNECT TARGET_IO('U', 23)
+#define TARGET_USBDEVFS_CLAIM_PORT TARGET_IORU('U', 24)
+#define TARGET_USBDEVFS_RELEASE_PORT TARGET_IORU('U', 25)
+#define TARGET_USBDEVFS_GET_CAPABILITIES TARGET_IORU('U', 26)
+#define TARGET_USBDEVFS_DISCONNECT_CLAIM TARGET_IORU('U', 27)
+#define TARGET_USBDEVFS_DROP_PRIVILEGES TARGET_IOWU('U', 30)
+#define TARGET_USBDEVFS_GET_SPEED TARGET_IO('U', 31)
+
 /* cdrom commands */
 #define TARGET_CDROMPAUSE		0x5301 /* Pause Audio Operation */
 #define TARGET_CDROMRESUME		0x5302 /* Resume paused Audio Operation */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 24631b09be..6f64a8bdf7 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -266,3 +266,51 @@ STRUCT(blkpg_ioctl_arg,
        TYPE_INT, /* flags */
        TYPE_INT, /* datalen */
        TYPE_PTRVOID) /* data */
+
+#if defined(CONFIG_USBFS)
+/* usb device ioctls */
+STRUCT(usbdevfs_ctrltransfer,
+        TYPE_CHAR, /* bRequestType */
+        TYPE_CHAR, /* bRequest */
+        TYPE_SHORT, /* wValue */
+        TYPE_SHORT, /* wIndex */
+        TYPE_SHORT, /* wLength */
+        TYPE_INT, /* timeout */
+        TYPE_PTRVOID) /* data */
+
+STRUCT(usbdevfs_bulktransfer,
+        TYPE_INT, /* ep */
+        TYPE_INT, /* len */
+        TYPE_INT, /* timeout */
+        TYPE_PTRVOID) /* data */
+
+STRUCT(usbdevfs_setinterface,
+        TYPE_INT, /* interface */
+        TYPE_INT) /* altsetting */
+
+STRUCT(usbdevfs_disconnectsignal,
+        TYPE_INT, /* signr */
+        TYPE_PTRVOID) /* context */
+
+STRUCT(usbdevfs_getdriver,
+        TYPE_INT, /* interface */
+        MK_ARRAY(TYPE_CHAR, USBDEVFS_MAXDRIVERNAME + 1)) /* driver */
+
+STRUCT(usbdevfs_connectinfo,
+        TYPE_INT, /* devnum */
+        TYPE_CHAR) /* slow */
+
+STRUCT(usbdevfs_ioctl,
+        TYPE_INT, /* ifno */
+        TYPE_INT, /* ioctl_code */
+        TYPE_PTRVOID) /* data */
+
+STRUCT(usbdevfs_hub_portinfo,
+        TYPE_CHAR, /* nports */
+        MK_ARRAY(TYPE_CHAR, 127)) /* port */
+
+STRUCT(usbdevfs_disconnect_claim,
+        TYPE_INT, /* interface */
+        TYPE_INT, /* flags */
+        MK_ARRAY(TYPE_CHAR, USBDEVFS_MAXDRIVERNAME + 1)) /* driver */
+#endif /* CONFIG_USBFS */
-- 
2.17.2
