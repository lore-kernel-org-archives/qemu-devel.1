Received: from eggs.gnu.org ([209.51.188.92]:38129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hMSAq-0003n0-LC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hMSAp-0006EM-L3
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:00:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hMSAp-0006Dk-Ez
	for qemu-devel@nongnu.org; Fri, 03 May 2019 02:59:59 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  3 May 2019 08:59:48 +0200
Message-Id: <20190503065954.17069-2-kraxel@redhat.com>
In-Reply-To: <20190503065954.17069-1-kraxel@redhat.com>
References: <20190503065954.17069-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/7] usb-mtp: fix string length for filename
 when writing metadata
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The ObjectInfo 'length' field provides the length of the
wide character string filename. This is then converted to
a multi-byte character string. This may have a different
byte count to the wide character string. We should use the
C string length of the multi-byte string instead.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190415154503.6758-2-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 99548b012d1f..6b7d1296e430 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1721,7 +1721,7 @@ static void usb_mtp_write_metadata(MTPState *s, uin=
t64_t dlen)
         return;
     }
=20
-    o =3D usb_mtp_object_lookup_name(p, filename, dataset->length);
+    o =3D usb_mtp_object_lookup_name(p, filename, -1);
     if (o !=3D NULL) {
         next_handle =3D o->handle;
     }
--=20
2.18.1
