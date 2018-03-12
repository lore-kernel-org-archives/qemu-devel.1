Received: from eggs.gnu.org ([2001:4830:134:3::10]:53019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR8u-00088T-KU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR8t-0007aI-1v
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evR8s-0007Zs-Tq
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EA59401DE71
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 17:21:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 12 Mar 2018 17:21:05 +0000
Message-Id: <20180312172124.56461-11-dgilbert@redhat.com>
In-Reply-To: <20180312172124.56461-1-dgilbert@redhat.com>
References: <20180312172124.56461-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 10/29] vhost+postcopy: Register shared ufd
 with postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Register the UFD that comes in as the response to the 'advise' method
with the postcopy code.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/vhost-user.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ceb17b0554..5900583437 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -171,6 +171,7 @@ struct vhost_user {
     CharBackend *chr;
     int slave_fd;
     NotifierWithReturn postcopy_notifier;
+    struct PostCopyFD  postcopy_fd;
 };
=20
 static bool ioeventfd_enabled(void)
@@ -796,6 +797,17 @@ out:
     return ret;
 }
=20
+/*
+ * Called back from the postcopy fault thread when a fault is received o=
n our
+ * ufd.
+ * TODO: This is Linux specific
+ */
+static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
+                                             void *ufd)
+{
+    return 0;
+}
+
 /*
  * Called at the start of an inbound postcopy on reception of the
  * 'advise' command.
@@ -835,8 +847,14 @@ static int vhost_user_postcopy_advise(struct vhost_d=
ev *dev, Error **errp)
         error_setg(errp, "%s: Failed to get ufd", __func__);
         return -1;
     }
+    fcntl(ufd, F_SETFL, O_NONBLOCK);
=20
-    /* TODO: register ufd with userfault thread */
+    /* register ufd with userfault thread */
+    u->postcopy_fd.fd =3D ufd;
+    u->postcopy_fd.data =3D dev;
+    u->postcopy_fd.handler =3D vhost_user_postcopy_fault_handler;
+    u->postcopy_fd.idstr =3D "vhost-user"; /* Need to find unique name *=
/
+    postcopy_register_shared_ufd(&u->postcopy_fd);
     return 0;
 }
=20
--=20
2.14.3
