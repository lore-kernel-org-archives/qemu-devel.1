Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1281EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF2522204
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yc/+1nS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF2522204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGN9I-0004HF-Ef
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 10:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGN6R-0001Tf-9e
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGN6P-0003s3-Qm
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599746345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2nL5nubYV63BIiDSxuLpmGc2Alel66jSGDQ6bJQNtI=;
 b=Yc/+1nS4tfdZJ1KHtaEPow/FYwwg9BAKZE7GYxk2TGGl4KM5R8iBTNp7nsbfkpZz2Ngvqb
 oeWmb4eAjBsEx8jUh8yIeleFK+ZRmm3/e0WGQOQu2WGTe79fWrHViiO+jT9izUOtJeXvqr
 ByByDeGJqQcRvkc10kyIJsLICgnXHH8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-Dyg6sEOLOEGFYJoiNlXcDA-1; Thu, 10 Sep 2020 09:59:01 -0400
X-MC-Unique: Dyg6sEOLOEGFYJoiNlXcDA-1
Received: by mail-wm1-f71.google.com with SMTP id x6so34496wmb.6
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 06:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I2nL5nubYV63BIiDSxuLpmGc2Alel66jSGDQ6bJQNtI=;
 b=dRhaWfLKs5BDDJ+6t1Pac+27Q5BadoS0M7QgwvSqpoImDlx3QKUVYiNdNiZCqxoA64
 jws7+lphJ8BjeVlF7mV3NgowSsS/Mc+n82dcDe1no0xkev0TNTVle8RDoF15ZZn7UJhs
 rIv0j+Pf2Cq/C98cnqhwI4nRyLePppUUydjxiuqbBGItYvR/DaQhizq8ZnPSdsCZvD9C
 /1NxdJdgOtFVhtOCfTzKngfJxFoZrPfFE0L8F3pmc88oAR9wV6cXcGbadgQXQHOp9d1S
 z8MH3mcQoMw3sHZbXzUJg8lA6UxOR3iaL/MVYbeoh2RyVQZueMBl+PlOf6PSAkeuMivn
 R8fg==
X-Gm-Message-State: AOAM5308LTR2BsBhpJkU2G+DAo2xN4EtEjOXsqUm93gwpWHad/JGwpW0
 lJMwKRnHvM5WFwRUDMjj7yxhD3XZITyISDc4GKYLonfdHjGkLzHhokuWijTdVSaE+Hnr8dqlLQR
 4mFPOLT6tguG/3JE=
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr106414wmb.43.1599746339504; 
 Thu, 10 Sep 2020 06:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdU15i9on/xEzpzTFJeNDrKwhj18/wXMi72xocKjHs0sI3MuTd2RxP84+HjI55tvZNWr9DSQ==
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr106406wmb.43.1599746339336; 
 Thu, 10 Sep 2020 06:58:59 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id p16sm9522186wro.71.2020.09.10.06.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 06:58:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/timer/hpet: Remove dead code
Date: Thu, 10 Sep 2020 15:58:51 +0200
Message-Id: <20200910135852.516809-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910135852.516809-1-philmd@redhat.com>
References: <20200910135852.516809-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Dov Murik <dovmurik@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code was never compiled/used, remove it.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/timer/hpet.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 380acfa7c8a..b683f64f1d3 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -416,20 +416,6 @@ static void hpet_del_timer(HPETTimer *t)
     update_irq(t, 0);
 }
 
-#ifdef HPET_DEBUG
-static uint32_t hpet_ram_readb(void *opaque, hwaddr addr)
-{
-    printf("qemu: hpet_read b at %" PRIx64 "\n", addr);
-    return 0;
-}
-
-static uint32_t hpet_ram_readw(void *opaque, hwaddr addr)
-{
-    printf("qemu: hpet_read w at %" PRIx64 "\n", addr);
-    return 0;
-}
-#endif
-
 static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
                               unsigned size)
 {
-- 
2.26.2


