Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6CAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9E020737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taIbyG7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9E020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikfR-0007f8-RL
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZ8-0007Yx-O7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:46 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jikZ7-0005aj-Vu
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:09:46 -0400
Received: by mail-pf1-x441.google.com with SMTP id b5so40861pfp.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hMythbUcqIycDnX7vBXLsyLkA4NDGTmBWD2zTKmRWuE=;
 b=taIbyG7tjBJJgV8zx4GDb38LGhzVx0dwki4yaynSdDoTWhApgA4g6cMYNXYJg1ykTe
 775xIXWqipvEbxa9kEevlG8kxg2oc8h7CLIfTYjHDLiSUcQYGLRDGpnJeh4E0CxbPioI
 RDNk0nnPvW43ZpaG3QBv6iiwe+5xExrdaMdgtbcGlP5kCATRH5jZKAf0RbsSVipcVeN4
 jVJ47wDwIKrlZyxgtbO1fVjXonv57RYro15U/XrbP0BqLyEz+wtmB6UJve2+/42Z9vxr
 8AT2MtQcmAQkPdMjdZr7gWNQILjSp8R73QtlCdl5U4+44nWckcE/9Gt9DdX7Eq9s9hzR
 Y1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hMythbUcqIycDnX7vBXLsyLkA4NDGTmBWD2zTKmRWuE=;
 b=qCtGABhCil0Bcqz4JD5YQqoKwb0Qz4WzGe9Uo87+gtlowqzhEM5yfdlsiOVdX0uFgi
 ooJsJl6msHUhZsoLdwPjKjkdUTSe9nVtJAR39E6v1cBVaoDQPe6wg6BxzuGlS8nC3aep
 8wF5MXpdkRnDtZXNA+tsbs4GsX3Mh24nEnfy8+qdY/CyB5hhC6gmgi2+rOJlRbdSEXHE
 pognDWNgv7DhwDy9wtIuuxKHCmC7jADOvUH6oR/zhPKuUzAYAytOZrQHZg9RetXcbqTO
 j+QTAVHcMsm+m8sh4j+K9xcjj603doJvK20FBSKqIMpHdYt7vnRKc2CNeJTSQrFTRw2+
 bDsQ==
X-Gm-Message-State: AOAM5326Kv+DFODHnhXXza/MuwRiRZzQO+Eo8DBp2WCLErRoOn6g8MSM
 3J5athmohbMe8BECJGhYRcSrbQVE1Ynq4w==
X-Google-Smtp-Source: ABdhPJxLp+5rb3an/abxTUz6Y+/u7tiKfB67V7VSwEzXcAPVzOdBmHfWFy4dmS8fmVYFovTWpRBEgw==
X-Received: by 2002:a63:2f43:: with SMTP id v64mr25800165pgv.232.1591733384164; 
 Tue, 09 Jun 2020 13:09:44 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1d09:cef2:3b1f:abce])
 by smtp.gmail.com with ESMTPSA id n19sm10523374pfu.194.2020.06.09.13.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 13:09:43 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/13] qht: call qemu_spin_destroy for head buckets
Date: Tue,  9 Jun 2020 16:07:30 -0400
Message-Id: <20200609200738.445-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609200738.445-1-robert.foley@linaro.org>
References: <20200609200738.445-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 util/qht.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/qht.c b/util/qht.c
index aa51be3c52..67e5d5b916 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -348,6 +348,7 @@ static inline void qht_chain_destroy(const struct qht_bucket *head)
     struct qht_bucket *curr = head->next;
     struct qht_bucket *prev;
 
+    qemu_spin_destroy(&head->lock);
     while (curr) {
         prev = curr;
         curr = curr->next;
-- 
2.17.1


