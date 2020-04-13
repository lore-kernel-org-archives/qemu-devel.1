Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF28C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2837D20737
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msz8u4rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2837D20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtTg-00009e-Br
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtQg-0003Rx-JL
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtQf-0006gh-LX
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:22:50 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jNtQf-0006gW-GK
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:22:49 -0400
Received: by mail-pl1-x641.google.com with SMTP id d24so3104613pll.8
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 00:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TZhgT5gzN/QhZfE1otKiPDej1lzfZYbOzbi8m9YCzNk=;
 b=msz8u4rnm9qloVBXtsffUI8FKe2tlKM+2hEuS45XjwHEz+dCvQHSQ7PdkCU8J9piN1
 3JvsDMJor8tnwIMkln5CN+Pa7AlPwBEjUTpBVIWCna1HZjItxG7ACje3wFcktp5e8tkD
 Kk0eY6ZdyNJ3lfzJ0c+r5Ccm4+ZO3xfZ3QTxoph9DQScR54Vkge4xoT10Fe2RDG+P0VB
 9Rv74/DzrAge9B1F/XCGuTOEmDOA3xb1+ktX3RK1VHaz0A0tjixOBqApknXcYiST4eGI
 CtT6oZS+UsGeR6471krMaDkC7MIFPuSCOX+ElkDp5r1/0cjb1yAvCfvBMdHPQ9Q6x4ta
 NG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=TZhgT5gzN/QhZfE1otKiPDej1lzfZYbOzbi8m9YCzNk=;
 b=NROhwCxxnPy88/T7JeF6n5YcPf5AegBreBA120HNe3YCQ2QSPrr6/M8O5LbtW7yoJA
 1ynaluh2k446l46xtFVhmZ69nLY3A7GjceilHSwuA/36Gc+1Quj4VFPry/dkYNeRHkLn
 HUFs1OixTOSlq5yciWHvGHGhbsKyF7Ec4a4+796tmRX/tJHCuBpiX+PjogzsnXnjGmRB
 93br787uhoC8d3EOOJLbjKTFHv8RRNkBjisFcxKnbUVl7+HR18HqxFzarfIyt3zHcd13
 hjEZlFU6mgew+ik8KjjfSnB3CCQUokcTA8qMeN2V/iIHFkVl6YbJQmUxLkJBlviTF8PR
 BgUA==
X-Gm-Message-State: AGi0PuZsSumfYlVIow5bU/FKCsiOvm/7VwWi5wOK0SC6RNHWKFI4Ioq8
 CeFCeDPY6nP/HPjue/XMOH0=
X-Google-Smtp-Source: APiQypI2Dw4REaEH3isPk9kUjxH01Os9b6g4OioUqeQskNSG8c/c8x97XaoId95X7kvG/IQrU79kDw==
X-Received: by 2002:a17:90a:ee90:: with SMTP id
 i16mr3079047pjz.165.1586762568561; 
 Mon, 13 Apr 2020 00:22:48 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u8sm7241341pgl.19.2020.04.13.00.22.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2020 00:22:48 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 03/15] KVM: MIPS: Fix VPN2_MASK definition for variable
 cpu_vmbits
Date: Mon, 13 Apr 2020 15:30:12 +0800
Message-Id: <1586763024-12197-4-git-send-email-chenhc@lemote.com>
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
 linux-mips@vger.kernel.org, stable@vger.kernel.org,
 Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>,
 Xing Li <lixing@loongson.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xing Li <lixing@loongson.cn>

If a CPU support more than 32bit vmbits (which is true for 64bit CPUs),
VPN2_MASK set to fixed 0xffffe000 will lead to a wrong EntryHi in some
functions such as _kvm_mips_host_tlb_inv().

The cpu_vmbits definition of 32bit CPU in cpu-features.h is 31, so we
still use the old definition.

Cc: stable@vger.kernel.org
Signed-off-by: Xing Li <lixing@loongson.cn>
[Huacai: Improve commit messages]
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/kvm_host.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 5794584..7b47a32 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -274,7 +274,11 @@ enum emulation_result {
 #define MIPS3_PG_SHIFT		6
 #define MIPS3_PG_FRAME		0x3fffffc0
 
+#if defined(CONFIG_64BIT)
+#define VPN2_MASK		GENMASK(cpu_vmbits - 1, 13)
+#else
 #define VPN2_MASK		0xffffe000
+#endif
 #define KVM_ENTRYHI_ASID	cpu_asid_mask(&boot_cpu_data)
 #define TLB_IS_GLOBAL(x)	((x).tlb_lo[0] & (x).tlb_lo[1] & ENTRYLO_G)
 #define TLB_VPN2(x)		((x).tlb_hi & VPN2_MASK)
-- 
2.7.0


