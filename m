Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4258C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA1620717
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMMg06uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA1620717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtq8-0001xy-Bo
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFh-0005vs-A7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFe-0000Rz-TA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:44 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFe-0000Mt-6F
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:42 -0500
Received: by mail-wr1-x433.google.com with SMTP id j42so3847797wrj.12
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=veJBdI4srUvxlLCq05JT1ehp6Oxq8JyfQY2kT56bPsQ=;
 b=bMMg06uyW3LuRAI146MhoL9H+C8XiC+euugDop+ncbB11X9BHb1R+xU8jXCigLaI1v
 WdhiQIQw+rr5PHQVntxOAiCzb/uCoZLiAe9qWIqXWQEioHn8TfEhxElvGkCy4uwWHxKq
 D9GF1N2mm508AIJhfc4QF6slV52xcCReg89ca2ZkNbK1nmwS1O8bnwgSYQLXi/l57d8R
 tIAhoggvRjYQNTrcK8fH6th08Ba2igHjUlIQqG4i3EIjmdiF/ucfjhy/2QXsXpG3QZ1/
 V2hvelEHJNJ/2CVC0oRr0uLNm2jJNugoeIYT74kWLRjISkxXo4J8VUm5AO7Ipd23RPen
 otBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=veJBdI4srUvxlLCq05JT1ehp6Oxq8JyfQY2kT56bPsQ=;
 b=MdbfJLGxrsOZe2OudbjNsv8CB3sasMLCntOFsehZGfpj1Zn05STESJ67Q+QkxOwjxx
 Q72c8RTPYJRadaGqlhs+ZIyLzhtuREUo5NFYd+fg2z5T7ylEsvtFMqmfoI+Vy97b3L0m
 GP4zycTtoge4IFwEPOu763U3ll0fyyjq3TKlSow7GOYprYvH3XyuXkj9PpAWT4C0uGnq
 Zta8LFuAzVpQfilLHAVlSnicSTAgFpyWaY9p71cMQTVNL8k5ELSZ5nWe4q4OePxRFfSe
 ziGvBMS5aFnx0l1N3Ii1ExCiADfs6CFlujtwoExNAwBqKzwrMWyg8JOS8BIghWlAeJv3
 IP2Q==
X-Gm-Message-State: APjAAAUyMMLckJBAwMAz8E+FhRAatW2JHINebp4829YikCffnsvGFEhs
 2R41CGCKV2KqQjNlt61lBGg57Dz4
X-Google-Smtp-Source: APXvYqyEgu+KwJ89tu4OTeXILL5Wsew3IhJWoswPQjxqaxqaVsmfr8gacdDlzXV/Oc35aQ+QOU+QTQ==
X-Received: by 2002:a05:6000:cb:: with SMTP id
 q11mr30288332wrx.14.1576513781046; 
 Mon, 16 Dec 2019 08:29:41 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 53/62] hw/i386: De-duplicate gsi_handler() to remove
 kvm_pc_gsi_handler()
Date: Mon, 16 Dec 2019 17:28:37 +0100
Message-Id: <1576513726-53700-54-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

Both gsi_handler() and kvm_pc_gsi_handler() have the same content,
except one comment. Move the comment, and de-duplicate the code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/ioapic.c | 12 ------------
 hw/i386/pc.c         |  4 +---
 hw/i386/x86.c        |  1 +
 include/sysemu/kvm.h |  1 -
 4 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 8703f19..973e2b2 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -48,18 +48,6 @@ void kvm_pc_setup_irq_routing(bool pci_enabled)
     }
 }
 
-void kvm_pc_gsi_handler(void *opaque, int n, int level)
-{
-    GSIState *s = opaque;
-
-    if (n < ISA_NUM_IRQS) {
-        /* Kernel will forward to both PIC and IOAPIC */
-        qemu_set_irq(s->i8259_irq[n], level);
-    } else {
-        qemu_set_irq(s->ioapic_irq[n], level);
-    }
-}
-
 typedef struct KVMIOAPICState KVMIOAPICState;
 
 struct KVMIOAPICState {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f571fe7..d706b98 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -341,10 +341,8 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
     s = g_new0(GSIState, 1);
     if (kvm_ioapic_in_kernel()) {
         kvm_pc_setup_irq_routing(pci_enabled);
-        *irqs = qemu_allocate_irqs(kvm_pc_gsi_handler, s, GSI_NUM_PINS);
-    } else {
-        *irqs = qemu_allocate_irqs(gsi_handler, s, GSI_NUM_PINS);
     }
+    *irqs = qemu_allocate_irqs(gsi_handler, s, GSI_NUM_PINS);
 
     return s;
 }
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 80e33be..d18a3ef 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -295,6 +295,7 @@ void gsi_handler(void *opaque, int n, int level)
 
     trace_x86_gsi_interrupt(n, level);
     if (n < ISA_NUM_IRQS) {
+        /* Under KVM, Kernel will forward to both PIC and IOAPIC */
         qemu_set_irq(s->i8259_irq[n], level);
     }
     qemu_set_irq(s->ioapic_irq[n], level);
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index aaf2a50..141342d 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -515,7 +515,6 @@ int kvm_irqchip_add_irqfd_notifier(KVMState *s, EventNotifier *n,
 int kvm_irqchip_remove_irqfd_notifier(KVMState *s, EventNotifier *n,
                                       qemu_irq irq);
 void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi);
-void kvm_pc_gsi_handler(void *opaque, int n, int level);
 void kvm_pc_setup_irq_routing(bool pci_enabled);
 void kvm_init_irq_routing(KVMState *s);
 
-- 
1.8.3.1



