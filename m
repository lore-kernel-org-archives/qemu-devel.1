Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA464C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22B72087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erN+N/Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22B72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bkw-0004wv-HH
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0n-0005NF-9I
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0l-000337-9P
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:13 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0j-0002ze-8R
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:11 -0400
Received: by mail-pf1-x444.google.com with SMTP id y72so6329476pfb.12
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Fo5ttwZvsmkPEs0WmaySuPJsLNa+8A7SD8ER3vUViKo=;
 b=erN+N/SmolmS9y4EmJ7QfaqckvwulGaPc5uOBw00cWdKKgkybjxPAKBy6de0NrCHxS
 jUvfHm2VJg/ywfkWrlpl2uLqx4C/adY9JuP9DYeE0RhEJmk2J8ytZ12xyqOgIF7etv5y
 LVyI/3VsPuVM08Ot3KWtPww/2plWDxsIhsdmnoODM9/FVzAR7CDBiL64aDMnIcL6Ik3h
 KLYEmJqF75GXgMpLJFkBQC56hu/nEQkOTLuqQzVHMuxKH9TqMyxhFaizMmIiBsrWiNFX
 28O+ZRgC3v60QspPSkzuEYObsKGBfbyODabD1dRbOr/3FbyTRYYRfXBfLU61gq9fhF6k
 U3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Fo5ttwZvsmkPEs0WmaySuPJsLNa+8A7SD8ER3vUViKo=;
 b=pfRkCNUMNiHyojAEi59SqXOmqqhhn0jSKcZzWWcKGzFc3LENUHIBKLvTrLhkuEGBU+
 Fhinu3PkXE62sJZD1D/OPFYe7Ks5fuDJQraPqKodrUYIMU1yShQYmpl5Pn/64tS5RZnJ
 HSOodpEMdECMujdRZuX46FYuv8cywlZXYfWAvNovCDwKV/pUOC4XKPi8BaJRoyNfvN3+
 IKoAqA2SPyiq19nex6UlxmoGxbMXR5/f9ranu/hZ73SUrFWDnX1UkrFUi46Wzrjz8ijJ
 lUo8sd0tEoSo2KzDaMxx+ZLgNlTTFNxTjAipA+BRR4wkn7t3BVHZ4ngzGDKTBirO8PE5
 QNKA==
X-Gm-Message-State: APjAAAXO1K6qdg8DlQ8P2M3hsBVSxstFMAa1cvU4w0mpCk8S0r/kNcHT
 iiUG6qOyazLdz0q0NfoDc+QGS2DMnoU=
X-Google-Smtp-Source: APXvYqwn2yw6Zcwp2pddQZxn8vUkg1v4T9D5pCThS/hs/vLwe/CWKI8igumn3YtXRsx51viLjMtsmA==
X-Received: by 2002:aa7:85c7:: with SMTP id z7mr11061358pfn.58.1567625526060; 
 Wed, 04 Sep 2019 12:32:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:41 -0700
Message-Id: <20190904193059.26202-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 51/69] target/arm: Convert T16 add/sub (3
 low, 2 low and imm)
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 ++------------------------
 target/arm/t16.decode  | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f9d4b619fa..45d617a2d3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10691,31 +10691,9 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
              * 0b0001_1xxx_xxxx_xxxx
              *  - Add, subtract (three low registers)
              *  - Add, subtract (two low registers and immediate)
+             * In decodetree.
              */
-            rn = (insn >> 3) & 7;
-            tmp = load_reg(s, rn);
-            if (insn & (1 << 10)) {
-                /* immediate */
-                tmp2 = tcg_temp_new_i32();
-                tcg_gen_movi_i32(tmp2, (insn >> 6) & 7);
-            } else {
-                /* reg */
-                rm = (insn >> 6) & 7;
-                tmp2 = load_reg(s, rm);
-            }
-            if (insn & (1 << 9)) {
-                if (s->condexec_mask)
-                    tcg_gen_sub_i32(tmp, tmp, tmp2);
-                else
-                    gen_sub_CC(tmp, tmp, tmp2);
-            } else {
-                if (s->condexec_mask)
-                    tcg_gen_add_i32(tmp, tmp, tmp2);
-                else
-                    gen_add_CC(tmp, tmp, tmp2);
-            }
-            tcg_temp_free_i32(tmp2);
-            store_reg(s, rd, tmp);
+            goto illegal_op;
         } else {
             /* shift immediate */
             rm = (insn >> 3) & 7;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index a7a437f930..2b5f368d31 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -117,3 +117,19 @@ ADD_rri         10101 rd:3 ........ \
 
 STM             11000 ... ........              @ldstm
 LDM_t16         11001 ... ........              @ldstm
+
+# Add/subtract (three low registers)
+
+@addsub_3       ....... rm:3 rn:3 rd:3 \
+                &s_rrr_shi %s shim=0 shty=0
+
+ADD_rrri        0001100 ... ... ...             @addsub_3
+SUB_rrri        0001101 ... ... ...             @addsub_3
+
+# Add/subtract (two low registers and immediate)
+
+@addsub_2i      ....... imm:3 rn:3 rd:3 \
+                &s_rri_rot %s rot=0
+
+ADD_rri         0001 110 ... ... ...            @addsub_2i
+SUB_rri         0001 111 ... ... ...            @addsub_2i
-- 
2.17.1


