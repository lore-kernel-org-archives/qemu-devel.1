Received: from eggs.gnu.org ([2001:4830:134:3::10]:57630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zj8-0003rL-3C
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zj5-0000ml-HJ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:41:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat,  6 Oct 2018 01:40:20 +0200
Message-Id: <20181005234023.8104-29-mreitz@redhat.com>
In-Reply-To: <20181005234023.8104-1-mreitz@redhat.com>
References: <20181005234023.8104-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 28/31] block/curl: Implement
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/curl.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 96790fdc70..a5d3e64b84 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -963,6 +963,23 @@ static int64_t curl_getlength(BlockDriverState *bs)
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
@@ -991,6 +1008,7 @@ static BlockDriver bdrv_http = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
@@ -1009,6 +1027,7 @@ static BlockDriver bdrv_https = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
@@ -1027,6 +1046,7 @@ static BlockDriver bdrv_ftp = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
@@ -1045,6 +1065,7 @@ static BlockDriver bdrv_ftps = {
     .bdrv_detach_aio_context    = curl_detach_aio_context,
     .bdrv_attach_aio_context    = curl_attach_aio_context,
 
+    .bdrv_refresh_filename      = curl_refresh_filename,
     .strong_runtime_opts        = curl_strong_runtime_opts,
 };
 
-- 
2.17.1
