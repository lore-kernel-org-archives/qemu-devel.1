Received: from eggs.gnu.org ([2001:4830:134:3::10]:43280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbk-00038s-8D
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsbj-0000KO-17
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:36 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:25 +0200
Message-Id: <20180809213528.14738-29-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 28/31] block/curl: Implement
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/curl.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 13fca02aba..fcb8ad501b 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -961,6 +961,23 @@ static int64_t curl_getlength(BlockDriverState *bs)
     return s->len;
 }
 
+static void curl_refresh_filename(BlockDriverState *bs)
+{
+    BDRVCURLState *s = bs->opaque;
+
+    /* "readahead" and "timeout" do not change the guest-visible data,
+     * so ignore them */
+    if (s->sslverify != CURL_BLOCK_OPT_SSLVERIFY_DEFAULT ||
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
 static const char *const curl_strong_runtime_opts[] = {
     CURL_BLOCK_OPT_URL,
     CURL_BLOCK_OPT_SSLVERIFY,
@@ -989,6 +1006,7 @@ static BlockDriver bdrv_http = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
@@ -1007,6 +1025,7 @@ static BlockDriver bdrv_https = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
@@ -1025,6 +1044,7 @@ static BlockDriver bdrv_ftp = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
@@ -1043,6 +1063,7 @@ static BlockDriver bdrv_ftps = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
-- 
2.17.1
