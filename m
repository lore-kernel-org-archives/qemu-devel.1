Received: from eggs.gnu.org ([2001:4830:134:3::10]:50146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qR-0006O7-4P
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qJ-00054g-Dk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0qJ-000539-56
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F62BC04AC48
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:12:50 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:20 +0000
Message-Id: <20171218191228.31018-6-berrange@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 05/13] ui: track how much decoded data we
 consumed when doing SASL encoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, P J P <ppandit@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

When we encode data for writing with SASL, we encode the entire pending output
buffer. The subsequent write, however, may not be able to send the full encoded
data in one go though, particularly with a slow network. So we delay setting the
output buffer offset back to zero until all the SASL encoded data is sent.

Between encoding the data and completing sending of the SASL encoded data,
however, more data might have been placed on the pending output buffer. So it
is not valid to set offset back to zero. Instead we must keep track of how much
data we consumed during encoding and subtract only that amount.

With the current bug we would be throwing away some pending data without having
sent it at all. By sheer luck this did not previously cause any serious problem
because appending data to the send buffer is always an atomic action, so we
only ever throw away complete RFB protocol messages. In the case of frame buffer
updates we'd catch up fairly quickly, so no obvious problem was visible.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc-auth-sasl.c | 3 ++-
 ui/vnc-auth-sasl.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 23f28280e7..761493b9b2 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -67,6 +67,7 @@ long vnc_client_write_sasl(VncState *vs)
         if (err != SASL_OK)
             return vnc_client_io_error(vs, -1, NULL);
 
+        vs->sasl.encodedRawLength = vs->output.offset;
         vs->sasl.encodedOffset = 0;
     }
 
@@ -78,7 +79,7 @@ long vnc_client_write_sasl(VncState *vs)
 
     vs->sasl.encodedOffset += ret;
     if (vs->sasl.encodedOffset == vs->sasl.encodedLength) {
-        vs->output.offset = 0;
+        vs->output.offset -= vs->sasl.encodedRawLength;
         vs->sasl.encoded = NULL;
         vs->sasl.encodedOffset = vs->sasl.encodedLength = 0;
     }
diff --git a/ui/vnc-auth-sasl.h b/ui/vnc-auth-sasl.h
index cb42745a6b..b9d8de1c10 100644
--- a/ui/vnc-auth-sasl.h
+++ b/ui/vnc-auth-sasl.h
@@ -53,6 +53,7 @@ struct VncStateSASL {
      */
     const uint8_t *encoded;
     unsigned int encodedLength;
+    unsigned int encodedRawLength;
     unsigned int encodedOffset;
     char *username;
     char *mechlist;
-- 
2.14.3
