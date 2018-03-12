Received: from eggs.gnu.org ([2001:4830:134:3::10]:53237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR9F-0008V5-Hw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evR9E-0007s7-Cv
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36146 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evR9E-0007rk-7d
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:22:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D32578D6D7
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 17:22:07 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 12 Mar 2018 17:21:19 +0000
Message-Id: <20180312172124.56461-25-dgilbert@redhat.com>
In-Reply-To: <20180312172124.56461-1-dgilbert@redhat.com>
References: <20180312172124.56461-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 24/29] vhost-user: Add
 VHOST_USER_POSTCOPY_END message
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

This message is sent just before the end of postcopy to get the
client to stop using userfault since we wont respond to any more
requests.  It should close userfaultfd so that any other pages
get mapped to the backing file automatically by the kernel, since
at this point we know we've received everything.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 23 +++++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h |  1 +
 docs/interop/vhost-user.txt           | 12 ++++++++++++
 hw/virtio/vhost-user.c                |  1 +
 4 files changed, 37 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 5feed52098..504ff5ea59 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -99,6 +99,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_SET_CONFIG),
         REQ(VHOST_USER_POSTCOPY_ADVISE),
         REQ(VHOST_USER_POSTCOPY_LISTEN),
+        REQ(VHOST_USER_POSTCOPY_END),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -1094,6 +1095,26 @@ vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *v=
msg)
     vmsg->payload.u64 =3D 0; /* Success */
     return true;
 }
+
+static bool
+vu_set_postcopy_end(VuDev *dev, VhostUserMsg *vmsg)
+{
+    DPRINT("%s: Entry\n", __func__);
+    dev->postcopy_listening =3D false;
+    if (dev->postcopy_ufd > 0) {
+        close(dev->postcopy_ufd);
+        dev->postcopy_ufd =3D -1;
+        DPRINT("%s: Done close\n", __func__);
+    }
+
+    vmsg->fd_num =3D 0;
+    vmsg->payload.u64 =3D 0;
+    vmsg->size =3D sizeof(vmsg->payload.u64);
+    vmsg->flags =3D VHOST_USER_VERSION |  VHOST_USER_REPLY_MASK;
+    DPRINT("%s: exit\n", __func__);
+    return true;
+}
+
 static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1169,6 +1190,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_set_postcopy_advise(dev, vmsg);
     case VHOST_USER_POSTCOPY_LISTEN:
         return vu_set_postcopy_listen(dev, vmsg);
+    case VHOST_USER_POSTCOPY_END:
+        return vu_set_postcopy_end(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index ed505cf0c1..79f7a53ee8 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -87,6 +87,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
     VHOST_USER_POSTCOPY_ADVISE  =3D 28,
     VHOST_USER_POSTCOPY_LISTEN  =3D 29,
+    VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index e295ef12ca..c058c407df 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -729,6 +729,18 @@ Master message types
       This is always sent sometime after a VHOST_USER_POSTCOPY_ADVISE, a=
nd
       thus only when VHOST_USER_PROTOCOL_F_PAGEFAULT is supported.
=20
+ * VHOST_USER_POSTCOPY_END
+      Id: 30
+      Slave payload: u64
+
+      Master advises that postcopy migration has now completed.  The
+      slave must disable the userfaultfd. The response is an acknowledge=
ment
+      only.
+      When VHOST_USER_PROTOCOL_F_PAGEFAULT is supported, this message
+      is sent at the end of the migration, after VHOST_USER_POSTCOPY_LIS=
TEN
+      was previously sent.
+      The value returned is an error indication; 0 is success.
+
 Slave message types
 -------------------
=20
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a785aefd3e..230f2f9d55 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -82,6 +82,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_CLOSE_CRYPTO_SESSION =3D 27,
     VHOST_USER_POSTCOPY_ADVISE  =3D 28,
     VHOST_USER_POSTCOPY_LISTEN  =3D 29,
+    VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
--=20
2.14.3
