Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C324DC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5DA2080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5DA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57654 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hayzt-0000p9-Jz
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 04:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57755)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <like.xu@linux.intel.com>) id 1hayro-00038V-5g
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1hayrj-0006FU-GF
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:10704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1hayrj-0005vT-3z
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jun 2019 01:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,363,1557212400"; d="scan'208";a="184175087"
Received: from likexu-e5-2699-v4.sh.intel.com ([10.239.48.178])
 by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2019 01:43:31 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org,
	Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 12 Jun 2019 16:41:00 +0800
Message-Id: <20190612084104.34984-6-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612084104.34984-1-like.xu@linux.intel.com>
References: <20190612084104.34984-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH v3 5/9] tests/x86-cpuid: Update testcases in
 test_topo_bits() with multiple dies
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, like.xu@linux.intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The corresponding topo_bits tests are updated to support die configurations.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 tests/test-x86-cpuid.c | 84 ++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
index ff225006e4..1942287f33 100644
--- a/tests/test-x86-cpuid.c
+++ b/tests/test-x86-cpuid.c
@@ -28,74 +28,80 @@
 
 static void test_topo_bits(void)
 {
-    /* simple tests for 1 thread per core, 1 core per socket */
-    g_assert_cmpuint(apicid_smt_width(1, 1), ==, 0);
-    g_assert_cmpuint(apicid_core_width(1, 1), ==, 0);
+    /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
+    g_assert_cmpuint(apicid_smt_width(1, 1, 1), ==, 0);
+    g_assert_cmpuint(apicid_core_width(1, 1, 1), ==, 0);
+    g_assert_cmpuint(apicid_die_width(1, 1, 1), ==, 0);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 0), ==, 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1), ==, 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 2), ==, 2);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 3), ==, 3);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 0), ==, 0);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 1), ==, 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 2), ==, 2);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 3), ==, 3);
 
 
     /* Test field width calculation for multiple values
      */
-    g_assert_cmpuint(apicid_smt_width(1, 2), ==, 1);
-    g_assert_cmpuint(apicid_smt_width(1, 3), ==, 2);
-    g_assert_cmpuint(apicid_smt_width(1, 4), ==, 2);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 2), ==, 1);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 3), ==, 2);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 4), ==, 2);
 
-    g_assert_cmpuint(apicid_smt_width(1, 14), ==, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 15), ==, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 16), ==, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 17), ==, 5);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 14), ==, 4);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 15), ==, 4);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 16), ==, 4);
+    g_assert_cmpuint(apicid_smt_width(1, 1, 17), ==, 5);
 
 
-    g_assert_cmpuint(apicid_core_width(30, 2), ==, 5);
-    g_assert_cmpuint(apicid_core_width(31, 2), ==, 5);
-    g_assert_cmpuint(apicid_core_width(32, 2), ==, 5);
-    g_assert_cmpuint(apicid_core_width(33, 2), ==, 6);
+    g_assert_cmpuint(apicid_core_width(1, 30, 2), ==, 5);
+    g_assert_cmpuint(apicid_core_width(1, 31, 2), ==, 5);
+    g_assert_cmpuint(apicid_core_width(1, 32, 2), ==, 5);
+    g_assert_cmpuint(apicid_core_width(1, 33, 2), ==, 6);
 
+    g_assert_cmpuint(apicid_die_width(1, 30, 2), ==, 0);
+    g_assert_cmpuint(apicid_die_width(2, 30, 2), ==, 1);
+    g_assert_cmpuint(apicid_die_width(3, 30, 2), ==, 2);
+    g_assert_cmpuint(apicid_die_width(4, 30, 2), ==, 2);
 
     /* build a weird topology and see if IDs are calculated correctly
      */
 
     /* This will use 2 bits for thread ID and 3 bits for core ID
      */
-    g_assert_cmpuint(apicid_smt_width(6, 3), ==, 2);
-    g_assert_cmpuint(apicid_core_width(6, 3), ==, 3);
-    g_assert_cmpuint(apicid_pkg_offset(6, 3), ==, 5);
+    g_assert_cmpuint(apicid_smt_width(1, 6, 3), ==, 2);
+    g_assert_cmpuint(apicid_core_offset(1, 6, 3), ==, 2);
+    g_assert_cmpuint(apicid_die_offset(1, 6, 3), ==, 5);
+    g_assert_cmpuint(apicid_pkg_offset(1, 6, 3), ==, 5);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 0), ==, 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1), ==, 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2), ==, 2);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 0), ==, 0);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1), ==, 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2), ==, 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 3 + 0), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 0), ==,
                      (1 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 1), ==,
                      (1 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 2), ==,
                      (1 << 2) | 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2 * 3 + 0), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 0), ==,
                      (2 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 1), ==,
                      (2 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 2 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 2), ==,
                      (2 << 2) | 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 5 * 3 + 0), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 0), ==,
                      (5 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 5 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 1), ==,
                      (5 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 5 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 2), ==,
                      (5 << 2) | 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 6 * 3 + 0 * 3 + 0), ==,
-                     (1 << 5));
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 1 * 6 * 3 + 1 * 3 + 1), ==,
-                     (1 << 5) | (1 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(6, 3, 3 * 6 * 3 + 5 * 3 + 2), ==,
-                     (3 << 5) | (5 << 2) | 2);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+                     1 * 6 * 3 + 0 * 3 + 0), ==, (1 << 5));
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+                     1 * 6 * 3 + 1 * 3 + 1), ==, (1 << 5) | (1 << 2) | 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+                     3 * 6 * 3 + 5 * 3 + 2), ==, (3 << 5) | (5 << 2) | 2);
 }
 
 int main(int argc, char **argv)
-- 
2.21.0


