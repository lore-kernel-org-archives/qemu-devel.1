Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A08C2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018A820714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="V5jCrBSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018A820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGbv7-0005wO-3u
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 01:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu4-0004Z7-9K
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbu3-0001au-3a
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:15:04 -0400
Received: from ozlabs.org ([203.11.71.1]:38149)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGbu2-0001Zh-1c; Tue, 24 Mar 2020 01:15:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48mfZW2ydnz9sQt; Tue, 24 Mar 2020 16:14:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585026899;
 bh=3li+HUL8pZwLDA6kLng6EhW+vWa7Ark5fqLG2FNEfLk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V5jCrBSYafRVievJ92CFo+ZFvrctHtsdZXGtrZyngREyw0dvq8gXJdjHbx56+Kd5M
 zvj638qWCNCA8IzPNBrW4E5oq8sbStGD7G8bL8/AyPaPcxYRFMxclgKgPZNROmSmxY
 NyfLcOJ02ESCOWrfCodWL0Hw3vLvUKs2VU/hh1f8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 1/7] ppc/spapr: Set the effective address provided flag in mc
 error log.
Date: Tue, 24 Mar 2020 16:14:50 +1100
Message-Id: <20200324051456.256116-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324051456.256116-1-david@gibson.dropbear.id.au>
References: <20200324051456.256116-1-david@gibson.dropbear.id.au>
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Per PAPR, it is expected to set effective address provided flag in
sub_err_type member of mc extended error log (i.e
rtas_event_log_v6_mc.sub_err_type). This somehow got missed in original
fwnmi-mce patch series. The current code just updates the effective addre=
ss
but does not set the flag to indicate that it is available. Hence guest
fails to extract effective address from mce rtas log. This patch fixes
that.

Without this patch guest MCE logs fails print DAR value:

[   11.933608] Disabling lock debugging due to kernel taint
[   11.933773] MCE: CPU0: machine check (Severe) Host TLB Multihit [Recov=
ered]
[   11.933979] MCE: CPU0: NIP: [c000000000090b34] radix__flush_tlb_range_=
psize+0x194/0xf00
[   11.934223] MCE: CPU0: Initiator CPU
[   11.934341] MCE: CPU0: Unknown

After the change:

[   22.454149] Disabling lock debugging due to kernel taint
[   22.454316] MCE: CPU0: machine check (Severe) Host TLB Multihit DAR: d=
eadbeefdeadbeef [Recovered]
[   22.454605] MCE: CPU0: NIP: [c0000000003e5804] kmem_cache_alloc+0x84/0=
x330
[   22.454820] MCE: CPU0: Initiator CPU
[   22.454944] MCE: CPU0: Unknown

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Message-Id: <158451653844.22972.17999316676230071087.stgit@jupiter>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_events.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 323fcef4aa..a4a540f43d 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -243,6 +243,14 @@ struct rtas_event_log_v6_mc {
 #define RTAS_LOG_V6_MC_TLB_PARITY                        1
 #define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
 #define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
+/*
+ * Per PAPR,
+ * For UE error type, set bit 1 of sub_err_type to indicate effective ad=
dr is
+ * provided. For other error types (SLB/ERAT/TLB), set bit 0 to indicate
+ * same.
+ */
+#define RTAS_LOG_V6_MC_UE_EA_ADDR_PROVIDED               0x40
+#define RTAS_LOG_V6_MC_EA_ADDR_PROVIDED                  0x80
     uint8_t reserved_1[6];
     uint64_t effective_address;
     uint64_t logical_address;
@@ -726,6 +734,22 @@ void spapr_hotplug_req_remove_by_count_indexed(Spapr=
DrcType drc_type,
                             RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc=
_id);
 }
=20
+static void spapr_mc_set_ea_provided_flag(struct mc_extended_log *ext_el=
og)
+{
+    switch (ext_elog->mc.error_type) {
+    case RTAS_LOG_V6_MC_TYPE_UE:
+        ext_elog->mc.sub_err_type |=3D RTAS_LOG_V6_MC_UE_EA_ADDR_PROVIDE=
D;
+        break;
+    case RTAS_LOG_V6_MC_TYPE_SLB:
+    case RTAS_LOG_V6_MC_TYPE_ERAT:
+    case RTAS_LOG_V6_MC_TYPE_TLB:
+        ext_elog->mc.sub_err_type |=3D RTAS_LOG_V6_MC_EA_ADDR_PROVIDED;
+        break;
+    default:
+        break;
+    }
+}
+
 static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
                                         struct mc_extended_log *ext_elog=
)
 {
@@ -751,6 +775,7 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *c=
pu, bool recovered,
             ext_elog->mc.sub_err_type =3D mc_derror_table[i].error_subty=
pe;
             if (mc_derror_table[i].dar_valid) {
                 ext_elog->mc.effective_address =3D cpu_to_be64(env->spr[=
SPR_DAR]);
+                spapr_mc_set_ea_provided_flag(ext_elog);
             }
=20
             summary |=3D mc_derror_table[i].initiator
@@ -769,6 +794,7 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *c=
pu, bool recovered,
             ext_elog->mc.sub_err_type =3D mc_ierror_table[i].error_subty=
pe;
             if (mc_ierror_table[i].nip_valid) {
                 ext_elog->mc.effective_address =3D cpu_to_be64(env->nip)=
;
+                spapr_mc_set_ea_provided_flag(ext_elog);
             }
=20
             summary |=3D mc_ierror_table[i].initiator
--=20
2.25.1


