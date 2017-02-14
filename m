Received: from eggs.gnu.org ([2001:4830:134:3::10]:38737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJO-0005qi-IR
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJM-0003Ly-Aj
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJM-0003L5-0G
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:16 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CB933A768D
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C0A8FACB84
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:25:52 +0100
Message-Id: <1487067971-10443-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 05/24] util/cutils: Rewrite documentation of
 qemu_strtol() & friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fixes the following documentation bugs:

* Fails to document that null @nptr is safe.

* Fails to document that we return -EINVAL when no conversion could be
  performed (commit 47d4be1).

* Confuses long long with int64_t, and unsigned long long with
  uint64_t.

* Claims the unsigned conversions can underflow.  They can't.

While there, mark problematic assumptions that int64_t is long long,
and uint64_t is unsigned long long with FIXME comments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/cutils.c | 80 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index 4fefcf3..1ae2a08 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -265,9 +265,6 @@ int64_t qemu_strtosz(const char *nptr, char **end)
 static int check_strtox_error(const char *p, char *endptr, const char **next,
                               int err)
 {
-    /* If no conversion was performed, prefer BSD behavior over glibc
-     * behavior.
-     */
     if (err == 0 && endptr == p) {
         err = EINVAL;
     }
@@ -281,30 +278,28 @@ static int check_strtox_error(const char *p, char *endptr, const char **next,
 }
 
 /**
- * QEMU wrappers for strtol(), strtoll(), strtoul(), strotull() C functions.
+ * Convert string @nptr to a long integer, and store it in @result.
  *
- * Convert ASCII string @nptr to a long integer value
- * from the given @base. Parameters @nptr, @endptr, @base
- * follows same semantics as strtol() C function.
+ * This is a wrapper around strtol() that is harder to misuse.
+ * Semantics of @nptr, @endptr, @base match strtol() with differences
+ * noted below.
  *
- * Unlike from strtol() function, if @endptr is not NULL, this
- * function will return -EINVAL whenever it cannot fully convert
- * the string in @nptr with given @base to a long. This function returns
- * the result of the conversion only through the @result parameter.
+ * @nptr may be null, and no conversion is performed then.
  *
- * If NULL is passed in @endptr, then the whole string in @ntpr
- * is a number otherwise it returns -EINVAL.
+ * If no conversion is performed, store @nptr in *@endptr and return
+ * -EINVAL.
  *
- * RETURN VALUE
- * Unlike from strtol() function, this wrapper returns either
- * -EINVAL or the errno set by strtol() function (e.g -ERANGE).
- * If the conversion overflows, -ERANGE is returned, and @result
- * is set to the max value of the desired type
- * (e.g. LONG_MAX, LLONG_MAX, ULONG_MAX, ULLONG_MAX). If the case
- * of underflow, -ERANGE is returned, and @result is set to the min
- * value of the desired type. For strtol(), strtoll(), @result is set to
- * LONG_MIN, LLONG_MIN, respectively, and for strtoul(), strtoull() it
- * is set to 0.
+ * If @endptr is null, and the string isn't fully converted, return
+ * -EINVAL.  This is the case when the pointer that would be stored in
+ * a non-null @endptr points to a character other than '\0'.
+ *
+ * If the conversion overflows @result, store LONG_MAX in @result,
+ * and return -ERANGE.
+ *
+ * If the conversion underflows @result, store LONG_MIN in @result,
+ * and return -ERANGE.
+ *
+ * Else store the converted value in @result, and return zero.
  */
 int qemu_strtol(const char *nptr, const char **endptr, int base,
                 long *result)
@@ -325,17 +320,29 @@ int qemu_strtol(const char *nptr, const char **endptr, int base,
 }
 
 /**
- * Converts ASCII string to an unsigned long integer.
+ * Convert string @nptr to an unsigned long, and store it in @result.
  *
- * If string contains a negative number, value will be converted to
- * the unsigned representation of the signed value, unless the original
- * (nonnegated) value would overflow, in this case, it will set @result
- * to ULONG_MAX, and return ERANGE.
+ * This is a wrapper around strtoul() that is harder to misuse.
+ * Semantics of @nptr, @endptr, @base match strtoul() with differences
+ * noted below.
  *
- * The same behavior holds, for qemu_strtoull() but sets @result to
- * ULLONG_MAX instead of ULONG_MAX.
+ * @nptr may be null, and no conversion is performed then.
  *
- * See qemu_strtol() documentation for more info.
+ * If no conversion is performed, store @nptr in *@endptr and return
+ * -EINVAL.
+ *
+ * If @endptr is null, and the string isn't fully converted, return
+ * -EINVAL.  This is the case when the pointer that would be stored in
+ * a non-null @endptr points to a character other than '\0'.
+ *
+ * If the conversion overflows @result, store ULONG_MAX in @result,
+ * and return -ERANGE.
+ *
+ * Else store the converted value in @result, and return zero.
+ *
+ * Note that a number with a leading minus sign gets converted without
+ * the minus sign, checked for overflow (see above), then negated (in
+ * @result's type).  This is exactly how strtoul() works.
  */
 int qemu_strtoul(const char *nptr, const char **endptr, int base,
                  unsigned long *result)
@@ -360,9 +367,10 @@ int qemu_strtoul(const char *nptr, const char **endptr, int base,
 }
 
 /**
- * Converts ASCII string to a long long integer.
+ * Convert string @nptr to an int64_t.
  *
- * See qemu_strtol() documentation for more info.
+ * Works like qemu_strtol(), except it stores INT64_MAX on overflow,
+ * and INT_MIN on underflow.
  */
 int qemu_strtoll(const char *nptr, const char **endptr, int base,
                  int64_t *result)
@@ -376,6 +384,7 @@ int qemu_strtoll(const char *nptr, const char **endptr, int base,
         err = -EINVAL;
     } else {
         errno = 0;
+        /* FIXME This assumes int64_t is long long */
         *result = strtoll(nptr, &p, base);
         err = check_strtox_error(nptr, p, endptr, errno);
     }
@@ -383,9 +392,9 @@ int qemu_strtoll(const char *nptr, const char **endptr, int base,
 }
 
 /**
- * Converts ASCII string to an unsigned long long integer.
+ * Convert string @nptr to an uint64_t.
  *
- * See qemu_strtol() documentation for more info.
+ * Works like qemu_strtoul(), except it stores UINT64_MAX on overflow.
  */
 int qemu_strtoull(const char *nptr, const char **endptr, int base,
                   uint64_t *result)
@@ -399,6 +408,7 @@ int qemu_strtoull(const char *nptr, const char **endptr, int base,
         err = -EINVAL;
     } else {
         errno = 0;
+        /* FIXME This assumes uint64_t is unsigned long long */
         *result = strtoull(nptr, &p, base);
         /* Windows returns 1 for negative out-of-range values.  */
         if (errno == ERANGE) {
-- 
2.7.4
