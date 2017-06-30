Received: from eggs.gnu.org ([2001:4830:134:3::10]:57954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dQyPc-0005Hy-Lz
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dQyPY-0004z5-9k
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:04:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dQyPY-0004yc-47
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:04:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41C72F2BA9
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 16:04:47 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 30 Jun 2017 18:04:22 +0200
Message-Id: <20170630160422.14842-3-maxime.coquelin@redhat.com>
In-Reply-To: <20170630160422.14842-1-maxime.coquelin@redhat.com>
References: <20170630160422.14842-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] vhost-user: unregister slave req handler
 at cleanup time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, mlureau@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

If the backend sends a request just before closing the socket,
the aio dispatcher might schedule its reading after the vhost
device has been cleaned, leading to a NULL pointer dereference
in slave_read();

vhost_user_cleanup() already closes the socket but it is not
enough, the handler has to be unregistered.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/virtio/vhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 958ee09..2203011 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -779,6 +779,7 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
 
     u = dev->opaque;
     if (u->slave_fd >= 0) {
+        qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
         close(u->slave_fd);
         u->slave_fd = -1;
     }
-- 
2.9.4
