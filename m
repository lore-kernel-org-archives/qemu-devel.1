Received: from eggs.gnu.org ([2001:4830:134:3::10]:53711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIf6L-0001zk-JO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIf6K-0005wo-Oe
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:50:37 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  7 Jun 2017 19:50:18 +0200
Message-Id: <1496857819-12466-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
References: <1496857819-12466-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/8] block/qcow.c: Fix memory leak in
 qcow_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out that the code path in qcow_create() for
the magic "fat:" backing file name leaks the memory used to
store the filename (CID 1307771). Free the memory before
we overwrite the pointer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow.c b/block/qcow.c
index 95ab123..7bd94dc 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -852,6 +852,7 @@ static int qcow_create(const char *filename, QemuOpts=
 *opts, Error **errp)
             header_size +=3D backing_filename_len;
         } else {
             /* special backing file for vvfat */
+            g_free(backing_file);
             backing_file =3D NULL;
         }
         header.cluster_bits =3D 9; /* 512 byte cluster to avoid copying
--=20
1.8.3.1
