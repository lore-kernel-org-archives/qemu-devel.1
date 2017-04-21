Received: from eggs.gnu.org ([2001:4830:134:3::10]:35627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exi-00040v-Vz
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d1exh-0002hc-Pn
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:26 -0400
Received: from mail.kernel.org ([198.145.29.136]:42892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d1exh-0002hP-JY
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 16:15:25 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Fri, 21 Apr 2017 13:14:52 -0700
Message-Id: <1492805702-19690-11-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1492805702-19690-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<1492805702-19690-1-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/21] 9p: introduce a type for the 9p header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: stefanha@gmail.com, sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, jgross@suse.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

Use the new type in virtio-9p-device.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
CC: anthony.perard@citrix.com
CC: jgross@suse.com
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.h               | 6 ++++++
 hw/9pfs/virtio-9p-device.c | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index b7e8362..5312d8a 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -119,6 +119,12 @@ static inline char *rpath(FsContext *ctx, const char=
 *path)
 typedef struct V9fsPDU V9fsPDU;
 struct V9fsState;
=20
+typedef struct {
+    uint32_t size_le;
+    uint8_t id;
+    uint16_t tag_le;
+} QEMU_PACKED P9MsgHeader;
+
 struct V9fsPDU
 {
     uint32_t size;
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 27a4a32..3782f43 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -46,11 +46,7 @@ static void handle_9p_output(VirtIODevice *vdev, VirtQ=
ueue *vq)
     VirtQueueElement *elem;
=20
     while ((pdu =3D pdu_alloc(s))) {
-        struct {
-            uint32_t size_le;
-            uint8_t id;
-            uint16_t tag_le;
-        } QEMU_PACKED out;
+        P9MsgHeader out;
=20
         elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
--=20
1.9.1
