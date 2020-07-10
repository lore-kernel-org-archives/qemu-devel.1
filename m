Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13945C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E52206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j4TBxW8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E52206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtswH-0001yB-4W
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqfT-00066b-IH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:54:11 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:39539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqfS-0006yZ-1B
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:54:11 -0400
Received: by mail-pj1-x1035.google.com with SMTP id b92so2448306pjc.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SQe+5VvW1r75JMKg4RkRNVzatof7TCQwBrRNcipixjc=;
 b=j4TBxW8RsIbHgyI7CvEUCCqOd2LSblRcBeXjrjPECuPzgWx6W1QpON/+HPUKfjwckA
 JBv9+D20WJVzHaDdvr5mlLCtk+pMRmsf/jST+ndkWp2m54zyi4h7iVnOgxyF9GCMtjZj
 NuPVEVb+F1jTqbjhO+C5/KGgp3MyiPvIWpWm4A8uVTOl6xqq4NiD+J2Vffp2FNZDEHnt
 YXO/VawqxY49MFbh63Gx6qU5VFV+EDQyI4KOESkCG3skmudZ8tX1A1ysPZ2HLQH04E3H
 bDAwl38oi1ujLwS89mAislljrbjVtKzPQ0TA+ZmQy/+WCm0uRejUSSKTofvQp0XCpAz0
 Nfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SQe+5VvW1r75JMKg4RkRNVzatof7TCQwBrRNcipixjc=;
 b=n+Dsji5W3iVgrumCBnulBgaUexPV4aOJEgqCmkTnz/TGPbKFPCT077NTDjiz87eb9H
 A+TA+b4AEAopfwec6C6nO3vkTxyyQfuRVENOJNnQjBn1wDvNQIDb31aTEp+CDl3hNn49
 NjVUdPTiimJ/mp5wM3zjKQJC33EC3Gm1xsLbUM1CXXwxMF3gIsxHdSoKOtfHhnkI41JM
 VbsLHEoRk4X7fBXpvBQ6ePmHtvQA0bh5KA3sDhhM/rtBf79G74c4wNc0s7nDhtYGR1jJ
 XfJjnEytMmK3PLqFeGQSPKrd+14LEm6Uxn8KyZ8YQz2IGiocZWTeRjRHSG2EDdQ6b/V/
 bt6g==
X-Gm-Message-State: AOAM530CrCZHH1vocsRAtrEmMB9ucii66Bz1ZZIiFsIDRLrVH2ojyrQ7
 zYE6WJSpjCLnJmGt3GxjvHJq4xU8uSjprg==
X-Google-Smtp-Source: ABdhPJzfn/MzYeUeYqWcu+iCXv6BX1K3zITB0QBurXdU4c+ivUphmcMtk+V+CoSI5a9x5gz5QhnGOw==
X-Received: by 2002:a17:90a:1a13:: with SMTP id
 19mr4574313pjk.167.1594378448628; 
 Fri, 10 Jul 2020 03:54:08 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:54:08 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 53/65] target/riscv: rvv-0.9: single-width scaling shift
 instructions
Date: Fri, 10 Jul 2020 18:49:07 +0800
Message-Id: <20200710104920.13550-54-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1035.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:18 -0400
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Zero-extend vssra.vi immediate value.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 34b0392625..5fa1f0c6ed 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2185,7 +2185,7 @@ GEN_OPIVV_TRANS(vssra_vv, opivv_check)
 GEN_OPIVX_TRANS(vssrl_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssra_vx,  opivx_check)
 GEN_OPIVI_TRANS(vssrl_vi, 1, vssrl_vx, opivx_check)
-GEN_OPIVI_TRANS(vssra_vi, 0, vssra_vx, opivx_check)
+GEN_OPIVI_TRANS(vssra_vi, 1, vssra_vx, opivx_check)
 
 /* Vector Narrowing Fixed-Point Clip Instructions */
 GEN_OPIWV_NARROW_TRANS(vnclipu_wv)
-- 
2.17.1


