Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE182C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B0D206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkyDH1SO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B0D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtuM-00080k-14
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFV-0005fc-U4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFU-0008Rv-SM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:33 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFU-0008PW-M4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:32 -0500
Received: by mail-wm1-x331.google.com with SMTP id p9so7444056wmc.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=X8qg4vC4u62X+krIpf2n1pZJRXcVq9s/dN9HuyUC68E=;
 b=DkyDH1SOrnnuzeAtaIVyM4YNPTAa8B2khYk2dkrazvMYpJmFFP6TuE9lrrhe8p8hjt
 ApCX2ys+xgUdD71Kzf/BcGEnNY418FWvWC6L4GpS4RP670Iw9R8LDwUXo4pO+1ieqpko
 uI6PUvYbJY3NGJd7qvvPPtEx21NNVT6fLYB3ehcGDhB7gQdf54Qs9yytaIdm3XICXVyG
 Fa0qF/GE+tbYKZoMaVrd69Z5k8dRaYE4bCglCXogK4fxHA9Qp/sJ84YfbZwvdQKKd8+g
 po3GzKr7HWv86FRkVzTIDMsmeeGA6hUzuP1+eNMxNaKRItTETRUz7r5r7HAB01qjoysg
 eyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=X8qg4vC4u62X+krIpf2n1pZJRXcVq9s/dN9HuyUC68E=;
 b=m7Nmrn8hvIciE5TTRiDz9f7nU49fMS98+jMtfUJ08YQdEGVbXvqk4wigsJiZJHl46+
 EGZ+jT0qCAnaNsICVOjzH3JRROEqhiwfH21LngrxxcpwzG9Zgem/M+394aRgIbBWISTp
 PXkZpwqF8uMnMxXQFtq79DezLjU0MZh5w1hlUNqMQtpdrsW8Qh0t7whH2IaYaYBVdFMD
 MS8SedM09Oo6S+YprRFlcKcnLPWMA4NmzLh3PupfyaMA76ciIbFGEOZ2tc6JcXSiFRhC
 79fap2OkSidb9LIYMg3qnjVwCzgfBJRqB5+N8iVxS5Bt1yvn0OANQNZUoK/PyZG3r3c+
 n8Ww==
X-Gm-Message-State: APjAAAW3AwDYzvsFGjJBxqS7n0tzDuzQkGHpS+UcKmcfE0NZySjNtL3l
 wHlOaVvXc6dd7qhiV9rNEoqkWklZ
X-Google-Smtp-Source: APXvYqw7JvnnRlb6JUrtGCwqD43KUNjwRhRY9WwYoehyq99NgYbWLm7j5CvquTkgad0OQqPTGkFwjg==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr30726224wmg.16.1576513771488; 
 Mon, 16 Dec 2019 08:29:31 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/62] i386: conditionally compile more files
Date: Mon, 16 Dec 2019 17:28:28 +0100
Message-Id: <1576513726-53700-45-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/Makefile.objs     | 6 +++---
 hw/i386/kvm/Makefile.objs | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 0d195b5..01ae202 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -1,11 +1,11 @@
 obj-$(CONFIG_KVM) += kvm/
 obj-y += e820_memory_layout.o multiboot.o
 obj-y += x86.o
-obj-y += pc.o
+obj-$(CONFIG_PC) += pc.o pc_sysfw.o
 obj-$(CONFIG_I440FX) += pc_piix.o
 obj-$(CONFIG_Q35) += pc_q35.o
 obj-$(CONFIG_MICROVM) += microvm.o
-obj-y += fw_cfg.o pc_sysfw.o
+obj-y += fw_cfg.o
 obj-y += x86-iommu.o
 obj-$(CONFIG_VTD) += intel_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o
@@ -14,4 +14,4 @@ obj-$(CONFIG_VMPORT) += vmport.o
 obj-$(CONFIG_VMMOUSE) += vmmouse.o
 
 obj-y += kvmvapic.o
-obj-y += acpi-build.o
+obj-$(CONFIG_PC) += acpi-build.o
diff --git a/hw/i386/kvm/Makefile.objs b/hw/i386/kvm/Makefile.objs
index 4224ed9..0c8d5f2 100644
--- a/hw/i386/kvm/Makefile.objs
+++ b/hw/i386/kvm/Makefile.objs
@@ -1 +1,5 @@
-obj-y += clock.o apic.o i8259.o ioapic.o i8254.o
+obj-y += clock.o
+obj-$(CONFIG_APIC) += apic.o
+obj-$(CONFIG_IOAPIC) += ioapic.o
+obj-$(CONFIG_I8254) += i8254.o
+obj-$(CONFIG_I8259) += i8259.o
-- 
1.8.3.1



