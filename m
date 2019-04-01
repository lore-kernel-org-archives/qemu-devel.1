Received: from eggs.gnu.org ([209.51.188.92]:45851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcj-0001zG-12
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxci-0004mD-1J
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:16 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:08:54 -0500
Message-Id: <20190401140903.19186-6-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/14] qemu-img: Gracefully shutdown when map
 can't finish
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Trying 'qemu-img map -f raw nbd://localhost:10809' causes the
NBD server to output a scary message:

qemu-nbd: Disconnect client, due to: Failed to read request: Unexpected e=
nd-of-file before all bytes were read

This is because the NBD client, being remote, has no way to expose a
human-readable map (the --output=3Djson data is fine, however). But
because we exit(1) right after the message, causing the client to
bypass all block cleanup, the server sees the abrupt exit and warns,
whereas it would be silent had the client had a chance to send
NBD_CMD_DISC. Other protocols may have similar cleanup issues, where
failure to blk_unref() could cause unintended effects.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190326184043.7544-1-eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 03a9a10dec1..76a961df824 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2736,14 +2736,14 @@ static int img_info(int argc, char **argv)
     return 0;
 }

-static void dump_map_entry(OutputFormat output_format, MapEntry *e,
-                           MapEntry *next)
+static int dump_map_entry(OutputFormat output_format, MapEntry *e,
+                          MapEntry *next)
 {
     switch (output_format) {
     case OFORMAT_HUMAN:
         if (e->data && !e->has_offset) {
             error_report("File contains external, encrypted or compresse=
d clusters.");
-            exit(1);
+            return -1;
         }
         if (e->data && !e->zero) {
             printf("%#-16"PRIx64"%#-16"PRIx64"%#-16"PRIx64"%s\n",
@@ -2776,6 +2776,7 @@ static void dump_map_entry(OutputFormat output_form=
at, MapEntry *e,
         }
         break;
     }
+    return 0;
 }

 static int get_block_status(BlockDriverState *bs, int64_t offset,
@@ -2968,12 +2969,15 @@ static int img_map(int argc, char **argv)
         }

         if (curr.length > 0) {
-            dump_map_entry(output_format, &curr, &next);
+            ret =3D dump_map_entry(output_format, &curr, &next);
+            if (ret < 0) {
+                goto out;
+            }
         }
         curr =3D next;
     }

-    dump_map_entry(output_format, &curr, NULL);
+    ret =3D dump_map_entry(output_format, &curr, NULL);

 out:
     blk_unref(blk);
--=20
2.20.1
