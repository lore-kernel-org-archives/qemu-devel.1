Received: from eggs.gnu.org ([2001:4830:134:3::10]:48323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvG-0003NR-Mx
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvF-0002pM-JR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZyvF-0002oJ-DQ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D6F6C0272F6
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:59:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 13:58:46 +0100
Message-Id: <20180112125854.18261-7-kraxel@redhat.com>
In-Reply-To: <20180112125854.18261-1-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/14] ui: track how much decoded data we
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

When we encode data for writing with SASL, we encode the entire pending o=
utput
buffer. The subsequent write, however, may not be able to send the full e=
ncoded
data in one go though, particularly with a slow network. So we delay sett=
ing the
output buffer offset back to zero until all the SASL encoded data is sent=
.

Between encoding the data and completing sending of the SASL encoded data=
,
however, more data might have been placed on the pending output buffer. S=
o it
is not valid to set offset back to zero. Instead we must keep track of ho=
w much
data we consumed during encoding and subtract only that amount.

With the current bug we would be throwing away some pending data without =
having
sent it at all. By sheer luck this did not previously cause any serious p=
roblem
because appending data to the send buffer is always an atomic action, so =
we
only ever throw away complete RFB protocol messages. In the case of frame=
 buffer
updates we'd catch up fairly quickly, so no obvious problem was visible.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20171218191228.31018-6-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc-auth-sasl.h | 1 +
 ui/vnc-auth-sasl.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

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
diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 23f28280e7..761493b9b2 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -67,6 +67,7 @@ long vnc_client_write_sasl(VncState *vs)
         if (err !=3D SASL_OK)
             return vnc_client_io_error(vs, -1, NULL);
=20
+        vs->sasl.encodedRawLength =3D vs->output.offset;
         vs->sasl.encodedOffset =3D 0;
     }
=20
@@ -78,7 +79,7 @@ long vnc_client_write_sasl(VncState *vs)
=20
     vs->sasl.encodedOffset +=3D ret;
     if (vs->sasl.encodedOffset =3D=3D vs->sasl.encodedLength) {
-        vs->output.offset =3D 0;
+        vs->output.offset -=3D vs->sasl.encodedRawLength;
         vs->sasl.encoded =3D NULL;
         vs->sasl.encodedOffset =3D vs->sasl.encodedLength =3D 0;
     }
--=20
2.9.3
