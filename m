Received: from eggs.gnu.org ([2001:4830:134:3::10]:51617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVc6-0007Q6-25
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVc4-0006YA-Dj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gPVc4-0006Xd-6D
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:28 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 21 Nov 2018 17:44:13 +0100
Message-Id: <20181121164421.20780-2-david@redhat.com>
In-Reply-To: <20181121164421.20780-1-david@redhat.com>
References: <20181121164421.20780-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-4.0 1/9] cutils: Add qemu_strtod() and
 qemu_strtod_finite()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>

Let's provide a wrapper for strtod().

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qemu/cutils.h |  2 ++
 util/cutils.c         | 65 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 7071bfe2d4..756b41c193 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -146,6 +146,8 @@ int qemu_strtoi64(const char *nptr, const char **endptr, int base,
                   int64_t *result);
 int qemu_strtou64(const char *nptr, const char **endptr, int base,
                   uint64_t *result);
+int qemu_strtod(const char *nptr, const char **endptr, double *result);
+int qemu_strtod_finite(const char *nptr, const char **endptr, double *result);
 
 int parse_uint(const char *s, unsigned long long *value, char **endptr,
                int base);
diff --git a/util/cutils.c b/util/cutils.c
index 698bd315bd..173407d2fd 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -544,6 +544,71 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
     return check_strtox_error(nptr, ep, endptr, errno);
 }
 
+/**
+ * Convert string @nptr to a double.
+  *
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
+ * If the conversion underflows, store +/-0.0 in @result, depending on the
+ * sign, and return -ERANGE.
+ *
+ * Else store the converted value in @result, and return zero.
+ */
+int qemu_strtod(const char *nptr, const char **endptr, double *result)
+{
+    char *ep;
+
+    if (!nptr) {
+        if (endptr) {
+            *endptr = nptr;
+        }
+        return -EINVAL;
+    }
+
+    errno = 0;
+    *result = strtod(nptr, &ep);
+    return check_strtox_error(nptr, ep, endptr, errno);
+}
+
+/**
+ * Convert string @nptr to a finite double.
+ *
+ * Works like qemu_strtod(), except that "NaN" and "inf" are rejected
+ * with -EINVAL and no conversion is performed.
+ */
+int qemu_strtod_finite(const char *nptr, const char **endptr, double *result)
+{
+    double tmp;
+    int ret;
+
+    ret = qemu_strtod(nptr, endptr, &tmp);
+    if (!ret && !isfinite(tmp)) {
+        if (endptr) {
+            *endptr = nptr;
+        }
+        ret = -EINVAL;
+    }
+
+    if (ret != -EINVAL) {
+        *result = tmp;
+    }
+    return ret;
+}
+
 /**
  * Searches for the first occurrence of 'c' in 's', and returns a pointer
  * to the trailing null byte if none was found.
-- 
2.17.2
