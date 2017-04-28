Received: from eggs.gnu.org ([2001:4830:134:3::10]:55472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cal-0001aq-31
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4Cak-0001C3-BO
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:17 +0200
Message-Id: <1493411622-5343-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/34] block: An empty filename counts as no
 filename
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

From: Max Reitz <mreitz@redhat.com>

Reproducer:
    $ ./qemu-img info ''
    qemu-img: ./block.c:1008: bdrv_open_driver: Assertion
        `!drv->bdrv_needs_filename || bs->filename[0]' failed.
    [1]    26105 abort (core dumped)  ./qemu-img info ''

This patch fixes this to be:
    $ ./qemu-img info ''
    qemu-img: Could not open '': The 'file' block driver requires a file
    name

Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index ceaca44..7b557f3 100644
--- a/block.c
+++ b/block.c
@@ -1204,7 +1204,7 @@ static int bdrv_open_common(BlockDriverState *bs, B=
lockBackend *file,
         filename =3D qdict_get_try_str(options, "filename");
     }
=20
-    if (drv->bdrv_needs_filename && !filename) {
+    if (drv->bdrv_needs_filename && (!filename || !filename[0])) {
         error_setg(errp, "The '%s' block driver requires a file name",
                    drv->format_name);
         ret =3D -EINVAL;
--=20
1.8.3.1
