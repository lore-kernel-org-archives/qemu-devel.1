Received: from eggs.gnu.org ([209.51.188.92]:45898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqlXr-0004q0-D6
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqlXn-0002EE-8g
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 16:12:47 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Feb 2019 22:12:04 +0100
Message-Id: <20190204211204.27321-4-philmd@redhat.com>
In-Reply-To: <20190204211204.27321-1-philmd@redhat.com>
References: <20190204211204.27321-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/3] util/cutils: Move function
 documentations to the header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Stefano Garzarella <sgarzare@redhat.com>

Many functions have documentation before the implementation in
cutils.c. Since we expect documentation around the prototype
declaration in headers, move the comments in cutils.h.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/qemu/cutils.h | 224 ++++++++++++++++++++++++++++++++++++++++++
 util/cutils.c         | 185 ----------------------------------
 2 files changed, 224 insertions(+), 185 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 644f2d75bd..f41b00ad37 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -47,6 +47,7 @@
  *    bytes and then add a NUL
  */
 void pstrcpy(char *buf, int buf_size, const char *str);
+
 /**
  * strpadcpy:
  * @buf: buffer to copy string into
@@ -60,6 +61,7 @@ void pstrcpy(char *buf, int buf_size, const char *str);
  * first @buf_size characters of @str, with no terminator.
  */
 void strpadcpy(char *buf, int buf_size, const char *str, char pad);
+
 /**
  * pstrcat:
  * @buf: buffer containing existing string
@@ -77,6 +79,7 @@ void strpadcpy(char *buf, int buf_size, const char *str=
, char pad);
  * Returns: @buf.
  */
 char *pstrcat(char *buf, int buf_size, const char *s);
+
 /**
  * strstart:
  * @str: string to test
@@ -94,6 +97,7 @@ char *pstrcat(char *buf, int buf_size, const char *s);
  * Returns: true if @str starts with prefix @val, false otherwise.
  */
 int strstart(const char *str, const char *val, const char **ptr);
+
 /**
  * stristart:
  * @str: string to test
@@ -110,6 +114,7 @@ int strstart(const char *str, const char *val, const =
char **ptr);
  *          false otherwise.
  */
 int stristart(const char *str, const char *val, const char **ptr);
+
 /**
  * qemu_strnlen:
  * @s: string
@@ -126,6 +131,7 @@ int stristart(const char *str, const char *val, const=
 char **ptr);
  * Returns: length of @s in bytes, or @max_len, whichever is smaller.
  */
 int qemu_strnlen(const char *s, int max_len);
+
 /**
  * qemu_strsep:
  * @input: pointer to string to parse
@@ -147,6 +153,16 @@ int qemu_strnlen(const char *s, int max_len);
  * Returns: the pointer originally in @input.
  */
 char *qemu_strsep(char **input, const char *delim);
+
+/**
+ * qemu_strchrnul:
+ *
+ * @s: String to parse.
+ * @c: Character to find.
+ *
+ * Searches for the first occurrence of @c in @s, and returns a pointer
+ * to the trailing null byte if none was found.
+ */
 #ifdef HAVE_STRCHRNUL
 static inline const char *qemu_strchrnul(const char *s, int c)
 {
@@ -155,27 +171,235 @@ static inline const char *qemu_strchrnul(const cha=
r *s, int c)
 #else
 const char *qemu_strchrnul(const char *s, int c);
 #endif
+
 time_t mktimegm(struct tm *tm);
 int qemu_fdatasync(int fd);
 int fcntl_setfl(int fd, int flag);
 int qemu_parse_fd(const char *param);
+
+/**
+ * qemu_strtoi:
+ *
+ * Convert string @nptr to an integer, and store it in @result.
+ *
+ * This is a wrapper around strtol() that is harder to misuse.
+ * Semantics of @nptr, @endptr, @base match strtol() with differences
+ * noted below.
+ *
+ * @nptr may be null, and no conversion is performed then.
+ *
+ * If no conversion is performed, store @nptr in *@endptr and return
+ * -EINVAL.
+ *
+ * If @endptr is null, and the string isn't fully converted, return
+ * -EINVAL.  This is the case when the pointer that would be stored in
+ * a non-null @endptr points to a character other than '\0'.
+ *
+ * If the conversion overflows @result, store INT_MAX in @result,
+ * and return -ERANGE.
+ *
+ * If the conversion underflows @result, store INT_MIN in @result,
+ * and return -ERANGE.
+ *
+ * Else store the converted value in @result, and return zero.
+ */
 int qemu_strtoi(const char *nptr, const char **endptr, int base,
                 int *result);
+
+/**
+ * qemu_strtoui:
+ *
+ * Convert string @nptr to an unsigned integer, and store it in @result.
+ *
+ * This is a wrapper around strtoul() that is harder to misuse.
+ * Semantics of @nptr, @endptr, @base match strtoul() with differences
+ * noted below.
+ *
+ * @nptr may be null, and no conversion is performed then.
+ *
+ * If no conversion is performed, store @nptr in *@endptr and return
+ * -EINVAL.
+ *
+ * If @endptr is null, and the string isn't fully converted, return
+ * -EINVAL.  This is the case when the pointer that would be stored in
+ * a non-null @endptr points to a character other than '\0'.
+ *
+ * If the conversion overflows @result, store UINT_MAX in @result,
+ * and return -ERANGE.
+ *
+ * Else store the converted value in @result, and return zero.
+ *
+ * Note that a number with a leading minus sign gets converted without
+ * the minus sign, checked for overflow (see above), then negated (in
+ * @result's type).  This is exactly how strtoul() works.
+ */
 int qemu_strtoui(const char *nptr, const char **endptr, int base,
                  unsigned int *result);
+
+/**
+ * qemu_strtol:
+ *
+ * Convert string @nptr to a long integer, and store it in @result.
+ *
+ * This is a wrapper around strtol() that is harder to misuse.
+ * Semantics of @nptr, @endptr, @base match strtol() with differences
+ * noted below.
+ *
+ * @nptr may be null, and no conversion is performed then.
+ *
+ * If no conversion is performed, store @nptr in *@endptr and return
+ * -EINVAL.
+ *
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
+ */
 int qemu_strtol(const char *nptr, const char **endptr, int base,
                 long *result);
+
+/**
+ * qemu_strtoul:
+ *
+ * Convert string @nptr to an unsigned long, and store it in @result.
+ *
+ * This is a wrapper around strtoul() that is harder to misuse.
+ * Semantics of @nptr, @endptr, @base match strtoul() with differences
+ * noted below.
+ *
+ * @nptr may be null, and no conversion is performed then.
+ *
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
+ */
+
 int qemu_strtoul(const char *nptr, const char **endptr, int base,
                  unsigned long *result);
+
+/**
+ * qemu_strtoi64:
+ *
+ * Convert string @nptr to an int64_t.
+ *
+ * Works like qemu_strtol(), except it stores INT64_MAX on overflow,
+ * and INT_MIN on underflow.
+ */
 int qemu_strtoi64(const char *nptr, const char **endptr, int base,
                   int64_t *result);
+
+/**
+ * qemu_strtou64:
+ *
+ * Convert string @nptr to an uint64_t.
+ *
+ * Works like qemu_strtoul(), except it stores UINT64_MAX on overflow.
+ */
 int qemu_strtou64(const char *nptr, const char **endptr, int base,
                   uint64_t *result);
+
+/**
+ * qemu_strtod:
+ *
+ * Convert string @nptr to a double.
+ *
+ * This is a wrapper around strtod() that is harder to misuse.
+ * Semantics of @nptr and @endptr match strtod() with differences
+ * noted below.
+ *
+ * @nptr may be null, and no conversion is performed then.
+ *
+ * If no conversion is performed, store @nptr in *@endptr and return
+ * -EINVAL.
+ *
+ * If @endptr is null, and the string isn't fully converted, return
+ * -EINVAL. This is the case when the pointer that would be stored in
+ * a non-null @endptr points to a character other than '\0'.
+ *
+ * If the conversion overflows, store +/-HUGE_VAL in @result, depending
+ * on the sign, and return -ERANGE.
+ *
+ * If the conversion underflows, store +/-0.0 in @result, depending on t=
he
+ * sign, and return -ERANGE.
+ *
+ * Else store the converted value in @result, and return zero.
+ */
 int qemu_strtod(const char *nptr, const char **endptr, double *result);
+
+/**
+ * qemu_strtod_finite:
+ *
+ * Convert string @nptr to a finite double.
+ *
+ * Works like qemu_strtod(), except that "NaN" and "inf" are rejected
+ * with -EINVAL and no conversion is performed.
+ */
 int qemu_strtod_finite(const char *nptr, const char **endptr, double *re=
sult);
=20
+/**
+ * parse_uint:
+ *
+ * @s: String to parse
+ * @value: Destination for parsed integer value
+ * @endptr: Destination for pointer to first character not consumed
+ * @base: integer base, between 2 and 36 inclusive, or 0
+ *
+ * Parse unsigned integer
+ *
+ * Parsed syntax is like strtoull()'s: arbitrary whitespace, a single op=
tional
+ * '+' or '-', an optional "0x" if @base is 0 or 16, one or more digits.
+ *
+ * If @s is null, or @base is invalid, or @s doesn't start with an
+ * integer in the syntax above, set *@value to 0, *@endptr to @s, and
+ * return -EINVAL.
+ *
+ * Set *@endptr to point right beyond the parsed integer (even if the in=
teger
+ * overflows or is negative, all digits will be parsed and *@endptr will
+ * point right beyond them).
+ *
+ * If the integer is negative, set *@value to 0, and return -ERANGE.
+ *
+ * If the integer overflows unsigned long long, set *@value to
+ * ULLONG_MAX, and return -ERANGE.
+ *
+ * Else, set *@value to the parsed integer, and return 0.
+ */
 int parse_uint(const char *s, unsigned long long *value, char **endptr,
                int base);
+
+/**
+ * parse_uint_full:
+ *
+ * @s: String to parse
+ * @value: Destination for parsed integer value
+ * @base: integer base, between 2 and 36 inclusive, or 0
+ *
+ * Parse unsigned integer from entire string
+ *
+ * Have the same behavior of parse_uint(), but with an additional check
+ * for additional data after the parsed number. If extra characters are =
present
+ * after the parsed number, the function will return -EINVAL, and *@v wi=
ll
+ * be set to 0.
+ */
 int parse_uint_full(const char *s, unsigned long long *value, int base);
=20
 int qemu_strtosz(const char *nptr, const char **end, uint64_t *result);
diff --git a/util/cutils.c b/util/cutils.c
index a8a3a3ba3b..a4c8858712 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -296,30 +296,6 @@ static int check_strtox_error(const char *nptr, char=
 *ep,
     return -libc_errno;
 }
=20
-/**
- * Convert string @nptr to an integer, and store it in @result.
- *
- * This is a wrapper around strtol() that is harder to misuse.
- * Semantics of @nptr, @endptr, @base match strtol() with differences
- * noted below.
- *
- * @nptr may be null, and no conversion is performed then.
- *
- * If no conversion is performed, store @nptr in *@endptr and return
- * -EINVAL.
- *
- * If @endptr is null, and the string isn't fully converted, return
- * -EINVAL.  This is the case when the pointer that would be stored in
- * a non-null @endptr points to a character other than '\0'.
- *
- * If the conversion overflows @result, store INT_MAX in @result,
- * and return -ERANGE.
- *
- * If the conversion underflows @result, store INT_MIN in @result,
- * and return -ERANGE.
- *
- * Else store the converted value in @result, and return zero.
- */
 int qemu_strtoi(const char *nptr, const char **endptr, int base,
                 int *result)
 {
@@ -348,31 +324,6 @@ int qemu_strtoi(const char *nptr, const char **endpt=
r, int base,
     return check_strtox_error(nptr, ep, endptr, errno);
 }
=20
-/**
- * Convert string @nptr to an unsigned integer, and store it in @result.
- *
- * This is a wrapper around strtoul() that is harder to misuse.
- * Semantics of @nptr, @endptr, @base match strtoul() with differences
- * noted below.
- *
- * @nptr may be null, and no conversion is performed then.
- *
- * If no conversion is performed, store @nptr in *@endptr and return
- * -EINVAL.
- *
- * If @endptr is null, and the string isn't fully converted, return
- * -EINVAL.  This is the case when the pointer that would be stored in
- * a non-null @endptr points to a character other than '\0'.
- *
- * If the conversion overflows @result, store UINT_MAX in @result,
- * and return -ERANGE.
- *
- * Else store the converted value in @result, and return zero.
- *
- * Note that a number with a leading minus sign gets converted without
- * the minus sign, checked for overflow (see above), then negated (in
- * @result's type).  This is exactly how strtoul() works.
- */
 int qemu_strtoui(const char *nptr, const char **endptr, int base,
                  unsigned int *result)
 {
@@ -407,30 +358,6 @@ int qemu_strtoui(const char *nptr, const char **endp=
tr, int base,
     return check_strtox_error(nptr, ep, endptr, errno);
 }
=20
-/**
- * Convert string @nptr to a long integer, and store it in @result.
- *
- * This is a wrapper around strtol() that is harder to misuse.
- * Semantics of @nptr, @endptr, @base match strtol() with differences
- * noted below.
- *
- * @nptr may be null, and no conversion is performed then.
- *
- * If no conversion is performed, store @nptr in *@endptr and return
- * -EINVAL.
- *
- * If @endptr is null, and the string isn't fully converted, return
- * -EINVAL.  This is the case when the pointer that would be stored in
- * a non-null @endptr points to a character other than '\0'.
- *
- * If the conversion overflows @result, store LONG_MAX in @result,
- * and return -ERANGE.
- *
- * If the conversion underflows @result, store LONG_MIN in @result,
- * and return -ERANGE.
- *
- * Else store the converted value in @result, and return zero.
- */
 int qemu_strtol(const char *nptr, const char **endptr, int base,
                 long *result)
 {
@@ -449,31 +376,6 @@ int qemu_strtol(const char *nptr, const char **endpt=
r, int base,
     return check_strtox_error(nptr, ep, endptr, errno);
 }
=20
-/**
- * Convert string @nptr to an unsigned long, and store it in @result.
- *
- * This is a wrapper around strtoul() that is harder to misuse.
- * Semantics of @nptr, @endptr, @base match strtoul() with differences
- * noted below.
- *
- * @nptr may be null, and no conversion is performed then.
- *
- * If no conversion is performed, store @nptr in *@endptr and return
- * -EINVAL.
- *
- * If @endptr is null, and the string isn't fully converted, return
- * -EINVAL.  This is the case when the pointer that would be stored in
- * a non-null @endptr points to a character other than '\0'.
- *
- * If the conversion overflows @result, store ULONG_MAX in @result,
- * and return -ERANGE.
- *
- * Else store the converted value in @result, and return zero.
- *
- * Note that a number with a leading minus sign gets converted without
- * the minus sign, checked for overflow (see above), then negated (in
- * @result's type).  This is exactly how strtoul() works.
- */
 int qemu_strtoul(const char *nptr, const char **endptr, int base,
                  unsigned long *result)
 {
@@ -496,12 +398,6 @@ int qemu_strtoul(const char *nptr, const char **endp=
tr, int base,
     return check_strtox_error(nptr, ep, endptr, errno);
 }
=20
-/**
- * Convert string @nptr to an int64_t.
- *
- * Works like qemu_strtol(), except it stores INT64_MAX on overflow,
- * and INT_MIN on underflow.
- */
 int qemu_strtoi64(const char *nptr, const char **endptr, int base,
                  int64_t *result)
 {
@@ -521,11 +417,6 @@ int qemu_strtoi64(const char *nptr, const char **end=
ptr, int base,
     return check_strtox_error(nptr, ep, endptr, errno);
 }
=20
-/**
- * Convert string @nptr to an uint64_t.
- *
- * Works like qemu_strtoul(), except it stores UINT64_MAX on overflow.
- */
 int qemu_strtou64(const char *nptr, const char **endptr, int base,
                   uint64_t *result)
 {
@@ -549,30 +440,6 @@ int qemu_strtou64(const char *nptr, const char **end=
ptr, int base,
     return check_strtox_error(nptr, ep, endptr, errno);
 }
=20
-/**
- * Convert string @nptr to a double.
-  *
- * This is a wrapper around strtod() that is harder to misuse.
- * Semantics of @nptr and @endptr match strtod() with differences
- * noted below.
- *
- * @nptr may be null, and no conversion is performed then.
- *
- * If no conversion is performed, store @nptr in *@endptr and return
- * -EINVAL.
- *
- * If @endptr is null, and the string isn't fully converted, return
- * -EINVAL. This is the case when the pointer that would be stored in
- * a non-null @endptr points to a character other than '\0'.
- *
- * If the conversion overflows, store +/-HUGE_VAL in @result, depending
- * on the sign, and return -ERANGE.
- *
- * If the conversion underflows, store +/-0.0 in @result, depending on t=
he
- * sign, and return -ERANGE.
- *
- * Else store the converted value in @result, and return zero.
- */
 int qemu_strtod(const char *nptr, const char **endptr, double *result)
 {
     char *ep;
@@ -589,12 +456,6 @@ int qemu_strtod(const char *nptr, const char **endpt=
r, double *result)
     return check_strtox_error(nptr, ep, endptr, errno);
 }
=20
-/**
- * Convert string @nptr to a finite double.
- *
- * Works like qemu_strtod(), except that "NaN" and "inf" are rejected
- * with -EINVAL and no conversion is performed.
- */
 int qemu_strtod_finite(const char *nptr, const char **endptr, double *re=
sult)
 {
     double tmp;
@@ -614,10 +475,6 @@ int qemu_strtod_finite(const char *nptr, const char =
**endptr, double *result)
     return ret;
 }
=20
-/**
- * Searches for the first occurrence of 'c' in 's', and returns a pointe=
r
- * to the trailing null byte if none was found.
- */
 #ifndef HAVE_STRCHRNUL
 const char *qemu_strchrnul(const char *s, int c)
 {
@@ -629,34 +486,6 @@ const char *qemu_strchrnul(const char *s, int c)
 }
 #endif
=20
-/**
- * parse_uint:
- *
- * @s: String to parse
- * @value: Destination for parsed integer value
- * @endptr: Destination for pointer to first character not consumed
- * @base: integer base, between 2 and 36 inclusive, or 0
- *
- * Parse unsigned integer
- *
- * Parsed syntax is like strtoull()'s: arbitrary whitespace, a single op=
tional
- * '+' or '-', an optional "0x" if @base is 0 or 16, one or more digits.
- *
- * If @s is null, or @base is invalid, or @s doesn't start with an
- * integer in the syntax above, set *@value to 0, *@endptr to @s, and
- * return -EINVAL.
- *
- * Set *@endptr to point right beyond the parsed integer (even if the in=
teger
- * overflows or is negative, all digits will be parsed and *@endptr will
- * point right beyond them).
- *
- * If the integer is negative, set *@value to 0, and return -ERANGE.
- *
- * If the integer overflows unsigned long long, set *@value to
- * ULLONG_MAX, and return -ERANGE.
- *
- * Else, set *@value to the parsed integer, and return 0.
- */
 int parse_uint(const char *s, unsigned long long *value, char **endptr,
                int base)
 {
@@ -698,20 +527,6 @@ out:
     return r;
 }
=20
-/**
- * parse_uint_full:
- *
- * @s: String to parse
- * @value: Destination for parsed integer value
- * @base: integer base, between 2 and 36 inclusive, or 0
- *
- * Parse unsigned integer from entire string
- *
- * Have the same behavior of parse_uint(), but with an additional check
- * for additional data after the parsed number. If extra characters are =
present
- * after the parsed number, the function will return -EINVAL, and *@v wi=
ll
- * be set to 0.
- */
 int parse_uint_full(const char *s, unsigned long long *value, int base)
 {
     char *endp;
--=20
2.20.1
