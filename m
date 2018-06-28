Received: from eggs.gnu.org ([2001:4830:134:3::10]:58248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKUO-00057T-Ou
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKUN-00053x-Fb
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 28 Jun 2018 02:07:41 +0200
Message-Id: <20180628000745.4477-28-mreitz@redhat.com>
In-Reply-To: <20180628000745.4477-1-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 27/31] block/curl: Harmonize option defaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Both of the defaults we currently have in the curl driver are named
based on a slightly different schema, let's unify that and call both
CURL_BLOCK_OPT_${NAME}_DEFAULT.

While at it, we can add a macro for the third option for which a default
exists, namely "sslverify".

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/curl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 8e4f17266b..f095fe4664 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -73,8 +73,6 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 
 #define CURL_NUM_STATES 8
 #define CURL_NUM_ACB    8
-#define READ_AHEAD_DEFAULT (256 * 1024)
-#define CURL_TIMEOUT_DEFAULT 5
 #define CURL_TIMEOUT_MAX 10000
 
 #define CURL_BLOCK_OPT_URL       "url"
@@ -88,6 +86,10 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_BLOCK_OPT_PROXY_USERNAME "proxy-username"
 #define CURL_BLOCK_OPT_PROXY_PASSWORD_SECRET "proxy-password-secret"
 
+#define CURL_BLOCK_OPT_READAHEAD_DEFAULT (256 * 1024)
+#define CURL_BLOCK_OPT_SSLVERIFY_DEFAULT true
+#define CURL_BLOCK_OPT_TIMEOUT_DEFAULT 5
+
 struct BDRVCURLState;
 
 static bool libcurl_initialized;
@@ -706,7 +708,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->readahead_size = qemu_opt_get_size(opts, CURL_BLOCK_OPT_READAHEAD,
-                                          READ_AHEAD_DEFAULT);
+                                          CURL_BLOCK_OPT_READAHEAD_DEFAULT);
     if ((s->readahead_size & 0x1ff) != 0) {
         error_setg(errp, "HTTP_READAHEAD_SIZE %zd is not a multiple of 512",
                    s->readahead_size);
@@ -714,13 +716,14 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->timeout = qemu_opt_get_number(opts, CURL_BLOCK_OPT_TIMEOUT,
-                                     CURL_TIMEOUT_DEFAULT);
+                                     CURL_BLOCK_OPT_TIMEOUT_DEFAULT);
     if (s->timeout > CURL_TIMEOUT_MAX) {
         error_setg(errp, "timeout parameter is too large or negative");
         goto out_noclean;
     }
 
-    s->sslverify = qemu_opt_get_bool(opts, CURL_BLOCK_OPT_SSLVERIFY, true);
+    s->sslverify = qemu_opt_get_bool(opts, CURL_BLOCK_OPT_SSLVERIFY,
+                                     CURL_BLOCK_OPT_SSLVERIFY_DEFAULT);
 
     cookie = qemu_opt_get(opts, CURL_BLOCK_OPT_COOKIE);
     cookie_secret = qemu_opt_get(opts, CURL_BLOCK_OPT_COOKIE_SECRET);
-- 
2.17.1
