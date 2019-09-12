Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDCDC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD712081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD712081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8S3O-00082x-Cs
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 12:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i8S0g-0005p7-Br
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i8S0e-0006K5-TB
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:31:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:37112 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i8S0e-00061q-Ho
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:31:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id A5F771A1E25;
 Thu, 12 Sep 2019 18:30:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 7D6FB1A1E6B;
 Thu, 12 Sep 2019 18:30:46 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 18:30:37 +0200
Message-Id: <1568305840-12550-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568305840-12550-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1568305840-12550-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 1/4] hw/mips/mips_jazz: Override
 do_transaction_failed hook
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The MIPS Jazz ('magnum' and 'pica61') boards have some code which
overrides the CPU's do_unassigned_access hook, so they can intercept
it and not raise exceptions on data accesses to invalid addresses,
only for instruction fetches.

We want to switch MIPS over to using the do_transaction_failed
hook instead, so add an intercept for that as well, and make
the board code install whichever hook the CPU is actually using.
Once we've changed the CPU implementation we can remove the
redundant code for the old hook.

Note: I am suspicious that the behaviour as implemented here may not
be what the hardware really does.  It was added in commit
54e755588cf1e90f0b14 to restore the behaviour that was broken by
commit c658b94f6e8c206c59d.  But prior to commit c658b94f6e8c206c59d
every MIPS board generated exceptions for instruction access to
invalid addresses but not for data accesses; and other boards,
notably Malta, were fixed by making all invalid accesses behave as
reads-as-zero (see the call to empty_slot_init() in
mips_malta_init()).  Hardware that raises exceptions for instruction
access and not data access seems to me to be an unlikely design, and
it's possible that the right way to emulate this is to make the Jazz
boards do what we did with Malta (or some variation of that).
Nonetheless, since I don't have access to real hardware to test
against I have taken the approach of "make QEMU continue to behave
the same way it did before this commit".  I have updated the comment
to correct the parts that are no longer accurate and note that
the hardware might behave differently.

The test case for the need for the hook-hijacking is in
https://bugs.launchpad.net/qemu/+bug/1245924 That BIOS will boot OK
either with this overriding of both hooks, or with a simple "global
memory region to ignore bad accesses of all types", so it doesn't
provide evidence either way, unfortunately.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Message-Id: <20190802160458.25681-2-peter.maydell@linaro.org>
---
 hw/mips/mips_jazz.c | 54 +++++++++++++++++++++++++++++++++++++++++++++--=
------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 388c15c..1a8e847 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -123,6 +123,28 @@ static void mips_jazz_do_unassigned_access(CPUState =
*cpu, hwaddr addr,
     (*real_do_unassigned_access)(cpu, addr, is_write, is_exec, opaque, s=
ize);
 }
=20
+static void (*real_do_transaction_failed)(CPUState *cpu, hwaddr physaddr=
,
+                                          vaddr addr, unsigned size,
+                                          MMUAccessType access_type,
+                                          int mmu_idx, MemTxAttrs attrs,
+                                          MemTxResult response,
+                                          uintptr_t retaddr);
+
+static void mips_jazz_do_transaction_failed(CPUState *cs, hwaddr physadd=
r,
+                                            vaddr addr, unsigned size,
+                                            MMUAccessType access_type,
+                                            int mmu_idx, MemTxAttrs attr=
s,
+                                            MemTxResult response,
+                                            uintptr_t retaddr)
+{
+    if (access_type !=3D MMU_INST_FETCH) {
+        /* ignore invalid access (ie do not raise exception) */
+        return;
+    }
+    (*real_do_transaction_failed)(cs, physaddr, addr, size, access_type,
+                                  mmu_idx, attrs, response, retaddr);
+}
+
 static void mips_jazz_init(MachineState *machine,
                            enum jazz_model_e jazz_model)
 {
@@ -157,16 +179,32 @@ static void mips_jazz_init(MachineState *machine,
     env =3D &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
=20
-    /* Chipset returns 0 in invalid reads and do not raise data exceptio=
ns.
+    /*
+     * Chipset returns 0 in invalid reads and do not raise data exceptio=
ns.
      * However, we can't simply add a global memory region to catch
-     * everything, as memory core directly call unassigned_mem_read/writ=
e
-     * on some invalid accesses, which call do_unassigned_access on the
-     * CPU, which raise an exception.
-     * Handle that case by hijacking the do_unassigned_access method on
-     * the CPU, and do not raise exceptions for data access. */
+     * everything, as this would make all accesses including instruction
+     * accesses be ignored and not raise exceptions.
+     * So instead we hijack either the do_unassigned_access method or
+     * the do_transaction_failed method on the CPU, and do not raise exc=
eptions
+     * for data access.
+     *
+     * NOTE: this behaviour of raising exceptions for bad instruction
+     * fetches but not bad data accesses was added in commit 54e755588cf=
1e9
+     * to restore behaviour broken by c658b94f6e8c206, but it is not cle=
ar
+     * whether the real hardware behaves this way. It is possible that
+     * real hardware ignores bad instruction fetches as well -- if so th=
en
+     * we could replace this hijacking of CPU methods with a simple glob=
al
+     * memory region that catches all memory accesses, as we do on Malta=
.
+     */
     cc =3D CPU_GET_CLASS(cpu);
-    real_do_unassigned_access =3D cc->do_unassigned_access;
-    cc->do_unassigned_access =3D mips_jazz_do_unassigned_access;
+    if (cc->do_unassigned_access) {
+        real_do_unassigned_access =3D cc->do_unassigned_access;
+        cc->do_unassigned_access =3D mips_jazz_do_unassigned_access;
+    }
+    if (cc->do_transaction_failed) {
+        real_do_transaction_failed =3D cc->do_transaction_failed;
+        cc->do_transaction_failed =3D mips_jazz_do_transaction_failed;
+    }
=20
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
--=20
2.7.4


