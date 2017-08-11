Received: from eggs.gnu.org ([2001:4830:134:3::10]:56995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZe-00017u-Sc
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZc-0002WO-JN
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 11 Aug 2017 16:05:31 +0200
Message-Id: <20170811140536.2792-3-kwolf@redhat.com>
In-Reply-To: <20170811140536.2792-1-kwolf@redhat.com>
References: <20170811140536.2792-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/7] vpc: Check failure of bdrv_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

vpc_open() was checking for bdrv_getlength() failure in one, but
not the other, location.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/vpc.c b/block/vpc.c
index 574879ba7c..82911ebead 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -219,6 +219,7 @@ static int vpc_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
     uint64_t pagetable_size;
     int disk_type =3D VHD_DYNAMIC;
     int ret;
+    int64_t bs_size;
=20
     bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file,
                                false, errp);
@@ -411,7 +412,13 @@ static int vpc_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
             }
         }
=20
-        if (s->free_data_block_offset > bdrv_getlength(bs->file->bs)) {
+        bs_size =3D bdrv_getlength(bs->file->bs);
+        if (bs_size < 0) {
+            error_setg_errno(errp, -bs_size, "Unable to learn image size=
");
+            ret =3D bs_size;
+            goto fail;
+        }
+        if (s->free_data_block_offset > bs_size) {
             error_setg(errp, "block-vpc: free_data_block_offset points a=
fter "
                              "the end of file. The image has been trunca=
ted.");
             ret =3D -EINVAL;
--=20
2.13.4
