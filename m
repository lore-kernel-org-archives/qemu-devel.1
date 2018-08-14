Received: from eggs.gnu.org ([2001:4830:134:3::10]:51109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpTiU-0001tN-Cv
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 03:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpTiT-0006RQ-HU
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 03:26:10 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 14 Aug 2018 15:25:51 +0800
Message-Id: <20180814072551.15465-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] luks: Allow share-rw=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Format drivers such as qcow2 don't allow sharing the same image between
two QEMU instances in order to prevent image corruptions, because of
metadata cache. LUKS driver don't modify metadata except for when
creating image, so it is safe to relax the permission. This makes
share-rw=3Don property work on virtual devices.

Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/crypto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index 146d81c90a..33ee01bebd 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -627,7 +627,9 @@ BlockDriver bdrv_crypto_luks =3D {
     .bdrv_probe         =3D block_crypto_probe_luks,
     .bdrv_open          =3D block_crypto_open_luks,
     .bdrv_close         =3D block_crypto_close,
-    .bdrv_child_perm    =3D bdrv_format_default_perms,
+    /* This driver doesn't modify LUKS metadata except when creating ima=
ge.
+     * Allow share-rw=3Don as a special case. */
+    .bdrv_child_perm    =3D bdrv_filter_default_perms,
     .bdrv_co_create     =3D block_crypto_co_create_luks,
     .bdrv_co_create_opts =3D block_crypto_co_create_opts_luks,
     .bdrv_co_truncate   =3D block_crypto_co_truncate,
--=20
2.17.1
