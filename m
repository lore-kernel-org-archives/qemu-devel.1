Received: from eggs.gnu.org ([2001:4830:134:3::10]:38829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJQ-0005qt-IG
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJM-0003MW-GW
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJM-0003LG-5e
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:16 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C31061D2B
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1EAQEOD003172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:26:15 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:25:54 +0100
Message-Id: <1487067971-10443-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/24] util/cutils: Clean up variable names
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
  latter to @eno.

Same for qemu_strtoul(), qemu_strtoi64(), qemu_strtou64(), of course.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/cutils.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index 0dc9b28..7d165bc 100644
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
+                              const char **endptr, int eno)
 {
-    if (err == 0 && endptr == p) {
-        err = EINVAL;
+    if (eno == 0 && ep == nptr) {
+        eno = EINVAL;
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
+    return -eno;
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
