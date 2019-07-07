Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1938C48BDB
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34082082F
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34082082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hk8Hy-0004xW-3Y
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 10:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hk8EG-0008NG-GB
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hk8EE-0003f1-I5
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:31571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hk8EC-00038w-Kr
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jul 2019 07:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,462,1557212400"; d="scan'208";a="185497873"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2019 07:33:02 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Sun,  7 Jul 2019 22:29:57 +0800
Message-Id: <20190707142958.31316-14-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190707142958.31316-1-tao3.xu@intel.com>
References: <20190707142958.31316-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] [PATCH v6 13/14] QMP: Add QMP interface to update HMAT
 at runtime
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
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add QMP interface to introduce new HMAT data (including System Locality
Latency and Bandwidth Information Structure,  Memory Side Cache
Information Structure) at runtime. The interface can
also replace existing HMAT data.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 hw/acpi/acpi-stub.c |  7 ++++++
 numa.c              | 55 +++++++++++++++++++++++++++++++++++++++------
 qapi/misc.json      | 49 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/acpi-stub.c b/hw/acpi/acpi-stub.c
index 4c9d081ed4..757570ee7f 100644
--- a/hw/acpi/acpi-stub.c
+++ b/hw/acpi/acpi-stub.c
@@ -22,8 +22,15 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/acpi/acpi.h"
+#include "sysemu/numa.h"
+#include "hw/acpi/hmat.h"
 
 void acpi_table_add(const QemuOpts *opts, Error **errp)
 {
     error_setg(errp, QERR_UNSUPPORTED);
 }
+
+void hmat_update(NumaState *nstat)
+{
+    /* For qmp_set_hmat_lb and qmp_set_hmat_cache in numa.c can compile */
+}
diff --git a/numa.c b/numa.c
index e34a08d84b..738e1e5f89 100644
--- a/numa.c
+++ b/numa.c
@@ -188,7 +188,7 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
 }
 
 static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
-                               Error **errp)
+                               bool runtime_flag, Error **errp)
 {
     int nb_numa_nodes = ms->numa_state->num_nodes;
     NodeInfo *numa_info = ms->numa_state->nodes;
@@ -265,7 +265,8 @@ static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
         if (!hmat_lb) {
             hmat_lb = g_malloc0(sizeof(*hmat_lb));
             ms->numa_state->hmat_lb[node->hierarchy][node->data_type] = hmat_lb;
-        } else if (hmat_lb->latency[node->initiator][node->target]) {
+        } else if (!runtime_flag &&
+                   hmat_lb->latency[node->initiator][node->target]) {
             error_setg(errp, "Duplicate configuration of the latency for "
                        "initiator=%" PRIu16 " and target=%" PRIu16 ".",
                        node->initiator, node->target);
@@ -286,7 +287,8 @@ static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
         if (!hmat_lb) {
             hmat_lb = g_malloc0(sizeof(*hmat_lb));
             ms->numa_state->hmat_lb[node->hierarchy][node->data_type] = hmat_lb;
-        } else if (hmat_lb->bandwidth[node->initiator][node->target]) {
+        } else if (!runtime_flag &&
+                   hmat_lb->bandwidth[node->initiator][node->target]) {
             error_setg(errp, "Duplicate configuration of the bandwidth for "
                        "initiator=%" PRIu16 " and target=%" PRIu16 ".",
                        node->initiator, node->target);
@@ -314,7 +316,7 @@ static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
 
 static
 void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
-                            Error **errp)
+                           bool runtime_flag, Error **errp)
 {
     int nb_numa_nodes = ms->numa_state->num_nodes;
     HMAT_Cache_Info *hmat_cache = NULL;
@@ -339,7 +341,8 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
                    node->level, node->total);
         return;
     }
-    if (ms->numa_state->hmat_cache[node->node_id][node->level]) {
+    if (!runtime_flag &&
+        ms->numa_state->hmat_cache[node->node_id][node->level]) {
         error_setg(errp, "Duplicate configuration of the side cache for "
                    "node-id=%" PRIu32 " and level=%" PRIu8 ".",
                    node->node_id, node->level);
@@ -419,13 +422,13 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
                                   &err);
         break;
     case NUMA_OPTIONS_TYPE_HMAT_LB:
-        parse_numa_hmat_lb(ms, &object->u.hmat_lb, &err);
+        parse_numa_hmat_lb(ms, &object->u.hmat_lb, 0, &err);
         if (err) {
             goto end;
         }
         break;
     case NUMA_OPTIONS_TYPE_HMAT_CACHE:
-        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
+        parse_numa_hmat_cache(ms, &object->u.hmat_cache, 0, &err);
         if (err) {
             goto end;
         }
@@ -688,6 +691,44 @@ void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
     set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
 }
 
+void qmp_set_hmat_lb(NumaHmatLBOptions *node, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    if (ms->numa_state == NULL || ms->numa_state->num_nodes <= 0) {
+        error_setg(errp, "NUMA is not supported");
+        return;
+    }
+
+    if (ms->numa_state->hma_enabled) {
+        parse_numa_hmat_lb(ms, node, 1, errp);
+        hmat_update(ms->numa_state);
+    } else {
+        error_setg(errp, "HMAT can't be changed at runtime when QEMU boot"
+                   " without setting HMAT latency, bandwidth or memory cache"
+                   " information");
+    }
+}
+
+void qmp_set_hmat_cache(NumaHmatCacheOptions *node, Error **errp)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    if (ms->numa_state == NULL || ms->numa_state->num_nodes <= 0) {
+        error_setg(errp, "NUMA is not supported");
+        return;
+    }
+
+    if (ms->numa_state->hma_enabled) {
+        parse_numa_hmat_cache(ms, node, 1, errp);
+        hmat_update(ms->numa_state);
+    } else {
+        error_setg(errp, "HMAT can't be changed at runtime when QEMU boot"
+                   " without setting HMAT latency, bandwidth or memory cache"
+                   " information");
+    }
+}
+
 void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
 {
     int node_id = object_property_get_int(OBJECT(dev), "node-id", &error_abort);
diff --git a/qapi/misc.json b/qapi/misc.json
index 00d5ffabe8..43ed56cdd0 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2722,6 +2722,31 @@
     '*latency': 'uint16',
     '*bandwidth': 'uint16' }}
 
+##
+# @set-hmat-lb:
+#
+# Set @NumaHmatLBOptions at runtime.
+#
+# Since: 4.1
+#
+# Example:
+# Set the processors in node 0 access memory in node with access-latency 5
+# nanoseconds(base latency is 10):
+#
+# -> { "execute": "set-hmat-lb",
+#      "arguments": { "initiator": 0,
+#                     "target": 1,
+#                     "hierarchy": "memory",
+#                     "data-type": "access-latency",
+#                     "base-lat": 10,
+#                     "latency": 5 } }
+# <- { "return": {} }
+##
+{ 'command': 'set-hmat-lb', 'boxed': true,
+    'data': 'NumaHmatLBOptions',
+    'allow-preconfig': true
+}
+
 ##
 # @HmatCacheAssociativity:
 #
@@ -2796,6 +2821,30 @@
    'policy': 'HmatCacheWritePolicy',
    'line': 'uint16' }}
 
+##
+# @set-hmat-cache:
+#
+# Set @NumaHmatCacheOptions at runtime.
+#
+# Since: 4.1
+#
+# Example:
+# Set Memory Side Cache Information in node 1:
+#
+# -> { "execute": "set-hmat-cache",
+#      "arguments": { "node-id": 1,
+#                     "size": 0x20000,
+#                     "total": 3,
+#                     "level": "direct",
+#                     "policy": "write-back",
+#                     "line": 8 } }
+# <- { "return": {} }
+##
+{ 'command': 'set-hmat-cache', 'boxed': true,
+    'data': 'NumaHmatCacheOptions',
+    'allow-preconfig': true
+}
+
 ##
 # @HostMemPolicy:
 #
-- 
2.20.1


