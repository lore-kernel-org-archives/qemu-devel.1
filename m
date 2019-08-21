Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D48C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFB66216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qiul+mHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB66216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SH8-000437-12
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFb-0002DI-Lx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFa-0002sQ-K1
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:15 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SFa-0002ri-En
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:14 -0400
Received: by mail-pg1-x543.google.com with SMTP id x15so1475354pgg.8
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Q+vm+ZkkzZrsnIcbi90qSr0+5L0toF/enmbYkAkl4I=;
 b=Qiul+mHnvALkrRKddprZNAqez9XwE8NHViV/Ztb/a1GgO3HHb3dGWEyl7NB3OHyOIA
 KtFPN/j3USyk8O35TorcKjJeHFY1Qr6jW8M3Tso121bRUpS2gdBoAkn6v1qNLHXujfwS
 HFtNLwY6CTHzb3izhtzNdpKsEQWe1bUegnJ9+YFtEyEK92CZEuHxpeb067dMFoM9iOD+
 zrmfNejbn4oO7ADWfBbwyZWgjS3TTvnU22py4H3F60DJlBONxbHdSKNPBzNpsalV0sdd
 MY+4FbUfq2CxubwyOEhzRFwsrP2NgjRHycnvaxqZFt/3nbYS8Zd7Ic9snlxNKif7D8Pt
 HT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Q+vm+ZkkzZrsnIcbi90qSr0+5L0toF/enmbYkAkl4I=;
 b=QbrH7JNGYDgj1YPj1NzE7haM3LJvM4aNotQ6FWUa6jE2UZhlgTh057cs0qnUD390QK
 3eEWjE3YC1xSwK+WmhLSatQhnFtAdIy/+PpzlzfvpVokirjErEVnRjY3sRRdkeYeKMEJ
 imcfpcrG3YYw+iFA4f8OLgHprr+pmw0SzVp+Jy6QL80Zh18Qj8vIfOIXZn8nOW3WgLDc
 15GVL1J7r1PSOkJJ6KFwa8bp4pfDEj7w2jepygiWK9X1xaeX5r2KfMLdW6aHQBV4t7u0
 yJJOLCTLdpeX/GG4ebr+jnqH/7pQoZt2jCarKyhWVhrUB54Cr1HcrhrjQ4JTyOz6dMU3
 a+bw==
X-Gm-Message-State: APjAAAVW35x5Md4WHBNm5zpnG9LUevDMJB7kmlg1HVTZqRc8SCxQlyZS
 s5tvaNAyPsr0zvdNXBzHSjwpPbbLXHs=
X-Google-Smtp-Source: APXvYqw0d9aJmgfCOxfQPjN2xdO3cqRobkWMHesNWBQtWVXeHhf17dnbb0mhqRiWqrQfL5AbxP9L5w==
X-Received: by 2002:a63:f857:: with SMTP id v23mr29388434pgj.228.1566400212807; 
 Wed, 21 Aug 2019 08:10:12 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:12 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:04 +1000
Message-Id: <4a2a872f45f1d967208216cda8c6030af19eb4e5.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v8 10/21] cputlb: Access MemoryRegion with MemOp
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Tony Nguyen <tony.nguyen.git@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory_region_dispatch_{read|write} operand "unsigned size" is
being converted into a "MemOp op".

Convert interfaces by using no-op size_memop.

After all interfaces are converted, size_memop will be implemented
and the memory_region_dispatch_{read|write} operand "unsigned size"
will be converted into a "MemOp op".

As size_memop is a no-op, this patch does not change any behaviour.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 523be4c848..6c83878f73 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -906,8 +906,8 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_read(mr, mr_offset,
-                                    &val, size, iotlbentry->attrs);
+    r = memory_region_dispatch_read(mr, mr_offset, &val, size_memop(size),
+                                    iotlbentry->attrs);
     if (r != MEMTX_OK) {
         hwaddr physaddr = mr_offset +
             section->offset_within_address_space -
@@ -947,8 +947,8 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_write(mr, mr_offset,
-                                     val, size, iotlbentry->attrs);
+    r = memory_region_dispatch_write(mr, mr_offset, val, size_memop(size),
+                                     iotlbentry->attrs);
     if (r != MEMTX_OK) {
         hwaddr physaddr = mr_offset +
             section->offset_within_address_space -
-- 
2.23.0


