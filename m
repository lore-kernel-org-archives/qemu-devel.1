Received: from eggs.gnu.org ([2001:4830:134:3::10]:51096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eeiZn-0005Tb-6K
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eeiZk-0006sK-Nf
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eeiZk-0006rQ-Gk
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C408878232
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 14:32:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 25 Jan 2018 15:32:11 +0100
Message-Id: <20180125143218.29528-2-kraxel@redhat.com>
In-Reply-To: <20180125143218.29528-1-kraxel@redhat.com>
References: <20180125143218.29528-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] ui: avoid sign extension using client
 width/height
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Pixman returns a signed int for the image width/height, but the VNC
protocol only permits a unsigned int16. Effective framebuffer size
is determined by the guest, limited by the video RAM size, so the
dimensions are unlikely to exceed the range of an unsigned int16,
but this is not currently validated.

With the current use of 'int' for client width/height, the calculation
of offsets in vnc_update_throttle_offset() suffers from integer size
promotion and sign extension, causing coverity warnings

*** CID 1385147:  Integer handling issues  (SIGN_EXTENSION)
/ui/vnc.c: 979 in vnc_update_throttle_offset()
973      * than that the client would already suffering awful audio
974      * glitches, so dropping samples is no worse really).
975      */
976     static void vnc_update_throttle_offset(VncState *vs)
977     {
978         size_t offset =
>>>     CID 1385147:  Integer handling issues  (SIGN_EXTENSION)
>>>     Suspicious implicit sign extension:
    "vs->client_pf.bytes_per_pixel" with type "unsigned char" (8 bits,
    unsigned) is promoted in "vs->client_width * vs->client_height *
    vs->client_pf.bytes_per_pixel" to type "int" (32 bits, signed), then
    sign-extended to type "unsigned long" (64 bits, unsigned).  If
    "vs->client_width * vs->client_height * vs->client_pf.bytes_per_pixel"
    is greater than 0x7FFFFFFF, the upper bits of the result will all be 1.
979             vs->client_width * vs->client_height * vs->client_pf.bytes_per_pixel;

Change client_width / client_height to be a size_t to avoid sign
extension and integer promotion. Then validate that dimensions are in
range wrt the RFB protocol u16 limits.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20180118155254.17053-1-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.h | 4 ++--
 ui/vnc.c | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 0c33a5f7fe..bbda0540a7 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -278,8 +278,8 @@ struct VncState
     int last_x;
     int last_y;
     uint32_t last_bmask;
-    int client_width;
-    int client_height;
+    size_t client_width; /* limited to u16 by RFB proto */
+    size_t client_height; /* limited to u16 by RFB proto */
     VncShareMode share_mode;
 
     uint32_t vnc_encoding;
diff --git a/ui/vnc.c b/ui/vnc.c
index 665a143578..33b087221f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -672,6 +672,11 @@ static void vnc_desktop_resize(VncState *vs)
         vs->client_height == pixman_image_get_height(vs->vd->server)) {
         return;
     }
+
+    assert(pixman_image_get_width(vs->vd->server) < 65536 &&
+           pixman_image_get_width(vs->vd->server) >= 0);
+    assert(pixman_image_get_height(vs->vd->server) < 65536 &&
+           pixman_image_get_height(vs->vd->server) >= 0);
     vs->client_width = pixman_image_get_width(vs->vd->server);
     vs->client_height = pixman_image_get_height(vs->vd->server);
     vnc_lock_output(vs);
@@ -2490,6 +2495,10 @@ static int protocol_client_init(VncState *vs, uint8_t *data, size_t len)
         return 0;
     }
 
+    assert(pixman_image_get_width(vs->vd->server) < 65536 &&
+           pixman_image_get_width(vs->vd->server) >= 0);
+    assert(pixman_image_get_height(vs->vd->server) < 65536 &&
+           pixman_image_get_height(vs->vd->server) >= 0);
     vs->client_width = pixman_image_get_width(vs->vd->server);
     vs->client_height = pixman_image_get_height(vs->vd->server);
     vnc_write_u16(vs, vs->client_width);
-- 
2.9.3
