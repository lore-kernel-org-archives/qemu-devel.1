Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4FFC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0511B206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJFNQNaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0511B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojqe-0002G6-Nz
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojPZ-0005Tg-Ci
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojPV-0007nr-1r
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57183
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojPU-0007nU-On
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22EPts6aFtlxMBe62U24R+ZdRqDDBVDzjTf7DPsfcPs=;
 b=BJFNQNaP7ONv2sQepcVR3EYytt0vbsVnLZ6c8QM8LEPrKUU/r5JvbRQaMU5rKB3JpQOH2X
 JIUKT/5GCr2Q2Eaarwj9+HgF78J1RT9pEN6lFHkhgtto0309QNdeydQvzUsIsgV87IojMC
 +nAMv39eM2A8GpBC+f2sVtG87ZWW0Fw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-UhmOe4wyNF6ftWXUhkWk4g-1; Tue, 07 Jan 2020 02:36:15 -0500
Received: by mail-qk1-f198.google.com with SMTP id f22so11034670qka.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xnCcrYb/jhhSnPfhxsRrpT5AqLZcj5F/dVmLqeFIs/8=;
 b=st53gJDfuSMU06ymFshcnNJpDroXojzELBRS7HDn7FfDuDelCWTf97RME8cwqoy9aK
 2ySbYlueXJZO6qtgjjHBgizqSvGGXztMOx389PSEgs1TmNO4F+nPFM+ZcUAF7IyniEwM
 od0VYLJ6PivE8Kn+QvRpH88iHBpqzllRJeWVlwamuyguBRSDUkJhrX/BRPhImhD9Pzil
 39C7IE9iTCedCwOlX7J6kCJ4v+Qhx0572b+RhrKmf8OXDPaKOEFjnBfIADCBVzvdrHEO
 7bZGkZ8l+Lze74BCZDOl3PmWwu7TK5qISIZvtbqCJ9OgxGe2HJuxLW6mmC51KYQYuGtr
 mZ4g==
X-Gm-Message-State: APjAAAWYhLppMBSBdwnwkw7napuQH6NBzgTPYDNPJL+wy8Mzg07DvYB7
 CuhcA13x73+5AUMZKUe1EqjuV4ea/UG6VzOXEMDHN06+rAHfaoIt79O4fRbGZ3VuNseu+Ug+9pU
 U+JAVMBubtkzDol4=
X-Received: by 2002:ac8:36dd:: with SMTP id b29mr77487487qtc.285.1578382573869; 
 Mon, 06 Jan 2020 23:36:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxET0ysr7suDjYkf5hzPt07yG2FhHPDadZDqcO+Q9JUffEYxqCKrEYddDTslzesdO28xQjIxw==
X-Received: by 2002:ac8:36dd:: with SMTP id b29mr77487463qtc.285.1578382573307; 
 Mon, 06 Jan 2020 23:36:13 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id v4sm24613139qtd.24.2020.01.06.23.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:36:12 -0800 (PST)
Date: Tue, 7 Jan 2020 02:36:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/32] numa: Extend CLI to provide memory latency and
 bandwidth information
Message-ID: <20200107073451.298261-13-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: UhmOe4wyNF6ftWXUhkWk4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Liu Jingqi <jingqi.liu@intel.com>,
 Tao Xu <tao3.xu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jingqi <jingqi.liu@intel.com>

Add -numa hmat-lb option to provide System Locality Latency and
Bandwidth Information. These memory attributes help to build
System Locality Latency and Bandwidth Information Structure(s)
in ACPI Heterogeneous Memory Attribute Table (HMAT). Before using
hmat-lb option, enable HMAT with -machine hmat=3Don.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20191213011929.2520-3-tao3.xu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 qapi/machine.json     |  93 +++++++++++++++++++-
 include/sysemu/numa.h |  53 ++++++++++++
 hw/core/numa.c        | 194 ++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx       |  47 +++++++++-
 4 files changed, 384 insertions(+), 3 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 27d0e37534..cf8faf5a2a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -426,10 +426,12 @@
 #
 # @cpu: property based CPU(s) to node mapping (Since: 2.10)
 #
+# @hmat-lb: memory latency and bandwidth information (Since: 5.0)
+#
 # Since: 2.1
 ##
 { 'enum': 'NumaOptionsType',
-  'data': [ 'node', 'dist', 'cpu' ] }
+  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
=20
 ##
 # @NumaOptions:
@@ -444,7 +446,8 @@
   'data': {
     'node': 'NumaNodeOptions',
     'dist': 'NumaDistOptions',
-    'cpu': 'NumaCpuOptions' }}
+    'cpu': 'NumaCpuOptions',
+    'hmat-lb': 'NumaHmatLBOptions' }}
=20
 ##
 # @NumaNodeOptions:
@@ -557,6 +560,92 @@
    'base': 'CpuInstanceProperties',
    'data' : {} }
=20
+##
+# @HmatLBMemoryHierarchy:
+#
+# The memory hierarchy in the System Locality Latency and Bandwidth
+# Information Structure of HMAT (Heterogeneous Memory Attribute Table)
+#
+# For more information about @HmatLBMemoryHierarchy, see chapter
+# 5.2.27.4: Table 5-146: Field "Flags" of ACPI 6.3 spec.
+#
+# @memory: the structure represents the memory performance
+#
+# @first-level: first level of memory side cache
+#
+# @second-level: second level of memory side cache
+#
+# @third-level: third level of memory side cache
+#
+# Since: 5.0
+##
+{ 'enum': 'HmatLBMemoryHierarchy',
+  'data': [ 'memory', 'first-level', 'second-level', 'third-level' ] }
+
+##
+# @HmatLBDataType:
+#
+# Data type in the System Locality Latency and Bandwidth
+# Information Structure of HMAT (Heterogeneous Memory Attribute Table)
+#
+# For more information about @HmatLBDataType, see chapter
+# 5.2.27.4: Table 5-146:  Field "Data Type" of ACPI 6.3 spec.
+#
+# @access-latency: access latency (nanoseconds)
+#
+# @read-latency: read latency (nanoseconds)
+#
+# @write-latency: write latency (nanoseconds)
+#
+# @access-bandwidth: access bandwidth (Bytes per second)
+#
+# @read-bandwidth: read bandwidth (Bytes per second)
+#
+# @write-bandwidth: write bandwidth (Bytes per second)
+#
+# Since: 5.0
+##
+{ 'enum': 'HmatLBDataType',
+  'data': [ 'access-latency', 'read-latency', 'write-latency',
+            'access-bandwidth', 'read-bandwidth', 'write-bandwidth' ] }
+
+##
+# @NumaHmatLBOptions:
+#
+# Set the system locality latency and bandwidth information
+# between Initiator and Target proximity Domains.
+#
+# For more information about @NumaHmatLBOptions, see chapter
+# 5.2.27.4: Table 5-146 of ACPI 6.3 spec.
+#
+# @initiator: the Initiator Proximity Domain.
+#
+# @target: the Target Proximity Domain.
+#
+# @hierarchy: the Memory Hierarchy. Indicates the performance
+#             of memory or side cache.
+#
+# @data-type: presents the type of data, access/read/write
+#             latency or hit latency.
+#
+# @latency: the value of latency from @initiator to @target
+#           proximity domain, the latency unit is "ns(nanosecond)".
+#
+# @bandwidth: the value of bandwidth between @initiator and @target
+#             proximity domain, the bandwidth unit is
+#             "Bytes per second".
+#
+# Since: 5.0
+##
+{ 'struct': 'NumaHmatLBOptions',
+    'data': {
+    'initiator': 'uint16',
+    'target': 'uint16',
+    'hierarchy': 'HmatLBMemoryHierarchy',
+    'data-type': 'HmatLBDataType',
+    '*latency': 'uint64',
+    '*bandwidth': 'size' }}
+
 ##
 # @HostMemPolicy:
 #
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 788cbec7a2..70f93c83d7 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -14,11 +14,34 @@ struct CPUArchId;
 #define NUMA_DISTANCE_MAX         254
 #define NUMA_DISTANCE_UNREACHABLE 255
=20
+/* the value of AcpiHmatLBInfo flags */
+enum {
+    HMAT_LB_MEM_MEMORY           =3D 0,
+    HMAT_LB_MEM_CACHE_1ST_LEVEL  =3D 1,
+    HMAT_LB_MEM_CACHE_2ND_LEVEL  =3D 2,
+    HMAT_LB_MEM_CACHE_3RD_LEVEL  =3D 3,
+    HMAT_LB_LEVELS   /* must be the last entry */
+};
+
+/* the value of AcpiHmatLBInfo data type */
+enum {
+    HMAT_LB_DATA_ACCESS_LATENCY   =3D 0,
+    HMAT_LB_DATA_READ_LATENCY     =3D 1,
+    HMAT_LB_DATA_WRITE_LATENCY    =3D 2,
+    HMAT_LB_DATA_ACCESS_BANDWIDTH =3D 3,
+    HMAT_LB_DATA_READ_BANDWIDTH   =3D 4,
+    HMAT_LB_DATA_WRITE_BANDWIDTH  =3D 5,
+    HMAT_LB_TYPES   /* must be the last entry */
+};
+
+#define UINT16_BITS       16
+
 struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
     bool present;
     bool has_cpu;
+    uint8_t lb_info_provided;
     uint16_t initiator;
     uint8_t distance[MAX_NODES];
 };
@@ -28,6 +51,31 @@ struct NumaNodeMem {
     uint64_t node_plugged_mem;
 };
=20
+struct HMAT_LB_Data {
+    uint8_t     initiator;
+    uint8_t     target;
+    uint64_t    data;
+};
+typedef struct HMAT_LB_Data HMAT_LB_Data;
+
+struct HMAT_LB_Info {
+    /* Indicates it's memory or the specified level memory side cache. */
+    uint8_t     hierarchy;
+
+    /* Present the type of data, access/read/write latency or bandwidth. *=
/
+    uint8_t     data_type;
+
+    /* The range bitmap of bandwidth for calculating common base */
+    uint64_t    range_bitmap;
+
+    /* The common base unit for latencies or bandwidths */
+    uint64_t    base;
+
+    /* Array to store the latencies or bandwidths */
+    GArray      *list;
+};
+typedef struct HMAT_LB_Info HMAT_LB_Info;
+
 struct NumaState {
     /* Number of NUMA nodes */
     int num_nodes;
@@ -40,11 +88,16 @@ struct NumaState {
=20
     /* NUMA nodes information */
     NodeInfo nodes[MAX_NODES];
+
+    /* NUMA nodes HMAT Locality Latency and Bandwidth Information */
+    HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
 };
 typedef struct NumaState NumaState;
=20
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)=
;
 void parse_numa_opts(MachineState *ms);
+void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
+                        Error **errp);
 void numa_complete_configuration(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
 extern QemuOptsList qemu_numa_opts;
diff --git a/hw/core/numa.c b/hw/core/numa.c
index e60da99293..34eb413f5d 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
 #include "sysemu/sysemu.h"
@@ -198,6 +199,186 @@ void parse_numa_distance(MachineState *ms, NumaDistOp=
tions *dist, Error **errp)
     ms->numa_state->have_numa_distance =3D true;
 }
=20
+void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
+                        Error **errp)
+{
+    int i, first_bit, last_bit;
+    uint64_t max_entry, temp_base, bitmap_copy;
+    NodeInfo *numa_info =3D numa_state->nodes;
+    HMAT_LB_Info *hmat_lb =3D
+        numa_state->hmat_lb[node->hierarchy][node->data_type];
+    HMAT_LB_Data lb_data =3D {};
+    HMAT_LB_Data *lb_temp;
+
+    /* Error checking */
+    if (node->initiator > numa_state->num_nodes) {
+        error_setg(errp, "Invalid initiator=3D%d, it should be less than %=
d",
+                   node->initiator, numa_state->num_nodes);
+        return;
+    }
+    if (node->target > numa_state->num_nodes) {
+        error_setg(errp, "Invalid target=3D%d, it should be less than %d",
+                   node->target, numa_state->num_nodes);
+        return;
+    }
+    if (!numa_info[node->initiator].has_cpu) {
+        error_setg(errp, "Invalid initiator=3D%d, it isn't an "
+                   "initiator proximity domain", node->initiator);
+        return;
+    }
+    if (!numa_info[node->target].present) {
+        error_setg(errp, "The target=3D%d should point to an existing node=
",
+                   node->target);
+        return;
+    }
+
+    if (!hmat_lb) {
+        hmat_lb =3D g_malloc0(sizeof(*hmat_lb));
+        numa_state->hmat_lb[node->hierarchy][node->data_type] =3D hmat_lb;
+        hmat_lb->list =3D g_array_new(false, true, sizeof(HMAT_LB_Data));
+    }
+    hmat_lb->hierarchy =3D node->hierarchy;
+    hmat_lb->data_type =3D node->data_type;
+    lb_data.initiator =3D node->initiator;
+    lb_data.target =3D node->target;
+
+    if (node->data_type <=3D HMATLB_DATA_TYPE_WRITE_LATENCY) {
+        /* Input latency data */
+
+        if (!node->has_latency) {
+            error_setg(errp, "Missing 'latency' option");
+            return;
+        }
+        if (node->has_bandwidth) {
+            error_setg(errp, "Invalid option 'bandwidth' since "
+                       "the data type is latency");
+            return;
+        }
+
+        /* Detect duplicate configuration */
+        for (i =3D 0; i < hmat_lb->list->len; i++) {
+            lb_temp =3D &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
+
+            if (node->initiator =3D=3D lb_temp->initiator &&
+                node->target =3D=3D lb_temp->target) {
+                error_setg(errp, "Duplicate configuration of the latency f=
or "
+                    "initiator=3D%d and target=3D%d", node->initiator,
+                    node->target);
+                return;
+            }
+        }
+
+        hmat_lb->base =3D hmat_lb->base ? hmat_lb->base : UINT64_MAX;
+
+        if (node->latency) {
+            /* Calculate the temporary base and compressed latency */
+            max_entry =3D node->latency;
+            temp_base =3D 1;
+            while (QEMU_IS_ALIGNED(max_entry, 10)) {
+                max_entry /=3D 10;
+                temp_base *=3D 10;
+            }
+
+            /* Calculate the max compressed latency */
+            temp_base =3D MIN(hmat_lb->base, temp_base);
+            max_entry =3D node->latency / hmat_lb->base;
+            max_entry =3D MAX(hmat_lb->range_bitmap, max_entry);
+
+            /*
+             * For latency hmat_lb->range_bitmap record the max compressed
+             * latency which should be less than 0xFFFF (UINT16_MAX)
+             */
+            if (max_entry >=3D UINT16_MAX) {
+                error_setg(errp, "Latency %" PRIu64 " between initiator=3D=
%d and "
+                        "target=3D%d should not differ from previously ent=
ered "
+                        "min or max values on more than %d", node->latency=
,
+                        node->initiator, node->target, UINT16_MAX - 1);
+                return;
+            } else {
+                hmat_lb->base =3D temp_base;
+                hmat_lb->range_bitmap =3D max_entry;
+            }
+
+            /*
+             * Set lb_info_provided bit 0 as 1,
+             * latency information is provided
+             */
+            numa_info[node->target].lb_info_provided |=3D BIT(0);
+        }
+        lb_data.data =3D node->latency;
+    } else if (node->data_type >=3D HMATLB_DATA_TYPE_ACCESS_BANDWIDTH) {
+        /* Input bandwidth data */
+        if (!node->has_bandwidth) {
+            error_setg(errp, "Missing 'bandwidth' option");
+            return;
+        }
+        if (node->has_latency) {
+            error_setg(errp, "Invalid option 'latency' since "
+                       "the data type is bandwidth");
+            return;
+        }
+        if (!QEMU_IS_ALIGNED(node->bandwidth, MiB)) {
+            error_setg(errp, "Bandwidth %" PRIu64 " between initiator=3D%d=
 and "
+                       "target=3D%d should be 1MB aligned", node->bandwidt=
h,
+                       node->initiator, node->target);
+            return;
+        }
+
+        /* Detect duplicate configuration */
+        for (i =3D 0; i < hmat_lb->list->len; i++) {
+            lb_temp =3D &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
+
+            if (node->initiator =3D=3D lb_temp->initiator &&
+                node->target =3D=3D lb_temp->target) {
+                error_setg(errp, "Duplicate configuration of the bandwidth=
 for "
+                    "initiator=3D%d and target=3D%d", node->initiator,
+                    node->target);
+                return;
+            }
+        }
+
+        hmat_lb->base =3D hmat_lb->base ? hmat_lb->base : 1;
+
+        if (node->bandwidth) {
+            /* Keep bitmap unchanged when bandwidth out of range */
+            bitmap_copy =3D hmat_lb->range_bitmap;
+            bitmap_copy |=3D node->bandwidth;
+            first_bit =3D ctz64(bitmap_copy);
+            temp_base =3D UINT64_C(1) << first_bit;
+            max_entry =3D node->bandwidth / temp_base;
+            last_bit =3D 64 - clz64(bitmap_copy);
+
+            /*
+             * For bandwidth, first_bit record the base unit of bandwidth =
bits,
+             * last_bit record the last bit of the max bandwidth. The max
+             * compressed bandwidth should be less than 0xFFFF (UINT16_MAX=
)
+             */
+            if ((last_bit - first_bit) > UINT16_BITS ||
+                max_entry >=3D UINT16_MAX) {
+                error_setg(errp, "Bandwidth %" PRIu64 " between initiator=
=3D%d "
+                        "and target=3D%d should not differ from previously=
 "
+                        "entered values on more than %d", node->bandwidth,
+                        node->initiator, node->target, UINT16_MAX - 1);
+                return;
+            } else {
+                hmat_lb->base =3D temp_base;
+                hmat_lb->range_bitmap =3D bitmap_copy;
+            }
+
+            /*
+             * Set lb_info_provided bit 1 as 1,
+             * bandwidth information is provided
+             */
+            numa_info[node->target].lb_info_provided |=3D BIT(1);
+        }
+        lb_data.data =3D node->bandwidth;
+    } else {
+        assert(0);
+    }
+
+    g_array_append_val(hmat_lb->list, lb_data);
+}
+
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
 {
     Error *err =3D NULL;
@@ -236,6 +417,19 @@ void set_numa_options(MachineState *ms, NumaOptions *o=
bject, Error **errp)
         machine_set_cpu_numa_node(ms, qapi_NumaCpuOptions_base(&object->u.=
cpu),
                                   &err);
         break;
+    case NUMA_OPTIONS_TYPE_HMAT_LB:
+        if (!ms->numa_state->hmat_enabled) {
+            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table "
+                       "(HMAT) is disabled, enable it with -machine hmat=
=3Don "
+                       "before using any of hmat specific options");
+            return;
+        }
+
+        parse_numa_hmat_lb(ms->numa_state, &object->u.hmat_lb, &err);
+        if (err) {
+            goto end;
+        }
+        break;
     default:
         abort();
     }
diff --git a/qemu-options.hx b/qemu-options.hx
index b78bc52634..a0c0bbb7cf 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -175,16 +175,19 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][,=
initiator=3Dnode]\n"
     "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][=
,initiator=3Dnode]\n"
     "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
-    "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=3Dz=
]\n",
+    "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=3Dz=
]\n"
+    "-numa hmat-lb,initiator=3Dnode,target=3Dnode,hierarchy=3Dmemory|first=
-level|second-level|third-level,data-type=3Daccess-latency|read-latency|wri=
te-latency[,latency=3Dlat][,bandwidth=3Dbw]\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu}]=
][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
 @itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
 @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{di=
stance}
 @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@va=
r{y}][,thread-id=3D@var{z}]
+@itemx -numa hmat-lb,initiator=3D@var{node},target=3D@var{node},hierarchy=
=3D@var{hierarchy},data-type=3D@var{tpye}[,latency=3D@var{lat}][,bandwidth=
=3D@var{bw}]
 @findex -numa
 Define a NUMA node and assign RAM and VCPUs to it.
 Set the NUMA distance from a source node to a destination node.
+Set the ACPI Heterogeneous Memory Attributes for the given nodes.
=20
 Legacy VCPU assignment uses @samp{cpus} option where
 @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
@@ -263,6 +266,48 @@ specified resources, it just assigns existing resource=
s to NUMA
 nodes. This means that one still has to use the @option{-m},
 @option{-smp} options to allocate RAM and VCPUs respectively.
=20
+Use @samp{hmat-lb} to set System Locality Latency and Bandwidth Informatio=
n
+between initiator and target NUMA nodes in ACPI Heterogeneous Attribute Me=
mory Table (HMAT).
+Initiator NUMA node can create memory requests, usually it has one or more=
 processors.
+Target NUMA node contains addressable memory.
+
+In @samp{hmat-lb} option, @var{node} are NUMA node IDs. @var{hierarchy} is=
 the memory
+hierarchy of the target NUMA node: if @var{hierarchy} is 'memory', the str=
ucture
+represents the memory performance; if @var{hierarchy} is 'first-level|seco=
nd-level|third-level',
+this structure represents aggregated performance of memory side caches for=
 each domain.
+@var{type} of 'data-type' is type of data represented by this structure in=
stance:
+if 'hierarchy' is 'memory', 'data-type' is 'access|read|write' latency or =
'access|read|write'
+bandwidth of the target memory; if 'hierarchy' is 'first-level|second-leve=
l|third-level',
+'data-type' is 'access|read|write' hit latency or 'access|read|write' hit =
bandwidth of the
+target memory side cache.
+
+@var{lat} is latency value in nanoseconds. @var{bw} is bandwidth value,
+the possible value and units are NUM[M|G|T], mean that the bandwidth value=
 are
+NUM byte per second (or MB/s, GB/s or TB/s depending on used suffix).
+Note that if latency or bandwidth value is 0, means the corresponding late=
ncy or
+bandwidth information is not provided.
+
+For example, the following options describe 2 NUMA nodes. Node 0 has 2 cpu=
s and
+a ram, node 1 has only a ram. The processors in node 0 access memory in no=
de
+0 with access-latency 5 nanoseconds, access-bandwidth is 200 MB/s;
+The processors in NUMA node 0 access memory in NUMA node 1 with access-lat=
ency 10
+nanoseconds, access-bandwidth is 100 MB/s.
+@example
+-machine hmat=3Don \
+-m 2G \
+-object memory-backend-ram,size=3D1G,id=3Dm0 \
+-object memory-backend-ram,size=3D1G,id=3Dm1 \
+-smp 2 \
+-numa node,nodeid=3D0,memdev=3Dm0 \
+-numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 \
+-numa cpu,node-id=3D0,socket-id=3D0 \
+-numa cpu,node-id=3D0,socket-id=3D1 \
+-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacce=
ss-latency,latency=3D5 \
+-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacce=
ss-bandwidth,bandwidth=3D200M \
+-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacce=
ss-latency,latency=3D10 \
+-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacce=
ss-bandwidth,bandwidth=3D100M
+@end example
+
 ETEXI
=20
 DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
--=20
MST


