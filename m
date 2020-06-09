Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74461C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B0820737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKd8inpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B0820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihK1-00069r-EO
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7E-0005vr-Ql
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:44 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:46036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7C-00016m-Bj
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:44 -0400
Received: by mail-wr1-x431.google.com with SMTP id c3so21991831wru.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Gyc4jAqqb4iRdL2lJtXMg0ZbvCkpCJJT7AmeHRVjQIU=;
 b=hKd8inpMobY7D1omGPcOVM9gONVV5VnVXqwIQa+X+IQe0VKzgtVvqVOvr15w2PudUP
 i+rrEKDhKPC1/j7i/W5XjDUNRHj/CGVBg1Wo4khpX+tCKva6hU/qVif/ydcSNfriLjdt
 RpAACZZmsJQhNjQpvT3/2rV7mmDf43DBg+YgRRI5XM2OYYfTDop37pYJ00gPCIswNMzn
 s2HQ9q86VOxdMwwywDOUKLtBJ27vIn3MpqrDLvjvpGgIUbGP3EyZLkVxm0WJTNkf+x9a
 gEWlV5yjNeQKnuE7Ub6egiHgDXEO6ifiYmtB88J59LgvQ2htDiy3kDmeJl7NOxyn2Iea
 UXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Gyc4jAqqb4iRdL2lJtXMg0ZbvCkpCJJT7AmeHRVjQIU=;
 b=oiPi/FOdfoRDzYrGzHULA/3QuIUCMoQlFOjuRjfvWo0GTGBa/VzHjCpm1tmdA3TZJ8
 2KW4XuwiPOYlL5vwAvQ/55Lgpb/8GJEjnrs9dz1jgf7NZxiYuREtLsAMCKZVfOGNXDup
 pCcoflo1Q9qTE1DWv15u7m+yIMbmlkpQTleRE4VFOhI66V2ifqUBhzaux+jVci3EpegX
 Dp4hbqPxu0KEE7hnu5pwloACvNJN5R+LH0rIY0YgyueNtLmeGrkZZrqmHvfRyWw/eRsD
 58z2fIKpsJk8kb6bHVQXY0ZDsDpQPUmFrzY9zDfLNZxvEpMGFHKszPOHDM/TBVFRug1Y
 +LMg==
X-Gm-Message-State: AOAM533c053l+qEmZIueLvRLkW0842lNDxMcDmCIsyQlxPdocAS8HDsr
 ZInddHpELFE+BcySoxX1Z8Kyz8f/
X-Google-Smtp-Source: ABdhPJwgvP9rapt/B6tE2xqR9Sh4o/A1PNBh869Q3npXC1BwRsrmf2LHgRTieaTRpVRuESETX6INpw==
X-Received: by 2002:a05:6000:87:: with SMTP id
 m7mr5469837wrx.306.1591720120424; 
 Tue, 09 Jun 2020 09:28:40 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 23sm3643598wmo.18.2020.06.09.09.28.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jun 2020 09:28:39 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 01/20] mailmap: Change email address of Filip Bozuta
Date: Tue,  9 Jun 2020 18:28:19 +0200
Message-Id: <1591720118-7378-2-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Filip Bozuta wants to use his new email address for his future
work in QEMU.

CC: Filip Bozuta <filip.bozuta@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Filip Bozuta <filip.bozuta@syrmia.com>
Message-Id: <20200602085215.12585-2-aleksandar.qemu.devel@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e3628c7..9f2a3a5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -45,6 +45,7 @@ Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
+Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
 Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-- 
2.7.4


