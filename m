Received: from eggs.gnu.org ([2001:4830:134:3::10]:38850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJR-0005r9-3P
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJN-0003OC-W0
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJN-0003NF-Nf
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:17 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2BDD19D241
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1EAQGC0023214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:26:17 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:26:02 +0100
Message-Id: <1487067971-10443-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 15/24] util/cutils: Rename qemu_strtosz() to
 qemu_strtosz_mebi()
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
Rename qemu_strtosz() to qemu_strtosz_mebi() to make the name
qemu_strtosz() available for the new function.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c                 |  2 +-
 hw/misc/ivshmem.c     |  2 +-
 include/qemu/cutils.h |  2 +-
 monitor.c             |  2 +-
 tests/test-cutils.c   | 38 +++++++++++++++++++-------------------
 util/cutils.c         |  2 +-
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/hmp.c b/hmp.c
index 2bc4f06..6d0d05b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1379,7 +1379,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
                 break;
             case MIGRATION_PARAMETER_MAX_BANDWIDTH:
                 p.has_max_bandwidth = true;
-                valuebw = qemu_strtosz(valuestr, &endp);
+                valuebw = qemu_strtosz_mebi(valuestr, &endp);
                 if (valuebw < 0 || (size_t)valuebw != valuebw
                     || *endp != '\0') {
                     error_setg(&err, "Invalid size %s", valuestr);
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index bf57e63..382dd8b 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1268,7 +1268,7 @@ static void ivshmem_realize(PCIDevice *dev, Error **errp)
         s->legacy_size = 4 << 20; /* 4 MB default */
     } else {
         char *end;
-        int64_t size = qemu_strtosz(s->sizearg, &end);
+        int64_t size = qemu_strtosz_mebi(s->sizearg, &end);
         if (size < 0 || (size_t)size != size || *end != '\0'
             || !is_power_of_2(size)) {
             error_setg(errp, "Invalid size %s", s->sizearg);
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 81613d0..5f4e138 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -153,9 +153,9 @@ int parse_uint_full(const char *s, unsigned long long *value, int base);
 #define QEMU_STRTOSZ_DEFSUFFIX_MB 'M'
 #define QEMU_STRTOSZ_DEFSUFFIX_KB 'K'
 #define QEMU_STRTOSZ_DEFSUFFIX_B 'B'
-int64_t qemu_strtosz(const char *nptr, char **end);
 int64_t qemu_strtosz_suffix(const char *nptr, char **end,
                             const char default_suffix);
+int64_t qemu_strtosz_mebi(const char *nptr, char **end);
 int64_t qemu_strtosz_metric(const char *nptr, char **end);
 
 #define K_BYTE     (1ULL << 10)
diff --git a/monitor.c b/monitor.c
index 3cd72a9..1f8c031 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2785,7 +2785,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
                         break;
                     }
                 }
-                val = qemu_strtosz(p, &end);
+                val = qemu_strtosz_mebi(p, &end);
                 if (val < 0) {
                     monitor_printf(mon, "invalid size\n");
                     goto fail;
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 383f812..86d36b7 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1376,16 +1376,16 @@ static void test_qemu_strtosz_simple(void)
     int64_t res;
 
     str = "0";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_mebi(str, &endptr);
     g_assert_cmpint(res, ==, 0);
     g_assert(endptr == str + 1);
 
     str = "12345M";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_mebi(str, &endptr);
     g_assert_cmpint(res, ==, 12345 * M_BYTE);
     g_assert(endptr == str + 6);
 
-    res = qemu_strtosz(str, NULL);
+    res = qemu_strtosz_mebi(str, NULL);
     g_assert_cmpint(res, ==, 12345 * M_BYTE);
 
     /* Note: precision is 53 bits since we're parsing with strtod() */
@@ -1433,35 +1433,35 @@ static void test_qemu_strtosz_units(void)
     int64_t res;
 
     /* default is M */
-    res = qemu_strtosz(none, &endptr);
+    res = qemu_strtosz_mebi(none, &endptr);
     g_assert_cmpint(res, ==, M_BYTE);
     g_assert(endptr == none + 1);
 
-    res = qemu_strtosz(b, &endptr);
+    res = qemu_strtosz_mebi(b, &endptr);
     g_assert_cmpint(res, ==, 1);
     g_assert(endptr == b + 2);
 
-    res = qemu_strtosz(k, &endptr);
+    res = qemu_strtosz_mebi(k, &endptr);
     g_assert_cmpint(res, ==, K_BYTE);
     g_assert(endptr == k + 2);
 
-    res = qemu_strtosz(m, &endptr);
+    res = qemu_strtosz_mebi(m, &endptr);
     g_assert_cmpint(res, ==, M_BYTE);
     g_assert(endptr == m + 2);
 
-    res = qemu_strtosz(g, &endptr);
+    res = qemu_strtosz_mebi(g, &endptr);
     g_assert_cmpint(res, ==, G_BYTE);
     g_assert(endptr == g + 2);
 
-    res = qemu_strtosz(t, &endptr);
+    res = qemu_strtosz_mebi(t, &endptr);
     g_assert_cmpint(res, ==, T_BYTE);
     g_assert(endptr == t + 2);
 
-    res = qemu_strtosz(p, &endptr);
+    res = qemu_strtosz_mebi(p, &endptr);
     g_assert_cmpint(res, ==, P_BYTE);
     g_assert(endptr == p + 2);
 
-    res = qemu_strtosz(e, &endptr);
+    res = qemu_strtosz_mebi(e, &endptr);
     g_assert_cmpint(res, ==, E_BYTE);
     g_assert(endptr == e + 2);
 }
@@ -1472,7 +1472,7 @@ static void test_qemu_strtosz_float(void)
     char *endptr = NULL;
     int64_t res;
 
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_mebi(str, &endptr);
     g_assert_cmpint(res, ==, 12.345 * M_BYTE);
     g_assert(endptr == str + 7);
 }
@@ -1484,17 +1484,17 @@ static void test_qemu_strtosz_invalid(void)
     int64_t res;
 
     str = "";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_mebi(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 
     str = " \t ";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_mebi(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 
     str = "crap";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_mebi(str, &endptr);
     g_assert_cmpint(res, ==, -EINVAL);
     g_assert(endptr == str);
 }
@@ -1506,12 +1506,12 @@ static void test_qemu_strtosz_trailing(void)
     int64_t res;
 
     str = "123xxx";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_mebi(str, &endptr);
     g_assert_cmpint(res, ==, 123 * M_BYTE);
     g_assert(endptr == str + 3);
 
     str = "1kiB";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_mebi(str, &endptr);
     g_assert_cmpint(res, ==, 1024);
     g_assert(endptr == str + 2);
 }
@@ -1523,7 +1523,7 @@ static void test_qemu_strtosz_erange(void)
     int64_t res;
 
     str = "-1";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_mebi(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 2);
 
@@ -1543,7 +1543,7 @@ static void test_qemu_strtosz_erange(void)
     g_assert(endptr == str + 19);
 
     str = "10E";
-    res = qemu_strtosz(str, &endptr);
+    res = qemu_strtosz_mebi(str, &endptr);
     g_assert_cmpint(res, ==, -ERANGE);
     g_assert(endptr == str + 3);
 }
diff --git a/util/cutils.c b/util/cutils.c
index 8a506e7..0315d5d 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -254,7 +254,7 @@ int64_t qemu_strtosz_suffix(const char *nptr, char **end,
     return do_strtosz(nptr, end, default_suffix, 1024);
 }
 
-int64_t qemu_strtosz(const char *nptr, char **end)
+int64_t qemu_strtosz_mebi(const char *nptr, char **end)
 {
     return qemu_strtosz_suffix(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_MB);
 }
-- 
2.7.4
