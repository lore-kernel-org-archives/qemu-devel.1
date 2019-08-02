Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75185C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D6B216C8
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUlf8tPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D6B216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hta4Z-0000B3-J8
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60573)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hta3F-0006qT-VE
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hta3E-000205-Ic
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hta3E-0001yc-C2
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id v19so66859650wmj.5
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BfQH4lRAqpmkXsMJ0tZi39/pftehOKqOJC/urrgU2h8=;
 b=NUlf8tPNQjy00va2F2YESvdUaz1WmLfyN7kpPPQ9jKJL03hlqfuumq5zsCMhlxewvq
 +n8oSSuwlOcFoSpEmYrGfsFcyt+rDFHQcOr0Z+c0C8sg4bQ+PHaMEYAv4JFsMmzC/hCY
 LvPhmsxjxTYELls5vQWv/btPBbCmijNPnnJqijs+CI2P/GTtErKQGXxFFZKmimA29hhV
 TQQjIlGLgnpEP4cCnO0bhVe/N80KDqt0V064ctlHFX1TWrVrLHw7A5LycfdviySsso52
 fZLUW+T8sjfEjjkjmCEv7lfJkMynGMdX5YeIOWOCbmI1iJA1XxN/ZhGJvHvW9gJWzryo
 kotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BfQH4lRAqpmkXsMJ0tZi39/pftehOKqOJC/urrgU2h8=;
 b=ocx2aDf/AZcXvIg93242o5LeS2hiF/Hr3ErgYyZVaqJtomeaask5uRoOofL/LMRxus
 mnsrRG+w7XjF6O30TmRkrR/6/WuXJXC7sXi2mvowri5Ndmlry4i3MTP6FMDeXG9jtKJQ
 WxRbXe3ybHm+kjPnKPYZE92regv8k9k6+a9VAN4kfE1JP9Pky3q+plIM+iuLXVIZeQPX
 LgjjmfKCE1ddgFlnjbBwcCv8o9317xJJbrusCrDzAOt1z+J8ILE0p+mpivBHe93j9fMh
 1l0S3cf/7ZbPvVdTMSlI/oKkWbK5BnYaTmA1rid+i+65YzC4dhMx/oHIHqo6FQKzBh4U
 xhfw==
X-Gm-Message-State: APjAAAXiL040d0LwdUkTx991+V1mxRCYDUdytoVXuhs+S34PF6EKPTXQ
 z7/gfnbkEVRJ0QpYruHb/wybxcp8BBnxIA==
X-Google-Smtp-Source: APXvYqyo129j5C7I6KevPiEjEFLy+Z5twKgGrrQcHxNawEJhnHKjI1wCl/qPh4bK/VYE+roeNxojEA==
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr4811460wme.173.1564761902450; 
 Fri, 02 Aug 2019 09:05:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o7sm66200171wmf.43.2019.08.02.09.05.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 02 Aug 2019 09:05:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 17:04:56 +0100
Message-Id: <20190802160458.25681-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802160458.25681-1-peter.maydell@linaro.org>
References: <20190802160458.25681-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 1/3] hw/mips/mips_jazz: Override
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/mips/mips_jazz.c | 54 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index fa8775d4284..c64b4c78809 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -123,6 +123,28 @@ static void mips_jazz_do_unassigned_access(CPUState *cpu, hwaddr addr,
     (*real_do_unassigned_access)(cpu, addr, is_write, is_exec, opaque, size);
 }
 
+static void (*real_do_transaction_failed)(CPUState *cpu, hwaddr physaddr,
+                                          vaddr addr, unsigned size,
+                                          MMUAccessType access_type,
+                                          int mmu_idx, MemTxAttrs attrs,
+                                          MemTxResult response,
+                                          uintptr_t retaddr);
+
+static void mips_jazz_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                            vaddr addr, unsigned size,
+                                            MMUAccessType access_type,
+                                            int mmu_idx, MemTxAttrs attrs,
+                                            MemTxResult response,
+                                            uintptr_t retaddr)
+{
+    if (access_type != MMU_INST_FETCH) {
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
     env = &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
 
-    /* Chipset returns 0 in invalid reads and do not raise data exceptions.
+    /*
+     * Chipset returns 0 in invalid reads and do not raise data exceptions.
      * However, we can't simply add a global memory region to catch
-     * everything, as memory core directly call unassigned_mem_read/write
-     * on some invalid accesses, which call do_unassigned_access on the
-     * CPU, which raise an exception.
-     * Handle that case by hijacking the do_unassigned_access method on
-     * the CPU, and do not raise exceptions for data access. */
+     * everything, as this would make all accesses including instruction
+     * accesses be ignored and not raise exceptions.
+     * So instead we hijack either the do_unassigned_access method or
+     * the do_transaction_failed method on the CPU, and do not raise exceptions
+     * for data access.
+     *
+     * NOTE: this behaviour of raising exceptions for bad instruction
+     * fetches but not bad data accesses was added in commit 54e755588cf1e9
+     * to restore behaviour broken by c658b94f6e8c206, but it is not clear
+     * whether the real hardware behaves this way. It is possible that
+     * real hardware ignores bad instruction fetches as well -- if so then
+     * we could replace this hijacking of CPU methods with a simple global
+     * memory region that catches all memory accesses, as we do on Malta.
+     */
     cc = CPU_GET_CLASS(cpu);
-    real_do_unassigned_access = cc->do_unassigned_access;
-    cc->do_unassigned_access = mips_jazz_do_unassigned_access;
+    if (cc->do_unassigned_access) {
+        real_do_unassigned_access = cc->do_unassigned_access;
+        cc->do_unassigned_access = mips_jazz_do_unassigned_access;
+    }
+    if (cc->do_transaction_failed) {
+        real_do_transaction_failed = cc->do_transaction_failed;
+        cc->do_transaction_failed = mips_jazz_do_transaction_failed;
+    }
 
     /* allocate RAM */
     memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
-- 
2.20.1


