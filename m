Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7F8C2D0D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887B0227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6ZycbOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887B0227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii1CO-0003Vz-GA
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 14:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ii0y7-0004s2-DY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ii0y6-0000t3-4I
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:56:14 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ii0y5-0000mt-Kv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:56:13 -0500
Received: by mail-pf1-x441.google.com with SMTP id 4so3770086pfz.9
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 10:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gBoYzkJdAL/tInNP9lZpL+nZi7QXFa1Q0BP5MRcfoAM=;
 b=w6ZycbOYOOOyZDHLOEjMExnN9Ob0B4EqaHqXl2JPNzqXSolq2ZRJqPDfT0F1kK1cqk
 dBIFGVEexbuf5ot2t2oJuRppY8YRtNynqnu9BL5WtB95CoPP6W3iY+4CUkQyZQiWn/w1
 no1geU4titTCqM2W0+LzmuHfF05LHoyT30oXKSjhtN8Gx8Wro9bjikGtvytgEWwKVa1J
 a+A0XPLdue1kXOZ6WErc1MprhvgCVO/V23L8OkPuk3FmQvGYtG0/BRSVZ1u4Zhq5sTlt
 NWEkQYd1fbnIPkK1kRsWs31MQk7y8A1GQyAYUg3F72ipp5IOdMoIVAj+sqw0QNVzC99o
 H65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gBoYzkJdAL/tInNP9lZpL+nZi7QXFa1Q0BP5MRcfoAM=;
 b=s6+jL+EwKpjxMYW6YKtvixH7g5BcNppTtOo9F+zSLWW1A4PnusQdCJHcmKEFvspoUj
 kqMTS2B5HMo1r5wYR9umIGsvGUg0Af3klnjJlSXpvZCkfUyccGn/P4pdn7/SvWO6BMYM
 q4vbv8spQf2fnYDYDZCwvYrq5/m+4Cc0Hd5cfLVCdrV1U2GwcGH3pCTRudcbFbc/Ve4K
 eqL5YDq41Bub0sfpO0nbJZE3hJEQrvITTUim46uYFqDUTNU5WMvTPOr4tBPHFJG3Tnfn
 8AlyyOiZKz49R6Jr1iFUlPC/9FkimddgkL3RU3Ip8iBdOAt4zMthd307Z8xJE9jgSb6S
 VP7w==
X-Gm-Message-State: APjAAAUOBrMdODq9G6FvBIzUNUNlHPxpW2fMgwNTNRE1x1hjK5bAcDnZ
 1lunlNrg2sI9cNAuFzmxhEQr17XEi04=
X-Google-Smtp-Source: APXvYqzuOSvg4JT6A+1dRDjWQK8yP4uq4st2lW06IwFrViIWOMU4K5oXRCK9moxk9o1pKmA3Wm7YKg==
X-Received: by 2002:aa7:86d4:: with SMTP id h20mr8582199pfo.232.1576781772062; 
 Thu, 19 Dec 2019 10:56:12 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:9de9:bce2:6ae3:53c4])
 by smtp.gmail.com with ESMTPSA id a26sm329682pfo.27.2019.12.19.10.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:56:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Set ISSIs16Bit in make_issinfo
Date: Thu, 19 Dec 2019 08:56:09 -1000
Message-Id: <20191219185609.16748-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 Jeff Kubascik <jeff.kubascik@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

During the conversion to decodetree, the setting of
ISSIs16Bit got lost.  This causes the guest os to
incorrectly adjust trapping memory operations.

Fixes: 46beb58efbb8a2a32
Cc: qemu-stable@nongnu.org
Reported-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2b6c1f91bf..9f0afbdb75 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8556,6 +8556,9 @@ static ISSInfo make_issinfo(DisasContext *s, int rd, bool p, bool w)
     /* ISS not valid if writeback */
     if (p && !w) {
         ret = rd;
+        if (s->base.pc_next - s->pc_curr == 2) {
+            ret |= ISSIs16Bit;
+        }
     } else {
         ret = ISSInvalid;
     }
-- 
2.20.1


