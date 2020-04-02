Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A6EC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B88F206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJXjiHzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B88F206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8FP-00064R-Ct
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 18:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jK8D6-0001bx-Nj
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jK8D3-0007R0-5X
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jK8D2-0007Qf-NW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585866072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rco8irUg11D2TArNYy9HRBuK5ph6X4DulIi8XnlO8KE=;
 b=jJXjiHzfFloirXxeYaWoc1hjIG3njZPoS7gecY17ljNAV+psRvs/bqc08Jhu9G90FjZsVm
 wxUUlu5KZ1zDtIphoWmZDc1dc8Bv1Qo7x63YWl38C/IC1Dba8p+Fn9Ew/2m1LshWOsjonf
 mJ2aL4cHCnH24bAq5RXacWMsIQZvbQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-GRBwH2TuN02kXvxX5AF-2w-1; Thu, 02 Apr 2020 18:21:04 -0400
X-MC-Unique: GRBwH2TuN02kXvxX5AF-2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 635A718A6EC0;
 Thu,  2 Apr 2020 22:21:03 +0000 (UTC)
Received: from localhost (ovpn-116-71.gru2.redhat.com [10.97.116.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0A1199E1A;
 Thu,  2 Apr 2020 22:20:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 1/9] hw/386: Add EPYC mode topology decoding functions
Date: Thu,  2 Apr 2020 19:20:43 -0300
Message-Id: <20200402222051.523093-2-ehabkost@redhat.com>
In-Reply-To: <20200402222051.523093-1-ehabkost@redhat.com>
References: <20200402222051.523093-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Babu Moger <babu.moger@amd.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

These functions add support for building EPYC mode topology given the smp
details like numa nodes, cores, threads and sockets.

The new apic id decoding is mostly similar to current apic id decoding
except that it adds a new field node_id when numa configured. Removes all
the hardcoded values. Subsequent patches will use these functions to build
the topology.

Following functions are added.
apicid_llc_width_epyc
apicid_llc_offset_epyc
apicid_pkg_offset_epyc
apicid_from_topo_ids_epyc
x86_topo_ids_from_idx_epyc
x86_topo_ids_from_apicid_epyc
x86_apicid_from_cpu_idx_epyc

The topology details are available in Processor Programming Reference (PPR)
for AMD Family 17h Model 01h, Revision B1 Processors. The revision guides a=
re
available from the bugzilla Link below.
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537

Signed-off-by: Babu Moger <babu.moger@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <158396721426.58170.2930696192478912976.stgit@naples-babu.amd.c=
om>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/topology.h | 100 +++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index b9593b9905..07239f95f4 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -47,6 +47,7 @@ typedef uint32_t apic_id_t;
=20
 typedef struct X86CPUTopoIDs {
     unsigned pkg_id;
+    unsigned node_id;
     unsigned die_id;
     unsigned core_id;
     unsigned smt_id;
@@ -88,6 +89,11 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *=
topo_info)
     return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
 }
=20
+/* Bit width of the node_id field per socket */
+static inline unsigned apicid_node_width_epyc(X86CPUTopoInfo *topo_info)
+{
+    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
+}
 /* Bit offset of the Core_ID field
  */
 static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
@@ -108,6 +114,100 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoIn=
fo *topo_info)
     return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
 }
=20
+#define NODE_ID_OFFSET 3 /* Minimum node_id offset if numa configured */
+
+/*
+ * Bit offset of the node_id field
+ *
+ * Make sure nodes_per_pkg >  0 if numa configured else zero.
+ */
+static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
+{
+    unsigned offset =3D apicid_die_offset(topo_info) +
+                      apicid_die_width(topo_info);
+
+    if (topo_info->nodes_per_pkg) {
+        return MAX(NODE_ID_OFFSET, offset);
+    } else {
+        return offset;
+    }
+}
+
+/* Bit offset of the Pkg_ID (socket ID) field */
+static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
+{
+    return apicid_node_offset_epyc(topo_info) +
+           apicid_node_width_epyc(topo_info);
+}
+
+/*
+ * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
+ *
+ * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
+ */
+static inline apic_id_t
+x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
+                              const X86CPUTopoIDs *topo_ids)
+{
+    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
+           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
+           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
+           (topo_ids->core_id << apicid_core_offset(topo_info)) |
+           topo_ids->smt_id;
+}
+
+static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
+                                              unsigned cpu_index,
+                                              X86CPUTopoIDs *topo_ids)
+{
+    unsigned nr_nodes =3D MAX(topo_info->nodes_per_pkg, 1);
+    unsigned nr_dies =3D topo_info->dies_per_pkg;
+    unsigned nr_cores =3D topo_info->cores_per_die;
+    unsigned nr_threads =3D topo_info->threads_per_core;
+    unsigned cores_per_node =3D DIV_ROUND_UP((nr_dies * nr_cores * nr_thre=
ads),
+                                            nr_nodes);
+
+    topo_ids->pkg_id =3D cpu_index / (nr_dies * nr_cores * nr_threads);
+    topo_ids->node_id =3D (cpu_index / cores_per_node) % nr_nodes;
+    topo_ids->die_id =3D cpu_index / (nr_cores * nr_threads) % nr_dies;
+    topo_ids->core_id =3D cpu_index / nr_threads % nr_cores;
+    topo_ids->smt_id =3D cpu_index % nr_threads;
+}
+
+/*
+ * Calculate thread/core/package IDs for a specific topology,
+ * based on APIC ID
+ */
+static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
+                                            X86CPUTopoInfo *topo_info,
+                                            X86CPUTopoIDs *topo_ids)
+{
+    topo_ids->smt_id =3D apicid &
+            ~(0xFFFFFFFFUL << apicid_smt_width(topo_info));
+    topo_ids->core_id =3D
+            (apicid >> apicid_core_offset(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
+    topo_ids->die_id =3D
+            (apicid >> apicid_die_offset(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
+    topo_ids->node_id =3D
+            (apicid >> apicid_node_offset_epyc(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
+    topo_ids->pkg_id =3D apicid >> apicid_pkg_offset_epyc(topo_info);
+}
+
+/*
+ * Make APIC ID for the CPU 'cpu_index'
+ *
+ * 'cpu_index' is a sequential, contiguous ID for the CPU.
+ */
+static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_=
info,
+                                                     unsigned cpu_index)
+{
+    X86CPUTopoIDs topo_ids;
+    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
+    return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
+}
 /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
--=20
2.24.1


