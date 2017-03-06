Received: from eggs.gnu.org ([2001:4830:134:3::10]:45942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsR-00045p-OY
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsQ-0004iu-9n
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:00:59 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 20:00:37 +0100
Message-Id: <1488826849-32384-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1488826849-32384-1-git-send-email-armbru@redhat.com>
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/15] sheepdog: Fix error handling
 sd_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, eblake@redhat.com, f4bug@amsat.org

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
2.7.4
