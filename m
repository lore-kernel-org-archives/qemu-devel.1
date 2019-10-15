Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0A7ECE58F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D093E2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D093E2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKUcD-0005RC-Cy
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 17:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKUVw-0004rP-BX
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKUVv-0006gT-4p
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKUVu-0006gL-Sf
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E44B3082231;
 Tue, 15 Oct 2019 21:37:54 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F77F5D70D;
 Tue, 15 Oct 2019 21:37:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org
Subject: [PULL 03/18] numa: Introduce MachineClass::auto_enable_numa for
 implicit NUMA node
Date: Tue, 15 Oct 2019 18:37:30 -0300
Message-Id: <20191015213745.22174-4-ehabkost@redhat.com>
In-Reply-To: <20191015213745.22174-1-ehabkost@redhat.com>
References: <20191015213745.22174-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 15 Oct 2019 21:37:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Tao Xu <tao3.xu@intel.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

Add MachineClass::auto_enable_numa field. When it is true, a NUMA node
is expected to be created implicitly.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20190905083238.1799-1-tao3.xu@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h |  1 +
 hw/core/numa.c      | 10 ++++++++--
 hw/ppc/spapr.c      |  9 +--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index be18a5c032..de45087f34 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -228,6 +228,7 @@ struct MachineClass {
     bool smbus_no_migration_support;
     bool nvdimm_supported;
     bool numa_mem_supported;
+    bool auto_enable_numa;
=20
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 4dfec5c95b..038c96d4ab 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -378,11 +378,17 @@ void numa_complete_configuration(MachineState *ms)
      *   guest tries to use it with that drivers.
      *
      * Enable NUMA implicitly by adding a new NUMA node automatically.
+     *
+     * Or if MachineClass::auto_enable_numa is true and no NUMA nodes,
+     * assume there is just one node with whole RAM.
      */
-    if (ms->ram_slots > 0 && ms->numa_state->num_nodes =3D=3D 0 &&
-        mc->auto_enable_numa_with_memhp) {
+    if (ms->numa_state->num_nodes =3D=3D 0 &&
+        ((ms->ram_slots > 0 &&
+        mc->auto_enable_numa_with_memhp) ||
+        mc->auto_enable_numa)) {
             NumaNodeOptions node =3D { };
             parse_numa_node(ms, &node, &error_abort);
+            numa_info[0].node_mem =3D ram_size;
     }
=20
     assert(max_numa_nodeid <=3D MAX_NODES);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 514a17ae74..4eb97d3a9b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -346,14 +346,6 @@ static int spapr_populate_memory(SpaprMachineState *=
spapr, void *fdt)
     hwaddr mem_start, node_size;
     int i, nb_nodes =3D machine->numa_state->num_nodes;
     NodeInfo *nodes =3D machine->numa_state->nodes;
-    NodeInfo ramnode;
-
-    /* No NUMA nodes, assume there is just one node with whole RAM */
-    if (!nb_nodes) {
-        nb_nodes =3D 1;
-        ramnode.node_mem =3D machine->ram_size;
-        nodes =3D &ramnode;
-    }
=20
     for (i =3D 0, mem_start =3D 0; i < nb_nodes; ++i) {
         if (!nodes[i].node_mem) {
@@ -4430,6 +4422,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
      */
     mc->numa_mem_align_shift =3D 28;
     mc->numa_mem_supported =3D true;
+    mc->auto_enable_numa =3D true;
=20
     smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
--=20
2.21.0


