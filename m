Received: from eggs.gnu.org ([2001:4830:134:3::10]:46644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAeo0-0003JR-Hb
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAenx-0001XG-EY
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:54:36 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 16 May 2017 11:54:13 -0400
Message-Id: <20170516155420.10106-2-jcody@redhat.com>
In-Reply-To: <20170516155420.10106-1-jcody@redhat.com>
References: <20170516155420.10106-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] block: curl: Allow passing cookies via
 QCryptoSecret
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, Peter Krempa <pkrempa@redhat.com>

From: Peter Krempa <pkrempa@redhat.com>

Since cookies can contain sensitive data (session ID, etc ...) it is
desired to hide them from the prying eyes of users. Add a possibility to
pass them via the secret infrastructure.

Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=1447413

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: f4a22cdebdd0bca6a13a43a2a6deead7f2ec4bb3.1493906281.git.pkrempa@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/curl.c         | 24 +++++++++++++++++++++++-
 qapi/block-core.json | 12 ++++++++++--
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index aa6e8cc..4382234 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -85,6 +85,7 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_BLOCK_OPT_SSLVERIFY "sslverify"
 #define CURL_BLOCK_OPT_TIMEOUT "timeout"
 #define CURL_BLOCK_OPT_COOKIE    "cookie"
+#define CURL_BLOCK_OPT_COOKIE_SECRET "cookie-secret"
 #define CURL_BLOCK_OPT_USERNAME "username"
 #define CURL_BLOCK_OPT_PASSWORD_SECRET "password-secret"
 #define CURL_BLOCK_OPT_PROXY_USERNAME "proxy-username"
@@ -624,6 +625,11 @@ static QemuOptsList runtime_opts = {
             .help = "Pass the cookie or list of cookies with each request"
         },
         {
+            .name = CURL_BLOCK_OPT_COOKIE_SECRET,
+            .type = QEMU_OPT_STRING,
+            .help = "ID of secret used as cookie passed with each request"
+        },
+        {
             .name = CURL_BLOCK_OPT_USERNAME,
             .type = QEMU_OPT_STRING,
             .help = "Username for HTTP auth"
@@ -657,6 +663,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     Error *local_err = NULL;
     const char *file;
     const char *cookie;
+    const char *cookie_secret;
     double d;
     const char *secretid;
     const char *protocol_delimiter;
@@ -693,7 +700,22 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     s->sslverify = qemu_opt_get_bool(opts, CURL_BLOCK_OPT_SSLVERIFY, true);
 
     cookie = qemu_opt_get(opts, CURL_BLOCK_OPT_COOKIE);
-    s->cookie = g_strdup(cookie);
+    cookie_secret = qemu_opt_get(opts, CURL_BLOCK_OPT_COOKIE_SECRET);
+
+    if (cookie && cookie_secret) {
+        error_setg(errp,
+                   "curl driver cannot handle both cookie and cookie secret");
+        goto out_noclean;
+    }
+
+    if (cookie_secret) {
+        s->cookie = qcrypto_secret_lookup_as_utf8(cookie_secret, errp);
+        if (!s->cookie) {
+            goto out_noclean;
+        }
+    } else {
+        s->cookie = g_strdup(cookie);
+    }
 
     file = qemu_opt_get(opts, CURL_BLOCK_OPT_URL);
     if (file == NULL) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6b974b9..ea0b3e8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2813,11 +2813,15 @@
 #               "name1=content1; name2=content2;" as explained by
 #               CURLOPT_COOKIE(3). Defaults to no cookies.
 #
+# @cookie-secret: ID of a QCryptoSecret object providing the cookie data in a
+#                 secure way. See @cookie for the format. (since 2.10)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsCurlHttp',
   'base': 'BlockdevOptionsCurlBase',
-  'data': { '*cookie': 'str' } }
+  'data': { '*cookie': 'str',
+            '*cookie-secret': 'str'} }
 
 ##
 # @BlockdevOptionsCurlHttps:
@@ -2832,12 +2836,16 @@
 # @sslverify:   Whether to verify the SSL certificate's validity (defaults to
 #               true)
 #
+# @cookie-secret: ID of a QCryptoSecret object providing the cookie data in a
+#                 secure way. See @cookie for the format. (since 2.10)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsCurlHttps',
   'base': 'BlockdevOptionsCurlBase',
   'data': { '*cookie': 'str',
-            '*sslverify': 'bool' } }
+            '*sslverify': 'bool',
+            '*cookie-secret': 'str'} }
 
 ##
 # @BlockdevOptionsCurlFtp:
-- 
2.9.3
