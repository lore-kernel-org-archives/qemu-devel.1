Received: from eggs.gnu.org ([209.51.188.92]:35595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghWZF-00028D-Pw
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghWZF-0001Xx-5f
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:24:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghWZE-0001XY-WC
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:24:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 588FF20B09
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:24:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 10 Jan 2019 10:23:55 +0100
Message-Id: <20190110092355.7121-3-kraxel@redhat.com>
In-Reply-To: <20190110092355.7121-1-kraxel@redhat.com>
References: <20190110092355.7121-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] usb-audio: ignore usb packages with wrong
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

usb packets with no payload (zero length) seem to happen in practice for
whatever reason.  Add a check and skip the packet then, otherwise we'll
trigger an assert.

Reported-by: Leonardo Soares M=C3=BCller <leozinho29_eu@hotmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181211072649.20700-1-kraxel@redhat.com
---
 hw/usb/dev-audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index ee43e4914d..28ac7c5165 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -321,6 +321,9 @@ static int streambuf_put(struct streambuf *buf, USBPa=
cket *p)
     if (!free) {
         return 0;
     }
+    if (p->iov.size !=3D USBAUDIO_PACKET_SIZE) {
+        return 0;
+    }
     assert(free >=3D USBAUDIO_PACKET_SIZE);
     usb_packet_copy(p, buf->data + (buf->prod % buf->size),
                     USBAUDIO_PACKET_SIZE);
--=20
2.9.3
