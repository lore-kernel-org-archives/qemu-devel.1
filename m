Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D36C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 05:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64F6221E9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 05:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l1LpHJNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64F6221E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPJDK-0001vz-SF
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 01:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jPJBz-0000gl-Ay
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 01:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jPJBy-0007SL-1g
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 01:05:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41189 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jPJBv-0007RU-Of; Fri, 17 Apr 2020 01:05:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 493PDM4l3Qz9sSs; Fri, 17 Apr 2020 15:05:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587099923;
 bh=uB/pOlpSyK6RnSOjkZjsdS+Li7f3wH6cGmH3QFWMPrI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l1LpHJNMi1JpK3kAh+psr5CQ4+vCUXfSVY1xMnVfUf4q/1nfCEgEu2qsCFjnQT1df
 eDv7h/2Yp+J8V4bTDT+phm29dnqr/F3dVu44tUTzPhjF1PBLEQ8bczpLdPg1oA4G+w
 NDvICM03UopTp5K7Sg30kNWDy0PjFhA8Q5pi8SSo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 2/3] target/ppc: Fix wrong interpretation of the disposition
 flag.
Date: Fri, 17 Apr 2020 15:05:13 +1000
Message-Id: <20200417050514.235060-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200417050514.235060-1-david@gibson.dropbear.id.au>
References: <20200417050514.235060-1-david@gibson.dropbear.id.au>
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
Cc: qemu-devel@nongnu.org, groug@kaod.org,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, clg@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ganesh Goudar <ganeshgr@linux.ibm.com>

Bitwise AND with kvm_run->flags to evaluate if we recovered from
MCE or not is not correct, As disposition in kvm_run->flags is a
two-bit integer value and not a bit map, So check for equality
instead of bitwise AND.

Without the fix qemu treats any unrecoverable mce error as recoverable
and ends up in a mce loop inside the guest, Below are the MCE logs before
and after the fix.

Before fix:

[   66.775757] MCE: CPU0: Initiator CPU
[   66.775891] MCE: CPU0: Unknown
[   66.776587] MCE: CPU0: machine check (Harmless) Host UE Indeterminate =
[Recovered]
[   66.776857] MCE: CPU0: NIP: [c0080000000e00b8] mcetest_tlbie+0xb0/0x12=
8 [mcetest_tlbie]

After fix:

[ 20.650577] CPU: 0 PID: 1415 Comm: insmod Tainted: G M O 5.6.0-fwnmi-arv=
+ #11
[ 20.650618] NIP: c0080000023a00e8 LR: c0080000023a00d8 CTR: c00000000002=
1fe0
[ 20.650660] REGS: c0000001fffd3d70 TRAP: 0200 Tainted: G M O (5.6.0-fwnm=
i-arv+)
[ 20.650708] MSR: 8000000002a0b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE> CR: =
42000222 XER: 20040000
[ 20.650758] CFAR: c00000000000b940 DAR: c0080000025e00e0 DSISR: 00000200=
 IRQMASK: 0
[ 20.650758] GPR00: c0080000023a00d8 c0000001fddd79a0 c0080000023a8500 00=
00000000000039
[ 20.650758] GPR04: 0000000000000001 0000000000000000 0000000000000000 00=
00000000000007
[ 20.650758] GPR08: 0000000000000007 c0080000025e00e0 0000000000000000 00=
000000000000f7
[ 20.650758] GPR12: 0000000000000000 c000000001900000 c00000000101f398 c0=
080000025c052f
[ 20.650758] GPR16: 00000000000003a8 c0080000025c0000 c0000001fddd7d70 c0=
000000015b7940
[ 20.650758] GPR20: 000000000000fff1 c000000000f72c28 c0080000025a0988 00=
00000000000000
[ 20.650758] GPR24: 0000000000000100 c0080000023a05d0 c0000000001f1d70 00=
00000000000000
[ 20.650758] GPR28: c0000001fde20000 c0000001fd02b2e0 c0080000023a0000 c0=
080000025e0000
[ 20.651178] NIP [c0080000023a00e8] mcetest_tlbie+0xe8/0xf0 [mcetest_tlbi=
e]
[ 20.651220] LR [c0080000023a00d8] mcetest_tlbie+0xd8/0xf0 [mcetest_tlbie=
]
[ 20.651262] Call Trace:
[ 20.651280] [c0000001fddd79a0] [c0080000023a00d8] mcetest_tlbie+0xd8/0xf=
0 [mcetest_tlbie] (unreliable)
[ 20.651340] [c0000001fddd7a10] [c00000000001091c] do_one_initcall+0x6c/0=
x2c0
[ 20.651390] [c0000001fddd7af0] [c0000000001f7998] do_init_module+0x90/0x=
298
[ 20.651433] [c0000001fddd7b80] [c0000000001f61a8] load_module+0x1f58/0x2=
7a0
[ 20.651476] [c0000001fddd7d40] [c0000000001f6c70] __do_sys_finit_module+=
0xe0/0x100
[ 20.651526] [c0000001fddd7e20] [c00000000000b9d0] system_call+0x5c/0x68
[ 20.651567] Instruction dump:
[ 20.651594] e8410018 3c620000 e8638020 480000cd e8410018 3c620000 e86380=
28 480000bd
[ 20.651646] e8410018 7be904e4 39400000 612900e0 <7d434a64> 4bffff74 3c4c=
0001 38428410
[ 20.651699] ---[ end trace 4c40897f016b4340 ]---
[ 20.653310]
Bus error
[ 20.655575] MCE: CPU0: machine check (Harmless) Host UE Indeterminate [N=
ot recovered]
[ 20.655575] MCE: CPU0: NIP: [c0080000023a00e8] mcetest_tlbie+0xe8/0xf0 [=
mcetest_tlbie]
[ 20.655576] MCE: CPU0: Initiator CPU
[ 20.655576] MCE: CPU0: Unknown

Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
Message-Id: <20200408170944.16003-1-ganeshgr@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 03d0667e8f..2692f76130 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2816,11 +2816,11 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 #if defined(TARGET_PPC64)
 int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
 {
-    bool recovered =3D run->flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
+    uint16_t flags =3D run->flags & KVM_RUN_PPC_NMI_DISP_MASK;
=20
     cpu_synchronize_state(CPU(cpu));
=20
-    spapr_mce_req_event(cpu, recovered);
+    spapr_mce_req_event(cpu, flags =3D=3D KVM_RUN_PPC_NMI_DISP_FULLY_REC=
OV);
=20
     return 0;
 }
--=20
2.25.2


