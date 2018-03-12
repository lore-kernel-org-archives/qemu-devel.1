Received: from eggs.gnu.org ([2001:4830:134:3::10]:52961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR8o-00082f-Mg
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR8n-0007VX-K2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evR8n-0007VI-Dx
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:21:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 159D0401C9AE
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 17:21:41 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 12 Mar 2018 17:21:02 +0000
Message-Id: <20180312172124.56461-8-dgilbert@redhat.com>
In-Reply-To: <20180312172124.56461-1-dgilbert@redhat.com>
References: <20180312172124.56461-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 07/29] libvhost-user: Support sending fds
 back to qemu
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

Allow replies with fds (for postcopy)

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 30 +++++++++++++++++++++++++++++=
-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 37d4228193..ed9f3148d3 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -246,6 +246,31 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserM=
sg *vmsg)
 {
     int rc;
     uint8_t *p =3D (uint8_t *)vmsg;
+    char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] =3D=
 { };
+    struct iovec iov =3D {
+        .iov_base =3D (char *)vmsg,
+        .iov_len =3D VHOST_USER_HDR_SIZE,
+    };
+    struct msghdr msg =3D {
+        .msg_iov =3D &iov,
+        .msg_iovlen =3D 1,
+        .msg_control =3D control,
+    };
+    struct cmsghdr *cmsg;
+
+    memset(control, 0, sizeof(control));
+    assert(vmsg->fd_num <=3D VHOST_MEMORY_MAX_NREGIONS);
+    if (vmsg->fd_num > 0) {
+        size_t fdsize =3D vmsg->fd_num * sizeof(int);
+        msg.msg_controllen =3D CMSG_SPACE(fdsize);
+        cmsg =3D CMSG_FIRSTHDR(&msg);
+        cmsg->cmsg_len =3D CMSG_LEN(fdsize);
+        cmsg->cmsg_level =3D SOL_SOCKET;
+        cmsg->cmsg_type =3D SCM_RIGHTS;
+        memcpy(CMSG_DATA(cmsg), vmsg->fds, fdsize);
+    } else {
+        msg.msg_controllen =3D 0;
+    }
=20
     /* Set the version in the flags when sending the reply */
     vmsg->flags &=3D ~VHOST_USER_VERSION_MASK;
@@ -253,7 +278,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMs=
g *vmsg)
     vmsg->flags |=3D VHOST_USER_REPLY_MASK;
=20
     do {
-        rc =3D write(conn_fd, p, VHOST_USER_HDR_SIZE);
+        rc =3D sendmsg(conn_fd, &msg, 0);
     } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
=20
     do {
@@ -346,6 +371,7 @@ vu_get_features_exec(VuDev *dev, VhostUserMsg *vmsg)
     }
=20
     vmsg->size =3D sizeof(vmsg->payload.u64);
+    vmsg->fd_num =3D 0;
=20
     DPRINT("Sending back to guest u64: 0x%016"PRIx64"\n", vmsg->payload.=
u64);
=20
@@ -501,6 +527,7 @@ vu_set_log_base_exec(VuDev *dev, VhostUserMsg *vmsg)
     dev->log_size =3D log_mmap_size;
=20
     vmsg->size =3D sizeof(vmsg->payload.u64);
+    vmsg->fd_num =3D 0;
=20
     return true;
 }
@@ -759,6 +786,7 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMs=
g *vmsg)
=20
     vmsg->payload.u64 =3D features;
     vmsg->size =3D sizeof(vmsg->payload.u64);
+    vmsg->fd_num =3D 0;
=20
     return true;
 }
--=20
2.14.3
