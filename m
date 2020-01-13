Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2658C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA0C206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA0C206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dornerworks.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2A5-0007or-KE
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Jeff.Kubascik@dornerworks.com>) id 1ir282-0005r2-LX
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Jeff.Kubascik@dornerworks.com>) id 1ir281-00014E-GQ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:59:46 -0500
Received: from mail.dornerworks.com ([12.207.209.150]:20859
 helo=webmail.dornerworks.com) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Jeff.Kubascik@dornerworks.com>)
 id 1ir27y-0000vg-W4; Mon, 13 Jan 2020 10:59:43 -0500
From: Jeff Kubascik <jeff.kubascik@dornerworks.com>
To: Peter Maydell <peter.maydell@linaro.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: [PATCH v2] target/arm: adjust program counter for wfi exception in
 AArch32
Date: Mon, 13 Jan 2020 10:59:34 -0500
Message-ID: <20200113155934.97572-1-jeff.kubascik@dornerworks.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.27.13.179]
X-ClientProxiedBy: Mcbain.dw.local (172.27.1.45) To Mcbain.dw.local
 (172.27.1.45)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 12.207.209.150
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
Cc: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 Jarvis Roach <Jarvis.Roach@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The wfi instruction can be configured to be trapped by a higher exception
level, such as the EL2 hypervisor. When the instruction is trapped, the
program counter should contain the address of the wfi instruction that
caused the exception. The program counter is adjusted for this in the wfi op
helper function.

However, this correction is done to env->pc, which only applies to AArch64
mode. For AArch32, the program counter is stored in env->regs[15]. This
adds an if-else statement to modify the correct program counter location
based on the the current CPU mode.

Signed-off-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
---
Hello,

I am using the ARMv8 version of QEMU to run the Xen hypervisor with a guest
virtual machine compiled for AArch32/Thumb code. I have noticed that when
the AArch32 guest VM executes the wfi instruction, the hypervisor trap of
the wfi instruction sees the program counter contain the address of the
instruction following the wfi. This does not occur for an AARch64 guest VM;
in this case, the program counter contains the address of the wfi
instruction. I am confident the correct behavior in both cases is for the
program counter to contain the address of the wfi instruction, as this works
on actual hardware (Xilinx Zynq UltraScale+ MPSoC).

I have tested the above patch and it works for Xen with both an AArch64
guest (Linux) and an AArch32 guest (RTEMS). I'm still getting accustomed to
the QEMU code base, so it may not be correct. Any feedback would be greatly
appreciated.

Sincerely,
Jeff Kubascik

Changes in v2:
- Added braces {} to if-else statement, per patchew feedback
---
 target/arm/op_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index e5a346cb87..27d16ad9ad 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -295,7 +295,12 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     }
 
     if (target_el) {
-        env->pc -= insn_len;
+        if (env->aarch64) {
+            env->pc -= insn_len;
+        } else {
+            env->regs[15] -= insn_len;
+        }
+
         raise_exception(env, EXCP_UDEF, syn_wfx(1, 0xe, 0, insn_len == 2),
                         target_el);
     }
-- 
2.17.1


