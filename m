Received: from eggs.gnu.org ([209.51.188.92]:38478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5n-0001Hb-0C
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5m-0001ob-5t
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:36 +0100
Message-Id: <20190225152053.15976-55-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 54/71] block/curl: Implement
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20190201192935.18394-29-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/curl.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 2c07a694d8..606709fea4 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -950,6 +950,23 @@ static int64_t curl_getlength(BlockDriverState *bs)
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
@@ -978,6 +995,7 @@ static BlockDriver bdrv_http =3D {
     .bdrv_detach_aio_context    =3D curl_detach_aio_context,
     .bdrv_attach_aio_context    =3D curl_attach_aio_context,
=20
+    .bdrv_refresh_filename      =3D curl_refresh_filename,
     .strong_runtime_opts        =3D curl_strong_runtime_opts,
 };
=20
@@ -996,6 +1014,7 @@ static BlockDriver bdrv_https =3D {
     .bdrv_detach_aio_context    =3D curl_detach_aio_context,
     .bdrv_attach_aio_context    =3D curl_attach_aio_context,
=20
+    .bdrv_refresh_filename      =3D curl_refresh_filename,
     .strong_runtime_opts        =3D curl_strong_runtime_opts,
 };
=20
@@ -1014,6 +1033,7 @@ static BlockDriver bdrv_ftp =3D {
     .bdrv_detach_aio_context    =3D curl_detach_aio_context,
     .bdrv_attach_aio_context    =3D curl_attach_aio_context,
=20
+    .bdrv_refresh_filename      =3D curl_refresh_filename,
     .strong_runtime_opts        =3D curl_strong_runtime_opts,
 };
=20
@@ -1032,6 +1052,7 @@ static BlockDriver bdrv_ftps =3D {
     .bdrv_detach_aio_context    =3D curl_detach_aio_context,
     .bdrv_attach_aio_context    =3D curl_attach_aio_context,
=20
+    .bdrv_refresh_filename      =3D curl_refresh_filename,
     .strong_runtime_opts        =3D curl_strong_runtime_opts,
 };
=20
--=20
2.20.1
