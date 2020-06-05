Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C76FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FDB2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QF39NHud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FDB2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGKU-0001l2-CH
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHo-0003cX-IE
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:44 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHn-0003rf-NX
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:44 -0400
Received: by mail-pg1-x543.google.com with SMTP id o8so5504528pgm.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hMythbUcqIycDnX7vBXLsyLkA4NDGTmBWD2zTKmRWuE=;
 b=QF39NHud8/ra/5ZqZBKv3m/n/nAeaD/9obblpGC2uR2ywu9ieUwSgeD0xj/Lhp0JPC
 I7f8pgYM/w/YGbzMvEKTLQUkKr7iDFWTkM9KNm9HAJI/MHZNZX6/ZOSGKRFzaG7YsfUt
 QLwZwUyV0zTMbnwQvHW79B1y0Unr/0NFSTQZN/+rLsn7mJ6cotfulusU8GlCuyoCD3xP
 oDvhsIjJmV0YK0vcU6xSfgoHra9GxGHFHDgtkAjO0FiBDvshRG5uxEmw7G4f+HgOKaaA
 n7Be7vyb+syOfzGphDOC39D4DK/Awfn0kfaoCk+vwhpJDZToyXymvJhDFkLZs+Tkv1/1
 7dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hMythbUcqIycDnX7vBXLsyLkA4NDGTmBWD2zTKmRWuE=;
 b=gZXEETRiN7GsgOGgGk8bOjkjcG4/DPDqFVITtnP+QfXRVIlooEAWsT+u9OG9QOkJKY
 ZD9efT/ANZ0AcSj5UBL3IbL5KPGp9QBZrNmQDnseV5FmAVZOH0Yx5Yj2qSGB8i7QxQ5Y
 3wXYtHzVffwr6xy/PsCJAMXSL4lqtz1JjGmy2mcrkFHMxCaSGOI32lcWHNGcUsWRO5dh
 mjmxef/Kjwoq/2iLIzrhPIsob5QvPUsJfXj3TFPFfOiN0P5oZPIuzh7qw6VmOEnz4SCx
 qJhgi+MbXaSLlkuDYHfJyQ+GZiDVwd4VB8kQBxsGrj3b+dqUl28EfWbpLEJuiLJoaVNK
 ZGRw==
X-Gm-Message-State: AOAM530iszJv//8eubVK9FQO4P+iimEcE5Z6EFHrhrkXK2OaIexw0KX/
 WZFW8EmzoeE7Q8iz9N7944gBwBn6FGDjDw==
X-Google-Smtp-Source: ABdhPJwVbfy5cn6wXa9rs1ItQJb4TkGXiG0kaK6fKn2CldolA5ZgeZWBAL66GCoA9GVOg7J11KV21w==
X-Received: by 2002:a63:7d58:: with SMTP id m24mr10192861pgn.81.1591378661982; 
 Fri, 05 Jun 2020 10:37:41 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id a19sm188307pfd.165.2020.06.05.10.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:37:41 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/13] qht: call qemu_spin_destroy for head buckets
Date: Fri,  5 Jun 2020 13:34:14 -0400
Message-Id: <20200605173422.1490-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605173422.1490-1-robert.foley@linaro.org>
References: <20200605173422.1490-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x543.google.com
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


