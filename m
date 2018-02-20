Received: from eggs.gnu.org ([2001:4830:134:3::10]:57073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eo2tA-0005xO-KK
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 03:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eo2t5-0000ft-KT
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 03:03:00 -0500
Received: from smtp15.cstnet.cn ([159.226.251.15]:45272 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1eo2t4-0000d6-BL
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 03:02:55 -0500
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Tue, 20 Feb 2018 16:02:40 +0800
Message-Id: <1519113760-4474-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel]  [PATCH v2] util/uri.c formating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, stefanha@redhat.com
Cc: qemu-devel@nongnu.org

 Formating the code with `clang-format -i util/uri.c`.
 My .clang-format file content is:
 '''
 IndentWidth: 4
 BreakBeforeBraces: Linux
 '''

Then use `perl -pi -e "s/return \((.*?)\);/return \1;/g" util/uri.c`
to remove pattern like this: "return (1);"

checkpatch.pl still rise these two kinds of "ERROR", I'm not sure
whether I should also suppress these, so I left it.

'''
ERROR: braces {} are necessary even for single statement blocks
#1803: FILE: uri.c:1803:
+            while ((bas->path[cur] != 0) && (bas->path[cur] != '/'))
+                cur++;

ERROR: braces {} are necessary for all arms of this statement
#1805: FILE: uri.c:1805:
+            if (bas->path[cur] == 0)
[...]
'''


Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 util/uri.c | 611 +++++++++++++++++++++++++++++++------------------------------
 1 file changed, 307 insertions(+), 304 deletions(-)

diff --git a/util/uri.c b/util/uri.c
index aa1c2da00c17..b01ae0ccb075 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -63,7 +63,6 @@ static void uri_clean(URI *uri);
  */
 #define IS_ALPHA(x) (IS_LOWALPHA(x) || IS_UPALPHA(x))

-
 /*
  * lowalpha = "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" |
  *            "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" |
@@ -97,27 +96,28 @@ static void uri_clean(URI *uri);
  * mark = "-" | "_" | "." | "!" | "~" | "*" | "'" | "(" | ")"
  */

-#define IS_MARK(x) (((x) == '-') || ((x) == '_') || ((x) == '.') ||     \
-        ((x) == '!') || ((x) == '~') || ((x) == '*') || ((x) == '\'') ||    \
-        ((x) == '(') || ((x) == ')'))
+#define IS_MARK(x)                                                             \
+    (((x) == '-') || ((x) == '_') || ((x) == '.') || ((x) == '!') ||           \
+     ((x) == '~') || ((x) == '*') || ((x) == '\'') || ((x) == '(') ||          \
+     ((x) == ')'))

 /*
  * unwise = "{" | "}" | "|" | "\" | "^" | "`"
  */

-#define IS_UNWISE(p)                                                    \
-    (((*(p) == '{')) || ((*(p) == '}')) || ((*(p) == '|')) ||         \
-     ((*(p) == '\\')) || ((*(p) == '^')) || ((*(p) == '[')) ||        \
+#define IS_UNWISE(p)                                                           \
+    (((*(p) == '{')) || ((*(p) == '}')) || ((*(p) == '|')) ||                  \
+     ((*(p) == '\\')) || ((*(p) == '^')) || ((*(p) == '[')) ||                 \
      ((*(p) == ']')) || ((*(p) == '`')))
 /*
  * reserved = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" | "$" | "," |
  *            "[" | "]"
  */

-#define IS_RESERVED(x) (((x) == ';') || ((x) == '/') || ((x) == '?') || \
-        ((x) == ':') || ((x) == '@') || ((x) == '&') || ((x) == '=') || \
-        ((x) == '+') || ((x) == '$') || ((x) == ',') || ((x) == '[') || \
-        ((x) == ']'))
+#define IS_RESERVED(x)                                                         \
+    (((x) == ';') || ((x) == '/') || ((x) == '?') || ((x) == ':') ||           \
+     ((x) == '@') || ((x) == '&') || ((x) == '=') || ((x) == '+') ||           \
+     ((x) == '$') || ((x) == ',') || ((x) == '[') || ((x) == ']'))

 /*
  * unreserved = alphanum | mark
@@ -129,7 +129,7 @@ static void uri_clean(URI *uri);
  * Skip to next pointer char, handle escaped sequences
  */

-#define NEXT(p) ((*p == '%')? p += 3 : p++)
+#define NEXT(p) ((*p == '%') ? p += 3 : p++)

 /*
  * Productions from the spec.
@@ -141,37 +141,35 @@ static void uri_clean(URI *uri);
  * path          = [ abs_path | opaque_part ]
  */

-
 /************************************************************************
- *									*
- *                         RFC 3986 parser				*
- *									*
+ *                                                                      *
+ *                         RFC 3986 parser                              *
+ *                                                                      *
  ************************************************************************/

 #define ISA_DIGIT(p) ((*(p) >= '0') && (*(p) <= '9'))
-#define ISA_ALPHA(p) (((*(p) >= 'a') && (*(p) <= 'z')) ||		\
-        ((*(p) >= 'A') && (*(p) <= 'Z')))
-#define ISA_HEXDIG(p)							\
-    (ISA_DIGIT(p) || ((*(p) >= 'a') && (*(p) <= 'f')) ||		\
+#define ISA_ALPHA(p)                                                           \
+    (((*(p) >= 'a') && (*(p) <= 'z')) || ((*(p) >= 'A') && (*(p) <= 'Z')))
+#define ISA_HEXDIG(p)                                                          \
+    (ISA_DIGIT(p) || ((*(p) >= 'a') && (*(p) <= 'f')) ||                       \
      ((*(p) >= 'A') && (*(p) <= 'F')))

 /*
  *    sub-delims    = "!" / "$" / "&" / "'" / "(" / ")"
  *                     / "*" / "+" / "," / ";" / "="
  */
-#define ISA_SUB_DELIM(p)						\
-    (((*(p) == '!')) || ((*(p) == '$')) || ((*(p) == '&')) ||		\
-     ((*(p) == '(')) || ((*(p) == ')')) || ((*(p) == '*')) ||		\
-     ((*(p) == '+')) || ((*(p) == ',')) || ((*(p) == ';')) ||		\
+#define ISA_SUB_DELIM(p)                                                       \
+    (((*(p) == '!')) || ((*(p) == '$')) || ((*(p) == '&')) ||                  \
+     ((*(p) == '(')) || ((*(p) == ')')) || ((*(p) == '*')) ||                  \
+     ((*(p) == '+')) || ((*(p) == ',')) || ((*(p) == ';')) ||                  \
      ((*(p) == '=')) || ((*(p) == '\'')))

 /*
  *    gen-delims    = ":" / "/" / "?" / "#" / "[" / "]" / "@"
  */
-#define ISA_GEN_DELIM(p)						\
-    (((*(p) == ':')) || ((*(p) == '/')) || ((*(p) == '?')) ||         \
-     ((*(p) == '#')) || ((*(p) == '[')) || ((*(p) == ']')) ||         \
-     ((*(p) == '@')))
+#define ISA_GEN_DELIM(p)                                                       \
+    (((*(p) == ':')) || ((*(p) == '/')) || ((*(p) == '?')) ||                  \
+     ((*(p) == '#')) || ((*(p) == '[')) || ((*(p) == ']')) || ((*(p) == '@')))

 /*
  *    reserved      = gen-delims / sub-delims
@@ -181,21 +179,21 @@ static void uri_clean(URI *uri);
 /*
  *    unreserved    = ALPHA / DIGIT / "-" / "." / "_" / "~"
  */
-#define ISA_UNRESERVED(p)						\
-    ((ISA_ALPHA(p)) || (ISA_DIGIT(p)) || ((*(p) == '-')) ||		\
-     ((*(p) == '.')) || ((*(p) == '_')) || ((*(p) == '~')))
+#define ISA_UNRESERVED(p)                                                      \
+    ((ISA_ALPHA(p)) || (ISA_DIGIT(p)) || ((*(p) == '-')) || ((*(p) == '.')) || \
+     ((*(p) == '_')) || ((*(p) == '~')))

 /*
  *    pct-encoded   = "%" HEXDIG HEXDIG
  */
-#define ISA_PCT_ENCODED(p)						\
+#define ISA_PCT_ENCODED(p)                                                     \
     ((*(p) == '%') && (ISA_HEXDIG(p + 1)) && (ISA_HEXDIG(p + 2)))

 /*
  *    pchar         = unreserved / pct-encoded / sub-delims / ":" / "@"
  */
-#define ISA_PCHAR(p)							\
-    (ISA_UNRESERVED(p) || ISA_PCT_ENCODED(p) || ISA_SUB_DELIM(p) ||	\
+#define ISA_PCHAR(p)                                                           \
+    (ISA_UNRESERVED(p) || ISA_PCT_ENCODED(p) || ISA_SUB_DELIM(p) ||            \
      ((*(p) == ':')) || ((*(p) == '@')))

 /**
@@ -209,25 +207,27 @@ static void uri_clean(URI *uri);
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_scheme(URI *uri, const char **str) {
+static int rfc3986_parse_scheme(URI *uri, const char **str)
+{
     const char *cur;

-    if (str == NULL)
-        return(-1);
+    if (str == NULL) {
+        return -1;
+    }

     cur = *str;
     if (!ISA_ALPHA(cur))
-        return(2);
+        return 2;
     cur++;
-    while (ISA_ALPHA(cur) || ISA_DIGIT(cur) ||
-            (*cur == '+') || (*cur == '-') || (*cur == '.')) cur++;
+    while (ISA_ALPHA(cur) || ISA_DIGIT(cur) || (*cur == '+') || (*cur == '-') ||
+           (*cur == '.'))
+        cur++;
     if (uri != NULL) {
         g_free(uri->scheme);
         uri->scheme = g_strndup(*str, cur - *str);
     }
     *str = cur;
-    return(0);
+    return 0;
 }

 /**
@@ -245,19 +245,18 @@ rfc3986_parse_scheme(URI *uri, const char **str) {
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_fragment(URI *uri, const char **str)
+static int rfc3986_parse_fragment(URI *uri, const char **str)
 {
     const char *cur;

     if (str == NULL)
-        return (-1);
+        return -1;

     cur = *str;

     while ((ISA_PCHAR(cur)) || (*cur == '/') || (*cur == '?') ||
-            (*cur == '[') || (*cur == ']') ||
-            ((uri != NULL) && (uri->cleanup & 1) && (IS_UNWISE(cur))))
+           (*cur == '[') || (*cur == ']') ||
+           ((uri != NULL) && (uri->cleanup & 1) && (IS_UNWISE(cur))))
         NEXT(cur);
     if (uri != NULL) {
         g_free(uri->fragment);
@@ -267,7 +266,7 @@ rfc3986_parse_fragment(URI *uri, const char **str)
             uri->fragment = uri_string_unescape(*str, cur - *str, NULL);
     }
     *str = cur;
-    return (0);
+    return 0;
 }

 /**
@@ -281,25 +280,24 @@ rfc3986_parse_fragment(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_query(URI *uri, const char **str)
+static int rfc3986_parse_query(URI *uri, const char **str)
 {
     const char *cur;

     if (str == NULL)
-        return (-1);
+        return -1;

     cur = *str;

     while ((ISA_PCHAR(cur)) || (*cur == '/') || (*cur == '?') ||
-            ((uri != NULL) && (uri->cleanup & 1) && (IS_UNWISE(cur))))
+           ((uri != NULL) && (uri->cleanup & 1) && (IS_UNWISE(cur))))
         NEXT(cur);
     if (uri != NULL) {
         g_free(uri->query);
-        uri->query = g_strndup (*str, cur - *str);
+        uri->query = g_strndup(*str, cur - *str);
     }
     *str = cur;
-    return (0);
+    return 0;
 }

 /**
@@ -314,8 +312,7 @@ rfc3986_parse_query(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_port(URI *uri, const char **str)
+static int rfc3986_parse_port(URI *uri, const char **str)
 {
     const char *cur = *str;
     int port = 0;
@@ -349,14 +346,13 @@ rfc3986_parse_port(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_user_info(URI *uri, const char **str)
+static int rfc3986_parse_user_info(URI *uri, const char **str)
 {
     const char *cur;

     cur = *str;
-    while (ISA_UNRESERVED(cur) || ISA_PCT_ENCODED(cur) ||
-            ISA_SUB_DELIM(cur) || (*cur == ':'))
+    while (ISA_UNRESERVED(cur) || ISA_PCT_ENCODED(cur) || ISA_SUB_DELIM(cur) ||
+           (*cur == ':'))
         NEXT(cur);
     if (*cur == '@') {
         if (uri != NULL) {
@@ -367,9 +363,9 @@ rfc3986_parse_user_info(URI *uri, const char **str)
                 uri->user = uri_string_unescape(*str, cur - *str, NULL);
         }
         *str = cur;
-        return(0);
+        return 0;
     }
-    return(1);
+    return 1;
 }

 /**
@@ -386,28 +382,28 @@ rfc3986_parse_user_info(URI *uri, const char **str)
  *
  * Returns 0 if found and skipped, 1 otherwise
  */
-static int
-rfc3986_parse_dec_octet(const char **str) {
+static int rfc3986_parse_dec_octet(const char **str)
+{
     const char *cur = *str;

     if (!(ISA_DIGIT(cur)))
-        return(1);
-    if (!ISA_DIGIT(cur+1))
+        return 1;
+    if (!ISA_DIGIT(cur + 1))
         cur++;
-    else if ((*cur != '0') && (ISA_DIGIT(cur + 1)) && (!ISA_DIGIT(cur+2)))
+    else if ((*cur != '0') && (ISA_DIGIT(cur + 1)) && (!ISA_DIGIT(cur + 2)))
         cur += 2;
     else if ((*cur == '1') && (ISA_DIGIT(cur + 1)) && (ISA_DIGIT(cur + 2)))
         cur += 3;
-    else if ((*cur == '2') && (*(cur + 1) >= '0') &&
-            (*(cur + 1) <= '4') && (ISA_DIGIT(cur + 2)))
+    else if ((*cur == '2') && (*(cur + 1) >= '0') && (*(cur + 1) <= '4') &&
+             (ISA_DIGIT(cur + 2)))
         cur += 3;
-    else if ((*cur == '2') && (*(cur + 1) == '5') &&
-            (*(cur + 2) >= '0') && (*(cur + 1) <= '5'))
+    else if ((*cur == '2') && (*(cur + 1) == '5') && (*(cur + 2) >= '0') &&
+             (*(cur + 1) <= '5'))
         cur += 3;
     else
-        return(1);
+        return 1;
     *str = cur;
-    return(0);
+    return 0;
 }
 /**
  * rfc3986_parse_host:
@@ -424,8 +420,7 @@ rfc3986_parse_dec_octet(const char **str) {
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_host(URI *uri, const char **str)
+static int rfc3986_parse_host(URI *uri, const char **str)
 {
     const char *cur = *str;
     const char *host;
@@ -439,7 +434,7 @@ rfc3986_parse_host(URI *uri, const char **str)
         while ((*cur != ']') && (*cur != 0))
             cur++;
         if (*cur != ']')
-            return(1);
+            return 1;
         cur++;
         goto found;
     }
@@ -463,7 +458,7 @@ rfc3986_parse_host(URI *uri, const char **str)
         if (rfc3986_parse_dec_octet(&cur) != 0)
             goto not_ipv4;
         goto found;
-not_ipv4:
+    not_ipv4:
         cur = *str;
     }
     /*
@@ -485,7 +480,7 @@ found:
             uri->server = NULL;
     }
     *str = cur;
-    return(0);
+    return 0;
 }

 /**
@@ -500,8 +495,7 @@ found:
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_authority(URI *uri, const char **str)
+static int rfc3986_parse_authority(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -516,14 +510,16 @@ rfc3986_parse_authority(URI *uri, const char **str)
     else
         cur++;
     ret = rfc3986_parse_host(uri, &cur);
-    if (ret != 0) return(ret);
+    if (ret != 0)
+        return ret;
     if (*cur == ':') {
         cur++;
         ret = rfc3986_parse_port(uri, &cur);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     }
     *str = cur;
-    return(0);
+    return 0;
 }

 /**
@@ -542,21 +538,20 @@ rfc3986_parse_authority(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_segment(const char **str, char forbid, int empty)
+static int rfc3986_parse_segment(const char **str, char forbid, int empty)
 {
     const char *cur;

     cur = *str;
     if (!ISA_PCHAR(cur)) {
         if (empty)
-            return(0);
-        return(1);
+            return 0;
+        return 1;
     }
     while (ISA_PCHAR(cur) && (*cur != forbid))
         NEXT(cur);
     *str = cur;
-    return (0);
+    return 0;
 }

 /**
@@ -571,8 +566,7 @@ rfc3986_parse_segment(const char **str, char forbid, int empty)
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_path_ab_empty(URI *uri, const char **str)
+static int rfc3986_parse_path_ab_empty(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -582,7 +576,8 @@ rfc3986_parse_path_ab_empty(URI *uri, const char **str)
     while (*cur == '/') {
         cur++;
         ret = rfc3986_parse_segment(&cur, 0, 1);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     }
     if (uri != NULL) {
         g_free(uri->path);
@@ -596,7 +591,7 @@ rfc3986_parse_path_ab_empty(URI *uri, const char **str)
         }
     }
     *str = cur;
-    return (0);
+    return 0;
 }

 /**
@@ -611,8 +606,7 @@ rfc3986_parse_path_ab_empty(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_path_absolute(URI *uri, const char **str)
+static int rfc3986_parse_path_absolute(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -620,14 +614,15 @@ rfc3986_parse_path_absolute(URI *uri, const char **str)
     cur = *str;

     if (*cur != '/')
-        return(1);
+        return 1;
     cur++;
     ret = rfc3986_parse_segment(&cur, 0, 0);
     if (ret == 0) {
         while (*cur == '/') {
             cur++;
             ret = rfc3986_parse_segment(&cur, 0, 1);
-            if (ret != 0) return(ret);
+            if (ret != 0)
+                return ret;
         }
     }
     if (uri != NULL) {
@@ -642,7 +637,7 @@ rfc3986_parse_path_absolute(URI *uri, const char **str)
         }
     }
     *str = cur;
-    return (0);
+    return 0;
 }

 /**
@@ -657,8 +652,7 @@ rfc3986_parse_path_absolute(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_path_rootless(URI *uri, const char **str)
+static int rfc3986_parse_path_rootless(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -666,11 +660,13 @@ rfc3986_parse_path_rootless(URI *uri, const char **str)
     cur = *str;

     ret = rfc3986_parse_segment(&cur, 0, 0);
-    if (ret != 0) return(ret);
+    if (ret != 0)
+        return ret;
     while (*cur == '/') {
         cur++;
         ret = rfc3986_parse_segment(&cur, 0, 1);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     }
     if (uri != NULL) {
         g_free(uri->path);
@@ -684,7 +680,7 @@ rfc3986_parse_path_rootless(URI *uri, const char **str)
         }
     }
     *str = cur;
-    return (0);
+    return 0;
 }

 /**
@@ -699,8 +695,7 @@ rfc3986_parse_path_rootless(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_path_no_scheme(URI *uri, const char **str)
+static int rfc3986_parse_path_no_scheme(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -708,11 +703,13 @@ rfc3986_parse_path_no_scheme(URI *uri, const char **str)
     cur = *str;

     ret = rfc3986_parse_segment(&cur, ':', 0);
-    if (ret != 0) return(ret);
+    if (ret != 0)
+        return ret;
     while (*cur == '/') {
         cur++;
         ret = rfc3986_parse_segment(&cur, 0, 1);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     }
     if (uri != NULL) {
         g_free(uri->path);
@@ -726,7 +723,7 @@ rfc3986_parse_path_no_scheme(URI *uri, const char **str)
         }
     }
     *str = cur;
-    return (0);
+    return 0;
 }

 /**
@@ -744,8 +741,7 @@ rfc3986_parse_path_no_scheme(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-    static int
-rfc3986_parse_hier_part(URI *uri, const char **str)
+static int rfc3986_parse_hier_part(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -755,17 +751,21 @@ rfc3986_parse_hier_part(URI *uri, const char **str)
     if ((*cur == '/') && (*(cur + 1) == '/')) {
         cur += 2;
         ret = rfc3986_parse_authority(uri, &cur);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
         ret = rfc3986_parse_path_ab_empty(uri, &cur);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
         *str = cur;
-        return(0);
+        return 0;
     } else if (*cur == '/') {
         ret = rfc3986_parse_path_absolute(uri, &cur);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     } else if (ISA_PCHAR(cur)) {
         ret = rfc3986_parse_path_rootless(uri, &cur);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     } else {
         /* path-empty is effectively empty */
         if (uri != NULL) {
@@ -774,7 +774,7 @@ rfc3986_parse_hier_part(URI *uri, const char **str)
         }
     }
     *str = cur;
-    return (0);
+    return 0;
 }

 /**
@@ -793,22 +793,26 @@ rfc3986_parse_hier_part(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_relative_ref(URI *uri, const char *str) {
+static int rfc3986_parse_relative_ref(URI *uri, const char *str)
+{
     int ret;

     if ((*str == '/') && (*(str + 1) == '/')) {
         str += 2;
         ret = rfc3986_parse_authority(uri, &str);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
         ret = rfc3986_parse_path_ab_empty(uri, &str);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     } else if (*str == '/') {
         ret = rfc3986_parse_path_absolute(uri, &str);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     } else if (ISA_PCHAR(str)) {
         ret = rfc3986_parse_path_no_scheme(uri, &str);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     } else {
         /* path-empty is effectively empty */
         if (uri != NULL) {
@@ -820,21 +824,22 @@ rfc3986_parse_relative_ref(URI *uri, const char *str) {
     if (*str == '?') {
         str++;
         ret = rfc3986_parse_query(uri, &str);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     }
     if (*str == '#') {
         str++;
         ret = rfc3986_parse_fragment(uri, &str);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     }
     if (*str != 0) {
         uri_clean(uri);
-        return(1);
+        return 1;
     }
-    return(0);
+    return 0;
 }

-
 /**
  * rfc3986_parse:
  * @uri:  pointer to an URI structure
@@ -847,33 +852,37 @@ rfc3986_parse_relative_ref(URI *uri, const char *str) {
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse(URI *uri, const char *str) {
+static int rfc3986_parse(URI *uri, const char *str)
+{
     int ret;

     ret = rfc3986_parse_scheme(uri, &str);
-    if (ret != 0) return(ret);
+    if (ret != 0)
+        return ret;
     if (*str != ':') {
-        return(1);
+        return 1;
     }
     str++;
     ret = rfc3986_parse_hier_part(uri, &str);
-    if (ret != 0) return(ret);
+    if (ret != 0)
+        return ret;
     if (*str == '?') {
         str++;
         ret = rfc3986_parse_query(uri, &str);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     }
     if (*str == '#') {
         str++;
         ret = rfc3986_parse_fragment(uri, &str);
-        if (ret != 0) return(ret);
+        if (ret != 0)
+            return ret;
     }
     if (*str != 0) {
         uri_clean(uri);
-        return(1);
+        return 1;
     }
-    return(0);
+    return 0;
 }

 /**
@@ -888,12 +897,12 @@ rfc3986_parse(URI *uri, const char *str) {
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_uri_reference(URI *uri, const char *str) {
+static int rfc3986_parse_uri_reference(URI *uri, const char *str)
+{
     int ret;

     if (str == NULL)
-        return(-1);
+        return -1;
     uri_clean(uri);

     /*
@@ -906,10 +915,10 @@ rfc3986_parse_uri_reference(URI *uri, const char *str) {
         ret = rfc3986_parse_relative_ref(uri, str);
         if (ret != 0) {
             uri_clean(uri);
-            return(ret);
+            return ret;
         }
     }
-    return(0);
+    return 0;
 }

 /**
@@ -922,20 +931,20 @@ rfc3986_parse_uri_reference(URI *uri, const char *str) {
  *
  * Returns a newly built URI or NULL in case of error
  */
-URI *
-uri_parse(const char *str) {
+URI *uri_parse(const char *str)
+{
     URI *uri;
     int ret;

     if (str == NULL)
-        return(NULL);
+        return NULL;
     uri = uri_new();
     ret = rfc3986_parse_uri_reference(uri, str);
     if (ret) {
         uri_free(uri);
-        return(NULL);
+        return NULL;
     }
-    return(uri);
+    return uri;
 }

 /**
@@ -950,9 +959,9 @@ uri_parse(const char *str) {
  *
  * Returns 0 or the error code
  */
-int
-uri_parse_into(URI *uri, const char *str) {
-    return(rfc3986_parse_uri_reference(uri, str));
+int uri_parse_into(URI *uri, const char *str)
+{
+    return rfc3986_parse_uri_reference(uri, str);
 }

 /**
@@ -966,13 +975,13 @@ uri_parse_into(URI *uri, const char *str) {
  *
  * Returns a newly built URI or NULL in case of error
  */
-URI *
-uri_parse_raw(const char *str, int raw) {
+URI *uri_parse_raw(const char *str, int raw)
+{
     URI *uri;
     int ret;

     if (str == NULL)
-        return(NULL);
+        return NULL;
     uri = uri_new();
     if (raw) {
         uri->cleanup |= 2;
@@ -980,15 +989,15 @@ uri_parse_raw(const char *str, int raw) {
     ret = uri_parse_into(uri, str);
     if (ret) {
         uri_free(uri);
-        return(NULL);
+        return NULL;
     }
-    return(uri);
+    return uri;
 }

 /************************************************************************
- *									*
- *			Generic URI structure functions			*
- *									*
+ *                                                                      *
+ *                    Generic URI structure functions                   *
+ *                                                                      *
  ************************************************************************/

 /**
@@ -998,12 +1007,12 @@ uri_parse_raw(const char *str, int raw) {
  *
  * Returns the new structure or NULL in case of error
  */
-URI *
-uri_new(void) {
+URI *uri_new(void)
+{
     URI *ret;

     ret = g_new0(URI, 1);
-    return(ret);
+    return ret;
 }

 /**
@@ -1012,15 +1021,15 @@ uri_new(void) {
  * Function to handle properly a reallocation when saving an URI
  * Also imposes some limit on the length of an URI string output
  */
-static char *
-realloc2n(char *ret, int *max) {
+static char *realloc2n(char *ret, int *max)
+{
     char *temp;
     int tmp;

     tmp = *max * 2;
     temp = g_realloc(ret, (tmp + 1));
     *max = tmp;
-    return(temp);
+    return temp;
 }

 /**
@@ -1031,16 +1040,16 @@ realloc2n(char *ret, int *max) {
  *
  * Returns a new string (to be deallocated by caller)
  */
-char *
-uri_to_string(URI *uri) {
+char *uri_to_string(URI *uri)
+{
     char *ret = NULL;
     char *temp;
     const char *p;
     int len;
     int max;

-    if (uri == NULL) return(NULL);
-
+    if (uri == NULL)
+        return NULL;

     max = 80;
     ret = g_malloc(max + 1);
@@ -1074,8 +1083,8 @@ uri_to_string(URI *uri) {
                 int val = *(unsigned char *)p++;
                 int hi = val / 0x10, lo = val % 0x10;
                 ret[len++] = '%';
-                ret[len++] = hi + (hi > 9? 'A'-10 : '0');
-                ret[len++] = lo + (lo > 9? 'A'-10 : '0');
+                ret[len++] = hi + (hi > 9 ? 'A' - 10 : '0');
+                ret[len++] = lo + (lo > 9 ? 'A' - 10 : '0');
             }
         }
     } else {
@@ -1093,18 +1102,16 @@ uri_to_string(URI *uri) {
                         temp = realloc2n(ret, &max);
                         ret = temp;
                     }
-                    if ((IS_UNRESERVED(*(p))) ||
-                            ((*(p) == ';')) || ((*(p) == ':')) ||
-                            ((*(p) == '&')) || ((*(p) == '=')) ||
-                            ((*(p) == '+')) || ((*(p) == '$')) ||
-                            ((*(p) == ',')))
+                    if ((IS_UNRESERVED(*(p))) || ((*(p) == ';')) ||
+                        ((*(p) == ':')) || ((*(p) == '&')) || ((*(p) == '=')) ||
+                        ((*(p) == '+')) || ((*(p) == '$')) || ((*(p) == ',')))
                         ret[len++] = *p++;
                     else {
                         int val = *(unsigned char *)p++;
                         int hi = val / 0x10, lo = val % 0x10;
                         ret[len++] = '%';
-                        ret[len++] = hi + (hi > 9? 'A'-10 : '0');
-                        ret[len++] = lo + (lo > 9? 'A'-10 : '0');
+                        ret[len++] = hi + (hi > 9 ? 'A' - 10 : '0');
+                        ret[len++] = lo + (lo > 9 ? 'A' - 10 : '0');
                     }
                 }
                 if (len + 3 >= max) {
@@ -1141,17 +1148,17 @@ uri_to_string(URI *uri) {
                     temp = realloc2n(ret, &max);
                     ret = temp;
                 }
-                if ((IS_UNRESERVED(*(p))) ||
-                        ((*(p) == '$')) || ((*(p) == ',')) || ((*(p) == ';')) ||
-                        ((*(p) == ':')) || ((*(p) == '@')) || ((*(p) == '&')) ||
-                        ((*(p) == '=')) || ((*(p) == '+')))
+                if ((IS_UNRESERVED(*(p))) || ((*(p) == '$')) ||
+                    ((*(p) == ',')) || ((*(p) == ';')) || ((*(p) == ':')) ||
+                    ((*(p) == '@')) || ((*(p) == '&')) || ((*(p) == '=')) ||
+                    ((*(p) == '+')))
                     ret[len++] = *p++;
                 else {
                     int val = *(unsigned char *)p++;
                     int hi = val / 0x10, lo = val % 0x10;
                     ret[len++] = '%';
-                    ret[len++] = hi + (hi > 9? 'A'-10 : '0');
-                    ret[len++] = lo + (lo > 9? 'A'-10 : '0');
+                    ret[len++] = hi + (hi > 9 ? 'A' - 10 : '0');
+                    ret[len++] = lo + (lo > 9 ? 'A' - 10 : '0');
                 }
             }
         } else if (uri->scheme != NULL) {
@@ -1168,12 +1175,10 @@ uri_to_string(URI *uri) {
              * the colon in file:///d: should not be escaped or
              * Windows accesses fail later.
              */
-            if ((uri->scheme != NULL) &&
-                    (p[0] == '/') &&
-                    (((p[1] >= 'a') && (p[1] <= 'z')) ||
-                     ((p[1] >= 'A') && (p[1] <= 'Z'))) &&
-                    (p[2] == ':') &&
-                    (!strcmp(uri->scheme, "file"))) {
+            if ((uri->scheme != NULL) && (p[0] == '/') &&
+                (((p[1] >= 'a') && (p[1] <= 'z')) ||
+                 ((p[1] >= 'A') && (p[1] <= 'Z'))) &&
+                (p[2] == ':') && (!strcmp(uri->scheme, "file"))) {
                 if (len + 3 >= max) {
                     temp = realloc2n(ret, &max);
                     ret = temp;
@@ -1188,16 +1193,16 @@ uri_to_string(URI *uri) {
                     ret = temp;
                 }
                 if ((IS_UNRESERVED(*(p))) || ((*(p) == '/')) ||
-                        ((*(p) == ';')) || ((*(p) == '@')) || ((*(p) == '&')) ||
-                        ((*(p) == '=')) || ((*(p) == '+')) || ((*(p) == '$')) ||
-                        ((*(p) == ',')))
+                    ((*(p) == ';')) || ((*(p) == '@')) || ((*(p) == '&')) ||
+                    ((*(p) == '=')) || ((*(p) == '+')) || ((*(p) == '$')) ||
+                    ((*(p) == ',')))
                     ret[len++] = *p++;
                 else {
                     int val = *(unsigned char *)p++;
                     int hi = val / 0x10, lo = val % 0x10;
                     ret[len++] = '%';
-                    ret[len++] = hi + (hi > 9? 'A'-10 : '0');
-                    ret[len++] = lo + (lo > 9? 'A'-10 : '0');
+                    ret[len++] = hi + (hi > 9 ? 'A' - 10 : '0');
+                    ret[len++] = lo + (lo > 9 ? 'A' - 10 : '0');
                 }
             }
         }
@@ -1235,8 +1240,8 @@ uri_to_string(URI *uri) {
                 int val = *(unsigned char *)p++;
                 int hi = val / 0x10, lo = val % 0x10;
                 ret[len++] = '%';
-                ret[len++] = hi + (hi > 9? 'A'-10 : '0');
-                ret[len++] = lo + (lo > 9? 'A'-10 : '0');
+                ret[len++] = hi + (hi > 9 ? 'A' - 10 : '0');
+                ret[len++] = lo + (lo > 9 ? 'A' - 10 : '0');
             }
         }
     }
@@ -1245,7 +1250,7 @@ uri_to_string(URI *uri) {
         ret = temp;
     }
     ret[len] = 0;
-    return(ret);
+    return ret;
 }

 /**
@@ -1254,9 +1259,10 @@ uri_to_string(URI *uri) {
  *
  * Make sure the URI struct is free of content
  */
-static void
-uri_clean(URI *uri) {
-    if (uri == NULL) return;
+static void uri_clean(URI *uri)
+{
+    if (uri == NULL)
+        return;

     g_free(uri->scheme);
     uri->scheme = NULL;
@@ -1282,16 +1288,16 @@ uri_clean(URI *uri) {
  *
  * Free up the URI struct
  */
-void
-uri_free(URI *uri) {
+void uri_free(URI *uri)
+{
     uri_clean(uri);
     g_free(uri);
 }

 /************************************************************************
- *									*
- *			Helper functions				*
- *									*
+ *                                                                      *
+ *                           Helper functions                           *
+ *                                                                      *
  ************************************************************************/

 /**
@@ -1305,12 +1311,12 @@ uri_free(URI *uri) {
  *
  * Returns 0 or an error code
  */
-static int
-normalize_uri_path(char *path) {
+static int normalize_uri_path(char *path)
+{
     char *cur, *out;

     if (path == NULL)
-        return(-1);
+        return -1;

     /* Skip all initial "/" chars.  We want to get to the beginning of the
      * first non-empty segment.
@@ -1319,7 +1325,7 @@ normalize_uri_path(char *path) {
     while (cur[0] == '/')
         ++cur;
     if (cur[0] == '\0')
-        return(0);
+        return 0;

     /* Keep everything we've seen so far.  */
     out = cur;
@@ -1367,7 +1373,7 @@ done_cd:
     while (cur[0] == '/')
         ++cur;
     if (cur[0] == '\0')
-        return(0);
+        return 0;

     /*
      * Analyze each segment in sequence for cases (e) and (f).
@@ -1409,9 +1415,9 @@ done_cd:
          * keep this segment and try the next one.
          */
         ++segp;
-        if (((cur[0] == '.') && (cur[1] == '.') && (segp == cur+3))
-                || ((segp[0] != '.') || (segp[1] != '.')
-                    || ((segp[2] != '/') && (segp[2] != '\0')))) {
+        if (((cur[0] == '.') && (cur[1] == '.') && (segp == cur + 3)) ||
+            ((segp[0] != '.') || (segp[1] != '.') ||
+             ((segp[2] != '/') && (segp[2] != '\0')))) {
             cur = segp;
             continue;
         }
@@ -1468,8 +1474,8 @@ done_cd:
      */
     if (path[0] == '/') {
         cur = path;
-        while ((cur[0] == '/') && (cur[1] == '.') && (cur[2] == '.')
-                && ((cur[3] == '/') || (cur[3] == '\0')))
+        while ((cur[0] == '/') && (cur[1] == '.') && (cur[2] == '.') &&
+               ((cur[3] == '/') || (cur[3] == '\0')))
             cur += 3;

         if (cur != path) {
@@ -1480,18 +1486,17 @@ done_cd:
         }
     }

-    return(0);
+    return 0;
 }

-static int is_hex(char c) {
-    if (((c >= '0') && (c <= '9')) ||
-            ((c >= 'a') && (c <= 'f')) ||
-            ((c >= 'A') && (c <= 'F')))
-        return(1);
-    return(0);
+static int is_hex(char c)
+{
+    if (((c >= '0') && (c <= '9')) || ((c >= 'a') && (c <= 'f')) ||
+        ((c >= 'A') && (c <= 'F')))
+        return 1;
+    return 0;
 }

-
 /**
  * uri_string_unescape:
  * @str:  the string to unescape
@@ -1506,15 +1511,17 @@ static int is_hex(char c) {
  * Returns a copy of the string, but unescaped, will return NULL only in case
  * of error
  */
-char *
-uri_string_unescape(const char *str, int len, char *target) {
+char *uri_string_unescape(const char *str, int len, char *target)
+{
     char *ret, *out;
     const char *in;

     if (str == NULL)
-        return(NULL);
-    if (len <= 0) len = strlen(str);
-    if (len < 0) return(NULL);
+        return NULL;
+    if (len <= 0)
+        len = strlen(str);
+    if (len < 0)
+        return NULL;

     if (target == NULL) {
         ret = g_malloc(len + 1);
@@ -1522,7 +1529,7 @@ uri_string_unescape(const char *str, int len, char *target) {
         ret = target;
     in = str;
     out = ret;
-    while(len > 0) {
+    while (len > 0) {
         if ((len > 2) && (*in == '%') && (is_hex(in[1])) && (is_hex(in[2]))) {
             in++;
             if ((*in >= '0') && (*in <= '9'))
@@ -1547,7 +1554,7 @@ uri_string_unescape(const char *str, int len, char *target) {
         }
     }
     *out = 0;
-    return(ret);
+    return ret;
 }

 /**
@@ -1560,25 +1567,26 @@ uri_string_unescape(const char *str, int len, char *target) {
  *
  * Returns a new escaped string or NULL in case of error.
  */
-char *
-uri_string_escape(const char *str, const char *list) {
+char *uri_string_escape(const char *str, const char *list)
+{
     char *ret, ch;
     char *temp;
     const char *in;
     int len, out;

     if (str == NULL)
-        return(NULL);
+        return NULL;
     if (str[0] == 0)
-        return(g_strdup(str));
+        return g_strdup(str);
     len = strlen(str);
-    if (!(len > 0)) return(NULL);
+    if (!(len > 0))
+        return NULL;

     len += 20;
     ret = g_malloc(len);
     in = str;
     out = 0;
-    while(*in != 0) {
+    while (*in != 0) {
         if (len - out <= 3) {
             temp = realloc2n(ret, &len);
             ret = temp;
@@ -1603,16 +1611,15 @@ uri_string_escape(const char *str, const char *list) {
         } else {
             ret[out++] = *in++;
         }
-
     }
     ret[out] = 0;
-    return(ret);
+    return ret;
 }

 /************************************************************************
- *									*
- *			Public functions				*
- *									*
+ *                                                                      *
+ *                           Public functions                           *
+ *                                                                      *
  ************************************************************************/

 /**
@@ -1630,8 +1637,8 @@ uri_string_escape(const char *str, const char *list) {
  * Returns a new URI string (to be freed by the caller) or NULL in case
  *         of error.
  */
-char *
-uri_resolve(const char *uri, const char *base) {
+char *uri_resolve(const char *uri, const char *base)
+{
     char *val = NULL;
     int ret, len, indx, cur, out;
     URI *ref = NULL;
@@ -1652,8 +1659,7 @@ uri_resolve(const char *uri, const char *base) {
         if (*uri) {
             ref = uri_new();
             ret = uri_parse_into(ref, uri);
-        }
-        else
+        } else
             ret = 0;
     }
     if (ret != 0)
@@ -1700,7 +1706,7 @@ uri_resolve(const char *uri, const char *base) {
      */
     res = uri_new();
     if ((ref->scheme == NULL) && (ref->path == NULL) &&
-            ((ref->authority == NULL) && (ref->server == NULL))) {
+        ((ref->authority == NULL) && (ref->server == NULL))) {
         res->scheme = g_strdup(bas->scheme);
         if (bas->authority != NULL)
             res->authority = g_strdup(bas->authority);
@@ -1711,7 +1717,7 @@ uri_resolve(const char *uri, const char *base) {
         }
         res->path = g_strdup(bas->path);
         if (ref->query != NULL) {
-            res->query = g_strdup (ref->query);
+            res->query = g_strdup(ref->query);
         } else {
             res->query = g_strdup(bas->query);
         }
@@ -1769,7 +1775,6 @@ uri_resolve(const char *uri, const char *base) {
         goto step_7;
     }

-
     /*
      * 6) If this step is reached, then we are resolving a relative-path
      *    reference.  The relative path needs to be merged with the base
@@ -1847,7 +1852,7 @@ done:
         uri_free(bas);
     if (res != NULL)
         uri_free(res);
-    return(val);
+    return val;
 }

 /**
@@ -1882,8 +1887,7 @@ done:
  * Returns a new URI string (to be freed by the caller) or NULL in case
  * error.
  */
-    char *
-uri_resolve_relative (const char *uri, const char * base)
+char *uri_resolve_relative(const char *uri, const char *base)
 {
     char *val = NULL;
     int ret;
@@ -1902,12 +1906,12 @@ uri_resolve_relative (const char *uri, const char * base)
     /*
      * First parse URI into a standard form
      */
-    ref = uri_new ();
+    ref = uri_new();
     /* If URI not already in "relative" form */
     if (uri[0] != '.') {
-        ret = uri_parse_into (ref, uri);
+        ret = uri_parse_into(ref, uri);
         if (ret != 0)
-            goto done;		/* Error in URI, return NULL */
+            goto done; /* Error in URI, return NULL */
     } else
         ref->path = g_strdup(uri);

@@ -1915,14 +1919,14 @@ uri_resolve_relative (const char *uri, const char * base)
      * Next parse base into the same standard form
      */
     if ((base == NULL) || (*base == 0)) {
-        val = g_strdup (uri);
+        val = g_strdup(uri);
         goto done;
     }
-    bas = uri_new ();
+    bas = uri_new();
     if (base[0] != '.') {
-        ret = uri_parse_into (bas, base);
+        ret = uri_parse_into(bas, base);
         if (ret != 0)
-            goto done;		/* Error in base, return NULL */
+            goto done; /* Error in base, return NULL */
     } else
         bas->path = g_strdup(base);

@@ -1931,14 +1935,13 @@ uri_resolve_relative (const char *uri, const char * base)
      * just return the URI
      */
     if ((ref->scheme != NULL) &&
-            ((bas->scheme == NULL) ||
-             (strcmp (bas->scheme, ref->scheme)) ||
-             (strcmp (bas->server, ref->server)))) {
-        val = g_strdup (uri);
+        ((bas->scheme == NULL) || (strcmp(bas->scheme, ref->scheme)) ||
+         (strcmp(bas->server, ref->server)))) {
+        val = g_strdup(uri);
         goto done;
     }
     if (bas->path == ref->path ||
-            (bas->path && ref->path && !strcmp(bas->path, ref->path))) {
+        (bas->path && ref->path && !strcmp(bas->path, ref->path))) {
         val = g_strdup("");
         goto done;
     }
@@ -1947,7 +1950,7 @@ uri_resolve_relative (const char *uri, const char * base)
         goto done;
     }
     if (ref->path == NULL) {
-        ref->path = (char *) "/";
+        ref->path = (char *)"/";
         remove_path = 1;
     }

@@ -1974,12 +1977,12 @@ uri_resolve_relative (const char *uri, const char * base)
                 nbslash++;
         }
         uptr = NULL;
-        len = 1;	/* this is for a string terminator only */
+        len = 1; /* this is for a string terminator only */
     } else {
         /*
          * Next we compare the two strings and find where they first differ
          */
-        if ((ref->path[pos] == '.') && (ref->path[pos+1] == '/'))
+        if ((ref->path[pos] == '.') && (ref->path[pos + 1] == '/'))
             pos += 2;
         if ((*bptr == '.') && (bptr[1] == '/'))
             bptr += 2;
@@ -1990,7 +1993,7 @@ uri_resolve_relative (const char *uri, const char * base)

         if (bptr[pos] == ref->path[pos]) {
             val = g_strdup("");
-            goto done;		/* (I can't imagine why anyone would do this) */
+            goto done; /* (I can't imagine why anyone would do this) */
         }

         /*
@@ -2016,13 +2019,13 @@ uri_resolve_relative (const char *uri, const char * base)
         /*
          * In base, count the number of '/' from the differing point
          */
-        if (bptr[pos] != ref->path[pos]) {/* check for trivial URI == base */
+        if (bptr[pos] != ref->path[pos]) { /* check for trivial URI == base */
             for (; bptr[ix] != 0; ix++) {
                 if (bptr[ix] == '/')
                     nbslash++;
             }
         }
-        len = strlen (uptr) + 1;
+        len = strlen(uptr) + 1;
     }

     if (nbslash == 0) {
@@ -2037,12 +2040,12 @@ uri_resolve_relative (const char *uri, const char * base)
      * length of the remainder of the URI, plus enough space
      * for the "../" groups, plus one for the terminator
      */
-    val = g_malloc (len + 3 * nbslash);
+    val = g_malloc(len + 3 * nbslash);
     vptr = val;
     /*
      * Put in as many "../" as needed
      */
-    for (; nbslash>0; nbslash--) {
+    for (; nbslash > 0; nbslash--) {
         *vptr++ = '.';
         *vptr++ = '.';
         *vptr++ = '/';
@@ -2051,12 +2054,12 @@ uri_resolve_relative (const char *uri, const char * base)
      * Finish up with the end of the URI
      */
     if (uptr != NULL) {
-        if ((vptr > val) && (len > 0) &&
-                (uptr[0] == '/') && (vptr[-1] == '/')) {
-            memcpy (vptr, uptr + 1, len - 1);
+        if ((vptr > val) && (len > 0) && (uptr[0] == '/') &&
+            (vptr[-1] == '/')) {
+            memcpy(vptr, uptr + 1, len - 1);
             vptr[len - 2] = 0;
         } else {
-            memcpy (vptr, uptr, len);
+            memcpy(vptr, uptr, len);
             vptr[len - 1] = 0;
         }
     } else {
@@ -2076,9 +2079,9 @@ done:
     if (remove_path != 0)
         ref->path = NULL;
     if (ref != NULL)
-        uri_free (ref);
+        uri_free(ref);
     if (bas != NULL)
-        uri_free (bas);
+        uri_free(bas);

     return val;
 }
@@ -2087,12 +2090,12 @@ done:
  * Utility functions to help parse and assemble query strings.
  */

-    struct QueryParams *
-query_params_new (int init_alloc)
+struct QueryParams *query_params_new(int init_alloc)
 {
     struct QueryParams *ps;

-    if (init_alloc <= 0) init_alloc = 1;
+    if (init_alloc <= 0)
+        init_alloc = 1;

     ps = g_new(QueryParams, 1);
     ps->n = 0;
@@ -2105,9 +2108,8 @@ query_params_new (int init_alloc)
 /* Ensure there is space to store at least one more parameter
  * at the end of the set.
  */
-    static int
-query_params_append (struct QueryParams *ps,
-        const char *name, const char *value)
+static int query_params_append(struct QueryParams *ps, const char *name,
+                               const char *value)
 {
     if (ps->n >= ps->alloc) {
         ps->p = g_renew(QueryParam, ps->p, ps->alloc * 2);
@@ -2122,41 +2124,41 @@ query_params_append (struct QueryParams *ps,
     return 0;
 }

-    void
-query_params_free (struct QueryParams *ps)
+void query_params_free(struct QueryParams *ps)
 {
     int i;

     for (i = 0; i < ps->n; ++i) {
-        g_free (ps->p[i].name);
-        g_free (ps->p[i].value);
+        g_free(ps->p[i].name);
+        g_free(ps->p[i].value);
     }
-    g_free (ps->p);
-    g_free (ps);
+    g_free(ps->p);
+    g_free(ps);
 }

-    struct QueryParams *
-query_params_parse (const char *query)
+struct QueryParams *query_params_parse(const char *query)
 {
     struct QueryParams *ps;
     const char *end, *eq;

-    ps = query_params_new (0);
-    if (!query || query[0] == '\0') return ps;
+    ps = query_params_new(0);
+    if (!query || query[0] == '\0')
+        return ps;

     while (*query) {
         char *name = NULL, *value = NULL;

         /* Find the next separator, or end of the string. */
-        end = strchr (query, '&');
+        end = strchr(query, '&');
         if (!end)
-            end = strchr (query, ';');
+            end = strchr(query, ';');
         if (!end)
-            end = query + strlen (query);
+            end = query + strlen(query);

         /* Find the first '=' character between here and end. */
-        eq = strchr (query, '=');
-        if (eq && eq >= end) eq = NULL;
+        eq = strchr(query, '=');
+        if (eq && eq >= end)
+            eq = NULL;

         /* Empty section (eg. "&&"). */
         if (end == query)
@@ -2166,14 +2168,14 @@ query_params_parse (const char *query)
          * and consistent with CGI.pm we assume value is "".
          */
         else if (!eq) {
-            name = uri_string_unescape (query, end - query, NULL);
+            name = uri_string_unescape(query, end - query, NULL);
             value = NULL;
         }
         /* Or if we have "name=" here (works around annoying
          * problem when calling uri_string_unescape with len = 0).
          */
-        else if (eq+1 == end) {
-            name = uri_string_unescape (query, eq - query, NULL);
+        else if (eq + 1 == end) {
+            name = uri_string_unescape(query, eq - query, NULL);
             value = g_new0(char, 1);
         }
         /* If the '=' character is at the beginning then we have
@@ -2184,18 +2186,19 @@ query_params_parse (const char *query)

         /* Otherwise it's "name=value". */
         else {
-            name = uri_string_unescape (query, eq - query, NULL);
-            value = uri_string_unescape (eq+1, end - (eq+1), NULL);
+            name = uri_string_unescape(query, eq - query, NULL);
+            value = uri_string_unescape(eq + 1, end - (eq + 1), NULL);
         }

         /* Append to the parameter set. */
-        query_params_append (ps, name, value);
+        query_params_append(ps, name, value);
         g_free(name);
         g_free(value);

-next:
+    next:
         query = end;
-        if (*query) query ++; /* skip '&' separator */
+        if (*query)
+            query++; /* skip '&' separator */
     }

     return ps;
--
2.7.4
