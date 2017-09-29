Received: from eggs.gnu.org ([2001:4830:134:3::10]:47633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyae-0002sd-Iy
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyad-0004VR-R6
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:56:40 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 29 Sep 2017 18:53:46 +0200
Message-Id: <20170929165347.29658-25-mreitz@redhat.com>
In-Reply-To: <20170929165347.29658-1-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 24/25] block/curl: Implement
 bdrv_refresh_filename()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/curl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 11318a9a29..fe57223fda 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -957,6 +957,20 @@ static int64_t curl_getlength(BlockDriverState *bs)
     return s->len;
 }
 
+static void curl_refresh_filename(BlockDriverState *bs)
+{
+    BDRVCURLState *s = bs->opaque;
+
+    if (!s->sslverify || s->cookie ||
+        s->username || s->password || s->proxyusername || s->proxypassword)
+    {
+        return;
+    }
+
+    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename), s->url);
+}
+
+
 static const char *const curl_sgfnt_runtime_opts[] = {
     CURL_BLOCK_OPT_URL,
     CURL_BLOCK_OPT_SSLVERIFY,
@@ -985,6 +999,7 @@ static BlockDriver bdrv_http = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
@@ -1003,6 +1018,7 @@ static BlockDriver bdrv_https = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
@@ -1021,6 +1037,7 @@ static BlockDriver bdrv_ftp = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
@@ -1039,6 +1056,7 @@ static BlockDriver bdrv_ftps = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .sgfnt_runtime_opts         = curl_sgfnt_runtime_opts,
 };
 
-- 
2.13.6
