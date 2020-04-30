Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F9C83009
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61136214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PV0pLBEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61136214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTyfY-0006r7-JU
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 22:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyYz-0006yV-6q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyXj-0004kL-KV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:32 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTyXj-0004k7-7f
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:03:15 -0400
Received: by mail-pg1-x541.google.com with SMTP id d3so2002870pgj.6
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 19:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gPebZLEq22TKfPbe2B1hfEuFz1pSf7HcPvbgd2/oRv4=;
 b=PV0pLBEHjRV/gNiDUYzWQtpWc6TVpTeRt2gEKaMpvbi7snT1KSMzF0lAozLGwtX+cN
 Xn+ygt0+LR/ZuD9RXb1VyxV4XE1CRZZXrqpIUzgTNGo4VGV0anixSV+opcitaZD/ZSSp
 eeMuu8aqHAbCxKfScLcpbfHRYvsrsnVit++v8XzGMX3S/g0ocyKs0DaJTjKC0M0KpCyt
 XRkdScWG1dR80MTet/1QUkpPZiRfAP3hqsC2jE0eB/Zaj6WEyRBS69i7Hwm0XfI6OKga
 zIIBlCH7Wl4cJSOV1vv11SKU8FSvpbD+KP/4g0CMnPg1mRy05BBMpwkH57IpYs854Nu+
 Vg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gPebZLEq22TKfPbe2B1hfEuFz1pSf7HcPvbgd2/oRv4=;
 b=hUrCYQ5NvoSL/Equr0dw/WV/RYsQaEYihBtMrgl2KT/IY0Etv3fxIYHZh1bsbDkZJi
 Gmj3w/HwUUpygF0gPb/KQbEBysmxb8UQRKJd9PLSwyX7z3bHWDcJ5sYmQiMhrk9EfIDD
 TDsVXZIS39Mj+/DNWTKD8rV+z8QBAsvUZ7A5obbomdBoZ9l9aQ4FlCVm7LQ3Z9uUOHDb
 QTnXB67IiBt5Ar8l5lPRHCfZ6dnK30qZeOFXBsTi25xmcN65H/V/8lMP9SibjUGxBqST
 vRnRNxBil0Ddi88Ut2U6eL3iq0n14RAc2YqZDHGcaDnV0Xi6N/v5QIgSzuF60vyvJ1vz
 rrDQ==
X-Gm-Message-State: AGi0PuYHO4VUAoe1ym1e4MhBWLIOkm1jdrINQfE0rnV7/hN3FLckOj/N
 xawEv5SQMCfhJRiXqpMN1MKey1uGoOQ=
X-Google-Smtp-Source: APiQypKslco0vWO6xTHi8aCd60X2ufJCKcYcchaY5Y/SGtcoz9BkbFVHbhsYb1+K3cNwFmL3dOR7yQ==
X-Received: by 2002:a62:7c16:: with SMTP id x22mr1097817pfc.267.1588212193543; 
 Wed, 29 Apr 2020 19:03:13 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y3sm409284pjb.41.2020.04.29.19.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 19:03:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/9] target/arm: Implement SVE2 crypto unary operations
Date: Wed, 29 Apr 2020 19:03:01 -0700
Message-Id: <20200430020303.20264-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430020303.20264-1-richard.henderson@linaro.org>
References: <20200430020303.20264-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  6 ++++++
 target/arm/translate-sve.c | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index b73b64c3f2..04985d2bb8 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1551,3 +1551,9 @@ STNT1_zprz      1110010 .. 00 ..... 001 ... ..... ..... \
 # SVE2 32-bit scatter non-temporal store (vector plus scalar)
 STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
                 @rprr_scatter_store xs=0 esz=2 scale=0
+
+### SVE2 Crypto Extensions
+
+# SVE2 crypto unary operations
+# AESMC and AESIMC
+AESMC           01000101 00 10000011100 decrypt:1 00000 rd:5
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 413000df3b..44dd1fe2b0 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8174,3 +8174,17 @@ static bool trans_USDOT_zzzz(DisasContext *s, arg_USDOT_zzzz *a)
     }
     return true;
 }
+
+static bool trans_AESMC(DisasContext *s, arg_AESMC *a)
+{
+    if (!dc_isar_feature(aa64_sve2_aes, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        unsigned rd = vec_full_reg_offset(s, a->rd);
+        tcg_gen_gvec_2_ool(rd, rd, vsz, vsz, a->decrypt,
+                           gen_helper_crypto_aesmc);
+    }
+    return true;
+}
-- 
2.20.1


