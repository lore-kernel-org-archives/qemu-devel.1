Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86314C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3395420771
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3395420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnnM-0008HA-8c
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhu-0006lB-B0
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21678
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHnhr-0000kN-Ur
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:35:41 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-nlFSvRpSMYmS6EP5uWjuFg-1; Mon, 14 Sep 2020 08:35:34 -0400
X-MC-Unique: nlFSvRpSMYmS6EP5uWjuFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FDDD1021D2F;
 Mon, 14 Sep 2020 12:35:33 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C51991002393;
 Mon, 14 Sep 2020 12:35:31 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/15] spapr: Add a return value to spapr_set_vcpu_id()
Date: Mon, 14 Sep 2020 14:35:00 +0200
Message-Id: <20200914123505.612812-11-groug@kaod.org>
In-Reply-To: <20200914123505.612812-1-groug@kaod.org>
References: <20200914123505.612812-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.81; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Greg Kurz <groug@kaod.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As recommended in "qapi/error.h", return true on success and false on
failure. This allows to reduce error propagation overhead in the callers.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/hw/ppc/spapr.h  | 2 +-
 hw/ppc/spapr.c          | 5 +++--
 hw/ppc/spapr_cpu_core.c | 5 +----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c8cd63bc0667..11682f00e8cc 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -909,7 +909,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_=
cpu_data arg);
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
=20
 int spapr_get_vcpu_id(PowerPCCPU *cpu);
-void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
+bool spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
 PowerPCCPU *spapr_find_cpu(int vcpu_id);
=20
 int spapr_caps_pre_load(void *opaque);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8b2b4e6272e6..e11472a53ab4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4289,7 +4289,7 @@ int spapr_get_vcpu_id(PowerPCCPU *cpu)
     return cpu->vcpu_id;
 }
=20
-void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp)
+bool spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
     MachineState *ms =3D MACHINE(spapr);
@@ -4302,10 +4302,11 @@ void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_ind=
ex, Error **errp)
         error_append_hint(errp, "Adjust the number of cpus to %d "
                           "or try to raise the number of threads per core\=
n",
                           vcpu_id * ms->smp.threads / spapr->vsmt);
-        return;
+        return false;
     }
=20
     cpu->vcpu_id =3D vcpu_id;
+    return true;
 }
=20
 PowerPCCPU *spapr_find_cpu(int vcpu_id)
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 3e4f402b2e9f..0c879d4da262 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -262,7 +262,6 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, =
int i, Error **errp)
     char *id;
     CPUState *cs;
     PowerPCCPU *cpu;
-    Error *local_err =3D NULL;
=20
     obj =3D object_new(scc->cpu_type);
=20
@@ -274,8 +273,7 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, =
int i, Error **errp)
      */
     cs->start_powered_off =3D true;
     cs->cpu_index =3D cc->core_id + i;
-    spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
-    if (local_err) {
+    if (!spapr_set_vcpu_id(cpu, cs->cpu_index, errp)) {
         goto err;
     }
=20
@@ -292,7 +290,6 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, =
int i, Error **errp)
=20
 err:
     object_unref(obj);
-    error_propagate(errp, local_err);
     return NULL;
 }
=20
--=20
2.26.2


