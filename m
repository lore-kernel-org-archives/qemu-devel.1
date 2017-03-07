Received: from eggs.gnu.org ([2001:4830:134:3::10]:42629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEq-0002Jk-0t
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEp-0002o0-4e
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:37 +0100
Message-Id: <1488901251-16214-14-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/27] sheepdog: Fix error handling sd_create()
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

From: Markus Armbruster <armbru@redhat.com>

As a bdrv_create() method, sd_create() must set an error and return
negative errno on failure.  It prints the error instead of setting it
when connect_to_sdog() fails.  Fix that.

While there, return the value of connect_to_sdog() like we do
elsewhere, instead of -EIO.  No functional change, as
connect_to_sdog() returns no other error code.

Many more suspicious uses of error_report() and error_report_err()
remain in other functions.  Left for another day.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/sheepdog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 0a0803e..be3db1f 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1829,14 +1829,12 @@ static int sd_create(const char *filename, QemuOp=
ts *opts,
     if (s->inode.block_size_shift =3D=3D 0) {
         SheepdogVdiReq hdr;
         SheepdogClusterRsp *rsp =3D (SheepdogClusterRsp *)&hdr;
-        Error *local_err =3D NULL;
         int fd;
         unsigned int wlen =3D 0, rlen =3D 0;
=20
-        fd =3D connect_to_sdog(s, &local_err);
+        fd =3D connect_to_sdog(s, errp);
         if (fd < 0) {
-            error_report_err(local_err);
-            ret =3D -EIO;
+            ret =3D fd;
             goto out;
         }
=20
--=20
1.8.3.1
