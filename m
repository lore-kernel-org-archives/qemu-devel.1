Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FAAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1897C230F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1897C230F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GLc-0001Vq-0F
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwT-0004HK-Bf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwQ-0001Fj-7O
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53752)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5FwP-0001B7-EU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD9F23082128;
 Tue,  3 Sep 2019 21:02:11 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7136060BE2;
 Tue,  3 Sep 2019 21:02:11 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 18:01:52 -0300
Message-Id: <20190903210201.14627-5-ehabkost@redhat.com>
In-Reply-To: <20190903210201.14627-1-ehabkost@redhat.com>
References: <20190903210201.14627-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 03 Sep 2019 21:02:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 04/13] numa: move numa global variable
 have_numa_distance into MachineState
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
Cc: Liu Jingqi <jingqi.liu@intel.com>, Tao Xu <tao3.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

Move existing numa global have_numa_distance into NumaState.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20190809065731.9097-4-tao3.xu@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/numa.h    | 4 ++--
 hw/arm/sbsa-ref.c        | 2 +-
 hw/arm/virt-acpi-build.c | 2 +-
 hw/arm/virt.c            | 2 +-
 hw/core/numa.c           | 5 ++---
 hw/i386/acpi-build.c     | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 1786e861d0..bfe04b514c 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -14,8 +14,6 @@ struct CPUArchId;
 #define NUMA_DISTANCE_MAX         254
 #define NUMA_DISTANCE_UNREACHABLE 255
=20
-extern bool have_numa_distance;
-
 struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
@@ -34,6 +32,8 @@ struct NumaState {
     /* Number of NUMA nodes */
     int num_nodes;
=20
+    /* Allow setting NUMA distance for different NUMA nodes */
+    bool have_numa_distance;
 };
 typedef struct NumaState NumaState;
=20
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index d15e5aebbd..7d7bb9fd96 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -160,7 +160,7 @@ static void create_fdt(SBSAMachineState *sms)
     qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
=20
-    if (have_numa_distance) {
+    if (ms->numa_state->have_numa_distance) {
         int size =3D nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t=
);
         uint32_t *matrix =3D g_malloc0(size);
         int idx, i, j;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9e6cfe65b5..b1deb76a53 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -798,7 +798,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuild=
Tables *tables)
     if (ms->numa_state->num_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, vms);
-        if (have_numa_distance) {
+        if (ms->numa_state->have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker, ms);
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8d36b37f8e..414f7ecd02 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -236,7 +236,7 @@ static void create_fdt(VirtMachineState *vms)
                                 "clk24mhz");
     qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", vms->clock_phandl=
e);
=20
-    if (have_numa_distance) {
+    if (nb_numa_nodes > 0 && ms->numa_state->have_numa_distance) {
         int size =3D nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t=
);
         uint32_t *matrix =3D g_malloc0(size);
         int idx, i, j;
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 2712c78adb..4a7adc9b98 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -55,7 +55,6 @@ static int have_mem;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
-bool have_numa_distance;
 NodeInfo numa_info[MAX_NODES];
=20
=20
@@ -173,7 +172,7 @@ void parse_numa_distance(MachineState *ms, NumaDistOp=
tions *dist, Error **errp)
     }
=20
     numa_info[src].distance[dst] =3D val;
-    have_numa_distance =3D true;
+    ms->numa_state->have_numa_distance =3D true;
 }
=20
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p)
@@ -446,7 +445,7 @@ void numa_complete_configuration(MachineState *ms)
          * asymmetric. In this case, the distances for both directions
          * of all node pairs are required.
          */
-        if (have_numa_distance) {
+        if (ms->numa_state->have_numa_distance) {
             /* Validate enough NUMA distance information was provided. *=
/
             validate_numa_distance(ms);
=20
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3c5868322b..e54e571a75 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2694,7 +2694,7 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
     if (pcms->numa_nodes) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, machine);
-        if (have_numa_distance) {
+        if (machine->numa_state->have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker, machine);
         }
--=20
2.21.0


