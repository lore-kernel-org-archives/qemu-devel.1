Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7B7C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823FD20658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVdNSGKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823FD20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE3WB-0001pP-MF
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jE3UW-00087b-JV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1jE3UV-00029n-4y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:08 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1jE3UU-0001zs-Nz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:06 -0400
Received: by mail-pl1-x641.google.com with SMTP id f8so9004545plt.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=w80CzMDxP22b8vsHY5R1KjcrEbEeVniwI+3e9Z9g2gI=;
 b=RVdNSGKy+5t3KDmeaRJkyaaVbU6RLMsdHgueG1lJ9OlgMPSHrN4ynU7t95JZo951Nr
 lGidtawaBCUh44dSKaxJhNea/V4CBE7ASk3Yr2Em2sb+K2r+T8hjQJawETtv6DGPtU7T
 vaAGcEAlkiJmpdqJ4zQzRFh7yA14AQVPD6ihq7VWr1OMyLLveG3DplSc4eXGivvKSE6L
 DCIA9HoWkwEAhE40knEv1rzJyq3XWHxk7g1WdgfCh7A5K/igM9OwdMdNYqmaaYBLLNmL
 L4feS+lGS1blhxLi0fb04pq0PPQsU1BsU5Sa0j22vBDobTFpr7xKG12DiTqi/+q9V7Ic
 Z4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=w80CzMDxP22b8vsHY5R1KjcrEbEeVniwI+3e9Z9g2gI=;
 b=pPHtm9dMehPb9M4ASaB2fSjN0OrSRmCLO0vmw13zb2OVgbJrOtnDJDTNRRHr9Xg7J6
 JYv/ix936e+SfVtjaW6QIfL+Psavfr1af8nBHUN8x+ZZ39f4C1s4z4sYlt7860kHjLs0
 2GzSEaDW+ejmjTKDXjyCTT+PEotWXq2rGsoLZ4a8wVWZuB6xDCeBUj/0Muxw21Ag96Oo
 aKBCUN7blHnBZDc2s0WG0Cs1U05NXASKdTyyCIh4GrVREDi3f923bYGWcWor+QUZNSbZ
 umZE1JRURAn6Gb2DGLcXyecqjabSP7OoKqYWhvfMF5IXQ3jl23b3AQ2W4dROEMKFPwPl
 lcXg==
X-Gm-Message-State: ANhLgQ3K0gpQaSzQ5EHF/qP21dqK12togWtPck1TLfOkwD1zhtMhpE5D
 +vCs4WapbTVUrXi546N0mOBDhw==
X-Google-Smtp-Source: ADFU+vtHPfipcGazbneWadOe0kx2X1CNILdui8txA4y7RiXl8kBgmpSPiidSGpCpkhgCfK0xa9NHxA==
X-Received: by 2002:a17:902:c1d1:: with SMTP id
 c17mr2429101plc.184.1584417963707; 
 Mon, 16 Mar 2020 21:06:03 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id e10sm1275052pfm.121.2020.03.16.21.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 21:06:03 -0700 (PDT)
Subject: [PULL 1/6] target/riscv: Correctly implement TSR trap
Date: Mon, 16 Mar 2020 21:05:42 -0700
Message-Id: <20200317040547.222501-2-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200317040547.222501-1-palmerdabbelt@google.com>
References: <20200317040547.222501-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

As reported in: https://bugs.launchpad.net/qemu/+bug/1851939 we weren't
correctly handling illegal instructions based on the value of MSTATUS_TSR
and the current privledge level.

This patch fixes the issue raised in the bug by raising an illegal
instruction if TSR is set and we are in S-Mode.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Behrens <jonathan@fintelia.io
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 8736f689c2..c6412f680c 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -85,7 +85,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
     }
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TSR)) {
+        get_field(env->mstatus, MSTATUS_TSR) && !(env->priv >= PRV_M)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-- 
2.25.1.481.gfbce0eb801-goog


