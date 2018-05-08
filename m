Received: from eggs.gnu.org ([2001:4830:134:3::10]:41317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt3-000331-U2
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt2-0001Pf-I2
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:09 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAt2-0001Op-7f
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:08 -0400
Received: by mail-wm0-x243.google.com with SMTP id l1-v6so24209581wmb.2
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:31 +0200
Message-Id: <1525817687-34620-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/30] opts: don't silently truncate long
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

From: Daniel P. Berrangé <berrange@redhat.com>

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

Signed-off-by: Daniel P. BerrangÃ© <berrange@redhat.com>
Message-Id: <20180416111743.8473-3-berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/test-qemu-opts.c | 18 ------------------
 util/qemu-option.c     | 44 ++++++++++++++++++++++----------------------
 2 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 77dd72b..7092e21 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -459,8 +459,6 @@ static void test_opts_parse(void)
 {
     Error *err = NULL;
     QemuOpts *opts;
-    char long_key[129];
-    char *params;
 
     /* Nothing */
     opts = qemu_opts_parse(&opts_list_03, "", false, &error_abort);
@@ -471,22 +469,6 @@ static void test_opts_parse(void)
     g_assert_cmpuint(opts_count(opts), ==, 1);
     g_assert_cmpstr(qemu_opt_get(opts, ""), ==, "val");
 
-    /* Long key */
-    memset(long_key, 'a', 127);
-    long_key[127] = 'z';
-    long_key[128] = 0;
-    params = g_strdup_printf("%s=v", long_key);
-    opts = qemu_opts_parse(&opts_list_03, params + 1, NULL, &error_abort);
-    g_assert_cmpuint(opts_count(opts), ==, 1);
-    g_assert_cmpstr(qemu_opt_get(opts, long_key + 1), ==, "v");
-
-    /* Overlong key gets truncated */
-    opts = qemu_opts_parse(&opts_list_03, params, NULL, &error_abort);
-    g_assert(opts_count(opts) == 1);
-    long_key[127] = 0;
-    g_assert_cmpstr(qemu_opt_get(opts, long_key), ==, "v");
-    g_free(params);
-
     /* Multiple keys, last one wins */
     opts = qemu_opts_parse(&opts_list_03, "a=1,b=2,,x,a=3",
                            false, &error_abort);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index baca40f..fa1a9f1 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -43,27 +43,23 @@
  * first byte of the option name)
  *
  * The option name is delimited by delim (usually , or =) or the string end
- * and is copied into buf. If the option name is longer than buf_size, it is
- * truncated. buf is always zero terminated.
+ * and is copied into option. The caller is responsible for free'ing option
+ * when no longer required.
  *
  * The return value is the position of the delimiter/zero byte after the option
  * name in p.
  */
-static const char *get_opt_name(char *buf, int buf_size, const char *p,
-                                char delim)
+static const char *get_opt_name(const char *p, char **option, char delim)
 {
-    char *q;
+    char *offset = strchr(p, delim);
 
-    q = buf;
-    while (*p != '\0' && *p != delim) {
-        if (q && (q - buf) < buf_size - 1)
-            *q++ = *p;
-        p++;
+    if (offset) {
+        *option = g_strndup(p, offset - p);
+        return offset;
+    } else {
+        *option = g_strdup(p);
+        return p + strlen(p);
     }
-    if (q)
-        *q = '\0';
-
-    return p;
 }
 
 /*
@@ -758,7 +754,8 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
 static void opts_do_parse(QemuOpts *opts, const char *params,
                           const char *firstname, bool prepend, Error **errp)
 {
-    char option[128], value[1024];
+    char *option = NULL;
+    char value[1024];
     const char *p,*pe,*pc;
     Error *local_err = NULL;
 
@@ -769,11 +766,11 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
             /* found "foo,more" */
             if (p == params && firstname) {
                 /* implicitly named first option */
-                pstrcpy(option, sizeof(option), firstname);
+                option = g_strdup(firstname);
                 p = get_opt_value(value, sizeof(value), p);
             } else {
                 /* option without value, probably a flag */
-                p = get_opt_name(option, sizeof(option), p, ',');
+                p = get_opt_name(p, &option, ',');
                 if (strncmp(option, "no", 2) == 0) {
                     memmove(option, option+2, strlen(option+2)+1);
                     pstrcpy(value, sizeof(value), "off");
@@ -783,10 +780,8 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
             }
         } else {
             /* found "foo=bar,more" */
-            p = get_opt_name(option, sizeof(option), p, '=');
-            if (*p != '=') {
-                break;
-            }
+            p = get_opt_name(p, &option, '=');
+            assert(*p == '=');
             p++;
             p = get_opt_value(value, sizeof(value), p);
         }
@@ -795,13 +790,18 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
             opt_set(opts, option, value, prepend, &local_err);
             if (local_err) {
                 error_propagate(errp, local_err);
-                return;
+                goto cleanup;
             }
         }
         if (*p != ',') {
             break;
         }
+        g_free(option);
+        option = NULL;
     }
+
+ cleanup:
+    g_free(option);
 }
 
 /**
-- 
1.8.3.1
