Received: from eggs.gnu.org ([2001:4830:134:3::10]:42742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEx-0002S2-KE
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEr-0002qH-Uy
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:31 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:40 +0100
Message-Id: <1488901251-16214-17-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/27] sheepdog: Don't truncate long VDI name in
 _open(), _create()
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

sd_parse_uri() truncates long VDI names silently.  Reject them
instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/sheepdog.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index d3d3731..fed7264 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -985,7 +985,10 @@ static int sd_parse_uri(BDRVSheepdogState *s, const =
char *filename,
         ret =3D -EINVAL;
         goto out;
     }
-    pstrcpy(vdi, SD_MAX_VDI_LEN, uri->path + 1);
+    if (g_strlcpy(vdi, uri->path + 1, SD_MAX_VDI_LEN) >=3D SD_MAX_VDI_LE=
N) {
+        ret =3D -EINVAL;
+        goto out;
+    }
=20
     qp =3D query_params_parse(uri->query);
     if (qp->n > 1 || (s->is_unix && !qp->n) || (!s->is_unix && qp->n)) {
--=20
1.8.3.1
