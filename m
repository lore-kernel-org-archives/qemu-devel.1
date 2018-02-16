Received: from eggs.gnu.org ([2001:4830:134:3::10]:36356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeao-0001dM-OE
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1emeal-0003fx-Lv
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1emeal-0003eT-Dc
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:54:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CEED8185324
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:54:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Feb 2018 12:54:09 +0100
Message-Id: <20180216115410.27287-9-kraxel@redhat.com>
In-Reply-To: <20180216115410.27287-1-kraxel@redhat.com>
References: <20180216115410.27287-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/9] ui: check VNC audio frequency limit at time
 of reading from client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The 'vs->as.freq' value is a signed integer, which is read from an
unsigned 32-bit int field on the wire. There is thus a risk of overflow
on 32-bit platforms. Move the frequency limit checking to be done at
time of read before casting to a signed integer.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180205114938.15784-4-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 746293ddfa..a77b568b57 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -982,14 +982,7 @@ static void vnc_update_throttle_offset(VncState *vs)
         vs->client_width * vs->client_height * vs->client_pf.bytes_per_p=
ixel;
=20
     if (vs->audio_cap) {
-        int freq =3D vs->as.freq;
-        /* We don't limit freq when reading settings from client, so
-         * it could be upto MAX_INT in size. 48khz is a sensible
-         * upper bound for trustworthy clients */
         int bps;
-        if (freq > 48000) {
-            freq =3D 48000;
-        }
         switch (vs->as.fmt) {
         default:
         case  AUD_FMT_U8:
@@ -1005,7 +998,7 @@ static void vnc_update_throttle_offset(VncState *vs)
             bps =3D 4;
             break;
         }
-        offset +=3D freq * bps * vs->as.nchannels;
+        offset +=3D vs->as.freq * bps * vs->as.nchannels;
     }
=20
     /* Put a floor of 1MB on offset, so that if we have a large pending
@@ -2292,6 +2285,7 @@ static int protocol_client_msg(VncState *vs, uint8_=
t *data, size_t len)
 {
     int i;
     uint16_t limit;
+    uint32_t freq;
     VncDisplay *vd =3D vs->vd;
=20
     if (data[0] > 3) {
@@ -2411,7 +2405,17 @@ static int protocol_client_msg(VncState *vs, uint8=
_t *data, size_t len)
                     vnc_client_error(vs);
                     break;
                 }
-                vs->as.freq =3D read_u32(data, 6);
+                freq =3D read_u32(data, 6);
+                /* No official limit for protocol, but 48khz is a sensib=
le
+                 * upper bound for trustworthy clients, and this limit
+                 * protects calculations involving 'vs->as.freq' later.
+                 */
+                if (freq > 48000) {
+                    VNC_DEBUG("Invalid audio frequency %u > 48000", freq=
);
+                    vnc_client_error(vs);
+                    break;
+                }
+                vs->as.freq =3D freq;
                 break;
             default:
                 VNC_DEBUG("Invalid audio message %d\n", read_u8(data, 4)=
);
--=20
2.9.3
