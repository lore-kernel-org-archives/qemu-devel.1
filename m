Received: from eggs.gnu.org ([2001:4830:134:3::10]:51787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erOjo-0003Ou-PB
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erOjn-000465-Fl
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:59:12 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu,  1 Mar 2018 13:58:55 +0000
Message-Id: <20180301135856.22698-2-rjones@redhat.com>
In-Reply-To: <20180301135856.22698-1-rjones@redhat.com>
References: <20180301135856.22698-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] block: curl: Allow arbitrary HTTP request
 headers to be set.
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

Allow arbitrary HTTP request headers to be set, like this:

  qemu-img create -f qcow2 \
      -b 'json:{ "file.driver":"http",
                 "file.url":"http://192.168.0.249/scratch/test.img",
                 "file.header": ["Authorization: letmein"] }' \
      test.qcow2

which adds the =E2=80=98Authorization: letmein=E2=80=99 header to the out=
going request
for the backing file.  Multiple headers can be set, and curl built-in
headers can be removed (using "Header:").

Note this uses the same format as curl's CURLOPT_HTTPHEADER, thus
pulling in curl API guarantees into qemu, but curl has had very strong
API backward compatibility since the start of the project.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 block/curl.c         | 21 ++++++++++++++++++++-
 qapi/block-core.json | 10 ++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index aa42535783..972673ba5c 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -83,6 +83,7 @@ static CURLMcode __curl_multi_socket_action(CURLM *mult=
i_handle,
 #define CURL_BLOCK_OPT_TIMEOUT "timeout"
 #define CURL_BLOCK_OPT_COOKIE    "cookie"
 #define CURL_BLOCK_OPT_COOKIE_SECRET "cookie-secret"
+#define CURL_BLOCK_OPT_HEADER_PATTERN "header."
 #define CURL_BLOCK_OPT_USERNAME "username"
 #define CURL_BLOCK_OPT_PASSWORD_SECRET "password-secret"
 #define CURL_BLOCK_OPT_PROXY_USERNAME "proxy-username"
@@ -134,6 +135,7 @@ typedef struct BDRVCURLState {
     bool sslverify;
     uint64_t timeout;
     char *cookie;
+    struct curl_slist *headers;
     bool accept_range;
     AioContext *aio_context;
     QemuMutex mutex;
@@ -486,6 +488,9 @@ static int curl_init_state(BDRVCURLState *s, CURLStat=
e *state)
         if (s->cookie) {
             curl_easy_setopt(state->curl, CURLOPT_COOKIE, s->cookie);
         }
+        if (s->headers) {
+            curl_easy_setopt(state->curl, CURLOPT_HTTPHEADER, s->headers=
);
+        }
         curl_easy_setopt(state->curl, CURLOPT_TIMEOUT, (long)s->timeout)=
;
         curl_easy_setopt(state->curl, CURLOPT_WRITEFUNCTION,
                          (void *)curl_read_cb);
@@ -680,7 +685,7 @@ static int curl_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     double d;
     const char *secretid;
     const char *protocol_delimiter;
-    int ret;
+    int i, nr, ret;
=20
=20
     if (flags & BDRV_O_RDWR) {
@@ -740,6 +745,18 @@ static int curl_open(BlockDriverState *bs, QDict *op=
tions, int flags,
         s->cookie =3D g_strdup(cookie);
     }
=20
+    s->headers =3D NULL;
+    nr =3D qdict_array_entries(options, CURL_BLOCK_OPT_HEADER_PATTERN);
+    for (i =3D 0; i < nr; ++i) {
+        char key[32];
+        const char *header;
+
+        snprintf(key, sizeof key, CURL_BLOCK_OPT_HEADER_PATTERN "%d", i)=
;
+        header =3D qdict_get_str(options, key);
+        s->headers =3D curl_slist_append(s->headers, header);
+        qdict_del(options, key);
+    }
+
     file =3D qemu_opt_get(opts, CURL_BLOCK_OPT_URL);
     if (file =3D=3D NULL) {
         error_setg(errp, "curl block driver requires an 'url' option");
@@ -847,6 +864,7 @@ out:
     state->curl =3D NULL;
 out_noclean:
     qemu_mutex_destroy(&s->mutex);
+    curl_slist_free_all(s->headers);
     g_free(s->cookie);
     g_free(s->url);
     g_free(s->username);
@@ -945,6 +963,7 @@ static void curl_close(BlockDriverState *bs)
     curl_detach_aio_context(bs);
     qemu_mutex_destroy(&s->mutex);
=20
+    curl_slist_free_all(s->headers);
     g_free(s->cookie);
     g_free(s->url);
     g_free(s->username);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5c5921bfb7..ca1ebdbef1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3047,12 +3047,15 @@
 # @cookie-secret: ID of a QCryptoSecret object providing the cookie data=
 in a
 #                 secure way. See @cookie for the format. (since 2.10)
 #
+# @header:      List of HTTP request headers, see CURLOPT_HTTPHEADER(3).
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsCurlHttp',
   'base': 'BlockdevOptionsCurlBase',
   'data': { '*cookie': 'str',
-            '*cookie-secret': 'str'} }
+            '*cookie-secret': 'str',
+            '*header': [ 'str' ] } }
=20
 ##
 # @BlockdevOptionsCurlHttps:
@@ -3070,13 +3073,16 @@
 # @cookie-secret: ID of a QCryptoSecret object providing the cookie data=
 in a
 #                 secure way. See @cookie for the format. (since 2.10)
 #
+# @header:      List of HTTP request headers, see CURLOPT_HTTPHEADER(3).
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsCurlHttps',
   'base': 'BlockdevOptionsCurlBase',
   'data': { '*cookie': 'str',
             '*sslverify': 'bool',
-            '*cookie-secret': 'str'} }
+            '*cookie-secret': 'str',
+            '*header': [ 'str' ] } }
=20
 ##
 # @BlockdevOptionsCurlFtp:
--=20
2.13.2
