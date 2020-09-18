Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0479C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687DB2100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azVw8s3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687DB2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBWO-0005jq-FN
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSo-0000EZ-5w
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:50 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:56094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBSm-0003Hc-2o
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:49 -0400
Received: by mail-pj1-x1042.google.com with SMTP id q4so2747603pjh.5
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yUm7gzqU0gkfA8vc3e03aOvHIouNKIgGnZpyrZReg0k=;
 b=azVw8s3PGlgUQCwoBI10t9OTwGuza4p599/kR29GLkHfn/rr5HtsRc913GgHbveOL1
 BwXzZlMBmrXyykoHTfl+bSdbMdrUIujnPH4evrF9FwX0t60mgW9cSHD7a6IeCmW88GY+
 nn3gIdntvxVrCcjDMFB9ML853OpmLtX9Aj+07L7AP7cvg0sQDvZWYlsaxdAiY+efvuDS
 e1wxnMA6+Q6PbzpSPQ6zQKb9P23sMkEeCyraYK9607wGkOinMYdONrSTNxzezp9l+5Sj
 x1FdlzIZIMLDVtJDP4uzmmMm4OqWqvIjvL2C00ebda+5ehsO2dd8RPmNHD98GvIdVrgY
 5RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yUm7gzqU0gkfA8vc3e03aOvHIouNKIgGnZpyrZReg0k=;
 b=W7zG5KpLwxMdh9tDfgD20HrUJA/7WhdNtunUHxDYL1okHa4o4UmARC5CTsXUNTN5YZ
 skBiuyGRMfMshOdJKvYCjXGWQhQ4hUDAY8n1DRF9FFF0Dv6Q9HyCnQx3jtgLl3skwSMk
 uSVjINPI/QdramxnqgvH2cKyDxEyqmitgZTWjuWqv2tXWXy5DKJGNKJGnUz2tR33QxKC
 ftV+thcJFo8RbVZSqaBAvR0vvnYxnPNLEGffqmdl/2D1rFRXe+PiRgyPnfpr68D3XmTf
 pBlwznCowgBtz9Hun2DSE/SQHTi5JffFLLohCEDOlFUn76M5V9rwLFOVc5GFcYj4dmsj
 +Vgw==
X-Gm-Message-State: AOAM530uR9rGww4650e+eDNF9Dg/5czdv1ex0tW6Cs8uDY8bSGVnzD6v
 Kp5eAfxDTAN3jUDAciz3F0xNk8sGKrG/OARe
X-Google-Smtp-Source: ABdhPJyg95Xe2gACiSCCRtRuWRWQLNIeIUzBaPIZl060vfwjAyMVAOcNG6L6WaMcyrku2KTjh92ieA==
X-Received: by 2002:a17:90a:c20f:: with SMTP id
 e15mr11498187pjt.163.1600416586513; 
 Fri, 18 Sep 2020 01:09:46 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id 84sm2238565pfw.14.2020.09.18.01.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:09:46 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 4/7] block: move logical block size check function to a
 common utility function
Date: Fri, 18 Sep 2020 16:09:09 +0800
Message-Id: <20200918080912.321299-5-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918080912.321299-1-coiby.xu@gmail.com>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=coiby.xu@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, bharatlkmlkvm@gmail.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the constants from hw/core/qdev-properties.c to
util/block-helpers.h so that knowledge of the min/max values is

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 hw/core/qdev-properties.c | 31 +++++---------------------
 util/block-helpers.c      | 46 +++++++++++++++++++++++++++++++++++++++
 util/block-helpers.h      | 19 ++++++++++++++++
 util/meson.build          |  1 +
 4 files changed, 71 insertions(+), 26 deletions(-)
 create mode 100644 util/block-helpers.c
 create mode 100644 util/block-helpers.h

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 098298c78e..e6ffd80b36 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -16,6 +16,7 @@
 #include "qemu/uuid.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
+#include "util/block-helpers.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -851,16 +852,6 @@ const PropertyInfo qdev_prop_size32 = {
 
 /* --- blocksize --- */
 
-/* lower limit is sector size */
-#define MIN_BLOCK_SIZE          512
-#define MIN_BLOCK_SIZE_STR      "512 B"
-/*
- * upper limit is arbitrary, 2 MiB looks sufficient for all sensible uses, and
- * matches qcow2 cluster size limit
- */
-#define MAX_BLOCK_SIZE          (2 * MiB)
-#define MAX_BLOCK_SIZE_STR      "2 MiB"
-
 static void set_blocksize(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
@@ -868,6 +859,7 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
     uint64_t value;
+    Error *local_err = NULL;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -877,24 +869,11 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
     if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
-    /* value of 0 means "unset" */
-    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
-        error_setg(errp,
-                   "Property %s.%s doesn't take value %" PRIu64
-                   " (minimum: " MIN_BLOCK_SIZE_STR
-                   ", maximum: " MAX_BLOCK_SIZE_STR ")",
-                   dev->id ? : "", name, value);
-        return;
-    }
-
-    /* We rely on power-of-2 blocksizes for bitmasks */
-    if ((value & (value - 1)) != 0) {
-        error_setg(errp,
-                  "Property %s.%s doesn't take value '%" PRId64 "', it's not a power of 2",
-                  dev->id ?: "", name, (int64_t)value);
+    check_block_size(dev->id ? : "", name, value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
-
     *ptr = value;
 }
 
diff --git a/util/block-helpers.c b/util/block-helpers.c
new file mode 100644
index 0000000000..c4851432f5
--- /dev/null
+++ b/util/block-helpers.c
@@ -0,0 +1,46 @@
+/*
+ * Block utility functions
+ *
+ * Copyright IBM, Corp. 2011
+ * Copyright (c) 2020 Coiby Xu <coiby.xu@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "block-helpers.h"
+
+/**
+ * check_block_size:
+ * @id: The unique ID of the object
+ * @name: The name of the property being validated
+ * @value: The block size in bytes
+ * @errp: A pointer to an area to store an error
+ *
+ * This function checks that the block size meets the following conditions:
+ * 1. At least MIN_BLOCK_SIZE
+ * 2. No larger than MAX_BLOCK_SIZE
+ * 3. A power of 2
+ */
+void check_block_size(const char *id, const char *name, int64_t value,
+                      Error **errp)
+{
+    /* value of 0 means "unset" */
+    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
+        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
+                   id, name, value, MIN_BLOCK_SIZE, MAX_BLOCK_SIZE);
+        return;
+    }
+
+    /* We rely on power-of-2 blocksizes for bitmasks */
+    if ((value & (value - 1)) != 0) {
+        error_setg(errp,
+                   "Property %s.%s doesn't take value '%" PRId64
+                   "', it's not a power of 2",
+                   id, name, value);
+        return;
+    }
+}
diff --git a/util/block-helpers.h b/util/block-helpers.h
new file mode 100644
index 0000000000..b53295a529
--- /dev/null
+++ b/util/block-helpers.h
@@ -0,0 +1,19 @@
+#ifndef BLOCK_HELPERS_H
+#define BLOCK_HELPERS_H
+
+#include "qemu/units.h"
+
+/* lower limit is sector size */
+#define MIN_BLOCK_SIZE          INT64_C(512)
+#define MIN_BLOCK_SIZE_STR      "512 B"
+/*
+ * upper limit is arbitrary, 2 MiB looks sufficient for all sensible uses, and
+ * matches qcow2 cluster size limit
+ */
+#define MAX_BLOCK_SIZE          (2 * MiB)
+#define MAX_BLOCK_SIZE_STR      "2 MiB"
+
+void check_block_size(const char *id, const char *name, int64_t value,
+                      Error **errp);
+
+#endif /* BLOCK_HELPERS_H */
diff --git a/util/meson.build b/util/meson.build
index 3921981ccf..2296e81b34 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -67,6 +67,7 @@ if have_block
   util_ss.add(files('nvdimm-utils.c'))
   util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
   util_ss.add(when: 'CONFIG_LINUX', if_true: files('vhost-user-server.c'))
+  util_ss.add(files('block-helpers.c'))
   util_ss.add(files('qemu-coroutine-sleep.c'))
   util_ss.add(files('qemu-co-shared-resource.c'))
   util_ss.add(files('thread-pool.c', 'qemu-timer.c'))
-- 
2.28.0


