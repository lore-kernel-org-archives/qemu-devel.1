Received: from eggs.gnu.org ([209.51.188.92]:51415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw4rV-0005x4-9B
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw4rU-00085G-2G
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:51:01 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 19 Feb 2019 12:50:43 +0000
Message-Id: <20190219125044.5416-2-berrange@redhat.com>
In-Reply-To: <20190219125044.5416-1-berrange@redhat.com>
References: <20190219125044.5416-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] qcow2: fail if encryption opts are
 provided to non-encrypted image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

If the qcow2 image does not have any encryption method specified in its
header, the user should not be providing any encryption options when
opening it. We already detect this if the user had set "encrypt.format"
but this field is optional so must consider any "encrypt.*" option to be
an error.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/qcow2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 65a54c9ac6..ecc577175f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1045,6 +1045,12 @@ static int qcow2_update_options_prepare(BlockDrive=
rState *bs,
             ret =3D -EINVAL;
             goto fail;
         }
+        if (encryptopts && qdict_size(encryptopts)) {
+            error_setg(errp, "No encryption in image header, but encrypt=
ion "
+                       "options provided");
+            ret =3D -EINVAL;
+            goto fail;
+        }
         break;
=20
     case QCOW_CRYPT_AES:
--=20
2.20.1
