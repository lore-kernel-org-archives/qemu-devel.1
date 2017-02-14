Received: from eggs.gnu.org ([2001:4830:134:3::10]:38807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJP-0005qq-Va
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJM-0003Mn-Mu
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJM-0003La-EK
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:16 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 981AAC0567B2
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1EAQFop001978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:26:16 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:26:01 +0100
Message-Id: <1487067971-10443-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 14/24] util/cutils: New qemu_strtosz_metric()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

To parse numbers with metric suffixes, we use

    qemu_strtosz_suffix_unit(nptr, &eptr, QEMU_STRTOSZ_DEFSUFFIX_B, 1000)

Capture this in a new function for legibility:

    qemu_strtosz_metric(nptr, &eptr)

Replace test_qemu_strtosz_suffix_unit() by test_qemu_strtosz_metric().

Rename qemu_strtosz_suffix_unit() to do_strtosz() and give it internal
linkage.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/cutils.h |  4 ++--
 target/i386/cpu.c     |  3 +--
 tests/test-cutils.c   | 13 ++++++-------
 util/cutils.c         | 11 ++++++++---
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index f922223..81613d0 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -156,8 +156,8 @@ int parse_uint_full(const char *s, unsigned long long *value, int base);
 int64_t qemu_strtosz(const char *nptr, char **end);
 int64_t qemu_strtosz_suffix(const char *nptr, char **end,
                             const char default_suffix);
-int64_t qemu_strtosz_suffix_unit(const char *nptr, char **end,
-                            const char default_suffix, int64_t unit);
+int64_t qemu_strtosz_metric(const char *nptr, char **end);
+
 #define K_BYTE     (1ULL << 10)
 #define M_BYTE     (1ULL << 20)
 #define G_BYTE     (1ULL << 30)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eb49980..3a8d72d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2036,8 +2036,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
             int64_t tsc_freq;
             char *err;
 
-            tsc_freq = qemu_strtosz_suffix_unit(val, &err,
-                                           QEMU_STRTOSZ_DEFSUFFIX_B, 1000);
+            tsc_freq = qemu_strtosz_metric(val, &err);
             if (tsc_freq < 0 || *err) {
                 error_setg(errp, "bad numerical value %s", val);
                 return;
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index af52ac5..383f812 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -1548,16 +1548,15 @@ static void test_qemu_strtosz_erange(void)
     g_assert(endptr == str + 3);
 }
 
-static void test_qemu_strtosz_suffix_unit(void)
+static void test_qemu_strtosz_metric(void)
 {
-    const char *str = "12345";
+    const char *str = "12345k";
     char *endptr = NULL;
     int64_t res;
 
-    res = qemu_strtosz_suffix_unit(str, &endptr,
-                                   QEMU_STRTOSZ_DEFSUFFIX_KB, 1000);
+    res = qemu_strtosz_metric(str, &endptr);
     g_assert_cmpint(res, ==, 12345000);
-    g_assert(endptr == str + 5);
+    g_assert(endptr == str + 6);
 }
 
 int main(int argc, char **argv)
@@ -1754,8 +1753,8 @@ int main(int argc, char **argv)
                     test_qemu_strtosz_trailing);
     g_test_add_func("/cutils/strtosz/erange",
                     test_qemu_strtosz_erange);
-    g_test_add_func("/cutils/strtosz/suffix-unit",
-                    test_qemu_strtosz_suffix_unit);
+    g_test_add_func("/cutils/strtosz/metric",
+                    test_qemu_strtosz_metric);
 
     return g_test_run();
 }
diff --git a/util/cutils.c b/util/cutils.c
index 7442d46..8a506e7 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -205,8 +205,8 @@ static int64_t suffix_mul(char suffix, int64_t unit)
  * in *end, if not NULL. Return -ERANGE on overflow, Return -EINVAL on
  * other error.
  */
-int64_t qemu_strtosz_suffix_unit(const char *nptr, char **end,
-                            const char default_suffix, int64_t unit)
+static int64_t do_strtosz(const char *nptr, char **end,
+                          const char default_suffix, int64_t unit)
 {
     int64_t retval = -EINVAL;
     char *endptr;
@@ -251,7 +251,7 @@ fail:
 int64_t qemu_strtosz_suffix(const char *nptr, char **end,
                             const char default_suffix)
 {
-    return qemu_strtosz_suffix_unit(nptr, end, default_suffix, 1024);
+    return do_strtosz(nptr, end, default_suffix, 1024);
 }
 
 int64_t qemu_strtosz(const char *nptr, char **end)
@@ -259,6 +259,11 @@ int64_t qemu_strtosz(const char *nptr, char **end)
     return qemu_strtosz_suffix(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_MB);
 }
 
+int64_t qemu_strtosz_metric(const char *nptr, char **end)
+{
+    return do_strtosz(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_B, 1000);
+}
+
 /**
  * Helper function for error checking after strtol() and the like
  */
-- 
2.7.4
