Received: from eggs.gnu.org ([2001:4830:134:3::10]:36969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDpQe-000544-M6
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDpQZ-0006Ot-Tf
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:56:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fDpQZ-0006Nm-MU
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:56:03 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  2 May 2018 11:55:52 +0100
Message-Id: <20180502105552.22925-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] vhost-user+postcopy: Use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use qemu_set_nonblock rather than a simple fcntl; cleaner
and I have no reason to change other flags.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 38da8692bb..c2bbb622d6 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1076,7 +1076,7 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
         error_setg(errp, "%s: Failed to get ufd", __func__);
         return -1;
     }
-    fcntl(ufd, F_SETFL, O_NONBLOCK);
+    qemu_set_nonblock(ufd);
 
     /* register ufd with userfault thread */
     u->postcopy_fd.fd = ufd;
-- 
2.17.0
