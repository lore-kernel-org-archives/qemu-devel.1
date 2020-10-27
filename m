Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982D6C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D980C20708
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEjizQT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D980C20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNgd-0002FD-SG
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPt-0001qy-24
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPj-0004fe-Sa
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id n15so1553681wrq.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mUpj98WdBdVAWjaOZxkn/4L2OavckRPis0DqMdib8X8=;
 b=aEjizQT/Z8k0UD5+o++QiHSG3oiI9WOQXG7udopHBZ/kX3z3Vpv1f3wAIWn67Zhf1T
 W7js4iPIux92eZNeBEZtjKLOhyei1W0ru+dboZ/sZTd84WWWD7J9V7O8A2QD0giW3XhM
 e4/V/aw2qVAPb97HZMQCncK/lA36WEHiX8kNrQWGDGqky5T8wdMuz0nIRxVZssf4SNaL
 xic1oYP8yZIT2Kxl8Ez99hMLYEBUwgn067uZZMdypc7zFl1jTbaz+TjvK8bxtYbP2GTd
 6NkBRooHQ+tA7m1YUHDSAwR4gB39MlSk3LqNVQdnp19hLTcBF+isNoTfhe4LWtY2zjd5
 DY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mUpj98WdBdVAWjaOZxkn/4L2OavckRPis0DqMdib8X8=;
 b=rejFBN3vu7j16xLDDpbMdeIcqX41mQ1nutAc8DLGEK7IfFZjvPrv0jR18AygeBnmC/
 3nSXSyZxyQiL+Ls/tchfOkamjeIAV7v0cW0xhFl9DM9TzJ0qd0AuYjnl8mj+KPAwz189
 w8yp2QaRUCozsLkkbMeolrZJp3SoSvJdmAoslahAAezolXn+4ca3YclI7RCLdqfDYbjX
 k4dM0ClcNiNpI/3dUxr1oZAroep+fGC9gQOeo2rQ0Dlp1K4kfpXW7UlL9ZEGDjPNhdYv
 A1ruwwdcX7Gi7xJ+YhNVOuI5wwllgdzNV9RhzBU81HvwHABTq3QS5HyqV167jGBszPtO
 e4cg==
X-Gm-Message-State: AOAM531wACBkzdjHTqW63lzOvW67S3m989VeEChtptIWSqTGOnFEWj7U
 gcV4FfMuqz4BY5QoO7LpYP/6kRGUiD1ZXQ==
X-Google-Smtp-Source: ABdhPJxLm1Gv0PlXDWdTp4i+tdoONAFb9yF4S+Y05hdqEOnxCarz4Uiy6bnzGVuINNcbznj7mgqp2A==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr2542659wrw.132.1603799118228; 
 Tue, 27 Oct 2020 04:45:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/48] arm/trace: Fix hex printing
Date: Tue, 27 Oct 2020 11:44:20 +0000
Message-Id: <20201027114438.17662-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use of 0x%d - make up our mind as 0x%x

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20201014193355.53074-1-dgilbert@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index c8a4d80f6bd..a335ee891db 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -41,7 +41,7 @@ smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
 smmuv3_decode_cd(uint32_t oas) "oas=%d"
 smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
 smmuv3_cmdq_cfgi_ste(int streamid) "streamid =%d"
-smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%d - end=0x%d"
+smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "streamid = %d"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid %d (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid %d (hits=%d, misses=%d, hit rate=%d)"
-- 
2.20.1


