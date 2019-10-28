Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45708CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0831320650
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0831320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzqv-0003DS-5f
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iOzpI-0000O5-Uk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iOzpG-0002oa-AN
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:52:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:47957)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iOzpG-0002nn-21
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Oct 2019 00:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; d="scan'208";a="224558711"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2019 00:52:25 -0700
From: Tao Xu <tao3.xu@intel.com>
To: mst@redhat.com, imammedo@redhat.com, eblake@redhat.com,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com
Subject: [PATCH v14 01/11] util/cutils: Add qemu_strtotime_ns()
Date: Mon, 28 Oct 2019 15:52:10 +0800
Message-Id: <20191028075220.25673-2-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028075220.25673-1-tao3.xu@intel.com>
References: <20191028075220.25673-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To convert strings with time suffixes to numbers, support time unit are
"ns" for nanosecond, "us" for microsecond, "ms" for millisecond or "s"
for second. Add test for qemu_strtotime_ns, test the input of basic,
time suffixes, float, invaild, trailing and overflow.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v14:
    - Reuse the codes of do_strtosz to build qemu_strtotime_ns
      (Eduardo)
    - Squash patch v13 01/12 and 02/12 together (Daniel and Eduardo)
    - Drop time unit picosecond (Eric)
---
 include/qemu/cutils.h |   1 +
 tests/test-cutils.c   | 204 ++++++++++++++++++++++++++++++++++++++++++
 util/cutils.c         |  89 +++++++++++-------
 3 files changed, 262 insertions(+), 32 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index b54c847e0f..ff2b3f4614 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -182,5 +182,6 @@ int uleb128_decode_small(const uint8_t *in, uint32_t *n);
  * *str1 is <, == or > than *str2.
  */
 int qemu_pstrcmp0(const char **str1, const char **str2);
+int qemu_strtotime_ns(const char *nptr, const char **end, uint64_t *result);
 
 #endif
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 1aa8351520..d6a0824efd 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -2179,6 +2179,198 @@ static void test_qemu_strtosz_metric(void)
     g_assert(endptr == str + 6);
 }
 
+static void test_qemu_strtotime_ns_simple(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    uint64_t res = 0xbaadf00d;
+
+    str = "0";
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0);
+    g_assert(endptr == str + 1);
+
+    str = "56789";
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 56789);
+    g_assert(endptr == str + 5);
+
+    err = qemu_strtotime_ns(str, NULL, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 56789);
+
+    /* Note: precision is 53 bits since we're parsing with strtod() */
+
+    str = "9007199254740991"; /* 2^53-1 */
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0x1fffffffffffff);
+    g_assert(endptr == str + 16);
+
+    str = "9007199254740992"; /* 2^53 */
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0x20000000000000);
+    g_assert(endptr == str + 16);
+
+    str = "9007199254740993"; /* 2^53+1 */
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0x20000000000000); /* rounded to 53 bits */
+    g_assert(endptr == str + 16);
+
+    str = "18446744073709549568"; /* 0xfffffffffffff800 (53 msbs set) */
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0xfffffffffffff800);
+    g_assert(endptr == str + 20);
+
+    str = "18446744073709550591"; /* 0xfffffffffffffbff */
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0xfffffffffffff800); /* rounded to 53 bits */
+    g_assert(endptr == str + 20);
+
+    /* 0x7ffffffffffffe00..0x7fffffffffffffff get rounded to
+     * 0x8000000000000000, thus -ERANGE; see test_qemu_strtosz_erange() */
+}
+
+static void test_qemu_strtotime_ns_units(void)
+{
+    const char *ns = "1ns";
+    const char *us = "1us";
+    const char *ms = "1ms";
+    const char *s = "1s";
+    int err;
+    const char *endptr;
+    uint64_t res = 0xbaadf00d;
+
+    /* default time unit is ns */
+    err = qemu_strtotime_ns(ns, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 1);
+    g_assert(endptr == ns + 3);
+
+    err = qemu_strtotime_ns(us, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 1000);
+    g_assert(endptr == us + 3);
+
+    err = qemu_strtotime_ns(ms, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 1000000);
+    g_assert(endptr == ms + 3);
+
+    err = qemu_strtotime_ns(s, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 1000000000LL);
+    g_assert(endptr == s + 2);
+}
+
+static void test_qemu_strtotime_ns_float(void)
+{
+    const char *str = "56.789us";
+    int err;
+    const char *endptr;
+    uint64_t res = 0xbaadf00d;
+
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 56.789 * 1000);
+    g_assert(endptr == str + 8);
+}
+
+static void test_qemu_strtotime_ns_invalid(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    uint64_t res = 0xbaadf00d;
+
+    str = "";
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = " \t ";
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = "crap";
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = "inf";
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = "NaN";
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+}
+
+static void test_qemu_strtotime_ns_trailing(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    uint64_t res = 0xbaadf00d;
+
+    str = "123xxx";
+
+    err = qemu_strtotime_ns(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+
+    str = "1msxxx";
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 1000000);
+    g_assert(endptr == str + 3);
+
+    err = qemu_strtotime_ns(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+}
+
+static void test_qemu_strtotime_ns_erange(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    uint64_t res = 0xbaadf00d;
+
+    str = "-1";
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert(endptr == str + 2);
+
+    str = "18446744073709550592"; /* 0xfffffffffffffc00 */
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert(endptr == str + 20);
+
+    str = "18446744073709551615"; /* 2^64-1 */
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert(endptr == str + 20);
+
+    str = "18446744073709551616"; /* 2^64 */
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert(endptr == str + 20);
+
+    str = "200000000000000ms";
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert(endptr == str + 17);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -2456,5 +2648,17 @@ int main(int argc, char **argv)
     g_test_add_func("/cutils/strtosz/metric",
                     test_qemu_strtosz_metric);
 
+    g_test_add_func("/cutils/strtotime/simple",
+                    test_qemu_strtotime_ns_simple);
+    g_test_add_func("/cutils/strtotime/units",
+                    test_qemu_strtotime_ns_units);
+    g_test_add_func("/cutils/strtotime/float",
+                    test_qemu_strtotime_ns_float);
+    g_test_add_func("/cutils/strtotime/invalid",
+                    test_qemu_strtotime_ns_invalid);
+    g_test_add_func("/cutils/strtotime/trailing",
+                    test_qemu_strtotime_ns_trailing);
+    g_test_add_func("/cutils/strtotime/erange",
+                    test_qemu_strtotime_ns_erange);
     return g_test_run();
 }
diff --git a/util/cutils.c b/util/cutils.c
index fd591cadf0..d83825f8b4 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -181,41 +181,38 @@ int fcntl_setfl(int fd, int flag)
 }
 #endif
 
-static int64_t suffix_mul(char suffix, int64_t unit)
-{
-    switch (qemu_toupper(suffix)) {
-    case 'B':
-        return 1;
-    case 'K':
-        return unit;
-    case 'M':
-        return unit * unit;
-    case 'G':
-        return unit * unit * unit;
-    case 'T':
-        return unit * unit * unit * unit;
-    case 'P':
-        return unit * unit * unit * unit * unit;
-    case 'E':
-        return unit * unit * unit * unit * unit * unit;
+static int64_t suffix_mul(const char *suffixes[], int num_suffix,
+                          const char *endptr, int *offset, int64_t unit)
+{
+    int i, suffix_len;
+    int64_t mul = 1;
+
+    for (i = 0; i < num_suffix; i++) {
+        suffix_len = strlen(suffixes[i]);
+        if (strlen(endptr) >= suffix_len &&
+            g_ascii_strncasecmp(suffixes[i], endptr, suffix_len) == 0) {
+            *offset = suffix_len;
+            return mul;
+        }
+        mul *= unit;
     }
+
     return -1;
 }
 
 /*
- * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
- * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
- * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
- * other error.
+ * Convert string according to different suffixes. End pointer will be returned
+ * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on other error.
  */
-static int do_strtosz(const char *nptr, const char **end,
-                      const char default_suffix, int64_t unit,
-                      uint64_t *result)
+static int do_strtomul(const char *nptr, const char **end,
+                       const char *suffixes[], int num_suffix,
+                       const char *default_suffix, int64_t unit,
+                       uint64_t *result)
 {
     int retval;
     const char *endptr;
-    unsigned char c;
     int mul_required = 0;
+    int offset = 0;
     double val, mul, integral, fraction;
 
     retval = qemu_strtod_finite(nptr, &endptr, &val);
@@ -226,12 +223,12 @@ static int do_strtosz(const char *nptr, const char **end,
     if (fraction != 0) {
         mul_required = 1;
     }
-    c = *endptr;
-    mul = suffix_mul(c, unit);
+
+    mul = suffix_mul(suffixes, num_suffix, endptr, &offset, unit);
     if (mul >= 0) {
-        endptr++;
+        endptr += offset;
     } else {
-        mul = suffix_mul(default_suffix, unit);
+        mul = suffix_mul(suffixes, num_suffix, default_suffix, &offset, unit);
         assert(mul >= 0);
     }
     if (mul == 1 && mul_required) {
@@ -259,19 +256,47 @@ out:
     return retval;
 }
 
+/*
+ * Convert string to bytes, allowing either B/b for bytes, K/k for KB,
+ * M/m for MB, G/g for GB or T/t for TB. End pointer will be returned
+ * in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
+ * other error.
+ */
+static int do_strtosz(const char *nptr, const char **end,
+                      const char *default_suffix, int64_t unit,
+                      uint64_t *result)
+{
+    static const char *suffixes[] = { "B", "K", "M", "G", "T", "P", "E" };
+
+    return do_strtomul(nptr, end, suffixes, 7, default_suffix, unit, result);
+}
+
 int qemu_strtosz(const char *nptr, const char **end, uint64_t *result)
 {
-    return do_strtosz(nptr, end, 'B', 1024, result);
+    return do_strtosz(nptr, end, "B", 1024, result);
 }
 
 int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result)
 {
-    return do_strtosz(nptr, end, 'M', 1024, result);
+    return do_strtosz(nptr, end, "M", 1024, result);
 }
 
 int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result)
 {
-    return do_strtosz(nptr, end, 'B', 1000, result);
+    return do_strtosz(nptr, end, "B", 1000, result);
+}
+
+/*
+ * Convert string to time, support time unit are ns for nanosecond, us for
+ * microsecond, ms for millisecond and s for second. End pointer will be
+ * returned in *end, if not NULL. Return -ERANGE on overflow, and -EINVAL on
+ * other error.
+ */
+int qemu_strtotime_ns(const char *nptr, const char **end, uint64_t *result)
+{
+    static const char *suffixes[] = { "ns", "us", "ms", "s" };
+
+    return do_strtomul(nptr, end, suffixes, 4, "ns", 1000, result);
 }
 
 /**
-- 
2.20.1


