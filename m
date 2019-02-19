Received: from eggs.gnu.org ([209.51.188.92]:51398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw4rU-0005wk-IQ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:51:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw4rT-00084Y-JR
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:51:00 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 19 Feb 2019 12:50:44 +0000
Message-Id: <20190219125044.5416-3-berrange@redhat.com>
In-Reply-To: <20190219125044.5416-1-berrange@redhat.com>
References: <20190219125044.5416-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] qcow2: mark image as corrupt if failing
 during create
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

During creation we write a minimal qcow2 header and then update it with
extra features. If the updating fails for some reason we might still be
left with a valid qcow2 image that will be mistakenly used for I/O. We
cannot delete the image, since we don't know if we created the
underlying storage or not. Thus we mark the header as corrupt to
prevents its later usage.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/qcow2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index ecc577175f..338513e652 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3104,6 +3104,9 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
=20
     ret =3D 0;
 out:
+    if (ret < 0) {
+        qcow2_mark_corrupt(blk_bs(blk));
+    }
     blk_unref(blk);
     bdrv_unref(bs);
     return ret;
--=20
2.20.1
