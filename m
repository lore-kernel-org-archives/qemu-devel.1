Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27132C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 11:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D669421908
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 11:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyBtjCkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D669421908
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55309 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHRyF-00032G-7M
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 07:46:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hHRxR-0002jc-Mc
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hHRxI-0000Wj-9E
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:45:24 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shahab.vahedi@gmail.com>)
	id 1hHRxA-0000Pa-Sn
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:45:14 -0400
Received: by mail-ed1-x541.google.com with SMTP id k45so4236909edb.6
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 04:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=98Qq3AiP3cHkjukBYMOl1co3En5Y7L9TEWuFbqscQ+c=;
	b=IyBtjCkfYpS46xZqh+sJFea61fJk5By84j/Wcz0SmClhm/vPih2oG4kMMHFCun2flE
	F1CkjWvHirVsG5IPkKtpTw5Fj50mZCPOLMYTvObm1dyIPTxwrMktWtm10ejbaDGL+k6T
	K/bHxNE4Uw5XLMMRW6F0brB1AOClrMrIG++taWmqY/MGZWBpbHl1BzVH2P4bw3hWUSII
	66BMR7j6yyBBi9CTnV4kxg8DIejd2J4MT2jbPbo1bPCct5ZNPR8q339iZhkLJ+N0Cu4C
	sS9nJEcny4Sw/+1U7fon5geh8xBX1isvVPQKDI3ok7HU6bLaLjGQi+erB33XbQD2e4Qt
	rJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=98Qq3AiP3cHkjukBYMOl1co3En5Y7L9TEWuFbqscQ+c=;
	b=a6H7zVOLzS8J8xrAgTi8U5NwzwfOeT/G3Cya7JyPYE8lR1PDrtdyezha1hWV27eMzG
	FDnyK1mkFnesyFb5vtngWqtEQqqCw/4mWf56DCDraODuLlnOy0+YI8k6ThKthgd7Pq3w
	fVSwF8n6os73Lkvk23CCwEx+qOD09iFnmeIMFXK3JoLP3CyeaURI8maYpwPJQ/ojt7Z9
	DBXwg9XSup+oINO4YHMStNEP0F/ZiLgtnNyFziztnY8e5SWZNIaXxGJad5cEj2MAAaGm
	tFXS9bVDc52kxHLQiYtw7YbLj+FEnHsslC2Jl4O6Pa8rnlxwZ47Ehz6HbANaTuNS1+xb
	jU7A==
X-Gm-Message-State: APjAAAWedVv10Xd6Kl0+O72f0+Wg6R3+gupbRK6jrpd2hGrbdY1naLbA
	mA/ZO+dDfk4CxQl3j/lkWPaXfQGMXlRxQQ==
X-Google-Smtp-Source: APXvYqyU/9C6pdHDEcJo2Shr+Qr1pMYwT9cDdl/0kfFRViZLmKgAVH/MGUFtqL08SilQbqFyx+ry2A==
X-Received: by 2002:a17:906:4c91:: with SMTP id
	q17mr1737752eju.3.1555674309000; 
	Fri, 19 Apr 2019 04:45:09 -0700 (PDT)
Received: from localhost.localdomain
	(ip-217-103-128-141.ip.prioritytelecom.net. [217.103.128.141])
	by smtp.gmail.com with ESMTPSA id
	i35sm1291840eda.55.2019.04.19.04.45.07
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 19 Apr 2019 04:45:08 -0700 (PDT)
From: Shahab Vahedi <shahab.vahedi@gmail.com>
To: qemu-devel@nongnu.org (open list:Overall)
Date: Fri, 19 Apr 2019 13:45:02 +0200
Message-Id: <20190419114502.20388-1-shahab.vahedi@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Shahab Vahedi <shahab.vahedi@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419114502.jhdhV9xN95YhS8CVE6ZFkSIKBFZRaETjTqLvn3eIfso@z>

This change adapts io_readx() to its input access_type. Currently
io_readx() treats any memory access as a read, although it has an
input argument "MMUAccessType access_type". This results in:

1) Calling the tlb_fill() only with MMU_DATA_LOAD
2) Considering only entry->addr_read as the tlb_addr

Buglink: https://bugs.launchpad.net/qemu/+bug/1825359

Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
---
Changelog:
- Extra space before closing parenthesis is removed

 accel/tcg/cputlb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 88cc8389e9..4a305ac942 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -878,10 +878,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         CPUTLBEntry *entry;
         target_ulong tlb_addr;
 
-        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
 
         entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = entry->addr_read;
+        tlb_addr =
+            (access_type == MMU_DATA_LOAD)  ? entry->addr_read  :
+            (access_type == MMU_DATA_STORE) ? entry->addr_write :
+            entry->addr_code;
         if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
             /* RAM access */
             uintptr_t haddr = addr + entry->addend;
-- 
2.21.0


