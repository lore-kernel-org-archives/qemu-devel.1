Received: from eggs.gnu.org ([2001:4830:134:3::10]:51785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erOjo-0003Oa-J7
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erOjn-00046R-LF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:59:12 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu,  1 Mar 2018 13:58:56 +0000
Message-Id: <20180301135856.22698-3-rjones@redhat.com>
In-Reply-To: <20180301135856.22698-1-rjones@redhat.com>
References: <20180301135856.22698-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] block: curl: Allow Certificate Authority
 bundle to be passed in.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jcody@redhat.com
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

This allows a Certificate Authority bundle to be passed to the curl
driver, allowing authentication against servers that check
certificates.  For example this allows you to access a disk on an
oVirt node:

  qemu-img create -f qcow2 \
      -b 'json:{ "file.driver": "https",
                 "file.url": "https://ovirt-node:54322/images/<disk-id>",
                  "file.header": ["Authorization: <ticket>"] }' \
                  "file.cainfo": "/tmp/ca.pem" }' \
      test.qcow2

(<disk-id> and <ticket> have to be determined using some extra code.
See
https://github.com/oVirt/ovirt-engine-sdk/blob/master/sdk/examples/upload_ova_as_vm.py
for some guidance).

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 block/curl.c         | 14 ++++++++++++++
 qapi/block-core.json |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 972673ba5c..2dc9035ff8 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -84,6 +84,7 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_BLOCK_OPT_COOKIE    "cookie"
 #define CURL_BLOCK_OPT_COOKIE_SECRET "cookie-secret"
 #define CURL_BLOCK_OPT_HEADER_PATTERN "header."
+#define CURL_BLOCK_OPT_CAINFO   "cainfo"
 #define CURL_BLOCK_OPT_USERNAME "username"
 #define CURL_BLOCK_OPT_PASSWORD_SECRET "password-secret"
 #define CURL_BLOCK_OPT_PROXY_USERNAME "proxy-username"
@@ -136,6 +137,7 @@ typedef struct BDRVCURLState {
     uint64_t timeout;
     char *cookie;
     struct curl_slist *headers;
+    char *cainfo;
     bool accept_range;
     AioContext *aio_context;
     QemuMutex mutex;
@@ -491,6 +493,9 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
         if (s->headers) {
             curl_easy_setopt(state->curl, CURLOPT_HTTPHEADER, s->headers);
         }
+        if (s->cainfo) {
+            curl_easy_setopt(state->curl, CURLOPT_CAINFO, s->cainfo);
+        }
         curl_easy_setopt(state->curl, CURLOPT_TIMEOUT, (long)s->timeout);
         curl_easy_setopt(state->curl, CURLOPT_WRITEFUNCTION,
                          (void *)curl_read_cb);
@@ -648,6 +653,11 @@ static QemuOptsList runtime_opts = {
             .help = "ID of secret used as cookie passed with each request"
         },
         {
+            .name = CURL_BLOCK_OPT_CAINFO,
+            .type = QEMU_OPT_STRING,
+            .help = "Pass the Certificate Authority bundle"
+        },
+        {
             .name = CURL_BLOCK_OPT_USERNAME,
             .type = QEMU_OPT_STRING,
             .help = "Username for HTTP auth"
@@ -757,6 +767,8 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         qdict_del(options, key);
     }
 
+    s->cainfo = qemu_opt_get(opts, CURL_BLOCK_OPT_CAINFO);
+
     file = qemu_opt_get(opts, CURL_BLOCK_OPT_URL);
     if (file == NULL) {
         error_setg(errp, "curl block driver requires an 'url' option");
@@ -864,6 +876,7 @@ out:
     state->curl = NULL;
 out_noclean:
     qemu_mutex_destroy(&s->mutex);
+    g_free(s->cainfo);
     curl_slist_free_all(s->headers);
     g_free(s->cookie);
     g_free(s->url);
@@ -963,6 +976,7 @@ static void curl_close(BlockDriverState *bs)
     curl_detach_aio_context(bs);
     qemu_mutex_destroy(&s->mutex);
 
+    g_free(s->cainfo);
     curl_slist_free_all(s->headers);
     g_free(s->cookie);
     g_free(s->url);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ca1ebdbef1..bf3066af08 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3073,6 +3073,8 @@
 # @cookie-secret: ID of a QCryptoSecret object providing the cookie data in a
 #                 secure way. See @cookie for the format. (since 2.10)
 #
+# @cainfo:      Certificate Authority bundle.
+#
 # @header:      List of HTTP request headers, see CURLOPT_HTTPHEADER(3).
 #
 # Since: 2.9
@@ -3082,6 +3084,7 @@
   'data': { '*cookie': 'str',
             '*sslverify': 'bool',
             '*cookie-secret': 'str',
+            '*cainfo': 'str',
             '*header': [ 'str' ] } }
 
 ##
-- 
2.13.2
