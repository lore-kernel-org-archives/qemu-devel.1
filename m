Received: from eggs.gnu.org ([2001:4830:134:3::10]:34096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1dM-0007qt-Ns
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1dL-0006bA-7i
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:45:08 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:45 +0100
Message-Id: <20181217224348.14922-29-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 28/31] block/curl: Implement
 bdrv_refresh_filename()
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/curl.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 02f9d9d692..1ccc2e92e1 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -963,6 +963,23 @@ static int64_t curl_getlength(BlockDriverState *bs)
     return s->len;
 }
=20
+static void curl_refresh_filename(BlockDriverState *bs)
+{
+    BDRVCURLState *s =3D bs->opaque;
+
+    /* "readahead" and "timeout" do not change the guest-visible data,
+     * so ignore them */
+    if (s->sslverify !=3D CURL_BLOCK_OPT_SSLVERIFY_DEFAULT ||
+        s->cookie || s->username || s->password || s->proxyusername ||
+        s->proxypassword)
+    {
+        return;
+    }
+
+    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename), s->url);
+}
+
+
 static const char *const curl_strong_runtime_opts[] =3D {
     CURL_BLOCK_OPT_URL,
     CURL_BLOCK_OPT_SSLVERIFY,
@@ -991,6 +1008,7 @@ static BlockDriver bdrv_http =3D {
     .bdrv_detach_aio_context    =3D curl_detach_aio_context,
     .bdrv_attach_aio_context    =3D curl_attach_aio_context,
=20
+    .bdrv_refresh_filename      =3D curl_refresh_filename,
     .strong_runtime_opts        =3D curl_strong_runtime_opts,
 };
=20
@@ -1009,6 +1027,7 @@ static BlockDriver bdrv_https =3D {
     .bdrv_detach_aio_context    =3D curl_detach_aio_context,
     .bdrv_attach_aio_context    =3D curl_attach_aio_context,
=20
+    .bdrv_refresh_filename      =3D curl_refresh_filename,
     .strong_runtime_opts        =3D curl_strong_runtime_opts,
 };
=20
@@ -1027,6 +1046,7 @@ static BlockDriver bdrv_ftp =3D {
     .bdrv_detach_aio_context    =3D curl_detach_aio_context,
     .bdrv_attach_aio_context    =3D curl_attach_aio_context,
=20
+    .bdrv_refresh_filename      =3D curl_refresh_filename,
     .strong_runtime_opts        =3D curl_strong_runtime_opts,
 };
=20
@@ -1045,6 +1065,7 @@ static BlockDriver bdrv_ftps =3D {
     .bdrv_detach_aio_context    =3D curl_detach_aio_context,
     .bdrv_attach_aio_context    =3D curl_attach_aio_context,
=20
+    .bdrv_refresh_filename      =3D curl_refresh_filename,
     .strong_runtime_opts        =3D curl_strong_runtime_opts,
 };
=20
--=20
2.19.2
