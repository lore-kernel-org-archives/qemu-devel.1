Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F7C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E0D21741
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CuPysYGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E0D21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMEt-0008JO-8b
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHv-0000p4-NF
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:15 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHk-0007D5-Bu
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:14 -0400
Received: by mail-pj1-x1042.google.com with SMTP id t7so3625173pjd.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MepNhYFr1+IOeR1yUlz4CllcCZZho0JnjR8wxuWPCCs=;
 b=CuPysYGjqEO0eaJBqR/yOj+GBnaAP/WwJNo+v8RHGa2xgQDUWLontjg2vzXXX4Bmp5
 5GR7xTMfYdBYN6Yvt552xPVUc0miD2mcvLgpyUakmzIW9orUtzXGluerhRs8lgCFlxaE
 8P/DHU23w13gWf+gQJzVEhStdVat7RYr930cTW+3OzUeiU18PkwvY4VGmEn/u/U3aUW7
 vBIm4bwswTiMpf0icdi7Fe0CVbtRFfrZDB/p4NqnAU+Pb+x9xKsIEMA5TVZzJ52KB+Lh
 edjpa980eGtxyP4KfKVG+mLpdH2+jhZNX8X2+4j9DF2ahBM6ZUF1pPj6omN/gdM1INEj
 cPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MepNhYFr1+IOeR1yUlz4CllcCZZho0JnjR8wxuWPCCs=;
 b=nqcohE1kY/75G/MlzmbjkpUgR8F90IO3UjuimmF9dzDxDgMsEynbzt3cHjkJhkoYgY
 9IIG+oWWBXb3aC1Sn3BMJtIsJy2n2O8U9L6II3pynh2Fn+8QCduG13Et5Ne85/Z0xyiA
 iti94acGVOTk2e13Oi8oe871eA8fScBryQIDHtkassEo1DdmLYh1m64HviJmUkaE518m
 0uJRllr4RfLUMOe8Kdn6Qtd/Yb8RDXHXv5ly1e+yzUPR7BLiUMqR3CUOQJrP7eRNT9Kc
 Ktaep5MHStJNLjbXhoE9XnGIaKWpZBnpzSIma3x9bSd8CxjE+x7VByZ8a2dvBjl8L+yB
 EhMQ==
X-Gm-Message-State: AOAM532FDr/hGKiGKkXbBQLTxQ2XeSeph8SvLpJakm0p+fdKI5OMDlRA
 gbMoHUwIrRWnaUTvCdfvwxUL6hRcL06gMA==
X-Google-Smtp-Source: ABdhPJxkMej0qKoQvMai6i/iaVC34KE4nWAwf4sqc+3izr99g1+GjI3KNWPL0Ko0cfOVK+MSSunZoQ==
X-Received: by 2002:a17:902:7608:b029:d0:cbe1:e70e with SMTP id
 k8-20020a1709027608b02900d0cbe1e70emr34642367pll.28.1600454342681; 
 Fri, 18 Sep 2020 11:39:02 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 53/81] target/arm: Split out formats for 2 vectors + 1 index
Date: Fri, 18 Sep 2020 11:37:23 -0700
Message-Id: <20200918183751.2787647-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently only used by FMUL, but will shortly be used more.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 5815ba9b1c..a121e55f07 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -67,6 +67,7 @@
 &rri_esz        rd rn imm esz
 &rrri_esz       rd rn rm imm esz
 &rrr_esz        rd rn rm esz
+&rrx_esz        rd rn rm index esz
 &rpr_esz        rd pg rn esz
 &rpr_s          rd pg rn s
 &rprr_s         rd pg rn rm s
@@ -245,6 +246,14 @@
 @rpri_scatter_store ....... msz:2 ..    imm:5 ... pg:3 rn:5 rd:5 \
                     &rpri_scatter_store
 
+# Two registers and a scalar by index
+@rrx_h          ........ 0. . ..      rm:3 ...... rn:5 rd:5 \
+                &rrx_esz index=%index3_22_19 esz=1
+@rrx_s          ........ 10 . index:2 rm:3 ...... rn:5 rd:5 \
+                &rrx_esz esz=2
+@rrx_d          ........ 11 . index:1 rm:4 ...... rn:5 rd:5 \
+                &rrx_esz esz=3
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -792,10 +801,9 @@ FMLA_zzxz       01100100 111 index:1 rm:4 00000 sub:1 rn:5 rd:5 \
 ### SVE FP Multiply Indexed Group
 
 # SVE floating-point multiply (indexed)
-FMUL_zzx        01100100 0.1 .. rm:3 001000 rn:5 rd:5 \
-                index=%index3_22_19 esz=1
-FMUL_zzx        01100100 101 index:2 rm:3 001000 rn:5 rd:5      esz=2
-FMUL_zzx        01100100 111 index:1 rm:4 001000 rn:5 rd:5      esz=3
+FMUL_zzx        01100100 .. 1 ..... 001000 ..... .....   @rrx_h
+FMUL_zzx        01100100 .. 1 ..... 001000 ..... .....   @rrx_s
+FMUL_zzx        01100100 .. 1 ..... 001000 ..... .....   @rrx_d
 
 ### SVE FP Fast Reduction Group
 
-- 
2.25.1


