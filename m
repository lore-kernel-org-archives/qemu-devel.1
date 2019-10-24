Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59813CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202F620650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN6pXa+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202F620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfDV-0005t3-4m
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj7-00089b-V9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj2-0007nd-Tb
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:33 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdj2-0007nL-Lx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id e11so17538338wrv.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZKfl1Pqq3FGyY1lzuLtSAUoFrIIAbeG7CA7XuDqVexQ=;
 b=YN6pXa+sf8rVTyeQfBml0lF2fXextF1eTmUy0cNjribSUpFhTIG4Y19e36NPOiVM03
 7xyKaeEoPX70BnWfFXsIJvw5A1h00lNtRPeggoI31KLBjsrq49fJoPOyUL4G6Ra9v0ly
 kH/FZ4SIRjIdGWpYZHvm85ptK5W/5peW2VO4OLqcAfsTNl0hmPvTRq5h28d3AmnSLxRC
 SwjfVrKv65uuJ3HudfmQto1CndOdu1rU8ygIw2cQJ33kdEC1tkcPaMEYy+9B+z+fMJ6W
 zkLOKRaRzwJig0E89AG9QYMYaCG0h/ClF7eKTSYVeKd0CBKodGcLkhcabllBu2o96+6A
 Y4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZKfl1Pqq3FGyY1lzuLtSAUoFrIIAbeG7CA7XuDqVexQ=;
 b=ObTxHK91U2J75k9r2RKeXG+x+nUuUlrj6k3QOeMI5V+M3YasnY7+l9fAL4BZjslMOT
 JkvTQBOPNoglJ/WUxfEUfuWUYod1ThxN19nvmLIlQDV5Vod0wYTc8OUeETiFLtsXquES
 bdW6Nq+WPgNpxLs9Nr7+1pNoVYV22cSZgkNmv6ccjv2hawgTa8fmFRDRzRQXnh2SSCg7
 OVNBS08eRRe9G0TO2L0B2popfdVvCmRKBCrOuipXIhJLctrZVvkyK7vvmAXQ6+wGX7m5
 rd/iB/2yi2oKJiLkfHl41mXtCBALobsKfUJSj2oScLNVQt7S76UKC8s6JLVPtlzyro76
 KhPw==
X-Gm-Message-State: APjAAAX70NzPMp1fuu6uvuFKpLMJ5IFpplQ+w8B58+/nx/PZqoWdw8yI
 tFfQTBKl7EgLI+6BwUG64iUXaOCz
X-Google-Smtp-Source: APXvYqyE0tP6WgmXztxrLj9AtSkpg4kG2uI41EIgkzx82zID+YYP9gAqG2oAHhMqGFjHUW1OZXgKsA==
X-Received: by 2002:a5d:638c:: with SMTP id p12mr3755598wru.136.1571925867265; 
 Thu, 24 Oct 2019 07:04:27 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/39] hw/i386/pc: Extract pc_gsi_create()
Date: Thu, 24 Oct 2019 16:03:43 +0200
Message-Id: <1571925835-31930-28-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The GSI creation code is common to all PC machines, extract the
common code.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191018135910.24286-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c         | 15 +++++++++++++++
 hw/i386/pc_piix.c    |  9 +--------
 hw/i386/pc_q35.c     |  9 +--------
 include/hw/i386/pc.h |  2 ++
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a8888dd..e8a54ac 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -355,6 +355,21 @@ void gsi_handler(void *opaque, int n, int level)
     qemu_set_irq(s->ioapic_irq[n], level);
 }
 
+GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
+{
+    GSIState *s;
+
+    s = g_new0(GSIState, 1);
+    if (kvm_ioapic_in_kernel()) {
+        kvm_pc_setup_irq_routing(pci_enabled);
+        *irqs = qemu_allocate_irqs(kvm_pc_gsi_handler, s, GSI_NUM_PINS);
+    } else {
+        *irqs = qemu_allocate_irqs(gsi_handler, s, GSI_NUM_PINS);
+    }
+
+    return s;
+}
+
 static void ioport80_write(void *opaque, hwaddr addr, uint64_t data,
                            unsigned size)
 {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a86317c..0cc951a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -189,14 +189,7 @@ static void pc_init1(MachineState *machine,
         xen_load_linux(pcms);
     }
 
-    gsi_state = g_malloc0(sizeof(*gsi_state));
-    if (kvm_ioapic_in_kernel()) {
-        kvm_pc_setup_irq_routing(pcmc->pci_enabled);
-        x86ms->gsi = qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
-                                       GSI_NUM_PINS);
-    } else {
-        x86ms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PINS);
-    }
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
 
     if (pcmc->pci_enabled) {
         pci_bus = i440fx_init(host_type,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 75c8caf..255c803 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -212,14 +212,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* irq lines */
-    gsi_state = g_malloc0(sizeof(*gsi_state));
-    if (kvm_ioapic_in_kernel()) {
-        kvm_pc_setup_irq_routing(pcmc->pci_enabled);
-        x86ms->gsi = qemu_allocate_irqs(kvm_pc_gsi_handler, gsi_state,
-                                       GSI_NUM_PINS);
-    } else {
-        x86ms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PINS);
-    }
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
 
     /* create pci host bus */
     q35_host = Q35_HOST_DEVICE(qdev_create(NULL, TYPE_Q35_HOST_DEVICE));
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 13c4eac..8c5dc39 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -157,6 +157,8 @@ typedef struct GSIState {
 
 void gsi_handler(void *opaque, int n, int level);
 
+GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
+
 /* vmport.c */
 #define TYPE_VMPORT "vmport"
 typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
-- 
1.8.3.1



