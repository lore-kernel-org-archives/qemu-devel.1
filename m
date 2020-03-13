Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956EDC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 03:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F80D206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 03:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F80D206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCbOn-00038U-Hs
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 23:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangyifei@huawei.com>) id 1jCbMJ-0006tf-9l
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 23:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangyifei@huawei.com>) id 1jCbMH-0000bT-VH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 23:51:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3201 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiangyifei@huawei.com>)
 id 1jCbMH-0000SL-EM; Thu, 12 Mar 2020 23:51:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B2A68667E133AF381F94;
 Fri, 13 Mar 2020 11:51:31 +0800 (CST)
Received: from huawei.com (10.133.201.158) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 13 Mar 2020
 11:51:25 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH RFC 8/9] target/riscv: Handler KVM_EXIT_RISCV_SBI exit
Date: Fri, 13 Mar 2020 11:49:48 +0800
Message-ID: <20200313034949.3028-9-jiangyifei@huawei.com>
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
X-Received-From: 45.249.212.190
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

Use char-fe handler console sbi call, which implement early
console io while apply 'earlycon=3Dsbi' into kernel parameters.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
---
 target/riscv/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 0f429fd802..1df70fbb29 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -38,6 +38,7 @@
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "kvm_riscv.h"
+#include "chardev/char-fe.h"
=20
 static __u64 kvm_riscv_reg_id(__u64 type, __u64 idx)
 {
@@ -61,6 +62,19 @@ static __u64 kvm_riscv_reg_id(__u64 type, __u64 idx)
=20
 #define RISCV_FP_D_REG(idx)  kvm_riscv_reg_id(KVM_REG_RISCV_FP_D, idx)
=20
+enum sbi_ext_id {
+    SBI_EXT_0_1_SET_TIMER =3D 0x0,
+    SBI_EXT_0_1_CONSOLE_PUTCHAR =3D 0x1,
+    SBI_EXT_0_1_CONSOLE_GETCHAR =3D 0x2,
+    SBI_EXT_0_1_CLEAR_IPI =3D 0x3,
+    SBI_EXT_0_1_SEND_IPI =3D 0x4,
+    SBI_EXT_0_1_REMOTE_FENCE_I =3D 0x5,
+    SBI_EXT_0_1_REMOTE_SFENCE_VMA =3D 0x6,
+    SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID =3D 0x7,
+    SBI_EXT_0_1_SHUTDOWN =3D 0x8,
+    SBI_EXT_BASE =3D 0x10,
+};
+
 static int kvm_riscv_get_regs_core(CPUState *cs)
 {
     int ret =3D 0;
@@ -423,9 +437,47 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cs)
     return true;
 }
=20
+static int kvm_riscv_handle_sbi(struct kvm_run *run)
+{
+    int ret =3D 0;
+    unsigned char ch;
+    switch (run->riscv_sbi.extension_id) {
+    case SBI_EXT_0_1_CONSOLE_PUTCHAR:
+        ch =3D run->riscv_sbi.args[0];
+        qemu_chr_fe_write(serial_hd(0)->be, &ch, sizeof(ch));
+        break;
+    case SBI_EXT_0_1_CONSOLE_GETCHAR:
+        ret =3D qemu_chr_fe_read_all(serial_hd(0)->be, &ch, sizeof(ch));
+        if (ret =3D=3D sizeof(ch)) {
+            run->riscv_sbi.args[0] =3D ch;
+        } else {
+            run->riscv_sbi.args[0] =3D -1;
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: un-handled SBI EXIT, specific reasons is %lu\=
n",
+                      __func__, run->riscv_sbi.extension_id);
+        ret =3D -1;
+        break;
+    }
+    return ret;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
-    return 0;
+    int ret =3D 0;
+    switch (run->exit_reason) {
+    case KVM_EXIT_RISCV_SBI:
+        ret =3D kvm_riscv_handle_sbi(run);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
+                      __func__, run->exit_reason);
+        ret =3D -1;
+        break;
+    }
+    return ret;
 }
=20
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
--=20
2.19.1



