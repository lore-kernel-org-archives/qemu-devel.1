Received: from eggs.gnu.org ([2001:4830:134:3::10]:50743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f828y-0002Gi-EK
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f828w-00045H-Q5
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:17:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34860 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f828w-00044U-KF
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 07:17:54 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 16 Apr 2018 12:17:42 +0100
Message-Id: <20180416111743.8473-3-berrange@redhat.com>
In-Reply-To: <20180416111743.8473-1-berrange@redhat.com>
References: <20180416111743.8473-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] opts: don't silently truncate long
 parameter keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The existing QemuOpts parsing code uses a fixed size 128 byte buffer
for storing the parameter keys. If a key exceeded this size it was
silently truncate and no error reported to the user. This behaviour was
reasonable & harmless because traditionally the key names are all
statically declared, and it was known that no code was declaring a key
longer than 127 bytes. This assumption, however, ceased to be valid once
the block layer added support for dot-separate compound keys. This
syntax allows for keys that can be arbitrarily long, limited only by the
number of block drivers you can stack up. With this usage, silently
truncating the key name can never lead to correct behaviour.

Hopefully such truncation would turn into an error, when the block code
then tried to extract options later, but there's no guarantee that will
happen. It is conceivable that an option specified by the user may be
truncated and then ignored. This could have serious consequences,
possibly even leading to security problems if the ignored option set a
security relevant parameter.

If the operating system didn't limit the user's argv when spawning QEMU,
the code should honour whatever length arguments were given without
imposing its own length restrictions. This patch thus changes the code
to use a heap allocated buffer for storing the keys during parsing,
lifting the arbitrary length restriction.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-qemu-opts.c | 18 ------------------
 util/qemu-option.c     | 44 ++++++++++++++++++++++----------------------
 2 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 2c422abcd4..4508f95a9b 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -459,8 +459,6 @@ static void test_opts_parse(void)
 {
     Error *err =3D NULL;
     QemuOpts *opts;
-    char long_key[129];
-    char *params;
=20
     /* Nothing */
     opts =3D qemu_opts_parse(&opts_list_03, "", false, &error_abort);
@@ -471,22 +469,6 @@ static void test_opts_parse(void)
     g_assert_cmpuint(opts_count(opts), =3D=3D, 1);
     g_assert_cmpstr(qemu_opt_get(opts, ""), =3D=3D, "val");
=20
-    /* Long key */
-    memset(long_key, 'a', 127);
-    long_key[127] =3D 'z';
-    long_key[128] =3D 0;
-    params =3D g_strdup_printf("%s=3Dv", long_key);
-    opts =3D qemu_opts_parse(&opts_list_03, params + 1, NULL, &error_abo=
rt);
-    g_assert_cmpuint(opts_count(opts), =3D=3D, 1);
-    g_assert_cmpstr(qemu_opt_get(opts, long_key + 1), =3D=3D, "v");
-
-    /* Overlong key gets truncated */
-    opts =3D qemu_opts_parse(&opts_list_03, params, NULL, &error_abort);
-    g_assert(opts_count(opts) =3D=3D 1);
-    long_key[127] =3D 0;
-    g_assert_cmpstr(qemu_opt_get(opts, long_key), =3D=3D, "v");
-    g_free(params);
-
     /* Multiple keys, last one wins */
     opts =3D qemu_opts_parse(&opts_list_03, "a=3D1,b=3D2,,x,a=3D3",
                            false, &error_abort);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index baca40fb94..fa1a9f17fc 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -43,27 +43,23 @@
  * first byte of the option name)
  *
  * The option name is delimited by delim (usually , or =3D) or the strin=
g end
- * and is copied into buf. If the option name is longer than buf_size, i=
t is
- * truncated. buf is always zero terminated.
+ * and is copied into option. The caller is responsible for free'ing opt=
ion
+ * when no longer required.
  *
  * The return value is the position of the delimiter/zero byte after the=
 option
  * name in p.
  */
-static const char *get_opt_name(char *buf, int buf_size, const char *p,
-                                char delim)
+static const char *get_opt_name(const char *p, char **option, char delim=
)
 {
-    char *q;
+    char *offset =3D strchr(p, delim);
=20
-    q =3D buf;
-    while (*p !=3D '\0' && *p !=3D delim) {
-        if (q && (q - buf) < buf_size - 1)
-            *q++ =3D *p;
-        p++;
+    if (offset) {
+        *option =3D g_strndup(p, offset - p);
+        return offset;
+    } else {
+        *option =3D g_strdup(p);
+        return p + strlen(p);
     }
-    if (q)
-        *q =3D '\0';
-
-    return p;
 }
=20
 /*
@@ -758,7 +754,8 @@ void qemu_opts_print(QemuOpts *opts, const char *sepa=
rator)
 static void opts_do_parse(QemuOpts *opts, const char *params,
                           const char *firstname, bool prepend, Error **e=
rrp)
 {
-    char option[128], value[1024];
+    char *option =3D NULL;
+    char value[1024];
     const char *p,*pe,*pc;
     Error *local_err =3D NULL;
=20
@@ -769,11 +766,11 @@ static void opts_do_parse(QemuOpts *opts, const cha=
r *params,
             /* found "foo,more" */
             if (p =3D=3D params && firstname) {
                 /* implicitly named first option */
-                pstrcpy(option, sizeof(option), firstname);
+                option =3D g_strdup(firstname);
                 p =3D get_opt_value(value, sizeof(value), p);
             } else {
                 /* option without value, probably a flag */
-                p =3D get_opt_name(option, sizeof(option), p, ',');
+                p =3D get_opt_name(p, &option, ',');
                 if (strncmp(option, "no", 2) =3D=3D 0) {
                     memmove(option, option+2, strlen(option+2)+1);
                     pstrcpy(value, sizeof(value), "off");
@@ -783,10 +780,8 @@ static void opts_do_parse(QemuOpts *opts, const char=
 *params,
             }
         } else {
             /* found "foo=3Dbar,more" */
-            p =3D get_opt_name(option, sizeof(option), p, '=3D');
-            if (*p !=3D '=3D') {
-                break;
-            }
+            p =3D get_opt_name(p, &option, '=3D');
+            assert(*p =3D=3D '=3D');
             p++;
             p =3D get_opt_value(value, sizeof(value), p);
         }
@@ -795,13 +790,18 @@ static void opts_do_parse(QemuOpts *opts, const cha=
r *params,
             opt_set(opts, option, value, prepend, &local_err);
             if (local_err) {
                 error_propagate(errp, local_err);
-                return;
+                goto cleanup;
             }
         }
         if (*p !=3D ',') {
             break;
         }
+        g_free(option);
+        option =3D NULL;
     }
+
+ cleanup:
+    g_free(option);
 }
=20
 /**
--=20
2.14.3
