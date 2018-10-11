Received: from eggs.gnu.org ([2001:4830:134:3::10]:44852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaZ-0004vX-5o
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaU-0001cU-4K
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAgaT-0001ap-Ps
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:33 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 11 Oct 2018 20:25:11 +0100
Message-Id: <20181011192513.63634-6-dgilbert@redhat.com>
In-Reply-To: <20181011192513.63634-1-dgilbert@redhat.com>
References: <20181011192513.63634-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/7] vhost-user: Don't ask for reply on postcopy
 mem table set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: wei@redhat.com, thuth@redhat.com, i.maximets@samsung.com, den@openvz.org

From: Ilya Maximets <i.maximets@samsung.com>

According to documentation, NEED_REPLY_MASK should not be set
for VHOST_USER_SET_MEM_TABLE request in postcopy mode.
This restriction was mistakenly applied to 'reply_supported'
variable, which is local and used only for non-postcopy case.

CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
Fixes: 9bb38019942c ("vhost+postcopy: Send address back to qemu")
Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Message-Id: <20181002140947.4107-1-i.maximets@samsung.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost-user.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ed47d645d9..e09bed0e4a 100644
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
2.19.0
