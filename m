Received: from eggs.gnu.org ([209.51.188.92]:53101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h1drH-0006nS-UH
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h1drG-0007TN-Vw
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1h1drG-0007SK-6M
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:13:46 -0500
From: Bandan Das <bsd@redhat.com>
Date: Wed,  6 Mar 2019 16:04:09 -0500
Message-Id: <20190306210409.14842-4-bsd@redhat.com>
In-Reply-To: <20190306210409.14842-1-bsd@redhat.com>
References: <20190306210409.14842-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/3] usb-mtp: prevent null dereference while
 deleting objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org

Spotted by Coverity: CID 1399144

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1f22284949..06e376bcd2 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1177,9 +1177,7 @@ static int usb_mtp_deletefn(MTPState *s, MTPObject =
*o, uint32_t trans)
             usb_mtp_object_free_one(s, o);
             success =3D true;
         }
-    }
-
-    if (o->format =3D=3D FMT_ASSOCIATION) {
+    } else if (o->format =3D=3D FMT_ASSOCIATION) {
         if (rmdir(o->path)) {
             partial_delete =3D true;
         } else {
--=20
2.19.2
