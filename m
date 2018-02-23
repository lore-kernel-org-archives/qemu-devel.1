Received: from eggs.gnu.org ([2001:4830:134:3::10]:60411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ep88o-0000Kn-F6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 02:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ep88j-0004aS-F3
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 02:51:38 -0500
Received: from smtp20.cstnet.cn ([159.226.251.20]:44787 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ep88h-0004Zr-Tc
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 02:51:33 -0500
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Fri, 23 Feb 2018 15:51:28 +0800
Message-Id: <1519372288-20791-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PATCH v3 3/3] util/uri.c: add brackets to `if`
 statements
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

Add brackets that wrap `if`, `else`, `while` that hold single
statements.

In order to do this, I write a simple python regex script.

Since then, all complaints rised by checkpatch.pl has been suppressed.

Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 util/uri.c | 462 ++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 291 insertions(+), 171 deletions(-)

diff --git a/util/uri.c b/util/uri.c
index 278e876ab8b1..48f7298787b1 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -105,18 +105,18 @@ static void uri_clean(URI *uri);
  */
 
 #define IS_UNWISE(p)                                                           \
-      (((*(p) == '{')) || ((*(p) == '}')) || ((*(p) == '|')) ||                \
-       ((*(p) == '\\')) || ((*(p) == '^')) || ((*(p) == '[')) ||               \
-       ((*(p) == ']')) || ((*(p) == '`')))
+    (((*(p) == '{')) || ((*(p) == '}')) || ((*(p) == '|')) ||                  \
+     ((*(p) == '\\')) || ((*(p) == '^')) || ((*(p) == '[')) ||                 \
+     ((*(p) == ']')) || ((*(p) == '`')))
 /*
  * reserved = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" | "$" | "," |
  *            "[" | "]"
  */
 
 #define IS_RESERVED(x) (((x) == ';') || ((x) == '/') || ((x) == '?') ||        \
-        ((x) == ':') || ((x) == '@') || ((x) == '&') || ((x) == '=') ||        \
-        ((x) == '+') || ((x) == '$') || ((x) == ',') || ((x) == '[') ||        \
-        ((x) == ']'))
+      ((x) == ':') || ((x) == '@') || ((x) == '&') || ((x) == '=') ||          \
+      ((x) == '+') || ((x) == '$') || ((x) == ',') || ((x) == '[') ||          \
+      ((x) == ']'))
 
 /*
  * unreserved = alphanum | mark
@@ -211,15 +211,17 @@ static int rfc3986_parse_scheme(URI *uri, const char **str)
 {
     const char *cur;
 
-    if (str == NULL)
+    if (str == NULL) {
         return -1;
+    }
 
     cur = *str;
-    if (!ISA_ALPHA(cur))
+    if (!ISA_ALPHA(cur)) {
         return 2;
+    }
     cur++;
-    while (ISA_ALPHA(cur) || ISA_DIGIT(cur) ||
-           (*cur == '+') || (*cur == '-') || (*cur == '.'))
+    while (ISA_ALPHA(cur) || ISA_DIGIT(cur) || (*cur == '+') || (*cur == '-') ||
+           (*cur == '.'))
         cur++;
     if (uri != NULL) {
         g_free(uri->scheme);
@@ -248,8 +250,9 @@ static int rfc3986_parse_fragment(URI *uri, const char **str)
 {
     const char *cur;
 
-    if (str == NULL)
+    if (str == NULL) {
         return -1;
+    }
 
     cur = *str;
 
@@ -259,10 +262,11 @@ static int rfc3986_parse_fragment(URI *uri, const char **str)
         NEXT(cur);
     if (uri != NULL) {
         g_free(uri->fragment);
-        if (uri->cleanup & 2)
+        if (uri->cleanup & 2) {
             uri->fragment = g_strndup(*str, cur - *str);
-        else
+        } else {
             uri->fragment = uri_string_unescape(*str, cur - *str, NULL);
+        }
     }
     *str = cur;
     return 0;
@@ -283,8 +287,9 @@ static int rfc3986_parse_query(URI *uri, const char **str)
 {
     const char *cur;
 
-    if (str == NULL)
+    if (str == NULL) {
         return -1;
+    }
 
     cur = *str;
 
@@ -356,10 +361,11 @@ static int rfc3986_parse_user_info(URI *uri, const char **str)
     if (*cur == '@') {
         if (uri != NULL) {
             g_free(uri->user);
-            if (uri->cleanup & 2)
+            if (uri->cleanup & 2) {
                 uri->user = g_strndup(*str, cur - *str);
-            else
+            } else {
                 uri->user = uri_string_unescape(*str, cur - *str, NULL);
+            }
         }
         *str = cur;
         return 0;
@@ -385,22 +391,24 @@ static int rfc3986_parse_dec_octet(const char **str)
 {
     const char *cur = *str;
 
-    if (!(ISA_DIGIT(cur)))
+    if (!(ISA_DIGIT(cur))) {
         return 1;
-    if (!ISA_DIGIT(cur + 1))
+    }
+    if (!ISA_DIGIT(cur + 1)) {
         cur++;
-    else if ((*cur != '0') && (ISA_DIGIT(cur + 1)) && (!ISA_DIGIT(cur + 2)))
+    } else if ((*cur != '0') && (ISA_DIGIT(cur + 1)) && (!ISA_DIGIT(cur + 2))) {
         cur += 2;
-    else if ((*cur == '1') && (ISA_DIGIT(cur + 1)) && (ISA_DIGIT(cur + 2)))
+    } else if ((*cur == '1') && (ISA_DIGIT(cur + 1)) && (ISA_DIGIT(cur + 2))) {
         cur += 3;
-    else if ((*cur == '2') && (*(cur + 1) >= '0') && (*(cur + 1) <= '4') &&
-             (ISA_DIGIT(cur + 2)))
+    } else if ((*cur == '2') && (*(cur + 1) >= '0') && (*(cur + 1) <= '4') &&
+               (ISA_DIGIT(cur + 2))) {
         cur += 3;
-    else if ((*cur == '2') && (*(cur + 1) == '5') && (*(cur + 2) >= '0') &&
-             (*(cur + 1) <= '5'))
+    } else if ((*cur == '2') && (*(cur + 1) == '5') && (*(cur + 2) >= '0') &&
+               (*(cur + 1) <= '5')) {
         cur += 3;
-    else
+    } else {
         return 1;
+    }
     *str = cur;
     return 0;
 }
@@ -430,10 +438,12 @@ static int rfc3986_parse_host(URI *uri, const char **str)
      */
     if (*cur == '[') {
         cur++;
-        while ((*cur != ']') && (*cur != 0))
+        while ((*cur != ']') && (*cur != 0)) {
             cur++;
-        if (*cur != ']')
+        }
+        if (*cur != ']') {
             return 1;
+        }
         cur++;
         goto found;
     }
@@ -441,21 +451,28 @@ static int rfc3986_parse_host(URI *uri, const char **str)
      * try to parse an IPv4
      */
     if (ISA_DIGIT(cur)) {
-        if (rfc3986_parse_dec_octet(&cur) != 0)
+        if (rfc3986_parse_dec_octet(&cur) != 0) {
             goto not_ipv4;
-        if (*cur != '.')
+        }
+        if (*cur != '.') {
             goto not_ipv4;
+        }
         cur++;
-        if (rfc3986_parse_dec_octet(&cur) != 0)
+        if (rfc3986_parse_dec_octet(&cur) != 0) {
             goto not_ipv4;
-        if (*cur != '.')
+        }
+        if (*cur != '.') {
             goto not_ipv4;
-        if (rfc3986_parse_dec_octet(&cur) != 0)
+        }
+        if (rfc3986_parse_dec_octet(&cur) != 0) {
             goto not_ipv4;
-        if (*cur != '.')
+        }
+        if (*cur != '.') {
             goto not_ipv4;
-        if (rfc3986_parse_dec_octet(&cur) != 0)
+        }
+        if (rfc3986_parse_dec_octet(&cur) != 0) {
             goto not_ipv4;
+        }
         goto found;
     not_ipv4:
         cur = *str;
@@ -463,20 +480,23 @@ static int rfc3986_parse_host(URI *uri, const char **str)
     /*
      * then this should be a hostname which can be empty
      */
-    while (ISA_UNRESERVED(cur) || ISA_PCT_ENCODED(cur) || ISA_SUB_DELIM(cur))
+    while (ISA_UNRESERVED(cur) || ISA_PCT_ENCODED(cur) || ISA_SUB_DELIM(cur)) {
         NEXT(cur);
+    }
 found:
     if (uri != NULL) {
         g_free(uri->authority);
         uri->authority = NULL;
         g_free(uri->server);
         if (cur != host) {
-            if (uri->cleanup & 2)
+            if (uri->cleanup & 2) {
                 uri->server = g_strndup(host, cur - host);
-            else
+            } else {
                 uri->server = uri_string_unescape(host, cur - host, NULL);
-        } else
+            }
+        } else {
             uri->server = NULL;
+        }
     }
     *str = cur;
     return 0;
@@ -504,18 +524,21 @@ static int rfc3986_parse_authority(URI *uri, const char **str)
      * try to parse a userinfo and check for the trailing @
      */
     ret = rfc3986_parse_user_info(uri, &cur);
-    if ((ret != 0) || (*cur != '@'))
+    if ((ret != 0) || (*cur != '@')) {
         cur = *str;
-    else
+    } else {
         cur++;
+    }
     ret = rfc3986_parse_host(uri, &cur);
-    if (ret != 0)
+    if (ret != 0) {
         return ret;
+    }
     if (*cur == ':') {
         cur++;
         ret = rfc3986_parse_port(uri, &cur);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     }
     *str = cur;
     return 0;
@@ -543,12 +566,14 @@ static int rfc3986_parse_segment(const char **str, char forbid, int empty)
 
     cur = *str;
     if (!ISA_PCHAR(cur)) {
-        if (empty)
+        if (empty) {
             return 0;
+        }
         return 1;
     }
-    while (ISA_PCHAR(cur) && (*cur != forbid))
+    while (ISA_PCHAR(cur) && (*cur != forbid)) {
         NEXT(cur);
+    }
     *str = cur;
     return 0;
 }
@@ -575,16 +600,18 @@ static int rfc3986_parse_path_ab_empty(URI *uri, const char **str)
     while (*cur == '/') {
         cur++;
         ret = rfc3986_parse_segment(&cur, 0, 1);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     }
     if (uri != NULL) {
         g_free(uri->path);
         if (*str != cur) {
-            if (uri->cleanup & 2)
+            if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
-            else
+            } else {
                 uri->path = uri_string_unescape(*str, cur - *str, NULL);
+            }
         } else {
             uri->path = NULL;
         }
@@ -612,25 +639,28 @@ static int rfc3986_parse_path_absolute(URI *uri, const char **str)
 
     cur = *str;
 
-    if (*cur != '/')
+    if (*cur != '/') {
         return 1;
+    }
     cur++;
     ret = rfc3986_parse_segment(&cur, 0, 0);
     if (ret == 0) {
         while (*cur == '/') {
             cur++;
             ret = rfc3986_parse_segment(&cur, 0, 1);
-            if (ret != 0)
+            if (ret != 0) {
                 return ret;
+            }
         }
     }
     if (uri != NULL) {
         g_free(uri->path);
         if (cur != *str) {
-            if (uri->cleanup & 2)
+            if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
-            else
+            } else {
                 uri->path = uri_string_unescape(*str, cur - *str, NULL);
+            }
         } else {
             uri->path = NULL;
         }
@@ -659,21 +689,24 @@ static int rfc3986_parse_path_rootless(URI *uri, const char **str)
     cur = *str;
 
     ret = rfc3986_parse_segment(&cur, 0, 0);
-    if (ret != 0)
+    if (ret != 0) {
         return ret;
+    }
     while (*cur == '/') {
         cur++;
         ret = rfc3986_parse_segment(&cur, 0, 1);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     }
     if (uri != NULL) {
         g_free(uri->path);
         if (cur != *str) {
-            if (uri->cleanup & 2)
+            if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
-            else
+            } else {
                 uri->path = uri_string_unescape(*str, cur - *str, NULL);
+            }
         } else {
             uri->path = NULL;
         }
@@ -702,21 +735,24 @@ static int rfc3986_parse_path_no_scheme(URI *uri, const char **str)
     cur = *str;
 
     ret = rfc3986_parse_segment(&cur, ':', 0);
-    if (ret != 0)
+    if (ret != 0) {
         return ret;
+    }
     while (*cur == '/') {
         cur++;
         ret = rfc3986_parse_segment(&cur, 0, 1);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     }
     if (uri != NULL) {
         g_free(uri->path);
         if (cur != *str) {
-            if (uri->cleanup & 2)
+            if (uri->cleanup & 2) {
                 uri->path = g_strndup(*str, cur - *str);
-            else
+            } else {
                 uri->path = uri_string_unescape(*str, cur - *str, NULL);
+            }
         } else {
             uri->path = NULL;
         }
@@ -750,21 +786,25 @@ static int rfc3986_parse_hier_part(URI *uri, const char **str)
     if ((*cur == '/') && (*(cur + 1) == '/')) {
         cur += 2;
         ret = rfc3986_parse_authority(uri, &cur);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
         ret = rfc3986_parse_path_ab_empty(uri, &cur);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
         *str = cur;
         return 0;
     } else if (*cur == '/') {
         ret = rfc3986_parse_path_absolute(uri, &cur);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     } else if (ISA_PCHAR(cur)) {
         ret = rfc3986_parse_path_rootless(uri, &cur);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     } else {
         /* path-empty is effectively empty */
         if (uri != NULL) {
@@ -799,19 +839,23 @@ static int rfc3986_parse_relative_ref(URI *uri, const char *str)
     if ((*str == '/') && (*(str + 1) == '/')) {
         str += 2;
         ret = rfc3986_parse_authority(uri, &str);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
         ret = rfc3986_parse_path_ab_empty(uri, &str);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     } else if (*str == '/') {
         ret = rfc3986_parse_path_absolute(uri, &str);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     } else if (ISA_PCHAR(str)) {
         ret = rfc3986_parse_path_no_scheme(uri, &str);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     } else {
         /* path-empty is effectively empty */
         if (uri != NULL) {
@@ -823,14 +867,16 @@ static int rfc3986_parse_relative_ref(URI *uri, const char *str)
     if (*str == '?') {
         str++;
         ret = rfc3986_parse_query(uri, &str);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     }
     if (*str == '#') {
         str++;
         ret = rfc3986_parse_fragment(uri, &str);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     }
     if (*str != 0) {
         uri_clean(uri);
@@ -856,26 +902,30 @@ static int rfc3986_parse(URI *uri, const char *str)
     int ret;
 
     ret = rfc3986_parse_scheme(uri, &str);
-    if (ret != 0)
+    if (ret != 0) {
         return ret;
+    }
     if (*str != ':') {
         return 1;
     }
     str++;
     ret = rfc3986_parse_hier_part(uri, &str);
-    if (ret != 0)
+    if (ret != 0) {
         return ret;
+    }
     if (*str == '?') {
         str++;
         ret = rfc3986_parse_query(uri, &str);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     }
     if (*str == '#') {
         str++;
         ret = rfc3986_parse_fragment(uri, &str);
-        if (ret != 0)
+        if (ret != 0) {
             return ret;
+        }
     }
     if (*str != 0) {
         uri_clean(uri);
@@ -900,8 +950,9 @@ static int rfc3986_parse_uri_reference(URI *uri, const char *str)
 {
     int ret;
 
-    if (str == NULL)
+    if (str == NULL) {
         return -1;
+    }
     uri_clean(uri);
 
     /*
@@ -935,8 +986,9 @@ URI *uri_parse(const char *str)
     URI *uri;
     int ret;
 
-    if (str == NULL)
+    if (str == NULL) {
         return NULL;
+    }
     uri = uri_new();
     ret = rfc3986_parse_uri_reference(uri, str);
     if (ret) {
@@ -979,8 +1031,9 @@ URI *uri_parse_raw(const char *str, int raw)
     URI *uri;
     int ret;
 
-    if (str == NULL)
+    if (str == NULL) {
         return NULL;
+    }
     uri = uri_new();
     if (raw) {
         uri->cleanup |= 2;
@@ -1047,8 +1100,9 @@ char *uri_to_string(URI *uri)
     int len;
     int max;
 
-    if (uri == NULL)
+    if (uri == NULL) {
         return NULL;
+    }
 
     max = 80;
     ret = g_malloc(max + 1);
@@ -1076,9 +1130,9 @@ char *uri_to_string(URI *uri)
                 temp = realloc2n(ret, &max);
                 ret = temp;
             }
-            if (IS_RESERVED(*(p)) || IS_UNRESERVED(*(p)))
+            if (IS_RESERVED(*(p)) || IS_UNRESERVED(*(p))) {
                 ret[len++] = *p++;
-            else {
+            } else {
                 int val = *(unsigned char *)p++;
                 int hi = val / 0x10, lo = val % 0x10;
                 ret[len++] = '%';
@@ -1103,9 +1157,9 @@ char *uri_to_string(URI *uri)
                     }
                     if ((IS_UNRESERVED(*(p))) || ((*(p) == ';')) ||
                         ((*(p) == ':')) || ((*(p) == '&')) || ((*(p) == '=')) ||
-                        ((*(p) == '+')) || ((*(p) == '$')) || ((*(p) == ',')))
+                        ((*(p) == '+')) || ((*(p) == '$')) || ((*(p) == ','))) {
                         ret[len++] = *p++;
-                    else {
+                    } else {
                         int val = *(unsigned char *)p++;
                         int hi = val / 0x10, lo = val % 0x10;
                         ret[len++] = '%';
@@ -1150,9 +1204,9 @@ char *uri_to_string(URI *uri)
                 if ((IS_UNRESERVED(*(p))) || ((*(p) == '$')) ||
                     ((*(p) == ',')) || ((*(p) == ';')) || ((*(p) == ':')) ||
                     ((*(p) == '@')) || ((*(p) == '&')) || ((*(p) == '=')) ||
-                    ((*(p) == '+')))
+                    ((*(p) == '+'))) {
                     ret[len++] = *p++;
-                else {
+                } else {
                     int val = *(unsigned char *)p++;
                     int hi = val / 0x10, lo = val % 0x10;
                     ret[len++] = '%';
@@ -1194,9 +1248,9 @@ char *uri_to_string(URI *uri)
                 if ((IS_UNRESERVED(*(p))) || ((*(p) == '/')) ||
                     ((*(p) == ';')) || ((*(p) == '@')) || ((*(p) == '&')) ||
                     ((*(p) == '=')) || ((*(p) == '+')) || ((*(p) == '$')) ||
-                    ((*(p) == ',')))
+                    ((*(p) == ','))) {
                     ret[len++] = *p++;
-                else {
+                } else {
                     int val = *(unsigned char *)p++;
                     int hi = val / 0x10, lo = val % 0x10;
                     ret[len++] = '%';
@@ -1233,9 +1287,9 @@ char *uri_to_string(URI *uri)
                 temp = realloc2n(ret, &max);
                 ret = temp;
             }
-            if ((IS_UNRESERVED(*(p))) || (IS_RESERVED(*(p))))
+            if ((IS_UNRESERVED(*(p))) || (IS_RESERVED(*(p)))) {
                 ret[len++] = *p++;
-            else {
+            } else {
                 int val = *(unsigned char *)p++;
                 int hi = val / 0x10, lo = val % 0x10;
                 ret[len++] = '%';
@@ -1260,8 +1314,9 @@ char *uri_to_string(URI *uri)
  */
 static void uri_clean(URI *uri)
 {
-    if (uri == NULL)
+    if (uri == NULL) {
         return;
+    }
 
     g_free(uri->scheme);
     uri->scheme = NULL;
@@ -1314,17 +1369,20 @@ static int normalize_uri_path(char *path)
 {
     char *cur, *out;
 
-    if (path == NULL)
+    if (path == NULL) {
         return -1;
+    }
 
     /* Skip all initial "/" chars.  We want to get to the beginning of the
      * first non-empty segment.
      */
     cur = path;
-    while (cur[0] == '/')
+    while (cur[0] == '/') {
         ++cur;
-    if (cur[0] == '\0')
+    }
+    if (cur[0] == '\0') {
         return 0;
+    }
 
     /* Keep everything we've seen so far.  */
     out = cur;
@@ -1340,8 +1398,9 @@ static int normalize_uri_path(char *path)
         if ((cur[0] == '.') && (cur[1] == '/')) {
             cur += 2;
             /* '//' normalization should be done at this point too */
-            while (cur[0] == '/')
+            while (cur[0] == '/') {
                 cur++;
+            }
             continue;
         }
 
@@ -1349,18 +1408,21 @@ static int normalize_uri_path(char *path)
          * d) If the buffer string ends with "." as a complete path segment,
          *    that "." is removed.
          */
-        if ((cur[0] == '.') && (cur[1] == '\0'))
+        if ((cur[0] == '.') && (cur[1] == '\0')) {
             break;
+        }
 
         /* Otherwise keep the segment.  */
         while (cur[0] != '/') {
-            if (cur[0] == '\0')
+            if (cur[0] == '\0') {
                 goto done_cd;
+            }
             (out++)[0] = (cur++)[0];
         }
         /* nomalize // */
-        while ((cur[0] == '/') && (cur[1] == '/'))
+        while ((cur[0] == '/') && (cur[1] == '/')) {
             cur++;
+        }
 
         (out++)[0] = (cur++)[0];
     }
@@ -1369,10 +1431,12 @@ done_cd:
 
     /* Reset to the beginning of the first segment for the next sequence.  */
     cur = path;
-    while (cur[0] == '/')
+    while (cur[0] == '/') {
         ++cur;
-    if (cur[0] == '\0')
+    }
+    if (cur[0] == '\0') {
         return 0;
+    }
 
     /*
      * Analyze each segment in sequence for cases (e) and (f).
@@ -1401,14 +1465,16 @@ done_cd:
 
         /* Find the end of the current segment.  */
         segp = cur;
-        while ((segp[0] != '/') && (segp[0] != '\0'))
+        while ((segp[0] != '/') && (segp[0] != '\0')) {
             ++segp;
+        }
 
         /* If this is the last segment, we're done (we need at least two
          * segments to meet the criteria for the (e) and (f) cases).
          */
-        if (segp[0] == '\0')
+        if (segp[0] == '\0') {
             break;
+        }
 
         /* If the first segment is "..", or if the next segment _isn't_ "..",
          * keep this segment and try the next one.
@@ -1437,15 +1503,18 @@ done_cd:
         /* string will overlap, do not use strcpy */
         tmp = cur;
         segp += 3;
-        while ((*tmp++ = *segp++) != 0)
+        while ((*tmp++ = *segp++) != 0) {
             ;
+        }
 
         /* If there are no previous segments, then keep going from here.  */
         segp = cur;
-        while ((segp > path) && ((--segp)[0] == '/'))
+        while ((segp > path) && ((--segp)[0] == '/')) {
             ;
-        if (segp == path)
+        }
+        if (segp == path) {
             continue;
+        }
 
         /* "segp" is pointing to the end of a previous segment; find it's
          * start.  We need to back up to the previous segment and start
@@ -1455,8 +1524,9 @@ done_cd:
          * remove the "foo/..".
          */
         cur = segp;
-        while ((cur > path) && (cur[-1] != '/'))
+        while ((cur > path) && (cur[-1] != '/')) {
             --cur;
+        }
     }
     out[0] = '\0';
 
@@ -1479,8 +1549,9 @@ done_cd:
 
         if (cur != path) {
             out = path;
-            while (cur[0] != '\0')
+            while (cur[0] != '\0') {
                 (out++)[0] = (cur++)[0];
+            }
             out[0] = 0;
         }
     }
@@ -1491,8 +1562,9 @@ done_cd:
 static int is_hex(char c)
 {
     if (((c >= '0') && (c <= '9')) || ((c >= 'a') && (c <= 'f')) ||
-        ((c >= 'A') && (c <= 'F')))
+        ((c >= 'A') && (c <= 'F'))) {
         return 1;
+    }
     return 0;
 }
 
@@ -1515,35 +1587,41 @@ char *uri_string_unescape(const char *str, int len, char *target)
     char *ret, *out;
     const char *in;
 
-    if (str == NULL)
+    if (str == NULL) {
         return NULL;
-    if (len <= 0)
+    }
+    if (len <= 0) {
         len = strlen(str);
-    if (len < 0)
+    }
+    if (len < 0) {
         return NULL;
+    }
 
     if (target == NULL) {
         ret = g_malloc(len + 1);
-    } else
+    } else {
         ret = target;
+    }
     in = str;
     out = ret;
     while (len > 0) {
         if ((len > 2) && (*in == '%') && (is_hex(in[1])) && (is_hex(in[2]))) {
             in++;
-            if ((*in >= '0') && (*in <= '9'))
+            if ((*in >= '0') && (*in <= '9')) {
                 *out = (*in - '0');
-            else if ((*in >= 'a') && (*in <= 'f'))
+            } else if ((*in >= 'a') && (*in <= 'f')) {
                 *out = (*in - 'a') + 10;
-            else if ((*in >= 'A') && (*in <= 'F'))
+            } else if ((*in >= 'A') && (*in <= 'F')) {
                 *out = (*in - 'A') + 10;
+            }
             in++;
-            if ((*in >= '0') && (*in <= '9'))
+            if ((*in >= '0') && (*in <= '9')) {
                 *out = *out * 16 + (*in - '0');
-            else if ((*in >= 'a') && (*in <= 'f'))
+            } else if ((*in >= 'a') && (*in <= 'f')) {
                 *out = *out * 16 + (*in - 'a') + 10;
-            else if ((*in >= 'A') && (*in <= 'F'))
+            } else if ((*in >= 'A') && (*in <= 'F')) {
                 *out = *out * 16 + (*in - 'A') + 10;
+            }
             in++;
             len -= 3;
             out++;
@@ -1573,13 +1651,16 @@ char *uri_string_escape(const char *str, const char *list)
     const char *in;
     int len, out;
 
-    if (str == NULL)
+    if (str == NULL) {
         return NULL;
-    if (str[0] == 0)
+    }
+    if (str[0] == 0) {
         return g_strdup(str);
+    }
     len = strlen(str);
-    if (!(len > 0))
+    if (!(len > 0)) {
         return NULL;
+    }
 
     len += 20;
     ret = g_malloc(len);
@@ -1597,15 +1678,17 @@ char *uri_string_escape(const char *str, const char *list)
             unsigned char val;
             ret[out++] = '%';
             val = ch >> 4;
-            if (val <= 9)
+            if (val <= 9) {
                 ret[out++] = '0' + val;
-            else
+            } else {
                 ret[out++] = 'A' + val - 0xA;
+            }
             val = ch & 0xF;
-            if (val <= 9)
+            if (val <= 9) {
                 ret[out++] = '0' + val;
-            else
+            } else {
                 ret[out++] = 'A' + val - 0xA;
+            }
             in++;
         } else {
             ret[out++] = *in++;
@@ -1652,17 +1735,19 @@ char *uri_resolve(const char *uri, const char *base)
      *    as a reference to "." rather than as a synonym for the current
      *    URI.  Should we do that here?
      */
-    if (uri == NULL)
+    if (uri == NULL) {
         ret = -1;
-    else {
+    } else {
         if (*uri) {
             ref = uri_new();
             ret = uri_parse_into(ref, uri);
-        } else
+        } else {
             ret = 0;
+        }
     }
-    if (ret != 0)
+    if (ret != 0) {
         goto done;
+    }
     if ((ref != NULL) && (ref->scheme != NULL)) {
         /*
          * The URI is absolute don't modify.
@@ -1670,15 +1755,16 @@ char *uri_resolve(const char *uri, const char *base)
         val = g_strdup(uri);
         goto done;
     }
-    if (base == NULL)
+    if (base == NULL) {
         ret = -1;
-    else {
+    } else {
         bas = uri_new();
         ret = uri_parse_into(bas, base);
     }
     if (ret != 0) {
-        if (ref)
+        if (ref) {
             val = uri_to_string(ref);
+        }
         goto done;
     }
     if (ref == NULL) {
@@ -1707,9 +1793,9 @@ char *uri_resolve(const char *uri, const char *base)
     if ((ref->scheme == NULL) && (ref->path == NULL) &&
         ((ref->authority == NULL) && (ref->server == NULL))) {
         res->scheme = g_strdup(bas->scheme);
-        if (bas->authority != NULL)
+        if (bas->authority != NULL) {
             res->authority = g_strdup(bas->authority);
-        else if (bas->server != NULL) {
+        } else if (bas->server != NULL) {
             res->server = g_strdup(bas->server);
             res->user = g_strdup(bas->user);
             res->port = bas->port;
@@ -1747,9 +1833,9 @@ char *uri_resolve(const char *uri, const char *base)
      *    use an authority component.
      */
     if ((ref->authority != NULL) || (ref->server != NULL)) {
-        if (ref->authority != NULL)
+        if (ref->authority != NULL) {
             res->authority = g_strdup(ref->authority);
-        else {
+        } else {
             res->server = g_strdup(ref->server);
             res->user = g_strdup(ref->user);
             res->port = ref->port;
@@ -1757,9 +1843,9 @@ char *uri_resolve(const char *uri, const char *base)
         res->path = g_strdup(ref->path);
         goto step_7;
     }
-    if (bas->authority != NULL)
+    if (bas->authority != NULL) {
         res->authority = g_strdup(bas->authority);
-    else if (bas->server != NULL) {
+    } else if (bas->server != NULL) {
         res->server = g_strdup(bas->server);
         res->user = g_strdup(bas->user);
         res->port = bas->port;
@@ -1783,10 +1869,12 @@ char *uri_resolve(const char *uri, const char *base)
      * Allocate a buffer large enough for the result string.
      */
     len = 2; /* extra / and 0 */
-    if (ref->path != NULL)
+    if (ref->path != NULL) {
         len += strlen(ref->path);
-    if (bas->path != NULL)
+    }
+    if (bas->path != NULL) {
         len += strlen(bas->path);
+    }
     res->path = g_malloc(len);
     res->path[0] = 0;
 
@@ -1799,10 +1887,12 @@ char *uri_resolve(const char *uri, const char *base)
     out = 0;
     if (bas->path != NULL) {
         while (bas->path[cur] != 0) {
-            while ((bas->path[cur] != 0) && (bas->path[cur] != '/'))
+            while ((bas->path[cur] != 0) && (bas->path[cur] != '/')) {
                 cur++;
-            if (bas->path[cur] == 0)
+            }
+            if (bas->path[cur] == 0) {
                 break;
+            }
 
             cur++;
             while (out < cur) {
@@ -1822,8 +1912,9 @@ char *uri_resolve(const char *uri, const char *base)
         /*
          * Ensure the path includes a '/'
          */
-        if ((out == 0) && (bas->server != NULL))
+        if ((out == 0) && (bas->server != NULL)) {
             res->path[out++] = '/';
+        }
         while (ref->path[indx] != 0) {
             res->path[out++] = ref->path[indx++];
         }
@@ -1845,12 +1936,15 @@ step_7:
     val = uri_to_string(res);
 
 done:
-    if (ref != NULL)
+    if (ref != NULL) {
         uri_free(ref);
-    if (bas != NULL)
+    }
+    if (bas != NULL) {
         uri_free(bas);
-    if (res != NULL)
+    }
+    if (res != NULL) {
         uri_free(res);
+    }
     return val;
 }
 
@@ -1899,8 +1993,9 @@ char *uri_resolve_relative(const char *uri, const char *base)
     char *bptr, *uptr, *vptr;
     int remove_path = 0;
 
-    if ((uri == NULL) || (*uri == 0))
+    if ((uri == NULL) || (*uri == 0)) {
         return NULL;
+    }
 
     /*
      * First parse URI into a standard form
@@ -1909,10 +2004,12 @@ char *uri_resolve_relative(const char *uri, const char *base)
     /* If URI not already in "relative" form */
     if (uri[0] != '.') {
         ret = uri_parse_into(ref, uri);
-        if (ret != 0)
+        if (ret != 0) {
             goto done; /* Error in URI, return NULL */
-    } else
+        }
+    } else {
         ref->path = g_strdup(uri);
+    }
 
     /*
      * Next parse base into the same standard form
@@ -1924,10 +2021,12 @@ char *uri_resolve_relative(const char *uri, const char *base)
     bas = uri_new();
     if (base[0] != '.') {
         ret = uri_parse_into(bas, base);
-        if (ret != 0)
+        if (ret != 0) {
             goto done; /* Error in base, return NULL */
-    } else
+        }
+    } else {
         bas->path = g_strdup(base);
+    }
 
     /*
      * If the scheme / server on the URI differs from the base,
@@ -1962,8 +2061,9 @@ char *uri_resolve_relative(const char *uri, const char *base)
     if (bas->path == NULL) {
         if (ref->path != NULL) {
             uptr = ref->path;
-            if (*uptr == '/')
+            if (*uptr == '/') {
                 uptr++;
+            }
             /* exception characters from uri_to_string */
             val = uri_string_escape(uptr, "/;&=+$,");
         }
@@ -1972,8 +2072,9 @@ char *uri_resolve_relative(const char *uri, const char *base)
     bptr = bas->path;
     if (ref->path == NULL) {
         for (ix = 0; bptr[ix] != 0; ix++) {
-            if (bptr[ix] == '/')
+            if (bptr[ix] == '/') {
                 nbslash++;
+            }
         }
         uptr = NULL;
         len = 1; /* this is for a string terminator only */
@@ -1981,14 +2082,17 @@ char *uri_resolve_relative(const char *uri, const char *base)
         /*
          * Next we compare the two strings and find where they first differ
          */
-        if ((ref->path[pos] == '.') && (ref->path[pos + 1] == '/'))
+        if ((ref->path[pos] == '.') && (ref->path[pos + 1] == '/')) {
             pos += 2;
-        if ((*bptr == '.') && (bptr[1] == '/'))
+        }
+        if ((*bptr == '.') && (bptr[1] == '/')) {
             bptr += 2;
-        else if ((*bptr == '/') && (ref->path[pos] != '/'))
+        } else if ((*bptr == '/') && (ref->path[pos] != '/')) {
             bptr++;
-        while ((bptr[pos] == ref->path[pos]) && (bptr[pos] != 0))
+        }
+        while ((bptr[pos] == ref->path[pos]) && (bptr[pos] != 0)) {
             pos++;
+        }
 
         if (bptr[pos] == ref->path[pos]) {
             val = g_strdup("");
@@ -2000,13 +2104,16 @@ char *uri_resolve_relative(const char *uri, const char *base)
          * beginning of the "unique" suffix of URI
          */
         ix = pos;
-        if ((ref->path[ix] == '/') && (ix > 0))
+        if ((ref->path[ix] == '/') && (ix > 0)) {
             ix--;
-        else if ((ref->path[ix] == 0) && (ix > 1) && (ref->path[ix - 1] == '/'))
+        } else if ((ref->path[ix] == 0) && (ix > 1) &&
+                   (ref->path[ix - 1] == '/')) {
             ix -= 2;
+        }
         for (; ix > 0; ix--) {
-            if (ref->path[ix] == '/')
+            if (ref->path[ix] == '/') {
                 break;
+            }
         }
         if (ix == 0) {
             uptr = ref->path;
@@ -2020,17 +2127,19 @@ char *uri_resolve_relative(const char *uri, const char *base)
          */
         if (bptr[pos] != ref->path[pos]) { /* check for trivial URI == base */
             for (; bptr[ix] != 0; ix++) {
-                if (bptr[ix] == '/')
+                if (bptr[ix] == '/') {
                     nbslash++;
+                }
             }
         }
         len = strlen(uptr) + 1;
     }
 
     if (nbslash == 0) {
-        if (uptr != NULL)
+        if (uptr != NULL) {
             /* exception characters from uri_to_string */
-            val = uri_string_escape(uptr, "/;&=+$,");
+        }
+        val = uri_string_escape(uptr, "/;&=+$,");
         goto done;
     }
 
@@ -2075,12 +2184,15 @@ done:
     /*
      * Free the working variables
      */
-    if (remove_path != 0)
+    if (remove_path != 0) {
         ref->path = NULL;
-    if (ref != NULL)
+    }
+    if (ref != NULL) {
         uri_free(ref);
-    if (bas != NULL)
+    }
+    if (bas != NULL) {
         uri_free(bas);
+    }
 
     return val;
 }
@@ -2093,8 +2205,9 @@ struct QueryParams *query_params_new(int init_alloc)
 {
     struct QueryParams *ps;
 
-    if (init_alloc <= 0)
+    if (init_alloc <= 0) {
         init_alloc = 1;
+    }
 
     ps = g_new(QueryParams, 1);
     ps->n = 0;
@@ -2141,27 +2254,32 @@ struct QueryParams *query_params_parse(const char *query)
     const char *end, *eq;
 
     ps = query_params_new(0);
-    if (!query || query[0] == '\0')
+    if (!query || query[0] == '\0') {
         return ps;
+    }
 
     while (*query) {
         char *name = NULL, *value = NULL;
 
         /* Find the next separator, or end of the string. */
         end = strchr(query, '&');
-        if (!end)
+        if (!end) {
             end = strchr(query, ';');
-        if (!end)
+        }
+        if (!end) {
             end = query + strlen(query);
+        }
 
         /* Find the first '=' character between here and end. */
         eq = strchr(query, '=');
-        if (eq && eq >= end)
+        if (eq && eq >= end) {
             eq = NULL;
+        }
 
         /* Empty section (eg. "&&"). */
-        if (end == query)
+        if (end == query) {
             goto next;
+        }
 
         /* If there is no '=' character, then we have just "name"
          * and consistent with CGI.pm we assume value is "".
@@ -2180,8 +2298,9 @@ struct QueryParams *query_params_parse(const char *query)
         /* If the '=' character is at the beginning then we have
          * "=value" and consistent with CGI.pm we _ignore_ this.
          */
-        else if (query == eq)
+        else if (query == eq) {
             goto next;
+        }
 
         /* Otherwise it's "name=value". */
         else {
@@ -2196,8 +2315,9 @@ struct QueryParams *query_params_parse(const char *query)
 
     next:
         query = end;
-        if (*query)
+        if (*query) {
             query++; /* skip '&' separator */
+        }
     }
 
     return ps;
-- 
2.7.4
