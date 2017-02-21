Received: from eggs.gnu.org ([2001:4830:134:3::10]:55098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpE-0007Q4-GL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGp9-0008T6-CO
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGp9-0008Sb-3K
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:11 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A0863B717
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:13:46 +0100
Message-Id: <1487708048-2131-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487708048-2131-1-git-send-email-armbru@redhat.com>
References: <1487708048-2131-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/24] option: Assert value string isn't null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Plenty of code relies on QemuOpt member @str not being null, including
qemu_opts_print(), qemu_opts_to_qdict(), and callbacks passed to
qemu_opt_foreach().

Begs the question whether it can be null.  Only opt_set() creates
QemuOpt.  It sets member @str to its argument @value.  Passing null
for @value would plant a time bomb.  Callers:

* opts_do_parse() can't pass null.

* qemu_opt_set() passes its argument @value.  Callers:

  - qemu_opts_from_qdict_1() can't pass null

  - qemu_opts_set() passes its argument @value, but none of its
    callers pass null.

  - Many more outside qemu-option.c, but they shouldn't pass null,
    either.

Assert member @str isn't null, so that misuse is caught right away.

Simplify parse_option_bool(), parse_option_number() and
parse_option_size() accordingly.  Best viewed with whitespace changes
ignored.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/qemu-option.c | 89 ++++++++++++++++++++++++------------------------------
 1 file changed, 39 insertions(+), 50 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index d611946..9708668 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -128,17 +128,13 @@ int get_param_value(char *buf, int buf_size,
 static void parse_option_bool(const char *name, const char *value, bool *ret,
                               Error **errp)
 {
-    if (value != NULL) {
-        if (!strcmp(value, "on")) {
-            *ret = 1;
-        } else if (!strcmp(value, "off")) {
-            *ret = 0;
-        } else {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                       name, "'on' or 'off'");
-        }
-    } else {
+    if (!strcmp(value, "on")) {
         *ret = 1;
+    } else if (!strcmp(value, "off")) {
+        *ret = 0;
+    } else {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   name, "'on' or 'off'");
     }
 }
 
@@ -148,16 +144,12 @@ static void parse_option_number(const char *name, const char *value,
     char *postfix;
     uint64_t number;
 
-    if (value != NULL) {
-        number = strtoull(value, &postfix, 0);
-        if (*postfix != '\0') {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name, "a number");
-            return;
-        }
-        *ret = number;
-    } else {
+    number = strtoull(value, &postfix, 0);
+    if (*postfix != '\0') {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name, "a number");
+        return;
     }
+    *ret = number;
 }
 
 static const QemuOptDesc *find_desc_by_name(const QemuOptDesc *desc,
@@ -180,39 +172,35 @@ void parse_option_size(const char *name, const char *value,
     char *postfix;
     double sizef;
 
-    if (value != NULL) {
-        sizef = strtod(value, &postfix);
-        if (sizef < 0 || sizef > UINT64_MAX) {
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
-                             "a non-negative number below 2^64");
-            return;
-        }
-        switch (*postfix) {
-        case 'T':
-            sizef *= 1024;
-            /* fall through */
-        case 'G':
-            sizef *= 1024;
-            /* fall through */
-        case 'M':
-            sizef *= 1024;
-            /* fall through */
-        case 'K':
-        case 'k':
-            sizef *= 1024;
-            /* fall through */
-        case 'b':
-        case '\0':
-            *ret = (uint64_t) sizef;
-            break;
-        default:
-            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name, "a size");
-            error_append_hint(errp, "You may use k, M, G or T suffixes for "
-                    "kilobytes, megabytes, gigabytes and terabytes.\n");
-            return;
-        }
-    } else {
+    sizef = strtod(value, &postfix);
+    if (sizef < 0 || sizef > UINT64_MAX) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
+                   "a non-negative number below 2^64");
+        return;
+    }
+    switch (*postfix) {
+    case 'T':
+        sizef *= 1024;
+        /* fall through */
+    case 'G':
+        sizef *= 1024;
+        /* fall through */
+    case 'M':
+        sizef *= 1024;
+        /* fall through */
+    case 'K':
+    case 'k':
+        sizef *= 1024;
+        /* fall through */
+    case 'b':
+    case '\0':
+        *ret = (uint64_t) sizef;
+        break;
+    default:
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name, "a size");
+        error_append_hint(errp, "You may use k, M, G or T suffixes for "
+                          "kilobytes, megabytes, gigabytes and terabytes.\n");
+        return;
     }
 }
 
@@ -566,6 +554,7 @@ static void opt_set(QemuOpts *opts, const char *name, const char *value,
     }
     opt->desc = desc;
     opt->str = g_strdup(value);
+    assert(opt->str);
     qemu_opt_parse(opt, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.7.4
