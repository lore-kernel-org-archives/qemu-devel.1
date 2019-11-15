Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF70AC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 07:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72D420718
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 07:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72D420718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVWTK-0008G8-Oh
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 02:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iVWQj-0005lD-F0
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 02:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iVWQg-0002cY-Qz
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 02:54:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:48001)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iVWQg-0002Zs-FT
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 02:54:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Nov 2019 23:54:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,307,1569308400"; d="scan'208";a="235987218"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga002.fm.intel.com with ESMTP; 14 Nov 2019 23:54:03 -0800
From: Tao Xu <tao3.xu@intel.com>
To: mst@redhat.com, imammedo@redhat.com, eblake@redhat.com,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com
Subject: [PATCH v16 04/14] util/cutils: Add qemu_strtotime_ns()
Date: Fri, 15 Nov 2019 15:53:42 +0800
Message-Id: <20191115075352.17734-5-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191115075352.17734-1-tao3.xu@intel.com>
References: <20191115075352.17734-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v16:
    - Update the test because precision is 64 bits

Changes in v15:
    - Add a new patch to refactor do_strtosz() (Eduardo)
    - use ARRAY_SIZE(suffixes) instead of hardcoding the
      suffixes number (Eduardo)
---
 include/qemu/cutils.h |   1 +
 tests/test-cutils.c   | 173 ++++++++++++++++++++++++++++++++++++++++++
 util/cutils.c         |  14 ++++
 3 files changed, 188 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 48cf9bf776..befa94f2d4 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -185,5 +185,6 @@ int uleb128_decode_small(const uint8_t *in, uint32_t *n);
  * *str1 is <, == or > than *str2.
  */
 int qemu_pstrcmp0(const char **str1, const char **str2);
+int qemu_strtotime_ns(const char *nptr, const char **end, uint64_t *result);
 
 #endif
diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 465514b85f..0ff1d816f1 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -2148,6 +2148,167 @@ static void test_qemu_strtosz_metric(void)
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
+    /* Note: precision is 64 bits (UINT64_MAX) */
+
+    str = "18446744073709551614"; /* UINT64_MAX - 1 */
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0xfffffffffffffffe);
+    g_assert(endptr == str + 20);
+
+    str = "18446744073709551615"; /* UINT64_MAX */
+    err = qemu_strtotime_ns(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0xffffffffffffffff);
+    g_assert(endptr == str + 20);
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
@@ -2425,5 +2586,17 @@ int main(int argc, char **argv)
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
index ffef92338a..0a885a0a90 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -283,6 +283,20 @@ int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result)
     return do_strtosz(nptr, end, "B", 1000, result);
 }
 
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
+    return do_strtomul(nptr, end, suffixes, ARRAY_SIZE(suffixes), "ns", 1000,
+                       result);
+}
+
 /**
  * Helper function for error checking after strtol() and the like
  */
-- 
2.20.1


