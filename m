Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CF9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45542205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 23:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4FqPsuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45542205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwx9k-0001Zd-Ff
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 18:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwx6f-00060t-1X
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwx6e-0001xE-1c
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:48 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwx6d-0001tx-Sd
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:50:47 -0500
Received: by mail-pf1-x444.google.com with SMTP id 4so477476pfz.9
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AFYT+5nf6GEUWECSnX5fIz25ugvv0VYdbfLr+bjNxyE=;
 b=M4FqPsuhthBEEHT237KaO9Wg5LbLdFY8KNCMSRdfyaf62zXLF0/NyJ8F6ZWfr6oFC7
 fu8IOF+ArNOgTP0HdlWMyBBEZUxMIHffP3j2tyLbLMpP5R+fJXOqY42eHfwi4Y2QS82T
 ZpWX98RxN4ogiiAKJaTXtYKSkK538CsXMGSoy75yfWKkUlZmsUJOv78wcQosle2OfcDj
 TJ/jXomW8R/nd6X2iLoTik8GWO8PrqeJc/n66n8gTeyCFLquoT8N7op1b05sCJ8ex1s3
 c8embUMuWKRTMrKvjOrWSI+2n7lXLZE//4eGzOAh6Rp1xxT9oefLV1OeG1z8+0PKuFoY
 icyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AFYT+5nf6GEUWECSnX5fIz25ugvv0VYdbfLr+bjNxyE=;
 b=PucmCQ6CKvLD9/tO9O35es6LNF3iS1Yhkkh1oFiI0AbanYDiIJS6BT4y4RGW2mQwDT
 TUShiGJvGUjdRkBLRp4IMatwcbe7zRC2JCI6vXZDRE9FCL4XQfcQucumP+g11qRIhsFE
 WKzs2mpV6sVTWwB/olVxzreOX+hfONAcS8iyE5vx8X/Gk+E3BB/KAdOp527BEu6u5JH3
 /ZxXeniwywvwTA0o84Chyk8dXsTfJzbSZn044Dfyz0OV2kOAVHopPH/4q1jXsUm6jI3O
 3igYQSjUphKCTikKA8BH3gZ6L9oq/Dipru5Etp5bK2eblsQ3AjBo0yL2PSbnWDbHRpgI
 qXIg==
X-Gm-Message-State: APjAAAXFrvffd1jct8Ab7C/yMooMAgAg0P20za9ok8ORIdX0n+NA+ZEG
 LtehF94AQHIgh7NG/7VaOZVYSR6wRN8=
X-Google-Smtp-Source: APXvYqx8DR/jxsqnIG/8R8dLs8UVbj8SlETvS+UlpKRUOkldfyre8GnXwI0JeJOZWcHI2hbJo2nJNA==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr1625894pgi.241.1580341846563; 
 Wed, 29 Jan 2020 15:50:46 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id 13sm3740195pfi.78.2020.01.29.15.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:50:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] target/ppc: Remove redundant mask in DCBZ
Date: Wed, 29 Jan 2020 15:50:39 -0800
Message-Id: <20200129235040.24022-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235040.24022-1-richard.henderson@linaro.org>
References: <20200129235040.24022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: hsp.cat7@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The value of addr has already been masked, just above.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index e7d3a79d96..0cb78777e7 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -293,7 +293,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     addr &= mask;
 
     /* Check reservation */
-    if ((env->reserve_addr & mask) == (addr & mask))  {
+    if ((env->reserve_addr & mask) == addr)  {
         env->reserve_addr = (target_ulong)-1ULL;
     }
 
-- 
2.20.1


