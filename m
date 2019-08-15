Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0573AC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F96205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1tLin0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F96205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Ez-0007oW-8k
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DD-0005sJ-TM
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DC-0008Dz-Qh
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:09:59 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:39541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DC-0008Dk-Mg
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:09:58 -0400
Received: by mail-yb1-xb43.google.com with SMTP id s142so402732ybc.6
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ouwU3mH0heGGYj5tVAnCDMGwPLkEloG4KITrIoN6Jz0=;
 b=Z1tLin0u8OQBU3jYRNi6no+IMJ7+piZGf1bc2DejWtEsqFTd9AvufUdiTNyUBZN/bE
 ql2NXcznET8QRALiBBCekue0noz/0RbLofkHdDA0LhjHhPiBJx3koPHs0Ww/E/0bReMz
 PykHOD96qRauom7zIx/UfoGgX1BtT8Z41DOUwVoAy+dPaPYpaXePAb7W5038XGjZciih
 RCw8WoVD+loKTspvQlnpUoo/94ZDxAWYyiId1DJ/i9xRH8nH/KVPDV0RObOxhrxs5MJm
 ZZqDx4O5tgkyYegzcVdrVDn11NYjJPwSpQOIjQOJNHf0MyO02qZczS2ab3G/aSb+kytH
 rRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ouwU3mH0heGGYj5tVAnCDMGwPLkEloG4KITrIoN6Jz0=;
 b=UZEQ4sF5AaKg9Ppqkzvmo8wzO2Bo3dhK2Qn7SQDkOEea5zKACMo7KatSthv75hO1PY
 UgZeiy5v5iPxik4ebOUHVh7kMVK4qFzQeSZnHF+CHeJeUEFuoepETt3AmHmBojFOGjOu
 0CP8hnBBZUPIZKw+9eZngB8BKLQmUKXpN4pLcQUSYRiwcwfzLk89czQOAgfgjgwpfRQq
 Pn6n+0gHoSuKHV9fdHJElGKPsyG/SVRJ3B1KyYalFXTxV/Zs5rBVXbGOoL7v6Jfcsggf
 WEHFtAqII25XmKX3MdAG/1cpVx9052Jyq708MvhYsb2GCqwGWLy0XesCnj/Nw/DTKTYf
 PZyQ==
X-Gm-Message-State: APjAAAUZtwBxkGJC0w7gIsHoRZO2rZC0Id3l2GRrvqQyO11kQyT4htha
 1IYT5qLcG2iyzANjIp/iSeNup7HH
X-Google-Smtp-Source: APXvYqxf1uIqEp03Hi01UodPJ2NYneHd2JcmOp+E2X09CSUc7c4K1SweVP8n37U7PQny092oO7w+VA==
X-Received: by 2002:a25:d7d0:: with SMTP id o199mr1960407ybg.162.1565834997967; 
 Wed, 14 Aug 2019 19:09:57 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:09:57 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:45 -0400
Message-Id: <20190815020928.9679-4-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v3 03/46] target/i386: reduce scope of
 variable aflag
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The variable aflag is not used in most of disas_insn; make this clear
by explicitly reducing its scope to the block where it is used.

Suggested-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index c0866c2797..bda96277e4 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4493,11 +4493,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     CPUX86State *env = cpu->env_ptr;
     int b, prefixes;
     int shift;
-    TCGMemOp ot, aflag, dflag;
+    TCGMemOp ot, dflag;
     int modrm, reg, rm, mod, op, opreg, val;
     target_ulong next_eip, tval;
     target_ulong pc_start = s->base.pc_next;
 
+    {
+    TCGMemOp aflag;
+
     s->pc_start = s->pc = pc_start;
     s->override = -1;
 #ifdef TARGET_X86_64
@@ -4657,6 +4660,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     s->prefix = prefixes;
     s->aflag = aflag;
     s->dflag = dflag;
+    }
 
     /* now check op code */
  reswitch:
-- 
2.20.1


