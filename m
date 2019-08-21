Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941F2C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1F422D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzmQjkGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1F422D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VET-0001PD-0a
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URi-0001f7-Mm
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URg-00089h-OC
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:54 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:45841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URg-00085i-J5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:52 -0400
Received: by mail-yw1-xc43.google.com with SMTP id n69so1222558ywd.12
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OaEXlIcC0ElEqv7wBsTi+9DAensG0Cger0elzEwwNHA=;
 b=YzmQjkGEO7nWBErQaln8vXMigSGwdbnVK8M+acJssDOD5d4yOxP/9N7XTKyw3w+xsm
 l25/8nNFhZKzLq/QowzXOIhjjVqbT5mGw5W2T1nUtBrM/y32Kqz6zSR7hmRKdqUWe7Dc
 zxKG46NeQrVDesCuR4f3/wK7qVqhnOJMvsw3DdGF+gkpWl7CTVr9+0jG6Yspk9A7+ye5
 nQNxX7/MDrjPKeY1MNIS4HpIla/gEYCoCvdLZZdDMBq/v7ow3USbXZqdEFoI7kXwdjKI
 CZxqjWarZis2OXY1Zs5EzjsYBAwan9Z/spv5FMTLg0gnVhbS7tvV8vC1g/VufsO1qvem
 +4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OaEXlIcC0ElEqv7wBsTi+9DAensG0Cger0elzEwwNHA=;
 b=i0lYGoBR8fThsO/m2EQXSXDXUutn3n01NgW4NgABh+DkxXRbcM8Nqwb5Vz17yDs5No
 nFWK40Pt3xvd2EwOCT2MxlgSHbBJD4tXndqEk34kW2G9aAwVpNLLzfNhdLo7jGmGUzlN
 zD8VnI0c73mIcGCDitFSiIwFeO8ZYGdJL1I49J29C2GmxjeyeLNEAUXM0CPZ5c6LbXZj
 Z5zG49J0mOjJxxV5QPLGsczvEDnzj/rXivGl9puSoi1O+Fc+jg9NMFAUdKLy39iFbjC4
 ZRbmKjJIo4kUQwKVIXIU4hpJTk9j9J+9GTXTQPWszyV4Mkd5+Jme0Mo1l5FeXfVoBPBu
 XiyQ==
X-Gm-Message-State: APjAAAUHu8YYf0BG2RKzM0KyYmA7McP3EKH5UOpZrJxZ42TIhvJqE5KC
 VVcPrspZMRJ3SARsyG5eXRfxs6f3
X-Google-Smtp-Source: APXvYqwqYxPi6W72+vzq1jg+NSwl/ZaBco+kPHlxAroiFb1WzIX80lLL2RFNOG7egG8FmIFOYVsGag==
X-Received: by 2002:a81:9293:: with SMTP id
 j141mr25650180ywg.363.1566408649045; 
 Wed, 21 Aug 2019 10:30:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:48 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:27 -0400
Message-Id: <20190821172951.15333-52-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v4 51/75] target/i386: introduce SSE4.1
 translators
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
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the translator macros to define translators required by SSE4.1
instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index f43e9b1ba4..110b963215 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6617,8 +6617,10 @@ DEF_TRANSLATE_INSN2(Vdq, Mdq)
 DEF_TRANSLATE_INSN2(Vdq, Nq)
 DEF_TRANSLATE_INSN2(Vdq, Qq)
 DEF_TRANSLATE_INSN2(Vdq, Udq)
+DEF_TRANSLATE_INSN2(Vdq, Wd)
 DEF_TRANSLATE_INSN2(Vdq, Wdq)
 DEF_TRANSLATE_INSN2(Vdq, Wq)
+DEF_TRANSLATE_INSN2(Vdq, Ww)
 DEF_TRANSLATE_INSN2(Vq, Ed)
 DEF_TRANSLATE_INSN2(Vq, Eq)
 DEF_TRANSLATE_INSN2(Vq, Wd)
@@ -6666,6 +6668,8 @@ DEF_TRANSLATE_INSN2(modrm_mod, modrm)
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN3(Ed, Vdq, Ib)
+DEF_TRANSLATE_INSN3(Eq, Vdq, Ib)
 DEF_TRANSLATE_INSN3(Gd, Nq, Ib)
 DEF_TRANSLATE_INSN3(Gd, Udq, Ib)
 DEF_TRANSLATE_INSN3(Gq, Nq, Ib)
@@ -6674,8 +6678,11 @@ DEF_TRANSLATE_INSN3(Nq, Nq, Ib)
 DEF_TRANSLATE_INSN3(Pq, Pq, Qd)
 DEF_TRANSLATE_INSN3(Pq, Pq, Qq)
 DEF_TRANSLATE_INSN3(Pq, Qq, Ib)
+DEF_TRANSLATE_INSN3(RdMb, Vdq, Ib)
+DEF_TRANSLATE_INSN3(RdMw, Vdq, Ib)
 DEF_TRANSLATE_INSN3(Udq, Udq, Ib)
 DEF_TRANSLATE_INSN3(Vd, Vd, Wd)
+DEF_TRANSLATE_INSN3(Vd, Wd, Ib)
 DEF_TRANSLATE_INSN3(Vdq, Vdq, Mq)
 DEF_TRANSLATE_INSN3(Vdq, Vdq, UdqMhq)
 DEF_TRANSLATE_INSN3(Vdq, Vdq, Wdq)
@@ -6683,6 +6690,7 @@ DEF_TRANSLATE_INSN3(Vdq, Vq, Mq)
 DEF_TRANSLATE_INSN3(Vdq, Vq, Wq)
 DEF_TRANSLATE_INSN3(Vdq, Wdq, Ib)
 DEF_TRANSLATE_INSN3(Vq, Vq, Wq)
+DEF_TRANSLATE_INSN3(Vq, Wq, Ib)
 
 #define DEF_TRANSLATE_INSN4(opT1, opT2, opT3, opT4)                     \
     static void translate_insn4(opT1, opT2, opT3, opT4)(                \
@@ -6731,7 +6739,11 @@ DEF_TRANSLATE_INSN3(Vq, Vq, Wq)
 DEF_TRANSLATE_INSN4(Pq, Pq, Qq, Ib)
 DEF_TRANSLATE_INSN4(Pq, Pq, RdMw, Ib)
 DEF_TRANSLATE_INSN4(Vd, Vd, Wd, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Vdq, Ed, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Vdq, Eq, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Vdq, RdMb, Ib)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, RdMw, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Vdq, Wd, Ib)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, Wd, modrm_mod)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, Wdq, Ib)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, Wq, modrm_mod)
-- 
2.20.1


