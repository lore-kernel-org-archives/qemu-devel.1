Received: from eggs.gnu.org ([209.51.188.92]:44007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmye-0004lM-LN
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grmyd-0003kf-PQ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:56:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grmyb-0003iC-TO
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:56:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75BD44CE8D
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 16:56:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  7 Feb 2019 17:54:46 +0100
Message-Id: <20190207165449.6125-10-marcandre.lureau@redhat.com>
In-Reply-To: <20190207165449.6125-1-marcandre.lureau@redhat.com>
References: <20190207165449.6125-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/12] libvhost-user: add vu_queue_unpop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

vhost-user-input will make use of this function to undo some queue pop
in case the virtio queue does not have enough room.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 14 ++++++++++++++
 contrib/libvhost-user/libvhost-user.c | 16 ++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index a4afbc3a46..6c7cbe14b6 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -459,6 +459,20 @@ void vu_queue_notify(VuDev *dev, VuVirtq *vq);
  */
 void *vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz);
=20
+
+/**
+ * vu_queue_unpop:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @elem: The #VuVirtqElement
+ * @len: number of bytes written
+ *
+ * Pretend the most recent element wasn't popped from the virtqueue.  Th=
e next
+ * call to vu_queue_pop() will refetch the element.
+ */
+void vu_queue_unpop(VuDev *dev, VuVirtq *vq, VuVirtqElement *elem,
+                    size_t len);
+
 /**
  * vu_queue_rewind:
  * @dev: a VuDev context
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index fcf5014240..df72d3e440 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1966,6 +1966,22 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
     return elem;
 }
=20
+static void
+vu_queue_detach_element(VuDev *dev, VuVirtq *vq, VuVirtqElement *elem,
+                        size_t len)
+{
+    vq->inuse--;
+    /* unmap, when DMA support is added */
+}
+
+void
+vu_queue_unpop(VuDev *dev, VuVirtq *vq, VuVirtqElement *elem,
+               size_t len)
+{
+    vq->last_avail_idx--;
+    vu_queue_detach_element(dev, vq, elem, len);
+}
+
 bool
 vu_queue_rewind(VuDev *dev, VuVirtq *vq, unsigned int num)
 {
--=20
2.20.1.519.g8feddda32c
