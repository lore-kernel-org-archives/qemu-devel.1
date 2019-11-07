Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DEDC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 07:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C6921D79
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 07:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C6921D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iScXJ-00038B-2F
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 02:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iScTx-0001IX-Kk
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 02:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iScTu-0004V1-EX
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 02:45:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:5076)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iScTu-0004DB-50
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 02:45:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 23:45:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; d="scan'208";a="404016814"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2019 23:45:16 -0800
From: Tao Xu <tao3.xu@intel.com>
To: mst@redhat.com, imammedo@redhat.com, eblake@redhat.com,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com
Subject: [PATCH v15 01/12] util/cutils: refactor do_strtosz() to support
 suffixes list
Date: Thu,  7 Nov 2019 15:45:00 +0800
Message-Id: <20191107074511.14304-2-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107074511.14304-1-tao3.xu@intel.com>
References: <20191107074511.14304-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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

Add do_strtomul() to convert string according to different suffixes.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v15:
    - Add a new patch to refactor do_strtosz() (Eduardo)
---
 util/cutils.c | 72 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index fd591cadf0..86d6e271fa 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -181,41 +181,37 @@ int fcntl_setfl(int fd, int flag)
 }
 #endif
 
-static int64_t suffix_mul(char suffix, int64_t unit)
+static int64_t suffix_mul(const char *suffixes[], int num_suffix,
+                          const char *endptr, int *offset, int64_t unit)
 {
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
+    int i, suffix_len;
+    int64_t mul = 1;
+
+    for (i = 0; i < num_suffix; i++) {
+        suffix_len = strlen(suffixes[i]);
+        if (g_ascii_strncasecmp(suffixes[i], endptr, suffix_len) == 0) {
+            *offset = suffix_len;
+            return mul;
+    }
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
+static int do_strtomul(const char *nptr, const char **end,
+                       const char *suffixes[], int num_suffix,
+                       const char *default_suffix, int64_t unit,
                       uint64_t *result)
 {
     int retval;
     const char *endptr;
-    unsigned char c;
     int mul_required = 0;
+    int offset = 0;
     double val, mul, integral, fraction;
 
     retval = qemu_strtod_finite(nptr, &endptr, &val);
@@ -226,12 +222,12 @@ static int do_strtosz(const char *nptr, const char **end,
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
@@ -259,19 +255,35 @@ out:
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
+    return do_strtomul(nptr, end, suffixes, ARRAY_SIZE(suffixes),
+                       default_suffix, unit, result);
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
 }
 
 /**
-- 
2.20.1


