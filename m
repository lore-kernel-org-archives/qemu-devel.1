Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2A5C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD0120715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD0120715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izszK-0003Fy-TT
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvY-0005q7-La
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvX-00018k-0w
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:28 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49894 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvW-0000HT-N3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 84D561A20FA;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 357981A2068;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 04/32] target/avr: CPU class: Add memory menagement support
Date: Fri,  7 Feb 2020 02:57:32 +0100
Message-Id: <1581040680-308-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This patch introduces three memory-management-related functions
that will become part of AVR CPU class object.

[AM: Split a larger AVR introduction patch into logical units]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/avr/cpu.c    |  3 +++
 target/avr/helper.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++=
+++
 2 files changed, 53 insertions(+)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 10cb83c..08a538c 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -203,6 +203,9 @@ static void avr_cpu_class_init(ObjectClass *oc, void =
*data)
     cc->cpu_exec_interrupt =3D avr_cpu_exec_interrupt;
     cc->dump_state =3D avr_cpu_dump_state;
     cc->set_pc =3D avr_cpu_set_pc;
+    cc->memory_rw_debug =3D avr_cpu_memory_rw_debug;
+    cc->get_phys_page_debug =3D avr_cpu_get_phys_page_debug;
+    cc->tlb_fill =3D avr_cpu_tlb_fill;
     cc->disas_set_info =3D avr_cpu_disas_set_info;
     cc->tcg_initialize =3D avr_cpu_tcg_init;
     cc->synchronize_from_tb =3D avr_cpu_synchronize_from_tb;
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 731a9ee..354def2 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -87,3 +87,53 @@ void avr_cpu_do_interrupt(CPUState *cs)
=20
     cs->exception_index =3D -1;
 }
+
+int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
+                                int len, bool is_write)
+{
+    return cpu_memory_rw_debug(cs, addr, buf, len, is_write);
+}
+
+hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    return addr; /* I assume 1:1 address correspondance */
+}
+
+bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
+{
+    int prot =3D 0;
+    MemTxAttrs attrs =3D {};
+    uint32_t paddr;
+
+    address &=3D TARGET_PAGE_MASK;
+
+    if (mmu_idx =3D=3D MMU_CODE_IDX) {
+        /* access to code in flash */
+        paddr =3D OFFSET_CODE + address;
+        prot =3D PAGE_READ | PAGE_EXEC;
+        if (paddr + TARGET_PAGE_SIZE > OFFSET_DATA) {
+            error_report("execution left flash memory");
+            exit(1);
+        }
+    } else if (address < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTER=
S) {
+        /*
+         * access to CPU registers, exit and rebuilt this TB to use full=
 access
+         * incase it touches specially handled registers like SREG or SP
+         */
+        AVRCPU *cpu =3D AVR_CPU(cs);
+        CPUAVRState *env =3D &cpu->env;
+        env->fullacc =3D 1;
+        cpu_loop_exit_restore(cs, retaddr);
+    } else {
+        /* access to memory. nothing special */
+        paddr =3D OFFSET_DATA + address;
+        prot =3D PAGE_READ | PAGE_WRITE;
+    }
+
+    tlb_set_page_with_attrs(
+        cs, address, paddr, attrs, prot, mmu_idx, TARGET_PAGE_SIZE);
+
+    return true;
+}
--=20
2.7.4


