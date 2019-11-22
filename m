Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F0EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BA220659
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BA220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY3ng-0005HD-L9
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 02:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iY3gI-0005Ev-Ts
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iY3gH-0002lo-0Q
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:48:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:36766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iY3gG-0002j8-Nu
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:48:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 23:48:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,229,1571727600"; d="scan'208";a="210178449"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by orsmga003.jf.intel.com with ESMTP; 21 Nov 2019 23:48:32 -0800
From: Tao Xu <tao3.xu@intel.com>
To: mst@redhat.com, imammedo@redhat.com, eblake@redhat.com,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 sw@weilnetz.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com,
 lvivier@redhat.com
Subject: [PATCH v17 01/14] util/cutils: Add Add qemu_strtold and
 qemu_strtold_finite
Date: Fri, 22 Nov 2019 15:48:13 +0800
Message-Id: <20191122074826.1373-2-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122074826.1373-1-tao3.xu@intel.com>
References: <20191122074826.1373-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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

Work like qemu_strtod() and qemu_strtold_finite, except store long
double.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

No changes in v17.
---
 include/qemu/cutils.h |  3 +++
 util/cutils.c         | 48 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index b54c847e0f..48cf9bf776 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -146,6 +146,9 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
                   uint64_t *result);
 int qemu_strtod(const char *nptr, const char **endptr, double *result);
 int qemu_strtod_finite(const char *nptr, const char **endptr, double *result);
+int qemu_strtold(const char *nptr, const char **endptr, long double *result);
+int qemu_strtold_finite(const char *nptr, const char **endptr,
+                        long double *result);
 
 int parse_uint(const char *s, unsigned long long *value, char **endptr,
                int base);
diff --git a/util/cutils.c b/util/cutils.c
index fd591cadf0..5db3b2add5 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -553,7 +553,7 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
 
 /**
  * Convert string @nptr to a double.
-  *
+ *
  * This is a wrapper around strtod() that is harder to misuse.
  * Semantics of @nptr and @endptr match strtod() with differences
  * noted below.
@@ -616,6 +616,52 @@ int qemu_strtod_finite(const char *nptr, const char **endptr, double *result)
     return ret;
 }
 
+/*
+ * Convert string @nptr to a long double.
+ *
+ * Works like qemu_strtod(), except it stores long double.
+ */
+int qemu_strtold(const char *nptr, const char **endptr, long double *result)
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
+    *result = strtold(nptr, &ep);
+    return check_strtox_error(nptr, ep, endptr, errno);
+}
+
+/*
+ * Convert string @nptr to a finite long double.
+ *
+ * Works like qemu_strtod_finite(), except it stores long double.
+ */
+int qemu_strtold_finite(const char *nptr, const char **endptr,
+                        long double *result)
+{
+    long double tmp;
+    int ret;
+
+    ret = qemu_strtold(nptr, endptr, &tmp);
+    if (!ret && !isfinite(tmp)) {
+        if (endptr) {
+            *endptr = nptr;
+        }
+        ret = -EINVAL;
+    }
+
+    if (ret != -EINVAL) {
+        *result = tmp;
+    }
+    return ret;
+}
+
 /**
  * Searches for the first occurrence of 'c' in 's', and returns a pointer
  * to the trailing null byte if none was found.
-- 
2.20.1


