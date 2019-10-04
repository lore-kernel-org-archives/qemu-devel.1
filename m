Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B88EC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C14215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pPxRe5gQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C14215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGKZy-0007CC-KC
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2k-0005OO-07
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2i-0005Vc-3H
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:33 -0400
Received: from ozlabs.org ([203.11.71.1]:58615)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2h-0005Rh-La; Fri, 04 Oct 2019 05:38:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YM444Gz9sSD; Fri,  4 Oct 2019 19:37:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181879;
 bh=KkBbadXgHLKHE0giSnukY5QoB/39g3F8C/fxNfwAoZ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pPxRe5gQtwN1g5osgkniLUaMcKIJ4UTvFkODLWmHL6qR6FDbssNBXpKx7oA4rCKfW
 pKLiav7I/AItMmIs+NBeqhew2ffTTaZ/bTZRNABoBaJpusTwiTQe8Zeke3c7Yu9xq1
 Xp3x+ciiBwuj5gXcvFjCH5x6xBAupG2G5eN5VsKs=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 30/53] spapr: Render full FDT on ibm,
 client-architecture-support
Date: Fri,  4 Oct 2019 19:37:24 +1000
Message-Id: <20191004093747.31350-31-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The ibm,client-architecture-support call is a way for the guest to
negotiate capabilities with a hypervisor. It is implemented as:
- the guest calls SLOF via client interface;
- SLOF calls QEMU (H_CAS hypercall) with an options vector from the guest=
;
- QEMU returns a device tree diff (which uses FDT format with
an additional header before it);
- SLOF walks through the partial diff tree and updates its internal tree
with the values from the diff.

This changes QEMU to simply re-render the entire tree and send it as
an update. SLOF can handle this already mostly, [1] is needed before this
can be applied. This stores the resulting tree in the spapr machine to ha=
ve
the latest valid FDT copy possible (this should not matter much as
H_UPDATE_DT happens right after that but nevertheless).

The benefit is reduced code size as there is no need for another set of
DT rendering helpers such as spapr_fixup_cpu_dt().

The downside is that the updates are bigger now (as they include all
nodes and properties) but the difference on a '-smp 256,threads=3D1' syst=
em
before/after is 2.35s vs. 2.5s.

[1] https://patchwork.ozlabs.org/patch/1152915/

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 88 ++++++--------------------------------------------
 1 file changed, 9 insertions(+), 79 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3742a8cf06..43920c140d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -295,64 +295,6 @@ static void spapr_populate_pa_features(SpaprMachineS=
tate *spapr,
     _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_si=
ze)));
 }
=20
-static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
-{
-    MachineState *ms =3D MACHINE(spapr);
-    int ret =3D 0, offset, cpus_offset;
-    CPUState *cs;
-    char cpu_model[32];
-    uint32_t pft_size_prop[] =3D {0, cpu_to_be32(spapr->htab_shift)};
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-        DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
-        int index =3D spapr_get_vcpu_id(cpu);
-        int compat_smt =3D MIN(ms->smp.threads, ppc_compat_max_vthreads(=
cpu));
-
-        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
-            continue;
-        }
-
-        snprintf(cpu_model, 32, "%s@%x", dc->fw_name, index);
-
-        cpus_offset =3D fdt_path_offset(fdt, "/cpus");
-        if (cpus_offset < 0) {
-            cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
-            if (cpus_offset < 0) {
-                return cpus_offset;
-            }
-        }
-        offset =3D fdt_subnode_offset(fdt, cpus_offset, cpu_model);
-        if (offset < 0) {
-            offset =3D fdt_add_subnode(fdt, cpus_offset, cpu_model);
-            if (offset < 0) {
-                return offset;
-            }
-        }
-
-        ret =3D fdt_setprop(fdt, offset, "ibm,pft-size",
-                          pft_size_prop, sizeof(pft_size_prop));
-        if (ret < 0) {
-            return ret;
-        }
-
-        if (ms->numa_state->num_nodes > 1) {
-            ret =3D spapr_fixup_cpu_numa_dt(fdt, offset, cpu);
-            if (ret < 0) {
-                return ret;
-            }
-        }
-
-        ret =3D spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt);
-        if (ret < 0) {
-            return ret;
-        }
-
-        spapr_populate_pa_features(spapr, cpu, fdt, offset);
-    }
-    return ret;
-}
-
 static hwaddr spapr_node0_size(MachineState *machine)
 {
     if (machine->numa_state->num_nodes) {
@@ -983,11 +925,13 @@ static bool spapr_hotplugged_dev_before_cas(void)
     return false;
 }
=20
+static void *spapr_build_fdt(SpaprMachineState *spapr);
+
 int spapr_h_cas_compose_response(SpaprMachineState *spapr,
                                  target_ulong addr, target_ulong size,
                                  SpaprOptionVector *ov5_updates)
 {
-    void *fdt, *fdt_skel;
+    void *fdt;
     SpaprDeviceTreeUpdateHeader hdr =3D { .version_id =3D 1 };
=20
     if (spapr_hotplugged_dev_before_cas()) {
@@ -1003,25 +947,7 @@ int spapr_h_cas_compose_response(SpaprMachineState =
*spapr,
=20
     size -=3D sizeof(hdr);
=20
-    /* Create skeleton */
-    fdt_skel =3D g_malloc0(size);
-    _FDT((fdt_create(fdt_skel, size)));
-    _FDT((fdt_finish_reservemap(fdt_skel)));
-    _FDT((fdt_begin_node(fdt_skel, "")));
-    _FDT((fdt_end_node(fdt_skel)));
-    _FDT((fdt_finish(fdt_skel)));
-    fdt =3D g_malloc0(size);
-    _FDT((fdt_open_into(fdt_skel, fdt, size)));
-    g_free(fdt_skel);
-
-    /* Fixup cpu nodes */
-    _FDT((spapr_fixup_cpu_dt(fdt, spapr)));
-
-    if (spapr_dt_cas_updates(spapr, fdt, ov5_updates)) {
-        return -1;
-    }
-
-    /* Pack resulting tree */
+    fdt =3D spapr_build_fdt(spapr);
     _FDT((fdt_pack(fdt)));
=20
     if (fdt_totalsize(fdt) + sizeof(hdr) > size) {
@@ -1033,7 +959,11 @@ int spapr_h_cas_compose_response(SpaprMachineState =
*spapr,
     cpu_physical_memory_write(addr, &hdr, sizeof(hdr));
     cpu_physical_memory_write(addr + sizeof(hdr), fdt, fdt_totalsize(fdt=
));
     trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
-    g_free(fdt);
+
+    g_free(spapr->fdt_blob);
+    spapr->fdt_size =3D fdt_totalsize(fdt);
+    spapr->fdt_initial_size =3D spapr->fdt_size;
+    spapr->fdt_blob =3D fdt;
=20
     return 0;
 }
--=20
2.21.0


