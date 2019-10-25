Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD0BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E902053B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3o1E+sJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E902053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0lr-0002WD-NA
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tn-0005Co-Bk
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tm-0001g2-Aw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:15 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831]:42375)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0Tm-0001fp-7G
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:14 -0400
Received: by mail-qt1-x831.google.com with SMTP id w14so3451350qto.9
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YCOFi2fDpbUezaVnqe2fyjA9hZ1F82Ek3+HEANsqQro=;
 b=r3o1E+sJZZ3s195dKunkrFvV0xCk+XH8nhfVpz7dAFaosR6a7pP10ak4h+gSL9SHNM
 xOJLhU+pCD8LZ6VvJMRMySKbN6XbaRI8e08hPP//g4gaHGS5jrkCpR9TX2DapPCb/kth
 QKJjvqbnRyh1ChIRsk6FYQLEDPBFkmbmq9M/CdWoI0F6Okjm/iQE6LnzT6xJ18wpUFVh
 qQ3DKY0HWy3ot4IvQoKMkK7ASwa927f7LmpuJ1ynKGfm3vnE6dzcEzo9BHg7oO+2TJL3
 7jcFd4EfXHb/pWp7I7TohFfs6fsLN7ngvIGs9zEieW2HlUJ2VL60/mZ6hD65znf9uj4e
 xWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YCOFi2fDpbUezaVnqe2fyjA9hZ1F82Ek3+HEANsqQro=;
 b=mmoeyvzhT5I2ucHfrWxQ58D98KSLmcqxggS35bunPGwG1aPdekD1BGLA6k8HVD/5hU
 gMu4ibgoN4U7xwLCsybfMW5Qe+nyOWNY+48+Ey9T5RsqAaTonDnV0KSOhcZ4iLs21ZL+
 mY6hSxQ1figsi9nZsRFotJPp/AHpQcmU1BuPQPYmmliWWTVn3Zrv2rA2ywc0ZhCXo14+
 Lt0EU6auoEW34wgRaM1+GU98whtUZv7xXVHPJ2aXVP53i3z98+R9gG6IsPGTB7Dg3bZZ
 donqrK1fhh8N8OLZePOnslvN/spVFUROdEjNEhSIHIvjvdqyxyHsukvQtfiPj1H09ui8
 LUzg==
X-Gm-Message-State: APjAAAXKhJ/QGNJqHRuNn789Faf3i4cBkIQrEZwD8zTkDEPVzGikyOQt
 0JjtoWnvOUK1ofq0lu5k4934jEU+Er0=
X-Google-Smtp-Source: APXvYqxOBCHKnULLz/vQbFrku+rFFQqV5lkWLXAWW8JVWnu/+LOb2AuTu8aw6aCbXeOI2tN57Jlwiw==
X-Received: by 2002:a05:6214:8c6:: with SMTP id
 da6mr2147206qvb.1.1572013333308; 
 Fri, 25 Oct 2019 07:22:13 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] cputlb: Fix tlb_vaddr_to_host
Date: Fri, 25 Oct 2019 10:21:57 -0400
Message-Id: <20191025142159.12459-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::831
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using uintptr_t instead of target_ulong meant that, for 64-bit guest
and 32-bit host, we truncated the guest address comparator and so may
not hit the tlb when we should.

Fixes: 4811e9095c0
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6f4194df96..5eebddcca8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1189,7 +1189,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
                         MMUAccessType access_type, int mmu_idx)
 {
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    uintptr_t tlb_addr, page;
+    target_ulong tlb_addr, page;
     size_t elt_ofs;
 
     switch (access_type) {
-- 
2.17.1


