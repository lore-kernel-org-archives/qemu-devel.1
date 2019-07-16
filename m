Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823D8C76191
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A62520880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJ0BBJcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A62520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnDWT-0006ax-B2
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 22:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44362)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnDVZ-0002lZ-Nu
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnDVX-0004b0-2k
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:48:00 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnDVU-0004XG-ML; Mon, 15 Jul 2019 22:47:56 -0400
Received: by mail-pl1-x641.google.com with SMTP id az7so9289493plb.5;
 Mon, 15 Jul 2019 19:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=De2i1fnAfzCHclgXYbgQlJSwI5p8Wu3AzTld5je3ygM=;
 b=rJ0BBJcTKHXpHUeCqj8mOMroI0K/XgKGBrYK/VukClXRzN2Zamzl77g9HZbULHIdmO
 TX4vd6vDP9V/wy1b6gEh/GuPAMiFKStuIm0H222UoRzwFku0VpUiuvfhdzXaVSjjNOqH
 T7axs8iL6bWd7K7b5ekClPHD/ywazp38f9qK5+a+SgBkxE3zmrr/RAG+XLjJsPBgihKm
 ekhEUxyflwqTWkbl9dCr7w/nJGtcK1Eaj0tkoHjnDF1GswG5T+S5bj6eWzVv1u5MxOVB
 I+Ho/ImbMSBvsglJDSuUyt2AUHl7KIq6xTb4c+ylrggLSA+sx+nroWaNYPXkWCHbYzS9
 JfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=De2i1fnAfzCHclgXYbgQlJSwI5p8Wu3AzTld5je3ygM=;
 b=cxmifrsaoc+BZDMiOLsmsE+E+uq5eH2RsX/4BmavdDBdLi+ZcP8W3LY+1trWHGKkN3
 AZUyOjNcTB3hRMutjduGmjldh2oNhtT8Gxpilh+ORCcqHZ8ZLEhg9hkMiVX1jvUWCTKf
 DMdYbVdc2PZ1JlW8a1LiG6dUTcF/jOG2MJNJm3NtPDgBKg3z0xS4IDeRpbzMcQvGEu6A
 sKBvjeJmmFMyJQ1Y8sueOnbXl/9CHecUnwqqHxLEQXvYhh7VKTv4zbS0WnxZpcJ4byNg
 0ucniVRCKGWgp3nHW3Yr3VkGUWeYSjIPTOMbYZx5lbnf5vZC7ewfTzN9PP4JNj0IO9+X
 KWmQ==
X-Gm-Message-State: APjAAAVyhcZ4RPgdx1AIlb24JtS+GC6CSmZsuSUMgnHhTrUHF2Cu/mEX
 mfJuQ6vp3AOhEl/rtpBkXNM=
X-Google-Smtp-Source: APXvYqwRlDATVV1lxvR8Qb0O4+geDHpG6AeK5ZXZKjk9Z+4SsbItqXhenuzApA4kEWAL1EZHn4C0WQ==
X-Received: by 2002:a17:902:9a85:: with SMTP id
 w5mr32208781plp.221.1563245275880; 
 Mon, 15 Jul 2019 19:47:55 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id x8sm16557837pfa.46.2019.07.15.19.47.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 19:47:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 16 Jul 2019 12:47:25 +1000
Message-Id: <20190716024726.17864-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716024726.17864-1-npiggin@gmail.com>
References: <20190716024726.17864-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v4 4/5] spapr: Implement H_JOIN
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This has been useful to modify and test the Linux pseries suspend
code but it requires modification to the guest to call it (due to
being gated by other unimplemented features). It is not otherwise
used by Linux yet, but work is slowly progressing there.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c       |  1 +
 hw/ppc/spapr_hcall.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 87b11e2484..5c54e1cb9a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1066,6 +1066,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
     add_str(hypertas, "hcall-tce");
     add_str(hypertas, "hcall-vio");
     add_str(hypertas, "hcall-splpar");
+    add_str(hypertas, "hcall-join");
     add_str(hypertas, "hcall-bulk");
     add_str(hypertas, "hcall-set-mode");
     add_str(hypertas, "hcall-sprg0");
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 28d58113be..52847a7047 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1069,6 +1069,47 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    CPUState *cs;
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+    bool last_unjoined = true;
+
+    if (env->msr & (1ULL << MSR_EE)) {
+        return H_BAD_MODE;
+    }
+
+    if (spapr_cpu->prod) {
+        spapr_cpu->prod = false;
+        return H_SUCCESS;
+    }
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *c = POWERPC_CPU(cs);
+        CPUPPCState *e = &c->env;
+        if (c == cpu)
+            continue;
+
+	/* Don't have a way to indicate joined, so use halted && MSR[EE]=0 */
+        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
+            last_unjoined = false;
+            break;
+        }
+    }
+    if (last_unjoined) {
+        return H_CONTINUE;
+    }
+
+    cs = CPU(cpu);
+    cs->halted = 1;
+    cs->exception_index = EXCP_HALTED;
+    cs->exit_request = 1;
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1959,6 +2000,9 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_CONFER, h_confer);
     spapr_register_hypercall(H_PROD, h_prod);
 
+    /* hcall-join */
+    spapr_register_hypercall(H_JOIN, h_join);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
 
     /* processor register resource access h-calls */
-- 
2.20.1


