Received: from eggs.gnu.org ([2001:4830:134:3::10]:42575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2kUC-0001aA-5U
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e2kUB-0000ca-5x
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e2kUA-0000c2-TO
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:53:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9B935F299A
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 20:53:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 12 Oct 2017 22:53:29 +0200
Message-Id: <20171012205330.29942-4-marcandre.lureau@redhat.com>
In-Reply-To: <20171012205330.29942-1-marcandre.lureau@redhat.com>
References: <20171012205330.29942-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] libvhost-user: Update and fix feature and
 request lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Update the ProtocolFeature and UserRequest lists to
match hw/virtio/vhost-user.c.
Fix the text labelling in libvhost-user.c to match the list.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20171002191521.15748-4-dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  9 ++++++++-
 contrib/libvhost-user/libvhost-user.c | 10 +++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index ff8059257e..d54683feeb 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -34,6 +34,10 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_MQ =3D 0,
     VHOST_USER_PROTOCOL_F_LOG_SHMFD =3D 1,
     VHOST_USER_PROTOCOL_F_RARP =3D 2,
+    VHOST_USER_PROTOCOL_F_REPLY_ACK =3D 3,
+    VHOST_USER_PROTOCOL_F_NET_MTU =3D 4,
+    VHOST_USER_PROTOCOL_F_SLAVE_REQ =3D 5,
+    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN =3D 6,
=20
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -61,7 +65,10 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_QUEUE_NUM =3D 17,
     VHOST_USER_SET_VRING_ENABLE =3D 18,
     VHOST_USER_SEND_RARP =3D 19,
-    VHOST_USER_INPUT_GET_CONFIG =3D 20,
+    VHOST_USER_NET_SET_MTU =3D 20,
+    VHOST_USER_SET_SLAVE_REQ_FD =3D 21,
+    VHOST_USER_IOTLB_MSG =3D 22,
+    VHOST_USER_SET_VRING_ENDIAN =3D 23,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 62be958f59..e36aed72d0 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -56,13 +56,10 @@
     } while (0)
=20
 static const char *
-vu_request_to_string(int req)
+vu_request_to_string(unsigned int req)
 {
 #define REQ(req) [req] =3D #req
     static const char *vu_request_str[] =3D {
-        REQ(VHOST_USER_NONE),
-        REQ(VHOST_USER_GET_FEATURES),
-        REQ(VHOST_USER_SET_FEATURES),
         REQ(VHOST_USER_NONE),
         REQ(VHOST_USER_GET_FEATURES),
         REQ(VHOST_USER_SET_FEATURES),
@@ -83,7 +80,10 @@ vu_request_to_string(int req)
         REQ(VHOST_USER_GET_QUEUE_NUM),
         REQ(VHOST_USER_SET_VRING_ENABLE),
         REQ(VHOST_USER_SEND_RARP),
-        REQ(VHOST_USER_INPUT_GET_CONFIG),
+        REQ(VHOST_USER_NET_SET_MTU),
+        REQ(VHOST_USER_SET_SLAVE_REQ_FD),
+        REQ(VHOST_USER_IOTLB_MSG),
+        REQ(VHOST_USER_SET_VRING_ENDIAN),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
--=20
2.15.0.rc0.40.gaefcc5f6f
