Received: from eggs.gnu.org ([2001:4830:134:3::10]:50003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dz6Bk-0001g4-2D
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dz6Bi-0000RX-RS
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dz6Bi-0000QZ-Iy
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:15:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFDA74ACBB
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 19:15:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  2 Oct 2017 20:15:20 +0100
Message-Id: <20171002191521.15748-4-dgilbert@redhat.com>
In-Reply-To: <20171002191521.15748-1-dgilbert@redhat.com>
References: <20171002191521.15748-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] libvhost-user: Update and fix feature and
 request lists
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com
List-ID: <qemu-devel.nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Update the ProtocolFeature and UserRequest lists to
match hw/virtio/vhost-user.c.
Fix the text labelling in libvhost-user.c to match the list.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 10 +++++-----
 contrib/libvhost-user/libvhost-user.h |  9 ++++++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 5ee8483a32..1901311a70 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -35,16 +35,13 @@
     } while (0)
 
 static const char *
-vu_request_to_string(int req)
+vu_request_to_string(unsigned int req)
 {
 #define REQ(req) [req] = #req
     static const char *vu_request_str[] = {
         REQ(VHOST_USER_NONE),
         REQ(VHOST_USER_GET_FEATURES),
         REQ(VHOST_USER_SET_FEATURES),
-        REQ(VHOST_USER_NONE),
-        REQ(VHOST_USER_GET_FEATURES),
-        REQ(VHOST_USER_SET_FEATURES),
         REQ(VHOST_USER_SET_OWNER),
         REQ(VHOST_USER_RESET_OWNER),
         REQ(VHOST_USER_SET_MEM_TABLE),
@@ -62,7 +59,10 @@ vu_request_to_string(int req)
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
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 94d7cc8fbd..c2fc6da720 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -34,6 +34,10 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_MQ = 0,
     VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
     VHOST_USER_PROTOCOL_F_RARP = 2,
+    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
+    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
+    VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
+    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -61,7 +65,10 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_QUEUE_NUM = 17,
     VHOST_USER_SET_VRING_ENABLE = 18,
     VHOST_USER_SEND_RARP = 19,
-    VHOST_USER_INPUT_GET_CONFIG = 20,
+    VHOST_USER_NET_SET_MTU = 20,
+    VHOST_USER_SET_SLAVE_REQ_FD = 21,
+    VHOST_USER_IOTLB_MSG = 22,
+    VHOST_USER_SET_VRING_ENDIAN = 23,
     VHOST_USER_MAX
 } VhostUserRequest;
 
-- 
2.13.6
