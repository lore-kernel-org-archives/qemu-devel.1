Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913B2C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B37620663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDYJ3VYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B37620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENQL-0002bJ-Dg
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLc-0004KR-IX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLa-0001rB-EE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLa-0001mV-12
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ee1lMh7e2gW2tg/Gbem+6EUMfUGQDqgf65E4cU6r3Zg=;
 b=dDYJ3VYdS44n1z7AEL3tRw5ZQTA3EjPuKG48PhLACgknE2EJa1m/rDvsw3Lqajb+uMTdUR
 DkSGkqzf3AFh/z4dxvdN/I6zcGUhwJqclr6TnBJxwJzcrNpEY79SyBVWiZcFYy6rqiwBc7
 FRT6HioCtMNwY8M1/DJfaFOPog15bMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-oGGpmKNBOVm7n3DiBs4Njg-1; Tue, 17 Mar 2020 21:18:10 -0400
X-MC-Unique: oGGpmKNBOVm7n3DiBs4Njg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D028E18A5502;
 Wed, 18 Mar 2020 01:18:08 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F8E419C58;
 Wed, 18 Mar 2020 01:18:08 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/13] hw/i386: Introduce X86CPUTopoInfo to contain topology
 info
Date: Tue, 17 Mar 2020 21:17:43 -0400
Message-Id: <20200318011748.2104336-9-ehabkost@redhat.com>
In-Reply-To: <20200318011748.2104336-1-ehabkost@redhat.com>
References: <20200318011748.2104336-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Babu Moger <babu.moger@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

This is an effort to re-arrange few data structure for better readability.

1. Add X86CPUTopoInfo which will have all the topology informations
   required to build the cpu topology. There is no functional changes.

2. Introduce init_topo_info to initialize X86CPUTopoInfo members from
   X86MachineState.

3. Update x86 unit tests for new calling convention with parameter X86CPUTo=
poInfo

There is no functional changes.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Message-Id: <158396717251.58170.4499717831243474938.stgit@naples-babu.amd.c=
om>
---
 hw/i386/pc.c               | 12 +++++------
 hw/i386/x86.c              | 32 +++++++++++++++++++++-------
 include/hw/i386/topology.h | 38 ++++++++++++++++++++-------------
 include/hw/i386/x86.h      |  3 +++
 tests/test-x86-cpuid.c     | 43 +++++++++++++++++++++-----------------
 5 files changed, 81 insertions(+), 47 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f52e84b2ba..662abb549d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1513,6 +1513,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_d=
ev,
     X86MachineState *x86ms =3D X86_MACHINE(pcms);
     unsigned int smp_cores =3D ms->smp.cores;
     unsigned int smp_threads =3D ms->smp.threads;
+    X86CPUTopoInfo topo_info;
=20
     if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
         error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
@@ -1520,6 +1521,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_d=
ev,
         return;
     }
=20
+    init_topo_info(&topo_info, x86ms);
+
     env->nr_dies =3D x86ms->smp_dies;
=20
     /*
@@ -1575,16 +1578,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
         topo_ids.die_id =3D cpu->die_id;
         topo_ids.core_id =3D cpu->core_id;
         topo_ids.smt_id =3D cpu->thread_id;
-        cpu->apic_id =3D apicid_from_topo_ids(x86ms->smp_dies, smp_cores,
-                                            smp_threads, &topo_ids);
+        cpu->apic_id =3D apicid_from_topo_ids(&topo_info, &topo_ids);
     }
=20
     cpu_slot =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     if (!cpu_slot) {
         MachineState *ms =3D MACHINE(pcms);
=20
-        x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
-                                 smp_cores, smp_threads, &topo_ids);
+        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
             " APIC ID %" PRIu32 ", valid index range 0:%d",
@@ -1605,8 +1606,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_d=
ev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizef=
n()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globa=
ls */
-    x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
-                             smp_cores, smp_threads, &topo_ids);
+    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
     if (cpu->socket_id !=3D -1 && cpu->socket_id !=3D topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id=
:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index c6ee5aac8c..b7d94e8dfe 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -57,6 +57,16 @@
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
=20
+inline void init_topo_info(X86CPUTopoInfo *topo_info,
+                           const X86MachineState *x86ms)
+{
+    MachineState *ms =3D MACHINE(x86ms);
+
+    topo_info->dies_per_pkg =3D x86ms->smp_dies;
+    topo_info->cores_per_die =3D ms->smp.cores;
+    topo_info->threads_per_core =3D ms->smp.threads;
+}
+
 /*
  * Calculates initial APIC ID for a specific CPU index
  *
@@ -68,13 +78,14 @@ static size_t pvh_start_addr;
 uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
                                     unsigned int cpu_index)
 {
-    MachineState *ms =3D MACHINE(x86ms);
     X86MachineClass *x86mc =3D X86_MACHINE_GET_CLASS(x86ms);
+    X86CPUTopoInfo topo_info;
     uint32_t correct_id;
     static bool warned;
=20
-    correct_id =3D x86_apicid_from_cpu_idx(x86ms->smp_dies, ms->smp.cores,
-                                         ms->smp.threads, cpu_index);
+    init_topo_info(&topo_info, x86ms);
+
+    correct_id =3D x86_apicid_from_cpu_idx(&topo_info, cpu_index);
     if (x86mc->compat_apic_id_mode) {
         if (cpu_index !=3D correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -145,19 +156,22 @@ int64_t x86_get_default_cpu_node_id(const MachineStat=
e *ms, int idx)
 {
    X86CPUTopoIDs topo_ids;
    X86MachineState *x86ms =3D X86_MACHINE(ms);
+   X86CPUTopoInfo topo_info;
+
+   init_topo_info(&topo_info, x86ms);
=20
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            x86ms->smp_dies, ms->smp.cores,
-                            ms->smp.threads, &topo_ids);
+                            &topo_info, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
=20
 const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 {
     X86MachineState *x86ms =3D X86_MACHINE(ms);
-    int i;
     unsigned int max_cpus =3D ms->smp.max_cpus;
+    X86CPUTopoInfo topo_info;
+    int i;
=20
     if (ms->possible_cpus) {
         /*
@@ -171,6 +185,9 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineS=
tate *ms)
     ms->possible_cpus =3D g_malloc0(sizeof(CPUArchIdList) +
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len =3D max_cpus;
+
+    init_topo_info(&topo_info, x86ms);
+
     for (i =3D 0; i < ms->possible_cpus->len; i++) {
         X86CPUTopoIDs topo_ids;
=20
@@ -179,8 +196,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineS=
tate *ms)
         ms->possible_cpus->cpus[i].arch_id =3D
             x86_cpu_apic_id_from_index(x86ms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 x86ms->smp_dies, ms->smp.cores,
-                                 ms->smp.threads, &topo_ids);
+                                 &topo_info, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id =3D true;
         ms->possible_cpus->cpus[i].props.socket_id =3D topo_ids.pkg_id;
         if (x86ms->smp_dies > 1) {
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 52def68610..7ea507f376 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -52,6 +52,12 @@ typedef struct X86CPUTopoIDs {
     unsigned smt_id;
 } X86CPUTopoIDs;
=20
+typedef struct X86CPUTopoInfo {
+    unsigned dies_per_pkg;
+    unsigned cores_per_die;
+    unsigned threads_per_core;
+} X86CPUTopoInfo;
+
 /* Return the bit width needed for 'count' IDs
  */
 static unsigned apicid_bitwidth_for_count(unsigned count)
@@ -119,11 +125,13 @@ static inline unsigned apicid_pkg_offset(unsigned nr_=
dies,
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
  */
-static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
-                                             unsigned nr_cores,
-                                             unsigned nr_threads,
+static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
                                              const X86CPUTopoIDs *topo_ids=
)
 {
+    unsigned nr_dies =3D topo_info->dies_per_pkg;
+    unsigned nr_cores =3D topo_info->cores_per_die;
+    unsigned nr_threads =3D topo_info->threads_per_core;
+
     return (topo_ids->pkg_id  <<
                apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
            (topo_ids->die_id  <<
@@ -136,12 +144,14 @@ static inline apic_id_t apicid_from_topo_ids(unsigned=
 nr_dies,
 /* Calculate thread/core/package IDs for a specific topology,
  * based on (contiguous) CPU index
  */
-static inline void x86_topo_ids_from_idx(unsigned nr_dies,
-                                         unsigned nr_cores,
-                                         unsigned nr_threads,
+static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
                                          unsigned cpu_index,
                                          X86CPUTopoIDs *topo_ids)
 {
+    unsigned nr_dies =3D topo_info->dies_per_pkg;
+    unsigned nr_cores =3D topo_info->cores_per_die;
+    unsigned nr_threads =3D topo_info->threads_per_core;
+
     topo_ids->pkg_id =3D cpu_index / (nr_dies * nr_cores * nr_threads);
     topo_ids->die_id =3D cpu_index / (nr_cores * nr_threads) % nr_dies;
     topo_ids->core_id =3D cpu_index / nr_threads % nr_cores;
@@ -152,11 +162,13 @@ static inline void x86_topo_ids_from_idx(unsigned nr_=
dies,
  * based on APIC ID
  */
 static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
-                                            unsigned nr_dies,
-                                            unsigned nr_cores,
-                                            unsigned nr_threads,
+                                            X86CPUTopoInfo *topo_info,
                                             X86CPUTopoIDs *topo_ids)
 {
+    unsigned nr_dies =3D topo_info->dies_per_pkg;
+    unsigned nr_cores =3D topo_info->cores_per_die;
+    unsigned nr_threads =3D topo_info->threads_per_core;
+
     topo_ids->smt_id =3D apicid &
             ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threa=
ds));
     topo_ids->core_id =3D
@@ -173,14 +185,12 @@ static inline void x86_topo_ids_from_apicid(apic_id_t=
 apicid,
  *
  * 'cpu_index' is a sequential, contiguous ID for the CPU.
  */
-static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_dies,
-                                                unsigned nr_cores,
-                                                unsigned nr_threads,
+static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
                                                 unsigned cpu_index)
 {
     X86CPUTopoIDs topo_ids;
-    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo_=
ids);
-    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo_ids);
+    x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
+    return apicid_from_topo_ids(topo_info, &topo_ids);
 }
=20
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 41fe37b8a3..22babcb3bb 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -21,6 +21,7 @@
 #include "exec/hwaddr.h"
 #include "qemu/notify.h"
=20
+#include "hw/i386/topology.h"
 #include "hw/boards.h"
 #include "hw/nmi.h"
 #include "hw/isa/isa.h"
@@ -82,6 +83,8 @@ typedef struct {
 #define X86_MACHINE_CLASS(class) \
     OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
=20
+void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86m=
s);
+
 uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
                                     unsigned int cpu_index);
=20
diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
index 1942287f33..66b953113b 100644
--- a/tests/test-x86-cpuid.c
+++ b/tests/test-x86-cpuid.c
@@ -28,15 +28,18 @@
=20
 static void test_topo_bits(void)
 {
+    X86CPUTopoInfo topo_info =3D {0};
+
     /* simple tests for 1 thread per core, 1 core per die, 1 die per packa=
ge */
     g_assert_cmpuint(apicid_smt_width(1, 1, 1), =3D=3D, 0);
     g_assert_cmpuint(apicid_core_width(1, 1, 1), =3D=3D, 0);
     g_assert_cmpuint(apicid_die_width(1, 1, 1), =3D=3D, 0);
=20
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 0), =3D=3D, 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 1), =3D=3D, 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 2), =3D=3D, 2);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 3), =3D=3D, 3);
+    topo_info =3D (X86CPUTopoInfo) {1, 1, 1};
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), =3D=3D, 0);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), =3D=3D, 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), =3D=3D, 2);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 3), =3D=3D, 3);
=20
=20
     /* Test field width calculation for multiple values
@@ -71,36 +74,38 @@ static void test_topo_bits(void)
     g_assert_cmpuint(apicid_die_offset(1, 6, 3), =3D=3D, 5);
     g_assert_cmpuint(apicid_pkg_offset(1, 6, 3), =3D=3D, 5);
=20
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 0), =3D=3D, 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1), =3D=3D, 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2), =3D=3D, 2);
+    topo_info =3D (X86CPUTopoInfo) {1, 6, 3};
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), =3D=3D, 0);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), =3D=3D, 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), =3D=3D, 2);
=20
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 0), =3D=3D,
+    topo_info =3D (X86CPUTopoInfo) {1, 6, 3};
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), =3D=
=3D,
                      (1 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 1), =3D=3D,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), =3D=
=3D,
                      (1 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 2), =3D=3D,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 2), =3D=
=3D,
                      (1 << 2) | 2);
=20
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 0), =3D=3D,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 0), =3D=
=3D,
                      (2 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 1), =3D=3D,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 1), =3D=
=3D,
                      (2 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 2), =3D=3D,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 2), =3D=
=3D,
                      (2 << 2) | 2);
=20
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 0), =3D=3D,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 0), =3D=
=3D,
                      (5 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 1), =3D=3D,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 1), =3D=
=3D,
                      (5 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 2), =3D=3D,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 2), =3D=
=3D,
                      (5 << 2) | 2);
=20
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
                      1 * 6 * 3 + 0 * 3 + 0), =3D=3D, (1 << 5));
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
                      1 * 6 * 3 + 1 * 3 + 1), =3D=3D, (1 << 5) | (1 << 2) |=
 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
                      3 * 6 * 3 + 5 * 3 + 2), =3D=3D, (3 << 5) | (5 << 2) |=
 2);
 }
=20
--=20
2.24.1


