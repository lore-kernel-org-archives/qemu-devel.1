Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68057C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3C1206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuJ/Ni/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3C1206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSoy-0001Vc-Uz
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHA-0005F0-QO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSH9-0003xy-Oa
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:20 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifSH9-0003wG-Hh
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:19 -0500
Received: by mail-wm1-x342.google.com with SMTP id w8so36614wmd.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 09:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X8qg4vC4u62X+krIpf2n1pZJRXcVq9s/dN9HuyUC68E=;
 b=BuJ/Ni/8Z0dbYx6aFUpWuzQRETBEy2qWx+fbII5cIRb4kj+NwHwyEda+ex2wWzrybV
 tYL1YA1z7iCfGD4Yz1oBNyNy/UpNJnDHMiBnQYpY3yHHRik2tC/iFLVhSN6lgE+BVOuP
 4Vr+mzYmKijOo5uBMpYYNZTCcNBUUm46o309YQX2XuqurUHSWLvPwfp2UaQRW5OYwyRb
 Vkb1x9I4NjTdqHpIjyhV8nuLqGA4p2e6WlkPlC2isGjvswMLi8XnVvxevQMGiI75rE04
 UfCQKbTXMbL7gczMttJ7z3Lsn4jvYi+pCGLuBUH+F6a+vZOa7UQ4v/upLdoBt2tnOecL
 gotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=X8qg4vC4u62X+krIpf2n1pZJRXcVq9s/dN9HuyUC68E=;
 b=j3atPfjxNVm/Up3D5gl9zlD6Gs9RlwiTzFaEJocYT9roaKXSoxiwm8WCWPvwKimPfN
 mqIV5BqSTJqFzBc3wBqQjjfSI+Qfprq2PI02CDj43gNoFxTaujhxXUgXUMtD4zmx30d2
 fd2APl1fQXHzFDC+i/xLL9vuSZ2AuXMx5WahPNHksQSTT8zcQItb6a0BaukfgX7wz8nt
 wK6xJVc2nLt1RuHN4KYRmJQz4pJFbrqrRAeNr2mWqNN0JiRIcN+rWU74BV0F8iY6/Br7
 0/peESS0gfQCx7gJqiIX89P+bgKdUqLZPs+0zxKo1YjfQ0yy/IbhhOEkzQinbcLBJ8cH
 4YYw==
X-Gm-Message-State: APjAAAWDa8QWj6K06wBj8acn7CFPtWtHWyMOM2Y/Zf8Y/ZsYasAzacXK
 7o/OuAMzBXCYGoVhLyDlmT570meO
X-Google-Smtp-Source: APXvYqx55EHdl3/Np2mJPg7qWsig0xTnAfk+a0dcuBs8z3ZLyIEtgac4SmRrubfRxJSHfGGvhJZ0RA==
X-Received: by 2002:a1c:286:: with SMTP id 128mr7597351wmc.176.1576171758031; 
 Thu, 12 Dec 2019 09:29:18 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 2sm6810130wrq.31.2019.12.12.09.29.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 09:29:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/8] i386: conditionally compile more files
Date: Thu, 12 Dec 2019 18:29:07 +0100
Message-Id: <1576171754-45138-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: philmd@redhat.com, slp@redhat.com
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



