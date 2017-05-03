Received: from eggs.gnu.org ([2001:4830:134:3::10]:53231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d5t8Y-0005ML-75
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d5t8X-0002ty-9O
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:12:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d5t8X-0002tk-33
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:12:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12A943D959
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 12:12:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 May 2017 16:11:43 +0400
Message-Id: <20170503121143.14925-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170503121143.14925-1-marcandre.lureau@redhat.com>
References: <20170503121143.14925-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] libvhost-user: make vu_queue_empty() safer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Check if vring.avail !=3D null before accessing it.

Fix crashes from callers such a vu_queue_pop() when queue isn't ready.

Fix documentation and return type while at it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h | 6 +++---
 contrib/libvhost-user/libvhost-user.c | 8 ++++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 156b50e989..af02a31ebe 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -327,13 +327,13 @@ void vu_queue_set_notification(VuDev *dev, VuVirtq =
*vq, int enable);
 bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
=20
 /**
- * vu_queue_enabled:
+ * vu_queue_empty:
  * @dev: a VuDev context
  * @vq: a VuVirtq queue
  *
- * Returns: whether the queue is empty.
+ * Returns: true if the queue is empty or not ready.
  */
-int vu_queue_empty(VuDev *dev, VuVirtq *vq);
+bool vu_queue_empty(VuDev *dev, VuVirtq *vq);
=20
 /**
  * vu_queue_notify:
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index f9680b6279..b0f15b76e3 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1125,11 +1125,15 @@ vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, uns=
igned int in_bytes,
=20
 /* Fetch avail_idx from VQ memory only when we really need to know if
  * guest has added some buffers. */
-int
+bool
 vu_queue_empty(VuDev *dev, VuVirtq *vq)
 {
+    if (!vq->vring.avail) {
+        return true;
+    }
+
     if (vq->shadow_avail_idx !=3D vq->last_avail_idx) {
-        return 0;
+        return false;
     }
=20
     return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
--=20
2.12.0.191.gc5d8de91d
