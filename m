Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4258C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 03:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F83A206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 03:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F83A206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCbNK-0008Bj-RF
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 23:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangyifei@huawei.com>) id 1jCbMJ-0006tg-AF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 23:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangyifei@huawei.com>) id 1jCbMH-0000b3-Nk
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 23:51:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35008 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiangyifei@huawei.com>)
 id 1jCbMH-0000SJ-Ay; Thu, 12 Mar 2020 23:51:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9C4DA5360106C1A36A6D;
 Fri, 13 Mar 2020 11:51:31 +0800 (CST)
Received: from huawei.com (10.133.201.158) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 13 Mar 2020
 11:51:22 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH RFC 5/9] target/riscv: Implement kvm_arch_put_registers
Date: Fri, 13 Mar 2020 11:49:45 +0800
Message-ID: <20200313034949.3028-6-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200313034949.3028-1-jiangyifei@huawei.com>
References: <20200313034949.3028-1-jiangyifei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.201.158]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: anup.patel@wdc.com, zhang.zhanghailiang@huawei.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 victor.zhangxiaofeng@huawei.com, Alistair.Francis@wdc.com,
 yinyipeng1@huawei.com, palmer@dabbelt.com, Yifei Jiang <jiangyifei@huawei.com>,
 dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Put GPR CSR and FP registers by kvm by KVM_SET_ONE_REG ioctl

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
---
 target/riscv/kvm.c | 136 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 8d5069b9e9..6dffda36bb 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -85,6 +85,31 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
     return ret;
 }
=20
+static int kvm_riscv_put_regs_core(CPUState *cs)
+{
+    int ret =3D 0;
+    int i;
+    uint64_t reg;
+    CPURISCVState *env =3D &RISCV_CPU(cs)->env;
+
+    reg =3D env->pc;
+    ret =3D kvm_set_one_reg(cs, RISCV_CORE_REG(regs.pc), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    for (i =3D 1; i < 32; i++) {
+        __u64 id =3D kvm_riscv_reg_id(KVM_REG_RISCV_CORE, i);
+        reg =3D env->gpr[i];
+        ret =3D kvm_set_one_reg(cs, id, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return ret;
+}
+
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
     int ret =3D 0;
@@ -142,6 +167,64 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     return ret;
 }
=20
+static int kvm_riscv_put_regs_csr(CPUState *cs)
+{
+    int ret =3D 0;
+    uint64_t reg;
+    CPURISCVState *env =3D &RISCV_CPU(cs)->env;
+
+    reg =3D env->mstatus;
+    ret =3D kvm_set_one_reg(cs, RISCV_CSR_REG(sstatus), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg =3D env->mie;
+    ret =3D kvm_set_one_reg(cs, RISCV_CSR_REG(sie), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg =3D env->stvec;
+    ret =3D kvm_set_one_reg(cs, RISCV_CSR_REG(stvec), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg =3D env->sscratch;
+    ret =3D kvm_set_one_reg(cs, RISCV_CSR_REG(sscratch), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg =3D env->sepc;
+    ret =3D kvm_set_one_reg(cs, RISCV_CSR_REG(sepc), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg =3D env->scause;
+    ret =3D kvm_set_one_reg(cs, RISCV_CSR_REG(scause), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg =3D env->mip;
+    ret =3D kvm_set_one_reg(cs, RISCV_CSR_REG(sip), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg =3D env->satp;
+    ret =3D kvm_set_one_reg(cs, RISCV_CSR_REG(sstatus), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    return ret;
+}
+
+
 static int kvm_riscv_get_regs_fp(CPUState *cs)
 {
     int ret =3D 0;
@@ -175,6 +258,40 @@ static int kvm_riscv_get_regs_fp(CPUState *cs)
     return ret;
 }
=20
+static int kvm_riscv_put_regs_fp(CPUState *cs)
+{
+    int ret =3D 0;
+    int i;
+    CPURISCVState *env =3D &RISCV_CPU(cs)->env;
+
+    if (riscv_has_ext(env, RVD)) {
+        uint64_t reg;
+        for (i =3D 0; i < 32; i++) {
+            reg =3D env->fpr[i];
+            ret =3D kvm_set_one_reg(cs, RISCV_FP_D_REG(i), &reg);
+            if (ret) {
+                return ret;
+            }
+        }
+        return ret;
+    }
+
+    if (riscv_has_ext(env, RVF)) {
+        uint32_t reg;
+        for (i =3D 0; i < 32; i++) {
+            reg =3D env->fpr[i];
+            ret =3D kvm_set_one_reg(cs, RISCV_FP_F_REG(i), &reg);
+            if (ret) {
+                return ret;
+            }
+        }
+        return ret;
+    }
+
+    return ret;
+}
+
+
 const KVMCapabilityInfo kvm_arch_required_capabilities[] =3D {
     KVM_CAP_LAST_INFO
 };
@@ -203,7 +320,24 @@ int kvm_arch_get_registers(CPUState *cs)
=20
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
-    return 0;
+    int ret =3D 0;
+
+    ret =3D kvm_riscv_put_regs_core(cs);
+    if (ret) {
+        return ret;
+    }
+
+    ret =3D kvm_riscv_put_regs_csr(cs);
+    if (ret) {
+        return ret;
+    }
+
+    ret =3D kvm_riscv_put_regs_fp(cs);
+    if (ret) {
+        return ret;
+    }
+
+    return ret;
 }
=20
 int kvm_arch_release_virq_post(int virq)
--=20
2.19.1



