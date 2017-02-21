Received: from eggs.gnu.org ([2001:4830:134:3::10]:55037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpC-0007Pr-JW
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgGpB-0008UF-1u
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgGpA-0008Tb-PS
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 15:14:12 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DA344E05F
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 20:14:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 21:13:49 +0100
Message-Id: <1487708048-2131-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1487708048-2131-1-git-send-email-armbru@redhat.com>
References: <1487708048-2131-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/24] util/cutils: Rewrite documentation of
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 util/cutils.c | 80 +++++++++++++++++++++++++++++++++--------------------=
------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index 4fefcf3..1ae2a08 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -265,9 +265,6 @@ int64_t qemu_strtosz(const char *nptr, char **end)
 static int check_strtox_error(const char *p, char *endptr, const char **=
next,
                               int err)
 {
-    /* If no conversion was performed, prefer BSD behavior over glibc
-     * behavior.
-     */
     if (err =3D=3D 0 && endptr =3D=3D p) {
         err =3D EINVAL;
     }
@@ -281,30 +278,28 @@ static int check_strtox_error(const char *p, char *=
endptr, const char **next,
 }
=20
 /**
- * QEMU wrappers for strtol(), strtoll(), strtoul(), strotull() C functi=
ons.
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
@@ -325,17 +320,29 @@ int qemu_strtol(const char *nptr, const char **endp=
tr, int base,
 }
=20
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
@@ -360,9 +367,10 @@ int qemu_strtoul(const char *nptr, const char **endp=
tr, int base,
 }
=20
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
@@ -376,6 +384,7 @@ int qemu_strtoll(const char *nptr, const char **endpt=
r, int base,
         err =3D -EINVAL;
     } else {
         errno =3D 0;
+        /* FIXME This assumes int64_t is long long */
         *result =3D strtoll(nptr, &p, base);
         err =3D check_strtox_error(nptr, p, endptr, errno);
     }
@@ -383,9 +392,9 @@ int qemu_strtoll(const char *nptr, const char **endpt=
r, int base,
 }
=20
 /**
- * Converts ASCII string to an unsigned long long integer.
+ * Convert string @nptr to an uint64_t.
  *
- * See qemu_strtol() documentation for more info.
+ * Works like qemu_strtoul(), except it stores UINT64_MAX on overflow.
  */
 int qemu_strtoull(const char *nptr, const char **endptr, int base,
                   uint64_t *result)
@@ -399,6 +408,7 @@ int qemu_strtoull(const char *nptr, const char **endp=
tr, int base,
         err =3D -EINVAL;
     } else {
         errno =3D 0;
+        /* FIXME This assumes uint64_t is unsigned long long */
         *result =3D strtoull(nptr, &p, base);
         /* Windows returns 1 for negative out-of-range values.  */
         if (errno =3D=3D ERANGE) {
--=20
2.7.4
