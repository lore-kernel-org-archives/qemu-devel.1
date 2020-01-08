Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BD7C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5277D20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nvBPAPJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5277D20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3qD-0005oP-Sx
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oX-0003qM-Ll
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oW-0002cu-5Z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:29 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:58913 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oV-0002UO-FH; Wed, 08 Jan 2020 00:23:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syMB0q2mz9sS3; Wed,  8 Jan 2020 16:23:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460998;
 bh=is8eYfBULY1O20eZEsh/522Pn0d1Nm9PMUQznMIJdgU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nvBPAPJHbxzNrdQeXEdNL6RsOWXcWWX4XL5q4i/hSrNJosozduPJHNzwEdlWHIu/u
 xEOXMMl6dZMt8T9Tx5Hk5+0duvXctoETNGz+BeN4REoIpeMrOQeWVRJeGSLWI3hDqM
 BhlsW30G0P8WjfcTYy0m18StKG5CUmXFHb/LmSyc=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 04/26] ppc/spapr: Support reboot of secure pseries guest
Date: Wed,  8 Jan 2020 16:22:50 +1100
Message-Id: <20200108052312.238710-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org,
 Bharata B Rao <bharata@linux.ibm.com>, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharata B Rao <bharata@linux.ibm.com>

A pseries guest can be run as a secure guest on Ultravisor-enabled
POWER platforms. When such a secure guest is reset, we need to
release/reset a few resources both on ultravisor and hypervisor side.
This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
machine reset path.

As part of this ioctl, the secure guest is essentially transitioned
back to normal mode so that it can reboot like a regular guest and
become secure again.

This ioctl has no effect when invoked for a normal guest. If this ioctl
fails for a secure guest, the guest is terminated.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
Message-Id: <20191219031445.8949-3-bharata@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       |  1 +
 target/ppc/kvm.c     | 15 +++++++++++++++
 target/ppc/kvm_ppc.h |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f11422fc41..e62c89b3dd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1597,6 +1597,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
     void *fdt;
     int rc;
=20
+    kvmppc_svm_off(&error_fatal);
     spapr_caps_apply(spapr);
=20
     first_ppc_cpu =3D POWERPC_CPU(first_cpu);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 5e4f219902..45a26c0fc6 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2894,3 +2894,18 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int=
64_t tb_offset)
         kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
     }
 }
+
+/*
+ * Don't set error if KVM_PPC_SVM_OFF ioctl is invoked on kernels
+ * that don't support this ioctl.
+ */
+void kvmppc_svm_off(Error **errp)
+{
+    int rc;
+    KVMState *s =3D KVM_STATE(current_machine->accelerator);
+
+    rc =3D kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
+    if (rc && rc !=3D -ENOTTY) {
+        error_setg_errno(errp, -rc, "KVM_PPC_SVM_OFF ioctl failed");
+    }
+}
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index f22daabf51..b713097bfb 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -37,6 +37,7 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
 target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
                                      bool radix, bool gtse,
                                      uint64_t proc_tbl);
+void kvmppc_svm_off(Error **errp);
 #ifndef CONFIG_USER_ONLY
 bool kvmppc_spapr_use_multitce(void);
 int kvmppc_spapr_enable_inkernel_multitce(void);
@@ -201,6 +202,11 @@ static inline target_ulong kvmppc_configure_v3_mmu(P=
owerPCCPU *cpu,
     return 0;
 }
=20
+static inline void kvmppc_svm_off(Error **errp)
+{
+    return;
+}
+
 static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
                                              unsigned int online)
 {
--=20
2.24.1


