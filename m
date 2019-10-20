Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B8FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 11:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA85D21721
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 11:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA85D21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iM9Ga-0000Ch-FO
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 07:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iM97a-0002dl-05
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 07:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iM97Y-0002x0-JI
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 07:11:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:63375)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iM97Y-0002wT-Bn
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 07:11:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Oct 2019 04:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,319,1566889200"; d="scan'208";a="371917542"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by orsmga005.jf.intel.com with ESMTP; 20 Oct 2019 04:11:31 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Subject: [PATCH v13 02/12] tests/cutils: Add test for qemu_strtotime_ps()
Date: Sun, 20 Oct 2019 19:11:15 +0800
Message-Id: <20191020111125.27659-3-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191020111125.27659-1-tao3.xu@intel.com>
References: <20191020111125.27659-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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

Test the input of basic, time suffixes, float, invaild, trailing and
overflow.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

No changes in v13.
---
 tests/test-cutils.c | 199 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/tests/test-cutils.c b/tests/test-cutils.c
index 1aa8351520..19c967d3d5 100644
--- a/tests/test-cutils.c
+++ b/tests/test-cutils.c
@@ -2179,6 +2179,193 @@ static void test_qemu_strtosz_metric(void)
     g_assert(endptr == str + 6);
 }
 
+static void test_qemu_strtotime_ps_simple(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    uint64_t res = 0xbaadf00d;
+
+    str = "0";
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0);
+    g_assert(endptr == str + 1);
+
+    str = "56789";
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 56789);
+    g_assert(endptr == str + 5);
+
+    err = qemu_strtotime_ps(str, NULL, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 56789);
+
+    /* Note: precision is 53 bits since we're parsing with strtod() */
+
+    str = "9007199254740991"; /* 2^53-1 */
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0x1fffffffffffff);
+    g_assert(endptr == str + 16);
+
+    str = "9007199254740992"; /* 2^53 */
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0x20000000000000);
+    g_assert(endptr == str + 16);
+
+    str = "9007199254740993"; /* 2^53+1 */
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0x20000000000000); /* rounded to 53 bits */
+    g_assert(endptr == str + 16);
+
+    str = "18446744073709549568"; /* 0xfffffffffffff800 (53 msbs set) */
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0xfffffffffffff800);
+    g_assert(endptr == str + 20);
+
+    str = "18446744073709550591"; /* 0xfffffffffffffbff */
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0xfffffffffffff800); /* rounded to 53 bits */
+    g_assert(endptr == str + 20);
+
+    /* 0x7ffffffffffffe00..0x7fffffffffffffff get rounded to
+     * 0x8000000000000000, thus -ERANGE; see test_qemu_strtosz_erange() */
+}
+
+static void test_qemu_strtotime_ps_units(void)
+{
+    const char *ps = "1ps";
+    const char *ns = "1ns";
+    const char *us = "1us";
+    const char *ms = "1ms";
+    const char *s = "1s";
+    int err;
+    const char *endptr;
+    uint64_t res = 0xbaadf00d;
+
+    err = qemu_strtotime_ps(ps, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 1);
+    g_assert(endptr == ps + 3);
+
+    err = qemu_strtotime_ps(ns, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 1000);
+    g_assert(endptr == ns + 3);
+
+    err = qemu_strtotime_ps(us, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 1000000);
+    g_assert(endptr == us + 3);
+
+    err = qemu_strtotime_ps(ms, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 1000000000LL);
+    g_assert(endptr == ms + 3);
+
+    err = qemu_strtotime_ps(s, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 1000000000000ULL);
+    g_assert(endptr == s + 2);
+}
+
+static void test_qemu_strtotime_ps_float(void)
+{
+    const char *str = "56.789ns";
+    int err;
+    const char *endptr;
+    uint64_t res = 0xbaadf00d;
+
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 56.789 * 1000);
+    g_assert(endptr == str + 8);
+}
+
+static void test_qemu_strtotime_ps_invalid(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    uint64_t res = 0xbaadf00d;
+
+    str = "";
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = " \t ";
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = "crap";
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = "inf";
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = "NaN";
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+}
+
+static void test_qemu_strtotime_ps_trailing(void)
+{
+    const char *str;
+    int err;
+    uint64_t res = 0xbaadf00d;
+
+    str = "123xxx";
+
+    err = qemu_strtotime_ps(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+}
+
+static void test_qemu_strtotime_ps_erange(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    uint64_t res = 0xbaadf00d;
+
+    str = "-1";
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert(endptr == str + 2);
+
+    str = "18446744073709550592"; /* 0xfffffffffffffc00 */
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert(endptr == str + 20);
+
+    str = "18446744073709551615"; /* 2^64-1 */
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert(endptr == str + 20);
+
+    str = "18446744073709551616"; /* 2^64 */
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert(endptr == str + 20);
+
+    str = "200000000000000s";
+    err = qemu_strtotime_ps(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert(endptr == str + 16);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -2456,5 +2643,17 @@ int main(int argc, char **argv)
     g_test_add_func("/cutils/strtosz/metric",
                     test_qemu_strtosz_metric);
 
+    g_test_add_func("/cutils/strtotime/simple",
+                    test_qemu_strtotime_ps_simple);
+    g_test_add_func("/cutils/strtotime/units",
+                    test_qemu_strtotime_ps_units);
+    g_test_add_func("/cutils/strtotime/float",
+                    test_qemu_strtotime_ps_float);
+    g_test_add_func("/cutils/strtotime/invalid",
+                    test_qemu_strtotime_ps_invalid);
+    g_test_add_func("/cutils/strtotime/trailing",
+                    test_qemu_strtotime_ps_trailing);
+    g_test_add_func("/cutils/strtotime/erange",
+                    test_qemu_strtotime_ps_erange);
     return g_test_run();
 }
-- 
2.20.1


