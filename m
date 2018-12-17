Received: from eggs.gnu.org ([2001:4830:134:3::10]:33939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1dB-0007hg-7d
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1dA-0006VP-BZ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:57 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:42 +0100
Message-Id: <20181217224348.14922-26-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 25/31] block: Do not copy exact_filename
 from format file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

If a format BDS's file BDS is in turn a format BDS, we cannot simply use
the same filename, because when opening a BDS tree based on a filename
alone, qemu will create only one format node on top of one protocol node
(disregarding a potential backing file).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index c8399a9036..44bebfc80c 100644
--- a/block.c
+++ b/block.c
@@ -5513,9 +5513,21 @@ void bdrv_refresh_filename(BlockDriverState *bs)
=20
         bs->exact_filename[0] =3D '\0';
=20
-        /* If no specific options have been given for this BDS, the file=
name of
-         * the underlying file should suffice for this one as well */
-        if (bs->file->bs->exact_filename[0] && !generate_json_filename) =
{
+        /*
+         * We can use the underlying file's filename if:
+         * - it has a filename,
+         * - the file is a protocol BDS, and
+         * - opening that file (as this BDS's format) will automatically=
 create
+         *   the BDS tree we have right now, that is:
+         *   - the user did not significantly change this BDS's behavior=
 with
+         *     some explicit (strong) options
+         *   - no non-file child of this BDS has been overridden by the =
user
+         *   Both of these conditions are represented by generate_json_f=
ilename.
+         */
+        if (bs->file->bs->exact_filename[0] &&
+            bs->file->bs->drv->bdrv_file_open &&
+            !generate_json_filename)
+        {
             strcpy(bs->exact_filename, bs->file->bs->exact_filename);
         }
     }
--=20
2.19.2
