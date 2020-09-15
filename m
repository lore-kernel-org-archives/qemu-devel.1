Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E393CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8446321D43
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nfe5AeBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8446321D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBIx-0005pi-5b
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBF5-0000oW-AD
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBF3-00049x-P7
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:30 -0400
Received: by mail-wr1-x42a.google.com with SMTP id j2so3373804wrx.7
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ffy6hHtaK2WOrcSc9+EcQC5iNP+C++tuTJATuVR3wkM=;
 b=nfe5AeBir9fXFDQyP6v70n0SIvgyRHWiuhr8lVcB0dTfMGXnbAg24wTGE0i7V67A3m
 UXPhATZowy8adOdgtsnYsDwheH4Nua+TrQfV6wQBAKl+rlrj0dUCXUbmXsnT1fJ6jETh
 aaNPIU85/o2B8MynmooY5SG9lLAeDWUSj9ytngmAgtFacB8C9XX9UX1mzIwLdRVHM+72
 OlCeekC9O0bnOcvHV4oWBclf8zbYHusiY4SJyVN0LLGbocxcB/v95ym31wpfMRBt7Hnj
 mP3ekP9Nt0vJiH2Ilppp4rLxqfYx83ZTesgeNaCfBcvuMnAF0zK7wXsMpXKGp5pouPuk
 eTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ffy6hHtaK2WOrcSc9+EcQC5iNP+C++tuTJATuVR3wkM=;
 b=thtzCV+qNXnQ8iWN3SUl4DcHZxmOOqZgNN5PQq9CbtGTt2bDdP5i0ljVRrs7EG+CUT
 9zZwu/s8v4orrpCtTtuo2tJBP1Kw5xl9YDBrUb6mG2vK7YITWTWSPz5oV/JLEw+9L5gt
 NPjNRHuK0nomgfwoty6XX1PFyLFpzTIkRNxHFr7+VhO/AYLTx4rKpNkG98TfgMh9DSkO
 oD5ermzqauP7/B3eCVazf1mCDJ4OS6EgJAzolyh2O8n4SoBwhOs65tTYhFldbSfLfGSb
 zfmMIABfnjjYtTMobdlu8pFywbLehaU8S5RWiZf6zcxW0DA+r6xoRvi+wBr4RD3lpVkU
 BgvQ==
X-Gm-Message-State: AOAM53340iiD6IgbhSwuNV605xWV5iYhiyySTJGnlkEFSswKnOJNK54q
 PdH2sKJt1Km6n9h5xgVNB3fG0gyd0BfEaQ==
X-Google-Smtp-Source: ABdhPJz6W/pmeTUtIbxHRwm2XSV6ALpNB1KZtBBPhOwogyPUt0UP6fj2GH0Q8AarAGnKLMJOFTTaLw==
X-Received: by 2002:adf:dc47:: with SMTP id m7mr21523253wrj.100.1600177408441; 
 Tue, 15 Sep 2020 06:43:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s17sm28179564wrr.40.2020.09.15.06.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 06:43:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9488E1FF91;
 Tue, 15 Sep 2020 14:43:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 5/8] configure: clean-up the target-list-exclude logic
Date: Tue, 15 Sep 2020 14:43:14 +0100
Message-Id: <20200915134317.11110-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200915134317.11110-1-alex.bennee@linaro.org>
References: <20200915134317.11110-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than sed and loop just do a grep.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/configure b/configure
index f5fe48d6dd7b..58be974065c8 100755
--- a/configure
+++ b/configure
@@ -1739,17 +1739,9 @@ if test -z "$target_list"; then
     fi
 fi
 
-exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
 for config in $mak_wilds; do
     target="$(basename "$config" .mak)"
-    exclude="no"
-    for excl in $exclude_list; do
-        if test "$excl" = "$target"; then
-            exclude="yes"
-            break;
-        fi
-    done
-    if test "$exclude" = "no"; then
+    if echo "$target_list_exclude" | grep -vq "$target"; then
         default_target_list="${default_target_list} $target"
     fi
 done
-- 
2.20.1


