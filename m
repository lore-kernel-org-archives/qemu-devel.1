Received: from eggs.gnu.org ([2001:4830:134:3::10]:55102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpE-0007Q9-N1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpB-0008UJ-2e
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGpA-0008TX-Qs
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:13 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BC3B61BAC
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:13:51 +0100
Message-Id: <1487708048-2131-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1487708048-2131-1-git-send-email-armbru@redhat.com>
References: <1487708048-2131-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/24] util/cutils: Clean up variable names
 around qemu_strtol()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Name same things the same, different things differently.

* qemu_strtol()'s parameter @nptr is called @p in
  check_strtox_error().  Rename the latter.

* qemu_strtol()'s parameter @endptr is called @next in
  check_strtox_error().  Rename the latter.

* qemu_strtol()'s variable @p is called @endptr in
  check_strtox_error().  Rename both to @ep.

* qemu_strtol()'s variable @err is *negative* errno,
  check_strtox_error()'s parameter @err is *positive*.  Rename the
  latter to @libc_errno.

Same for qemu_strtoul(), qemu_strtoi64(), qemu_strtou64(), of course.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/cutils.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index 0dc9b28..0fb0f82 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -260,21 +260,21 @@ int64_t qemu_strtosz(const char *nptr, char **end)
 }
 
 /**
- * Helper function for qemu_strto*l() functions.
+ * Helper function for error checking after strtol() and the like
  */
-static int check_strtox_error(const char *p, char *endptr, const char **next,
-                              int err)
+static int check_strtox_error(const char *nptr, char *ep,
+                              const char **endptr, int libc_errno)
 {
-    if (err == 0 && endptr == p) {
-        err = EINVAL;
+    if (libc_errno == 0 && ep == nptr) {
+        libc_errno = EINVAL;
     }
-    if (!next && *endptr) {
+    if (!endptr && *ep) {
         return -EINVAL;
     }
-    if (next) {
-        *next = endptr;
+    if (endptr) {
+        *endptr = ep;
     }
-    return -err;
+    return -libc_errno;
 }
 
 /**
@@ -304,7 +304,7 @@ static int check_strtox_error(const char *p, char *endptr, const char **next,
 int qemu_strtol(const char *nptr, const char **endptr, int base,
                 long *result)
 {
-    char *p;
+    char *ep;
     int err = 0;
     if (!nptr) {
         if (endptr) {
@@ -313,8 +313,8 @@ int qemu_strtol(const char *nptr, const char **endptr, int base,
         err = -EINVAL;
     } else {
         errno = 0;
-        *result = strtol(nptr, &p, base);
-        err = check_strtox_error(nptr, p, endptr, errno);
+        *result = strtol(nptr, &ep, base);
+        err = check_strtox_error(nptr, ep, endptr, errno);
     }
     return err;
 }
@@ -347,7 +347,7 @@ int qemu_strtol(const char *nptr, const char **endptr, int base,
 int qemu_strtoul(const char *nptr, const char **endptr, int base,
                  unsigned long *result)
 {
-    char *p;
+    char *ep;
     int err = 0;
     if (!nptr) {
         if (endptr) {
@@ -356,12 +356,12 @@ int qemu_strtoul(const char *nptr, const char **endptr, int base,
         err = -EINVAL;
     } else {
         errno = 0;
-        *result = strtoul(nptr, &p, base);
+        *result = strtoul(nptr, &ep, base);
         /* Windows returns 1 for negative out-of-range values.  */
         if (errno == ERANGE) {
             *result = -1;
         }
-        err = check_strtox_error(nptr, p, endptr, errno);
+        err = check_strtox_error(nptr, ep, endptr, errno);
     }
     return err;
 }
@@ -375,7 +375,7 @@ int qemu_strtoul(const char *nptr, const char **endptr, int base,
 int qemu_strtoi64(const char *nptr, const char **endptr, int base,
                  int64_t *result)
 {
-    char *p;
+    char *ep;
     int err = 0;
     if (!nptr) {
         if (endptr) {
@@ -385,8 +385,8 @@ int qemu_strtoi64(const char *nptr, const char **endptr, int base,
     } else {
         errno = 0;
         /* FIXME This assumes int64_t is long long */
-        *result = strtoll(nptr, &p, base);
-        err = check_strtox_error(nptr, p, endptr, errno);
+        *result = strtoll(nptr, &ep, base);
+        err = check_strtox_error(nptr, ep, endptr, errno);
     }
     return err;
 }
@@ -399,7 +399,7 @@ int qemu_strtoi64(const char *nptr, const char **endptr, int base,
 int qemu_strtou64(const char *nptr, const char **endptr, int base,
                   uint64_t *result)
 {
-    char *p;
+    char *ep;
     int err = 0;
     if (!nptr) {
         if (endptr) {
@@ -409,12 +409,12 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
     } else {
         errno = 0;
         /* FIXME This assumes uint64_t is unsigned long long */
-        *result = strtoull(nptr, &p, base);
+        *result = strtoull(nptr, &ep, base);
         /* Windows returns 1 for negative out-of-range values.  */
         if (errno == ERANGE) {
             *result = -1;
         }
-        err = check_strtox_error(nptr, p, endptr, errno);
+        err = check_strtox_error(nptr, ep, endptr, errno);
     }
     return err;
 }
-- 
2.7.4
