Received: from eggs.gnu.org ([2001:4830:134:3::10]:43960)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9N9N-0006aP-HF
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 00:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9N9I-0002Uq-Ub
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 00:28:09 -0400
Received: from mail2.static.mailgun.info ([104.130.122.2]:56269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9N9H-0002St-2R
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 00:28:04 -0400
Sender: cst=tolva.net@mg-relay.tolva.net
From: =?UTF-8?q?Cortland=20T=C3=B6lva?= <cst@tolva.net>
Date: Sun,  7 Oct 2018 21:27:46 -0700
Message-Id: <20181008042747.10130-2-cst@tolva.net>
In-Reply-To: <20181008042747.10130-1-cst@tolva.net>
References: <20181008042747.10130-1-cst@tolva.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] linux-user: Use calculated sizes for usbfs
 ioctls.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cortland=20T=C3=B6lva?= <cst@tolva.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Size calculation should have used the target struct.  Fix the error by
marking these ioctls as needing runtime size calcuation.

Signed-off-by: Cortland Tölva <cst@tolva.net>
---
 linux-user/syscall_defs.h | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index af91f9582d..2daa5ebdcc 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -863,31 +863,29 @@ struct target_pollfd {
 
 #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
 
-#if defined(CONFIG_USBFS)
 /* usb ioctls */
-#define TARGET_USBDEVFS_CONTROL TARGET_IOWR('U', 0, struct usbdevfs_ctrltransfer)
-#define TARGET_USBDEVFS_BULK TARGET_IOWR('U', 2, struct usbdevfs_bulktransfer)
-#define TARGET_USBDEVFS_RESETEP TARGET_IOR('U', 3, int)
-#define TARGET_USBDEVFS_SETINTERFACE TARGET_IOR('U', 4, struct usbdevfs_setinterface)
-#define TARGET_USBDEVFS_SETCONFIGURATION TARGET_IOR('U',  5, int)
-#define TARGET_USBDEVFS_GETDRIVER TARGET_IOW('U', 8, struct usbdevfs_getdriver)
-#define TARGET_USBDEVFS_DISCSIGNAL TARGET_IOR('U', 14, struct usbdevfs_disconnectsignal)
-#define TARGET_USBDEVFS_CLAIMINTERFACE TARGET_IOR('U', 15, int)
-#define TARGET_USBDEVFS_RELEASEINTERFACE TARGET_IOR('U', 16, int)
-#define TARGET_USBDEVFS_CONNECTINFO TARGET_IOW('U', 17, struct usbdevfs_connectinfo)
-#define TARGET_USBDEVFS_IOCTL TARGET_IOWR('U', 18, struct usbdevfs_ioctl)
-#define TARGET_USBDEVFS_HUB_PORTINFO TARGET_IOR('U', 19, struct usbdevfs_hub_portinfo)
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
 #define TARGET_USBDEVFS_RESET TARGET_IO('U', 20)
-#define TARGET_USBDEVFS_CLEAR_HALT TARGET_IOR('U', 21, int)
+#define TARGET_USBDEVFS_CLEAR_HALT TARGET_IORU('U', 21)
 #define TARGET_USBDEVFS_DISCONNECT TARGET_IO('U', 22)
 #define TARGET_USBDEVFS_CONNECT TARGET_IO('U', 23)
-#define TARGET_USBDEVFS_CLAIM_PORT TARGET_IOR('U', 24, int)
-#define TARGET_USBDEVFS_RELEASE_PORT TARGET_IOR('U', 25, int)
-#define TARGET_USBDEVFS_GET_CAPABILITIES TARGET_IOR('U', 26, int)
-#define TARGET_USBDEVFS_DISCONNECT_CLAIM TARGET_IOR('U', 27, struct usbdevfs_disconnect_claim)
-#define TARGET_USBDEVFS_DROP_PRIVILEGES TARGET_IOW('U', 30, int)
+#define TARGET_USBDEVFS_CLAIM_PORT TARGET_IORU('U', 24)
+#define TARGET_USBDEVFS_RELEASE_PORT TARGET_IORU('U', 25)
+#define TARGET_USBDEVFS_GET_CAPABILITIES TARGET_IORU('U', 26)
+#define TARGET_USBDEVFS_DISCONNECT_CLAIM TARGET_IORU('U', 27)
+#define TARGET_USBDEVFS_DROP_PRIVILEGES TARGET_IOWU('U', 30)
 #define TARGET_USBDEVFS_GET_SPEED TARGET_IO('U', 31)
-#endif /* CONFIG_USBFS */
 
 /* cdrom commands */
 #define TARGET_CDROMPAUSE		0x5301 /* Pause Audio Operation */
-- 
2.17.1
