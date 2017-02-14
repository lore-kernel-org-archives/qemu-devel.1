Received: from eggs.gnu.org ([2001:4830:134:3::10]:38769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJP-0005qn-Ay
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJM-0003MM-FE
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJM-0003LP-5j
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:16 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 597FA3D956
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1EAQEMB024036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:26:15 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:25:55 +0100
Message-Id: <1487067971-10443-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 08/24] util/cutils: Clean up control flow
 around qemu_strtol() a bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reorder check_strtox_error() to make it obvious that we always store
through a non-null @endptr.

Transform

    if (some error) {
        error case ...
        err = value for error case;
    } else {
        normal case ...
        err = value for normal case;
    }
    return err;

to

    if (some error) {
        error case ...
        return value for error case;
    }
    normal case ...
    return value for normal case;

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/cutils.c | 89 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index 7d165bc..7442d46 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -265,15 +265,20 @@ int64_t qemu_strtosz(const char *nptr, char **end)
 static int check_strtox_error(const char *nptr, char *ep,
                               const char **endptr, int eno)
 {
-    if (eno == 0 && ep == nptr) {
-        eno = EINVAL;
-    }
-    if (!endptr && *ep) {
-        return -EINVAL;
-    }
     if (endptr) {
         *endptr = ep;
     }
+
+    /* Turn "no conversion" into an error */
+    if (eno == 0 && ep == nptr) {
+        return -EINVAL;
+    }
+
+    /* Fail when we're expected to consume the string, but didn't */
+    if (!endptr && *ep) {
+        return -EINVAL;
+    }
+
     return -eno;
 }
 
@@ -305,18 +310,17 @@ int qemu_strtol(const char *nptr, const char **endptr, int base,
                 long *result)
 {
     char *ep;
-    int err = 0;
+
     if (!nptr) {
         if (endptr) {
             *endptr = nptr;
         }
-        err = -EINVAL;
-    } else {
-        errno = 0;
-        *result = strtol(nptr, &ep, base);
-        err = check_strtox_error(nptr, ep, endptr, errno);
+        return -EINVAL;
     }
-    return err;
+
+    errno = 0;
+    *result = strtol(nptr, &ep, base);
+    return check_strtox_error(nptr, ep, endptr, errno);
 }
 
 /**
@@ -348,22 +352,21 @@ int qemu_strtoul(const char *nptr, const char **endptr, int base,
                  unsigned long *result)
 {
     char *ep;
-    int err = 0;
+
     if (!nptr) {
         if (endptr) {
             *endptr = nptr;
         }
-        err = -EINVAL;
-    } else {
-        errno = 0;
-        *result = strtoul(nptr, &ep, base);
-        /* Windows returns 1 for negative out-of-range values.  */
-        if (errno == ERANGE) {
-            *result = -1;
-        }
-        err = check_strtox_error(nptr, ep, endptr, errno);
+        return -EINVAL;
     }
-    return err;
+
+    errno = 0;
+    *result = strtoul(nptr, &ep, base);
+    /* Windows returns 1 for negative out-of-range values.  */
+    if (errno == ERANGE) {
+        *result = -1;
+    }
+    return check_strtox_error(nptr, ep, endptr, errno);
 }
 
 /**
@@ -376,19 +379,18 @@ int qemu_strtoi64(const char *nptr, const char **endptr, int base,
                  int64_t *result)
 {
     char *ep;
-    int err = 0;
+
     if (!nptr) {
         if (endptr) {
             *endptr = nptr;
         }
-        err = -EINVAL;
-    } else {
-        errno = 0;
-        /* FIXME This assumes int64_t is long long */
-        *result = strtoll(nptr, &ep, base);
-        err = check_strtox_error(nptr, ep, endptr, errno);
+        return -EINVAL;
     }
-    return err;
+
+    errno = 0;
+    /* FIXME This assumes int64_t is long long */
+    *result = strtoll(nptr, &ep, base);
+    return check_strtox_error(nptr, ep, endptr, errno);
 }
 
 /**
@@ -400,23 +402,22 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
                   uint64_t *result)
 {
     char *ep;
-    int err = 0;
+
     if (!nptr) {
         if (endptr) {
             *endptr = nptr;
         }
-        err = -EINVAL;
-    } else {
-        errno = 0;
-        /* FIXME This assumes uint64_t is unsigned long long */
-        *result = strtoull(nptr, &ep, base);
-        /* Windows returns 1 for negative out-of-range values.  */
-        if (errno == ERANGE) {
-            *result = -1;
-        }
-        err = check_strtox_error(nptr, ep, endptr, errno);
+        return -EINVAL;
     }
-    return err;
+
+    errno = 0;
+    /* FIXME This assumes uint64_t is unsigned long long */
+    *result = strtoull(nptr, &ep, base);
+    /* Windows returns 1 for negative out-of-range values.  */
+    if (errno == ERANGE) {
+        *result = -1;
+    }
+    return check_strtox_error(nptr, ep, endptr, errno);
 }
 
 /**
-- 
2.7.4
