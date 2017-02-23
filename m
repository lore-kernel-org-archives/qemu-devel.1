Received: from eggs.gnu.org ([2001:4830:134:3::10]:39764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgzSs-0001yF-Us
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgzSr-0000qF-2a
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgzSq-0000pA-QE
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 14:54:09 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D79F381F07
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:54:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 77B90B7D26
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:54:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Feb 2017 20:53:53 +0100
Message-Id: <1487879642-16139-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1487879642-16139-1-git-send-email-armbru@redhat.com>
References: <1487879642-16139-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 15/24] util/cutils: Rename qemu_strtosz() to
 qemu_strtosz_MiB()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

With qemu_strtosz(), no suffix means mebibytes.  It's used rarely.
I'm going to add a similar function where no suffix means bytes.
Rename qemu_strtosz() to qemu_strtosz_MiB() to make the name
qemu_strtosz() available for the new function.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1487708048-2131-16-git-send-email-armbru@redhat.com>
---
 hmp.c                 |  2 +-
 hw/misc/ivshmem.c     |  2 +-
 include/qemu/cutils.h |  2 +-
 monitor.c             |  2 +-
 tests/test-cutils.c   | 38 +++++++++++++++++++-------------------
 util/cutils.c         |  2 +-
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/hmp.c b/hmp.c
index aba728f..72a5256 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1385,7 +1385,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 break;
             case MIGRATION_PARAMETER_MAX_BANDWIDTH:
                 p.has_max_bandwidth = true;
-                valuebw = qemu_strtosz(valuestr, &endp);
+                valuebw = qemu_strtosz_MiB(valuestr, &endp);
                 if (valuebw < 0 || (size_t)valuebw != valuebw
                     || *endp != '\0') {
                     error_setg(&err, "Invalid size %s", valuestr);
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index bf57e63..b3d9ed9 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1268,7 +1268,7 @@ static void ivshmem_realize(PCIDevice *dev, Error **errp)
         s->legacy_size = 4 << 20; /* 4 MB default */
     } else {
         char *end;
-        int64_t size = qemu_strtosz(s->sizearg, &end);
+        int64_t size = qemu_strtosz_MiB(s->sizearg, &end);
         if (size < 0 || (size_t)size != size || *end != '\0'
             || !is_power_of_2(size)) {
             error_setg(errp, "Invalid size %s", s->sizearg);
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 81613d0..a08b1b0 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -153,9 +153,9 @@ int parse_uint_full(const char *s, unsigned long long *value, int base);
 #define QEMU_STRTOSZ_DEFSUFFIX_MB 'M'
 #define QEMU_STRTOSZ_DEFSUFFIX_KB 'K'
 #define QEMU_STRTOSZ_DEFSUFFIX_B 'B'
-int64_t qemu_strtosz(const char *nptr, char **end);
 int64_t qemu_strtosz_suffix(const char *nptr, char **end,
                             const char default_suffix);
+int64_t qemu_strtosz_MiB(const char *nptr, char **end);
 int64_t qemu_strtosz_metric(const char *nptr, char **end);
 
 #define K_BYTE     (1ULL << 10)
diff --git a/monitor.c b/monitor.c
index 5953fc9..c2c1e42 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2811,7 +2811,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                         break;
                     }
                 }
-                val = qemu_strtosz(p, &end);
+                val = qemu_strtosz_MiB(p, &end);
                 if (val < 0) {
                     monitor_printf(mon, "invalid size\n");
                     goto fail;
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index e1d4054..9bbfb8f 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1376,16 +1376,16 @@ static void test_qemu_strtosz_simple(void)
     int64_t res;
 
     str = "0";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_MiB(str, &endptr);
     g_assert_cmpint(res, ==, 0);
     g_assert(endptr == str + 1);
 
     str = "12345M";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_MiB(str, &endptr);
     g_assert_cmpint(res, ==, 12345 * M_BYTE);
     g_assert(endptr == str + 6);
 
-    res = qemu_strtosz(str, NULL);
+    res = qemu_strtosz_MiB(str, NULL);
     g_assert_cmpint(res, ==, 12345 * M_BYTE);
 
     /* Note: precision is 53 bits since we're parsing with strtod() */
@@ -1433,35 +1433,35 @@ static void test_qemu_strtosz_units(void)
     int64_t res;
 
     /* default is M */
-    res = qemu_strtosz(none, &endptr);
+    res = qemu_strtosz_MiB(none, &endptr);
     g_assert_cmpint(res, ==, M_BYTE);
     g_assert(endptr == none + 1);
 
-    res = qemu_strtosz(b, &endptr);
+    res = qemu_strtosz_MiB(b, &endptr);
     g_assert_cmpint(res, ==, 1);
     g_assert(endptr == b + 2);
 
-    res = qemu_strtosz(k, &endptr);
+    res = qemu_strtosz_MiB(k, &endptr);
     g_assert_cmpint(res, ==, K_BYTE);
     g_assert(endptr == k + 2);
 
-    res = qemu_strtosz(m, &endptr);
+    res = qemu_strtosz_MiB(m, &endptr);
     g_assert_cmpint(res, ==, M_BYTE);
     g_assert(endptr == m + 2);
 
-    res = qemu_strtosz(g, &endptr);
+    res = qemu_strtosz_MiB(g, &endptr);
     g_assert_cmpint(res, ==, G_BYTE);
     g_assert(endptr == g + 2);
 
-    res = qemu_strtosz(t, &endptr);
+    res = qemu_strtosz_MiB(t, &endptr);
     g_assert_cmpint(res, ==, T_BYTE);
     g_assert(endptr == t + 2);
 
-    res = qemu_strtosz(p, &endptr);
+    res = qemu_strtosz_MiB(p, &endptr);
     g_assert_cmpint(res, ==, P_BYTE);
     g_assert(endptr == p + 2);
 
-    res = qemu_strtosz(e, &endptr);
+    res = qemu_strtosz_MiB(e, &endptr);
     g_assert_cmpint(res, ==, E_BYTE);
     g_assert(endptr == e + 2);
 }
@@ -1472,7 +1472,7 @@ static void test_qemu_strtosz_float(void)
     char *endptr = NULL;
     int64_t res;
 
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_MiB(str, &endptr);
     g_assert_cmpint(res, ==, 12.345 * M_BYTE);
     g_assert(endptr == str + 7);
 }
@@ -1484,17 +1484,17 @@ static void test_qemu_strtosz_invalid(void)
     int64_t res;
 
     str = "";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_MiB(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 
     str = " \t ";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_MiB(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 
     str = "crap";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_MiB(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 }
@@ -1506,12 +1506,12 @@ static void test_qemu_strtosz_trailing(void)
     int64_t res;
 
     str = "123xxx";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_MiB(str, &endptr);
     g_assert_cmpint(res, ==, 123 * M_BYTE);
     g_assert(endptr == str + 3);
 
     str = "1kiB";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_MiB(str, &endptr);
     g_assert_cmpint(res, ==, 1024);
     g_assert(endptr == str + 2);
 }
@@ -1523,7 +1523,7 @@ static void test_qemu_strtosz_erange(void)
     int64_t res;
 
     str = "-1";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_MiB(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 2);
 
@@ -1543,7 +1543,7 @@ static void test_qemu_strtosz_erange(void)
     g_assert(endptr == str + 19);
 
     str = "10E";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_MiB(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 3);
 }
diff --git a/util/cutils.c b/util/cutils.c
index b46e254..9693add 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -254,7 +254,7 @@ int64_t qemu_strtosz_suffix(const char *nptr, char **end,
     return do_strtosz(nptr, end, default_suffix, 1024);
 }
 
-int64_t qemu_strtosz(const char *nptr, char **end)
+int64_t qemu_strtosz_MiB(const char *nptr, char **end)
 {
     return qemu_strtosz_suffix(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_MB);
 }
-- 
2.7.4
