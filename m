Received: from eggs.gnu.org ([2001:4830:134:3::10]:34274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gL4Yp-00046s-Fl
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gL4Yl-0004PP-Ep
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:02:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gL4Yl-0004C6-4L
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:02:43 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Nov 2018 12:02:16 +0100
Message-Id: <20181109110221.10553-2-david@redhat.com>
In-Reply-To: <20181109110221.10553-1-david@redhat.com>
References: <20181109110221.10553-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 1/6] cutils: add qemu_strtod()
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
 include/qemu/cutils.h |  1 +
 util/cutils.c         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 7071bfe2d4..84fb9e53c6 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -146,6 +146,7 @@ int qemu_strtoi64(const char *nptr, const char **endptr, int base,
                   int64_t *result);
 int qemu_strtou64(const char *nptr, const char **endptr, int base,
                   uint64_t *result);
+int qemu_strtod(const char *nptr, const char **endptr, double *result);
 
 int parse_uint(const char *s, unsigned long long *value, char **endptr,
                int base);
diff --git a/util/cutils.c b/util/cutils.c
index 698bd315bd..850e3af9ea 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -544,6 +544,28 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
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
 /**
  * Searches for the first occurrence of 'c' in 's', and returns a pointer
  * to the trailing null byte if none was found.
-- 
2.17.2
