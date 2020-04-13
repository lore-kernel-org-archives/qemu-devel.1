Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA61C2BBC7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF7F2076A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKTR6opB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF7F2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtQk-0003Ey-Gr
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtQ2-0002Nq-I9
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtQ1-00062u-8l
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:22:10 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:51976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jNtQ1-00062m-3T
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:22:09 -0400
Received: by mail-pj1-x1042.google.com with SMTP id e16so3211731pjp.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=unWCB+7tFDxvEbrE324xq/PWVQz1J3pJxb0QQI5akQE=;
 b=eKTR6opBGDmh0WFyXbesHgyM2YLRiQFBHC5uiZl88n0oTzSeL/Tw+NnUNWcgwwMV14
 qKkmx5brwvB6qb6lT84AzMa8YjqZO8gDWvwkYx17LXozZOZwUDRvs5yxrWL2p4Ig/s3u
 X50Y/qv8M0lU4uKxUALpT/12ToTX+eSaLTsgLbN1b9tH/QQvi0RDupAzExbDtqEhZX3n
 slW9tOMpwAZENfYGaOaU6jubumcyoWCclOA95qQU9NBXVvCMZ9AOoKgbLhNYfYfW518z
 RfbMLqTBmwnA6IFH4TSOhP9Nyd0OH0d67QITUHNXc2UrZCBwdv+PcS3/U2DsWN3XhRjG
 0/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=unWCB+7tFDxvEbrE324xq/PWVQz1J3pJxb0QQI5akQE=;
 b=FxSnWr1w5eeq7mzm3ShHxXrNr8L4b0+J/lqaPFer4e+g9+2DQqeuPHwzyBYhiHimwm
 NBg+MY0oTsshbf6y/EMGOJNk0sv0cZOP6hfqzz3jlGFdm6v/Jw0l8OJ8gPVA55qcQ6Ve
 vwMYT5SabiJdUGAuW+8HrnqB1aH3bpY0sI4CJbox4f/SqGDuwGJXZ+e61/ZWb0DycNIH
 JRq3bYXDbMWCyp73VD/2aZUc47BtdxMVHdCvFQY7uRqrnFo0DMOzcn7Q3l3+8mhu5oQ5
 2QKVcdHnJlNgp6MKoxr++LUe8ISI7DevSnJC/8E3aL4OeknGQAQy69zCSds7batzl5Jy
 VI9A==
X-Gm-Message-State: AGi0PuZoXzL7BSCa383E3YWpHPwJ96JWjMLcdroEaMh7yaLWqSWBSONc
 bRsB3KaSP7BxgxejMwyzbQg=
X-Google-Smtp-Source: APiQypKG3jjD0bEk/1UaizxYUdFYFTcbzT0+h4p2hEYYr1KO3YnMiBfTuV+NpLNifY8hBLinUgTaew==
X-Received: by 2002:a17:90a:4809:: with SMTP id
 a9mr20297730pjh.73.1586762528070; 
 Mon, 13 Apr 2020 00:22:08 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u8sm7241341pgl.19.2020.04.13.00.22.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2020 00:22:07 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 01/15] mips: define pud_index() regardless of page table
 folding
Date: Mon, 13 Apr 2020 15:30:10 +0800
Message-Id: <1586763024-12197-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
 Huacai Chen <chenhc@lemote.com>, Mike Rapoport <rppt@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mike Rapoport <rppt@linux.ibm.com>

Commit 31168f033e37 ("mips: drop __pXd_offset() macros that duplicate
pXd_index() ones") is correct that pud_index() & __pud_offset() are the
same when pud_index() is actually provided, however it does not take into
account the __PAGETABLE_PUD_FOLDED case. This has broken MIPS KVM
compilation because it relied on availability of pud_index().

Define pud_index() regardless of page table folded. It will evaluate to
actual index for 4-level pagetables and to 0 for folded PUD level.

Link: https://lore.kernel.org/lkml/20200331154749.5457-1-pbonzini@redhat.com
Tested-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Huacai Chen <chenhc@lemote.com>
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
[Huacai: Add Tested-by and take this patch into my series, because my
         series can't build an available kernel if without this patch.]
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/pgtable-64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index f92716c..ee5dc0c 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -172,6 +172,8 @@
 
 extern pte_t invalid_pte_table[PTRS_PER_PTE];
 
+#define pud_index(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
+
 #ifndef __PAGETABLE_PUD_FOLDED
 /*
  * For 4-level pagetables we defines these ourselves, for 3-level the
@@ -210,8 +212,6 @@ static inline void p4d_clear(p4d_t *p4dp)
 	p4d_val(*p4dp) = (unsigned long)invalid_pud_table;
 }
 
-#define pud_index(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
-
 static inline unsigned long p4d_page_vaddr(p4d_t p4d)
 {
 	return p4d_val(p4d);
-- 
2.7.0


