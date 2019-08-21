Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C3DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32702082F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbFad2KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32702082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Upr-0001UE-1J
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR6-0000oQ-Hf
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR5-0007BR-A4
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:16 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:39259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UR5-0007Af-4P
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:15 -0400
Received: by mail-yb1-xb44.google.com with SMTP id s142so1340941ybc.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j47aWmgFVqZnau895YhI/GcoyHImA6cC56u4iojAVmY=;
 b=KbFad2KZhTuIF8rr8F4xKcfTiIyXS8SmiL3Bn3PfLKv4EGV0m34L5nNye7CBECxVNv
 yb/lDLBI8/nU5+0WsoJowoq1igOmVoLryh5q5TLLsS1ZxkrBc9SnQnf02CUbpZLaT7S6
 J993sz5zXKcS131FpjlUMOXT8g71VDwTFf+KfYyjsSLd+w6QFzKmeC9nt91lY2BKWgCa
 CV9be1cUhZCy3kLl0C3cyLNC67TEm3+B3tl6CQm+EQw0Bg8ZD4T9LaZ0FE3/Y+3+Mxoe
 aG3yTY8oNdMiXm/a2qdu2UmxmVJ3tiRF4+or4TCnfd/Q+Wsy4wYFgQG0+2hdAbKGxdSU
 ZRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j47aWmgFVqZnau895YhI/GcoyHImA6cC56u4iojAVmY=;
 b=n/KXdCNWxpk74rl5V+O7JyV40k4etLImU7DKOfcPU6XjYMfgkvKANSeD40t1J0in8o
 L8OYbh++oW+sRS8qrB6f7bSKa5l9TwWTZhVuhxtlDCUExS5KQFS0aTf50bvq3ofwtXyl
 Wvwa60Wp2qcDin8vervICK6oXv0iAr8Os4/ij6whiMtQ9flTZKVcnOTLb/Nb79MDt+nl
 jrHY83lLbB8OS0f1Z62kbgwg+NUVrtGCJRQfS5vGaZoxlJ0eiOQzQTf0lGI6nMAqS86z
 NWQAbz5UwgmvsMzeJPDRnKipXDKaAa8x2VhDHJWIi3/M9x5QCw26EMMvxJdl3bs4T5Kb
 m5Pw==
X-Gm-Message-State: APjAAAXlfqkpj93hggvl2dAObYGnBsUxnf/eeOzKafbgCc9gOB93V64C
 ExjMcilUvcfx5Fzj/uML3FaCpvom
X-Google-Smtp-Source: APXvYqwfvtOi3W8OFmGtx4+kBJotX4Lfoh7L2BHi0lh361VuwORjV4NeQNAJPeK3DtlLy/zAUeogpQ==
X-Received: by 2002:a25:587:: with SMTP id 129mr25650453ybf.121.1566408614478; 
 Wed, 21 Aug 2019 10:30:14 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:13 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:49 -0400
Message-Id: <20190821172951.15333-14-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RFC PATCH v4 13/75] target/i386: decode the 0F38/0F3A
 prefix in gen_sse_ng
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

In order to decode 0F38/0F3A-prefixed instructions, we need to load an
additional byte. This poses a problem if the instruction is not
implemented yet; implement a rewind in this (default) case.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 661010973b..bd9c62dc54 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4545,7 +4545,23 @@ static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 #define CASES_VEX_LIG(e, N, ...)  CASES_VEX_L128(e, N, ## __VA_ARGS__)  \
                                   CASES_VEX_L256(e, N, ## __VA_ARGS__)
 
+        CASES(0x38, 3, W, IG, M, 0F, P, IG)
+        CASES(0x38, 4, W, IG, M, 0F, P, IG, VEX_L, IG) {
+            m = M_0F38;
+            op = x86_ldub_code(env, s);
+        } break;
+
+        CASES(0x3a, 3, W, IG, M, 0F, P, IG)
+        CASES(0x3a, 4, W, IG, M, 0F, P, IG, VEX_L, IG) {
+            m = M_0F3A;
+            op = x86_ldub_code(env, s);
+        } break;
+
         default: {
+            if (m == M_0F38 || m == M_0F3A) {
+                /* rewind the advance_pc() x86_ldub_code() did */
+                advance_pc(env, s, -1);
+            }
             gen_sse(env, s, b);
         } return;
 
-- 
2.20.1


