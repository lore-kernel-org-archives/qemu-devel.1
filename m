Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B63AC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64B220737
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjEyoehE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64B220737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtUz-0002v4-Ve
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtTY-0000aS-1y
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtTX-0008Dm-68
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:25:47 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jNtTX-0008Db-0p
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:25:47 -0400
Received: by mail-pl1-x641.google.com with SMTP id y12so2807187pll.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 00:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rcr3r7EHKTN20QWo1cHUmhcCCOh7xy4CEyh5IWphRGk=;
 b=hjEyoehEw9UiB64zs266aysB8Fech4XcqTwQUvT8cKrEH/MwgwN0vaZZFZWBXbaxEs
 2VLmeoun9JWg3PbInHrMXSP0qONm/51gRkxx8p6mWe14O07jdRQKL2meU7uk6Xg/sQ0Z
 yi5C13ie0/ddCU+RXouid0RzEhQN1OwesDWaxiVLkAsnHbgqRjkl70h/jyKWMzlgeMeC
 uqUaN3+CSbb8zi+H4NeC0vpHAXeZo3+vsT/CB4zLL9++5c9T3bK/scGget+jFE60g74C
 f1+lNuEjbfD88NpaPXXpyUMbaHv7JUSx4RrOrhIM2FpZ4ZSZ1xAPfEKyNg8ckNizszn7
 /qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=rcr3r7EHKTN20QWo1cHUmhcCCOh7xy4CEyh5IWphRGk=;
 b=nAqRzc3BujMBgJgRWfXbFUdlM1riXcuTZ8swZUT1UVtOGoQTj+Lx/smGynGprJKrKD
 Zvji6URVh+6z72e1CCNuUrq98eztDjZJ65YVXSfgZ0YMjnEwnW2EJg+5yW1oG2kGrVHT
 qMJunG2oJMoX+xnx7YJI63WFJ+ai0MT0pah5e8RyepTgVqV7VL65W1AR7K54NMgMLHZK
 oAQD9BWRjyTmsz2ivr6fcrwVwaPnNBhyYF9a85FLjpVV8qIx+hBzJZdm8hJRJBodL/xM
 +BHZPuZVIPnCoQMoxVvRNX8quyEeW9R2qK2WJ7TgOPb+q7KPfM8NyMpb7EdnQuCX+KZ/
 a8lQ==
X-Gm-Message-State: AGi0PuZYqKqiETNnIK0znnHvtP0B/I/BVNImdB3sO2iUB5qIEqkOz/Yf
 dxgcTSTcX1R/0Ntm6DQ39vY=
X-Google-Smtp-Source: APiQypJ7sYB35a50kXkyVw2AqbaMP+yLekJXXIv+HR2IAM6iz4MvwvlOfVTeyYhgzICPnycZFBqg+g==
X-Received: by 2002:a17:90a:e50a:: with SMTP id
 t10mr21330556pjy.110.1586762746231; 
 Mon, 13 Apr 2020 00:25:46 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u8sm7241341pgl.19.2020.04.13.00.25.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2020 00:25:45 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 08/15] KVM: MIPS: Use root tlb to control guest's CCA for
 Loongson-3
Date: Mon, 13 Apr 2020 15:30:17 +0800
Message-Id: <1586763024-12197-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

KVM guest has two levels of address translation: guest tlb translates
GVA to GPA, and root tlb translates GPA to HPA. By default guest's CCA
is controlled by guest tlb, but Loongson-3 maintains all cache coherency
by hardware (including multi-core coherency and I/O DMA coherency) so it
prefers all guest mappings be cacheable mappings. Thus, we use root tlb
to control guest's CCA for Loongson-3.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kvm/vz.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index 422cd06..e30ebb2 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -2871,6 +2871,10 @@ static int kvm_vz_hardware_enable(void)
 	if (cpu_has_guestctl2)
 		clear_c0_guestctl2(0x3f << 10);
 
+	/* Control guest CCA attribute */
+	if (cpu_has_csr())
+		csr_writel(csr_readl(0xffffffec) | 0x1, 0xffffffec);
+
 	return 0;
 }
 
-- 
2.7.0


