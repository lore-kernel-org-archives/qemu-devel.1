Received: from eggs.gnu.org ([2001:4830:134:3::10]:52723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIGi-0005YT-Ik
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIGd-0004If-RF
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNIGd-0004I9-MN
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:11 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 15 Nov 2018 15:04:53 +0100
Message-Id: <20181115140501.7872-2-david@redhat.com>
In-Reply-To: <20181115140501.7872-1-david@redhat.com>
References: <20181115140501.7872-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/9] cutils: add qemu_strtod() and
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/qemu/cutils.h |  2 ++
 util/cutils.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

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
index 698bd315bd..7868a683e8 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -544,6 +544,44 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
     return check_strtox_error(nptr, ep, endptr, errno);
 }
 
+/**
+ * Convert string @nptr to a double.
+ *
+ * Works like qemu_strtoul(), except it stores +/-HUGE_VAL on
+ * overflow/underflow.
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
+ * Works like qemu_strtoul(), except it stores +/-HUGE_VAL on
+ * overflow/underflow. "NaN" or "inf" are rejcted with -EINVAL.
+ */
+int qemu_strtod_finite(const char *nptr, const char **endptr, double *result)
+{
+    int ret = qemu_strtod(nptr, endptr, result);
+
+    if (!ret && !isfinite(*result)) {
+        return -EINVAL;
+    }
+    return ret;
+}
+
 /**
  * Searches for the first occurrence of 'c' in 's', and returns a pointer
  * to the trailing null byte if none was found.
-- 
2.17.2
