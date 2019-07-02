Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1EBC4646D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEA121721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RguI+KUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEA121721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCwk-0006Y1-Dc
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58818)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzK-0005Ne-F5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzI-0003GO-KS
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:58 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45211 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBzH-0002wS-Bo; Tue, 02 Jul 2019 02:09:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMk58rzz9sPv; Tue,  2 Jul 2019 16:09:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047746;
 bh=KvUuUxnqPIlSOE4K0wqSk8jUw/rVwZt3I6uPIyNI4mI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RguI+KUoGRilSmMghQW9NZ4l1iFCjIjdTfkYABoFe8hBY8gcQfvKjOZk8eVlY79+A
 +2LLV1a4seTffIItRYdwYjbjEMDeR4bShqu5p2bsf2FeI/+AMq2RXxxtkgG84CwELG
 v2weE3IH7OoTGuYnJ6qWIg/fYfFccsgRU1EfQvjo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:35 +1000
Message-Id: <20190702060857.3926-28-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 27/49] ppc: Introduce kvmppc_set_reg_tb_offset()
 helper
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Introduce a KVM helper and its stub instead of guarding the code with
CONFIG_KVM.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156051055736.224162.11641594431517798715.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc.c         | 5 +----
 target/ppc/kvm.c     | 9 +++++++++
 target/ppc/kvm_ppc.h | 5 +++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 288196dfa6..a9e508c496 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1034,10 +1034,7 @@ static void timebase_load(PPCTimebase *tb)
     CPU_FOREACH(cpu) {
         PowerPCCPU *pcpu =3D POWERPC_CPU(cpu);
         pcpu->env.tb_env->tb_offset =3D tb_off_adj;
-#if defined(CONFIG_KVM)
-        kvm_set_one_reg(cpu, KVM_REG_PPC_TB_OFFSET,
-                        &pcpu->env.tb_env->tb_offset);
-#endif
+        kvmppc_set_reg_tb_offset(pcpu, pcpu->env.tb_env->tb_offset);
     }
 }
=20
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9014ed029f..8a06d3171e 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2944,3 +2944,12 @@ void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, un=
signed int online)
         kvm_set_one_reg(cs, KVM_REG_PPC_ONLINE, &online);
     }
 }
+
+void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
+{
+    CPUState *cs =3D CPU(cpu);
+
+    if (kvm_enabled()) {
+        kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
+    }
+}
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 45776cad79..e642aaaf92 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -80,6 +80,7 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 bool kvmppc_hpt_needs_host_contiguous_pages(void);
 void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
 void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
+void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
=20
 #else
=20
@@ -206,6 +207,10 @@ static inline void kvmppc_set_reg_ppc_online(PowerPC=
CPU *cpu,
     return;
 }
=20
+static inline void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_=
offset)
+{
+}
+
 #ifndef CONFIG_USER_ONLY
 static inline bool kvmppc_spapr_use_multitce(void)
 {
--=20
2.21.0


