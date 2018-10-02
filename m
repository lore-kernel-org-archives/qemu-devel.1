Received: from eggs.gnu.org ([2001:4830:134:3::10]:40550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1g7LL9-0005iM-1B
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1g7LL5-0004er-Nr
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:07:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1g7LL5-0004dM-AE
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:07:51 -0400
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 02 Oct 2018 17:09:47 +0300
Message-id: <20181002140947.4107-1-i.maximets@samsung.com>
MIME-version: 1.0
References: <CGME20181002140746eucas1p14d822ee1600d78687a73d6bf9a44e36b@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vhost-user: Don't ask for reply on postcopy
 mem table set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

According to documentation, NEED_REPLY_MASK should not be set
for VHOST_USER_SET_MEM_TABLE request in postcopy mode.
This restriction was mistakenly applied to 'reply_supported'
variable, which is local and used only for non-postcopy case.

CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
Fixes: 9bb38019942c ("vhost+postcopy: Send address back to qemu")
Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
---
 hw/virtio/vhost-user.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b041343632..c442daa562 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -374,8 +374,6 @@ static int vhost_user_set_mem_table_postcopy(struct v=
host_dev *dev,
     int fds[VHOST_MEMORY_MAX_NREGIONS];
     int i, fd;
     size_t fd_num =3D 0;
-    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
-                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
     VhostUserMsg msg_reply;
     int region_i, msg_i;
=20
@@ -384,10 +382,6 @@ static int vhost_user_set_mem_table_postcopy(struct =
vhost_dev *dev,
         .hdr.flags =3D VHOST_USER_VERSION,
     };
=20
-    if (reply_supported) {
-        msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
-    }
-
     if (u->region_rb_len < dev->mem->nregions) {
         u->region_rb =3D g_renew(RAMBlock*, u->region_rb, dev->mem->nreg=
ions);
         u->region_rb_offset =3D g_renew(ram_addr_t, u->region_rb_offset,
@@ -503,10 +497,6 @@ static int vhost_user_set_mem_table_postcopy(struct =
vhost_dev *dev,
         return -1;
     }
=20
-    if (reply_supported) {
-        return process_message_reply(dev, &msg);
-    }
-
     return 0;
 }
=20
@@ -519,8 +509,7 @@ static int vhost_user_set_mem_table(struct vhost_dev =
*dev,
     size_t fd_num =3D 0;
     bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
     bool reply_supported =3D virtio_has_feature(dev->protocol_features,
-                                          VHOST_USER_PROTOCOL_F_REPLY_AC=
K) &&
-                                          !do_postcopy;
+                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
=20
     if (do_postcopy) {
         /* Postcopy has enough differences that it's best done in it's o=
wn
--=20
2.17.1
