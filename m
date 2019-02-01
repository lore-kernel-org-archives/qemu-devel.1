Received: from eggs.gnu.org ([209.51.188.92]:47760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeXc-0007Ke-3b
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:31:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeXa-0003RE-92
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:31:55 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:31 +0100
Message-Id: <20190201192935.18394-28-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 27/31] block/curl: Harmonize option defaults
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
index 1c9e4f6a64..2c07a694d8 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -61,8 +61,6 @@ static CURLMcode __curl_multi_socket_action(CURLM *mult=
i_handle,
=20
 #define CURL_NUM_STATES 8
 #define CURL_NUM_ACB    8
-#define READ_AHEAD_DEFAULT (256 * 1024)
-#define CURL_TIMEOUT_DEFAULT 5
 #define CURL_TIMEOUT_MAX 10000
=20
 #define CURL_BLOCK_OPT_URL       "url"
@@ -76,6 +74,10 @@ static CURLMcode __curl_multi_socket_action(CURLM *mul=
ti_handle,
 #define CURL_BLOCK_OPT_PROXY_USERNAME "proxy-username"
 #define CURL_BLOCK_OPT_PROXY_PASSWORD_SECRET "proxy-password-secret"
=20
+#define CURL_BLOCK_OPT_READAHEAD_DEFAULT (256 * 1024)
+#define CURL_BLOCK_OPT_SSLVERIFY_DEFAULT true
+#define CURL_BLOCK_OPT_TIMEOUT_DEFAULT 5
+
 struct BDRVCURLState;
=20
 static bool libcurl_initialized;
@@ -696,7 +698,7 @@ static int curl_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     }
=20
     s->readahead_size =3D qemu_opt_get_size(opts, CURL_BLOCK_OPT_READAHE=
AD,
-                                          READ_AHEAD_DEFAULT);
+                                          CURL_BLOCK_OPT_READAHEAD_DEFAU=
LT);
     if ((s->readahead_size & 0x1ff) !=3D 0) {
         error_setg(errp, "HTTP_READAHEAD_SIZE %zd is not a multiple of 5=
12",
                    s->readahead_size);
@@ -704,13 +706,14 @@ static int curl_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
     }
=20
     s->timeout =3D qemu_opt_get_number(opts, CURL_BLOCK_OPT_TIMEOUT,
-                                     CURL_TIMEOUT_DEFAULT);
+                                     CURL_BLOCK_OPT_TIMEOUT_DEFAULT);
     if (s->timeout > CURL_TIMEOUT_MAX) {
         error_setg(errp, "timeout parameter is too large or negative");
         goto out_noclean;
     }
=20
-    s->sslverify =3D qemu_opt_get_bool(opts, CURL_BLOCK_OPT_SSLVERIFY, t=
rue);
+    s->sslverify =3D qemu_opt_get_bool(opts, CURL_BLOCK_OPT_SSLVERIFY,
+                                     CURL_BLOCK_OPT_SSLVERIFY_DEFAULT);
=20
     cookie =3D qemu_opt_get(opts, CURL_BLOCK_OPT_COOKIE);
     cookie_secret =3D qemu_opt_get(opts, CURL_BLOCK_OPT_COOKIE_SECRET);
--=20
2.20.1
