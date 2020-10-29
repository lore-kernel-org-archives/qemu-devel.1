Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4F1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D0B20754
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMJwztie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D0B20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4NL-0003AT-6G
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Jb-00064y-7f
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4JX-0006TU-3R
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/V2bopfrgs5z9fXdSqKgAQr3mfETDBQSgYOoqY9Jixw=;
 b=HMJwztie6yqZ2oBGfIcEZbwyQyVq8RjijRhiet9pLHhLnDb/5fxdFTP8NhBFTB7ZNXcfWO
 LmnZxUBcnX2CFfo9Dhq01xXIupKB401DrB/yadVX24aqgLk45WTVkDeQm2EIW60Jwyn4sY
 +LW+ExVOi65vm1VofLpBGf8Kgecuw5g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-FFeTHNa6O5iy0Uo7IGg2Fg-1; Thu, 29 Oct 2020 05:33:43 -0400
X-MC-Unique: FFeTHNa6O5iy0Uo7IGg2Fg-1
Received: by mail-ed1-f69.google.com with SMTP id dm20so954443edb.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/V2bopfrgs5z9fXdSqKgAQr3mfETDBQSgYOoqY9Jixw=;
 b=jsXm6Tbi93rM9h3c4aHnidD7QxAHUBxkYgNOJnoDAY/gpYeXeLKrv2eu4bp31SN+VC
 F8WXOi5BtvsHmvVyoVmpja5Td8y1c82v0she5kbL9jjl8haWJxnQhlfBLhWgEIMLfMly
 wDalCg1DVV/hNnoA4nJG6TpV4F1mnm5CsRtyUBtsdGMUwz1HwGhRmMZt7fPEdkLflLVW
 PEXWv9icCovaFZb1KSU7RODhPO2VNZv60RzsuzQpKn9opYK1c9qZ1LETz8YeYs01lwYU
 OHqUpdC+s6V+HVzjP3WeojlHTIW/Ik2GHyL3jk4WrppoeClu5SQ+GyVsoHJxMhzk3YRD
 GtwQ==
X-Gm-Message-State: AOAM5320zPRKIj5jZZG3dlnWZEcgSenAYvm+u6cwOfX7i8sl9sLG1crj
 4e6D7npV+uGqwDMwcdU4DF/VGQTtWQ3sXIttHPTEDqMC0tdoKFENo5PRZZcPwEM9ifyYt41egID
 0xup/HcdrgLQLlmc=
X-Received: by 2002:aa7:c792:: with SMTP id n18mr2975749eds.209.1603964021784; 
 Thu, 29 Oct 2020 02:33:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYpESBUBbOB5lW/BGGS4fuMQ3uYbb/gclHdzF0P/kIYuQNRO6rAfDaJcaq0s9OfNJKAYveQQ==
X-Received: by 2002:aa7:c792:: with SMTP id n18mr2975728eds.209.1603964021606; 
 Thu, 29 Oct 2020 02:33:41 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id x2sm1176316edr.65.2020.10.29.02.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:33:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 06/25] block/nvme: Improve
 nvme_free_req_queue_wait() trace information
Date: Thu, 29 Oct 2020 10:32:47 +0100
Message-Id: <20201029093306.1063879-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029093306.1063879-1-philmd@redhat.com>
References: <20201029093306.1063879-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

What we want to trace is the block driver state and the queue index.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 2 +-
 block/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 8d74401ae7a..29d2541b911 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -292,7 +292,7 @@ static NVMeRequest *nvme_get_free_req(NVMeQueuePair *q)
 
     while (q->free_req_head == -1) {
         if (qemu_in_coroutine()) {
-            trace_nvme_free_req_queue_wait(q);
+            trace_nvme_free_req_queue_wait(q->s, q->index);
             qemu_co_queue_wait(&q->free_req_queue, &q->lock);
         } else {
             qemu_mutex_unlock(&q->lock);
diff --git a/block/trace-events b/block/trace-events
index 86292f3312b..cc5e2b55cb5 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -154,7 +154,7 @@ nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s
 nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset 0x%"PRIx64" bytes %"PRId64""
 nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset 0x%"PRIx64" bytes %"PRId64" ret %d"
 nvme_dma_map_flush(void *s) "s %p"
-nvme_free_req_queue_wait(void *q) "q %p"
+nvme_free_req_queue_wait(void *s, unsigned q_index) "s %p q #%u"
 nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
 nvme_cmd_map_qiov_pages(void *s, int i, uint64_t page) "s %p page[%d] 0x%"PRIx64
 nvme_cmd_map_qiov_iov(void *s, int i, void *page, int pages) "s %p iov[%d] %p pages %d"
-- 
2.26.2


