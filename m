Received: from eggs.gnu.org ([2001:4830:134:3::10]:48534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gDwyO-00025W-Bl
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gDwyN-0005C9-KE
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 15:31:44 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Sat, 20 Oct 2018 21:31:06 +0200
Message-Id: <20181020193107.11369-1-kwolf@redhat.com>
In-Reply-To: <20181019163013.11787-1-kwolf@redhat.com>
References: <20181019163013.11787-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 10/11] block: Make auto-read-only=on default
 for -drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

While we want machine interfaces like -blockdev and QMP blockdev-add to
add as little auto-detection as possible so that management tools are
explicit about their needs, -drive is a convenience option for human
users. Enabling auto-read-only=3Don by default there enables users to use
read-only images for read-only guest devices without having to specify
read-only=3Don explicitly. If they try to attach the image to a read-writ=
e
device, they will still get an error message.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 blockdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/blockdev.c b/blockdev.c
index a8755bd908..ab57a8a53a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -590,6 +590,7 @@ static BlockBackend *blockdev_init(const char *file, =
QDict *bs_opts,
         qdict_set_default_str(bs_opts, BDRV_OPT_CACHE_NO_FLUSH, "off");
         qdict_set_default_str(bs_opts, BDRV_OPT_READ_ONLY,
                               read_only ? "on" : "off");
+        qdict_set_default_str(bs_opts, BDRV_OPT_AUTO_READ_ONLY, "on");
         assert((bdrv_flags & BDRV_O_CACHE_MASK) =3D=3D 0);
=20
         if (runstate_check(RUN_STATE_INMIGRATE)) {
--=20
2.19.1
