Received: from eggs.gnu.org ([2001:4830:134:3::10]:47550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj8h-0007ls-T5
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj8g-0007Vw-RR
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:43 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:39:29 +0100
Message-Id: <20170212013929.6793-4-mreitz@redhat.com>
In-Reply-To: <20170212013440.5919-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/21] qemu-img: Avoid setting ret to unused
 value in img_convert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out that we assign the return value from
bdrv_snapshot_load_tmp() to 'ret' in img_convert(), but then
never use that variable. (We check for failure by looking
at local_err instead.) Drop the unused assignment, bringing
the call into line with the following call to
bdrv_snapshot_laod_tmp_by_id_or_name().

(Fixes CID 1247240.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1486744104-15590-3-git-send-email-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 38266e56b0..cff22e3005 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1968,10 +1968,10 @@ static int img_convert(int argc, char **argv)
     }
=20
     if (sn_opts) {
-        ret =3D bdrv_snapshot_load_tmp(bs[0],
-                                     qemu_opt_get(sn_opts, SNAPSHOT_OPT_=
ID),
-                                     qemu_opt_get(sn_opts, SNAPSHOT_OPT_=
NAME),
-                                     &local_err);
+        bdrv_snapshot_load_tmp(bs[0],
+                               qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
+                               qemu_opt_get(sn_opts, SNAPSHOT_OPT_NAME),
+                               &local_err);
     } else if (snapshot_name !=3D NULL) {
         if (bs_n > 1) {
             error_report("No support for concatenating multiple snapshot=
");
--=20
2.11.0
