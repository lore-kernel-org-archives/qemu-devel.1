Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F11C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A66A21670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A66A21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLOVe-0000oC-Fc
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 04:53:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hLOUs-0000WV-MZ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hLOUr-0006MC-DC
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:52:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:63395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hLOUk-0006ID-UU; Tue, 30 Apr 2019 04:52:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	30 Apr 2019 01:52:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,413,1549958400"; d="scan'208";a="295728798"
Received: from xulike-server.sh.intel.com ([10.239.48.134])
	by orsmga004.jf.intel.com with ESMTP; 30 Apr 2019 01:52:07 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 16:50:40 +0800
Message-Id: <1556614240-36369-1-git-send-email-like.xu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: [Qemu-devel] [PATCH] hw/arm/fsl-imx: move cpus initialization to
 realize time after smp_cpus check
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Igor Mammedov <imammedo@redhat.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430085040.JeJ9IG1ncA0rYIXpNZZTr3nRDTmQvq5Sdiz2gSlM0HY@z>

If "smp_cpus> FSL_IMX6_NUM_CPUS" fails in *_realize(), there is no need to
initialize the CPUs in *_init(). So it could be better to create all cpus
after the validity in *_realize(). On the other hand, it makes the usages
of global variable smp_cpus more centrally for maintenance.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/arm/fsl-imx6.c   | 13 +++++++------
 hw/arm/fsl-imx6ul.c | 12 ++++++------
 hw/arm/fsl-imx7.c   | 15 +++++++--------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 7b7b97f..14015a1 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -37,12 +37,6 @@ static void fsl_imx6_init(Object *obj)
     char name[NAME_SIZE];
     int i;
 
-    for (i = 0; i < MIN(smp_cpus, FSL_IMX6_NUM_CPUS); i++) {
-        snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
-                                "cortex-a9-" TYPE_ARM_CPU, &error_abort, NULL);
-    }
-
     sysbus_init_child_obj(obj, "a9mpcore", &s->a9mpcore, sizeof(s->a9mpcore),
                           TYPE_A9MPCORE_PRIV);
 
@@ -95,6 +89,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 {
     FslIMX6State *s = FSL_IMX6(dev);
     uint16_t i;
+    char name[NAME_SIZE];
     Error *err = NULL;
 
     if (smp_cpus > FSL_IMX6_NUM_CPUS) {
@@ -103,6 +98,12 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    for (i = 0; i < MIN(smp_cpus, FSL_IMX6_NUM_CPUS); i++) {
+        snprintf(name, NAME_SIZE, "cpu%d", i);
+        object_initialize_child(OBJECT(dev), name, &s->cpu[i],
+            sizeof(s->cpu[i]), "cortex-a9-" TYPE_ARM_CPU, &error_abort, NULL);
+    }
+
     for (i = 0; i < smp_cpus; i++) {
 
         /* On uniprocessor, the CBAR is set to 0 */
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 4b56bfa..7f30eb7 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -32,12 +32,6 @@ static void fsl_imx6ul_init(Object *obj)
     char name[NAME_SIZE];
     int i;
 
-    for (i = 0; i < MIN(smp_cpus, FSL_IMX6UL_NUM_CPUS); i++) {
-        snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
-                                "cortex-a7-" TYPE_ARM_CPU, &error_abort, NULL);
-    }
-
     /*
      * A7MPCORE
      */
@@ -167,6 +161,12 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    for (i = 0; i < MIN(smp_cpus, FSL_IMX6UL_NUM_CPUS); i++) {
+        snprintf(name, NAME_SIZE, "cpu%d", i);
+        object_initialize_child(OBJECT(dev), name, &s->cpu[i],
+            sizeof(s->cpu[i]), "cortex-a7-" TYPE_ARM_CPU, &error_abort, NULL);
+    }
+
     for (i = 0; i < smp_cpus; i++) {
         Object *o = OBJECT(&s->cpu[i]);
 
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 7663ad6..2580348 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -34,14 +34,6 @@ static void fsl_imx7_init(Object *obj)
     char name[NAME_SIZE];
     int i;
 
-
-    for (i = 0; i < MIN(smp_cpus, FSL_IMX7_NUM_CPUS); i++) {
-        snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
-                                ARM_CPU_TYPE_NAME("cortex-a7"), &error_abort,
-                                NULL);
-    }
-
     /*
      * A7MPCORE
      */
@@ -167,6 +159,13 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    for (i = 0; i < MIN(smp_cpus, FSL_IMX7_NUM_CPUS); i++) {
+        snprintf(name, NAME_SIZE, "cpu%d", i);
+        object_initialize_child(OBJECT(dev), name, &s->cpu[i],
+            sizeof(s->cpu[i]), ARM_CPU_TYPE_NAME("cortex-a7"),
+            &error_abort, NULL);
+    }
+
     for (i = 0; i < smp_cpus; i++) {
         o = OBJECT(&s->cpu[i]);
 
-- 
1.8.3.1


