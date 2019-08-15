Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7442C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C1C208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxmoiry2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C1C208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5nv-0001xk-Jy
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dl-0006Vg-VG
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dk-0000T1-LO
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:33 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:37212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Dk-0000SI-Ga
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:32 -0400
Received: by mail-yw1-xc43.google.com with SMTP id u141so299706ywe.4
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yPZM94CiBTkzIXWuhhec9WrQvniel8ip84VQamAa6Fk=;
 b=rxmoiry2DX+rhEAj6cnPBk44vOs+4QpV21nPyjei+U1H2GBSFuoJFHXTVSm6jJIlI9
 mFYPkQ2Zzt4RyJEcEn89EU2V0U+ZgaRohomWjOmA7SPFaHd9MAldhFzrr4RytechqDDx
 5ZQP8GCozNibQjWlrHUpRSrDmXffjeTfccC6zjTrRQnz30mrDY1Wae3f5fqKUTXvJKu1
 W2dfdcHGBJJVae1wKshZnkg+fLFBsEMqjlsMNQU/crb2y4caudMuR3FZvOQrI1O3m55P
 9laKoLWCIqqcd8sBL1Op9UBvizhOfmxn0e7MIGAW9+akvHBVVAceKiXn0ue8Z9okSptQ
 EtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yPZM94CiBTkzIXWuhhec9WrQvniel8ip84VQamAa6Fk=;
 b=gzhrCjHn43N1f98A6zF+icO8TheRK5riDnsiHe8Fm2ZgycgFyJItWL1DsrL3TrG15D
 wHqQBSgJV4t7y9C7g1XeTb36qpqpt4qkJbT2o9xK7ZkGDpJGJyG6p0NTBHLXxdXWMRft
 iONWKOtlpux0gOaAbUUtaHh5eE9zuiDgnI5ruDXCjP/sV+CCqtxaEVf/yb1w7Eplndz1
 OYYxIBIxUJLcsikZhZbQ3SUwrFK73EN/i8OLxNl7D7hOba0kIvHYlLUTLupoJ51M6LtK
 lboNXOkuudw9MY3cu1NQD6kdKczf+elYn64qwoKd1NRXdhzEu262izVatxr5plcx574d
 SLUg==
X-Gm-Message-State: APjAAAVK8LbL5E7tIB12+RHrQgZT5QWfoDK2nmJZyJO6n6sTzh5qFQax
 AG2ZoywjaGN+2nvVe8LYefzcKaCS
X-Google-Smtp-Source: APXvYqzCwZgL8qqIVmKCuLS7bSxnBAdAWlHSC+Ee7Mks0a9Lq7lDEY38NY50pbdz7itCav+2rM2smg==
X-Received: by 2002:a81:aa50:: with SMTP id z16mr1525233ywk.278.1565835031792; 
 Wed, 14 Aug 2019 19:10:31 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:31 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:23 -0400
Message-Id: <20190815020928.9679-42-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v3 41/46] target/i386: introduce SSE2
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

Use the translator macros to define translators required by SSE2
instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3d526ee470..177bedd0ef 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5891,14 +5891,20 @@ DEF_TRANSLATE_INSN1(Md)
     }
 
 DEF_TRANSLATE_INSN2(Ed, Pq)
+DEF_TRANSLATE_INSN2(Ed, Vdq)
 DEF_TRANSLATE_INSN2(Eq, Pq)
+DEF_TRANSLATE_INSN2(Eq, Vdq)
 DEF_TRANSLATE_INSN2(Gd, Nq)
 DEF_TRANSLATE_INSN2(Gd, Udq)
 DEF_TRANSLATE_INSN2(Gd, Wd)
+DEF_TRANSLATE_INSN2(Gd, Wq)
 DEF_TRANSLATE_INSN2(Gq, Nq)
 DEF_TRANSLATE_INSN2(Gq, Udq)
 DEF_TRANSLATE_INSN2(Gq, Wd)
+DEF_TRANSLATE_INSN2(Gq, Wq)
+DEF_TRANSLATE_INSN2(Md, Gd)
 DEF_TRANSLATE_INSN2(Mdq, Vdq)
+DEF_TRANSLATE_INSN2(Mq, Gq)
 DEF_TRANSLATE_INSN2(Mq, Pq)
 DEF_TRANSLATE_INSN2(Mq, Vdq)
 DEF_TRANSLATE_INSN2(Mq, Vq)
@@ -5906,16 +5912,33 @@ DEF_TRANSLATE_INSN2(Pq, Ed)
 DEF_TRANSLATE_INSN2(Pq, Eq)
 DEF_TRANSLATE_INSN2(Pq, Nq)
 DEF_TRANSLATE_INSN2(Pq, Qq)
+DEF_TRANSLATE_INSN2(Pq, Uq)
+DEF_TRANSLATE_INSN2(Pq, Wdq)
 DEF_TRANSLATE_INSN2(Pq, Wq)
 DEF_TRANSLATE_INSN2(Qq, Pq)
+DEF_TRANSLATE_INSN2(UdqMq, Vq)
 DEF_TRANSLATE_INSN2(Vd, Ed)
 DEF_TRANSLATE_INSN2(Vd, Eq)
 DEF_TRANSLATE_INSN2(Vd, Wd)
+DEF_TRANSLATE_INSN2(Vd, Wq)
+DEF_TRANSLATE_INSN2(Vdq, Ed)
+DEF_TRANSLATE_INSN2(Vdq, Eq)
+DEF_TRANSLATE_INSN2(Vdq, Nq)
 DEF_TRANSLATE_INSN2(Vdq, Qq)
+DEF_TRANSLATE_INSN2(Vdq, Udq)
 DEF_TRANSLATE_INSN2(Vdq, Wdq)
+DEF_TRANSLATE_INSN2(Vdq, Wq)
+DEF_TRANSLATE_INSN2(Vq, Ed)
+DEF_TRANSLATE_INSN2(Vq, Eq)
+DEF_TRANSLATE_INSN2(Vq, Mq)
 DEF_TRANSLATE_INSN2(Vq, UdqMhq)
+DEF_TRANSLATE_INSN2(Vq, Wd)
+DEF_TRANSLATE_INSN2(Vq, Wq)
 DEF_TRANSLATE_INSN2(Wd, Vd)
 DEF_TRANSLATE_INSN2(Wdq, Vdq)
+DEF_TRANSLATE_INSN2(Wq, Vq)
+DEF_TRANSLATE_INSN2(Wq, Wd)
+DEF_TRANSLATE_INSN2(modrm_mod, modrm)
 
 #define DEF_TRANSLATE_INSN3(opT1, opT2, opT3)                           \
     static void translate_insn3(opT1, opT2, opT3)(                      \
@@ -5962,14 +5985,21 @@ DEF_TRANSLATE_INSN2(Wdq, Vdq)
     }
 
 DEF_TRANSLATE_INSN3(Gd, Nq, Ib)
+DEF_TRANSLATE_INSN3(Gd, Udq, Ib)
 DEF_TRANSLATE_INSN3(Gq, Nq, Ib)
+DEF_TRANSLATE_INSN3(Gq, Udq, Ib)
 DEF_TRANSLATE_INSN3(Nq, Nq, Ib)
 DEF_TRANSLATE_INSN3(Pq, Pq, Qd)
 DEF_TRANSLATE_INSN3(Pq, Pq, Qq)
 DEF_TRANSLATE_INSN3(Pq, Qq, Ib)
+DEF_TRANSLATE_INSN3(Udq, Udq, Ib)
 DEF_TRANSLATE_INSN3(Vd, Vd, Wd)
+DEF_TRANSLATE_INSN3(Vdq, Vd, Mq)
+DEF_TRANSLATE_INSN3(Vdq, Vdq, Mq)
 DEF_TRANSLATE_INSN3(Vdq, Vdq, Wdq)
 DEF_TRANSLATE_INSN3(Vdq, Vq, Wq)
+DEF_TRANSLATE_INSN3(Vdq, Wdq, Ib)
+DEF_TRANSLATE_INSN3(Vq, Vq, Wq)
 
 #define DEF_TRANSLATE_INSN4(opT1, opT2, opT3, opT4)                     \
     static void translate_insn4(opT1, opT2, opT3, opT4)(                \
@@ -6025,8 +6055,11 @@ DEF_TRANSLATE_INSN3(Vdq, Vq, Wq)
 
 DEF_TRANSLATE_INSN4(Pq, Pq, RdMw, Ib)
 DEF_TRANSLATE_INSN4(Vd, Vd, Wd, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Vdq, RdMw, Ib)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, Wd, modrm_mod)
 DEF_TRANSLATE_INSN4(Vdq, Vdq, Wdq, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Vdq, Wq, modrm_mod)
+DEF_TRANSLATE_INSN4(Vq, Vq, Wq, Ib)
 
 #define OPCODE_GRP_BEGIN(grpname)                                       \
     static void translate_group(grpname)(                               \
-- 
2.20.1


