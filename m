Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C78C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DE120737
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHKwQhQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DE120737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtSs-0007Dr-CB
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtRK-0004Vt-Nz
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtRI-0007LW-Fr
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:23:29 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jNtRI-0007Hq-1u
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:23:28 -0400
Received: by mail-pj1-x1041.google.com with SMTP id o1so2646430pjs.4
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UVCxTnXHR3JksW4kNoRPYShJz0VQm0+u2ggksb/zVto=;
 b=YHKwQhQ8uYspWZKAckCJrtm72ODPhNdButAAJ27i9ZCefOlJDY//J9k6k+KGCG9+LI
 cljDdKd298diKZYs+1YwB3L5xRmmtSEe/0R0Tp1qGy9M6exVw2H/pM0AR7NFXsnsCwsL
 KwMoI/aRYOokKR/ub5d6FFHj2R0A/J+Kb8Fb1ozpAvLvzUq2zcJbQSC+WGsJ3InM64ER
 udEBtFP2AoLf2+YyzXXveF9V88yw5U5iNUEcF6jxoDOH+cd0NIROOZWwjuT7nwJ1L7MN
 zRJY4HD+dc2adbLRErSmlzHa3Rw6gJgc1PreAdODMduMyTn2NCpp66X0scK2Q54ikpur
 Ljug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=UVCxTnXHR3JksW4kNoRPYShJz0VQm0+u2ggksb/zVto=;
 b=hxBrRjE35i7g5CP4ZTCWM3dq1ZQL2rv+6JqgaEWAQWYV+yqkdFLiC6jeDYtaOCB8di
 Tk5UWsZHL90VTLYeB2ZqO4YKHSxw5PA/NRyzCyspoQyjUBxNH1L7BoVBcYRge7l2he5O
 kZOVNZgbkqKrMMdB19hMHvrpEJ05tEozWkI/E4NrBdT4+KTmy6cxHUdnezPYE4bZYzEG
 AXrvMQfc6To5HwKavyM5TQh6OJ4hMT8wYMF3GuhB0veQTyXO1kLfiq0ywUvbBiHKj+cT
 K2+/IBGEmjGQsITjwMgoCjbW1jcZuHY54S9tP0Vqb8ZODiBssEy59+Sa1aFEttUPy6zV
 h/QA==
X-Gm-Message-State: AGi0PuYTYn8lwL5k5s/loHm7SUKmmnqh5k1ZDlD9i0eJe2leFS7b9DLI
 N3DI0pCD0cpoTt279t5QVW8=
X-Google-Smtp-Source: APiQypI1h6KmTeIWmHIup4Gdrnsdh7SfYOYPE5/YrcJrz5mweL0LD6nQ/PM51Xkrsv2zk27QQYZkow==
X-Received: by 2002:a17:90a:fe18:: with SMTP id
 ck24mr21510792pjb.57.1586762607056; 
 Mon, 13 Apr 2020 00:23:27 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u8sm7241341pgl.19.2020.04.13.00.23.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2020 00:23:26 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 05/15] KVM: MIPS: Add EVENTFD support which is needed by VHOST
Date: Mon, 13 Apr 2020 15:30:14 +0800
Message-Id: <1586763024-12197-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: kvm@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
 Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add EVENTFD support for KVM/MIPS, which is needed by VHOST. Tested on
Loongson-3 platform.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kvm/Kconfig     | 1 +
 arch/mips/kvm/Makefile    | 2 +-
 arch/mips/kvm/trap_emul.c | 3 +++
 arch/mips/kvm/vz.c        | 3 +++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index eac25ae..80b0464 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -22,6 +22,7 @@ config KVM
 	select EXPORT_UASM
 	select PREEMPT_NOTIFIERS
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
+	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
 	select KVM_MMIO
 	select MMU_NOTIFIER
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 01affc1..0a3cef6 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -2,7 +2,7 @@
 # Makefile for KVM support for MIPS
 #
 
-common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
+common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o eventfd.o)
 
 EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
 
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 5a11e83..f464506b 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -529,6 +529,9 @@ static int kvm_trap_emul_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MIPS_TE:
 		r = 1;
 		break;
+	case KVM_CAP_IOEVENTFD:
+		r = 1;
+		break;
 	default:
 		r = 0;
 		break;
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index dde2088..17932ab 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -2927,6 +2927,9 @@ static int kvm_vz_check_extension(struct kvm *kvm, long ext)
 		r = 2;
 		break;
 #endif
+	case KVM_CAP_IOEVENTFD:
+		r = 1;
+		break;
 	default:
 		r = 0;
 		break;
-- 
2.7.0


