Received: from eggs.gnu.org ([209.51.188.92]:58082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grPFI-0005vk-Ne
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grPFI-000074-06
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:36:16 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 16:29:19 +0100
Message-Id: <20190206152919.5532-3-mreitz@redhat.com>
In-Reply-To: <20190206152919.5532-1-mreitz@redhat.com>
References: <20190206152919.5532-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] block/ssh: Implement .bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>

ssh_bdrv_dirname() is basically the generic bdrv_dirname(), except it
takes care not to silently chop off any query string (i.e.,
host_key_check).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/ssh.c b/block/ssh.c
index 88401bbd31..b519c00869 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1295,6 +1295,26 @@ static void ssh_refresh_filename(BlockDriverState =
*bs)
     }
 }
=20
+static char *ssh_bdrv_dirname(BlockDriverState *bs, Error **errp)
+{
+    if (qdict_haskey(bs->full_open_options, "host_key_check")) {
+        /*
+         * We cannot generate a simple prefix if we would have to
+         * append a query string.
+         */
+        error_setg(errp,
+                   "Cannot generate a base directory with host_key_check=
 set");
+        return NULL;
+    }
+
+    if (bs->exact_filename[0] =3D=3D '\0') {
+        error_setg(errp, "Cannot generate a base directory for this ssh =
node");
+        return NULL;
+    }
+
+    return path_combine(bs->exact_filename, "");
+}
+
 static const char *const ssh_strong_runtime_opts[] =3D {
     "host",
     "port",
@@ -1322,6 +1342,7 @@ static BlockDriver bdrv_ssh =3D {
     .bdrv_co_truncate             =3D ssh_co_truncate,
     .bdrv_co_flush_to_disk        =3D ssh_co_flush,
     .bdrv_refresh_filename        =3D ssh_refresh_filename,
+    .bdrv_dirname                 =3D ssh_bdrv_dirname,
     .create_opts                  =3D &ssh_create_opts,
     .strong_runtime_opts          =3D ssh_strong_runtime_opts,
 };
--=20
2.20.1
