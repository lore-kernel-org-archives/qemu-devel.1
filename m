Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1714C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B00D208A9
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRB/u5DD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B00D208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nxN-0007kW-Cb
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nua-0003VK-AG
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nuX-0006DH-Np
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xMDzywp//OugMrKjSizTC3WTyFIJ7uQWbux4Y7eWkQY=;
 b=HRB/u5DDJLJNVgnnSJRdSYTdJMXUWgSJNBUrzQTW6fEs0u1KMWTnXUX9QkVknACe2+VXHT
 mw2OeyXQ644cy3zdPfTJxKCvDoWpkCTHfistWBKgCN+YuAXbxUM3Eo0Ha/guV8X8MM6RE1
 7Am6TWU0f6QmV42M50cR85+4VUqfpBw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-dY8FWrNnN9eTG7CwsF4nOA-1; Thu, 20 Aug 2020 12:59:31 -0400
X-MC-Unique: dY8FWrNnN9eTG7CwsF4nOA-1
Received: by mail-wm1-f70.google.com with SMTP id u14so1941791wml.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 09:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xMDzywp//OugMrKjSizTC3WTyFIJ7uQWbux4Y7eWkQY=;
 b=rumhFKVe1rqq7nx50A4Pox7PV/wGtUhs71KSxTTnsdMu2+RQrsicjA7FpfdFmd/Gyj
 mAT+u2v4cduqrdFJJa48DCX+xf4BKZlt/hL4TdcqK/aCtMfKyx7u8+8/37kOnQWWDxea
 rkCXIp+tvS+2lCHbu5hMNyzM95JeuXspIpUoWClhJr7SxBne4t4jQ8m3KJwCcgUgKmXU
 0X2lXMFvBeOOYygj62cAnyjrEHhyS4/KKaC73GWbveqLXODhlAz+DL+jviSB8jl3qN21
 /EBhzLlONGL7gTm5sWYD2PK+hvtvEjPK0eLhrx/SbYoTXPCFYrzhH0SaXfhSxgomuvpC
 pLyA==
X-Gm-Message-State: AOAM531fuqhyZXSOanfbGeHRYPsR8q801Oz0D73JbpKMZ4PcgCMBOUlg
 maLM9GnreTbl0s3S/7rliIqEFvLn1wTDqG+uJ7rTPy4XwPgkPg5EvdtIg5NWRNV8Y/otXWCvEzV
 QMSXae69MagjsV+s=
X-Received: by 2002:a7b:c401:: with SMTP id k1mr4259211wmi.18.1597942770038;
 Thu, 20 Aug 2020 09:59:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIlDAdqewr7poOXewRpVpML2nR7umyFdrOqfMoM0E+zIsKaFM90r1HpKBZxKX7NTWwSS9XKA==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr4259203wmi.18.1597942769906;
 Thu, 20 Aug 2020 09:59:29 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j4sm5136932wmi.48.2020.08.20.09.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 09:59:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/15] block/nvme: Improve error message when IO queue
 creation failed
Date: Thu, 20 Aug 2020 18:58:51 +0200
Message-Id: <20200820165901.1139109-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820165901.1139109-1-philmd@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not use the same error message for different failures.
Display a different error whether it is the CQ or the SQ.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 003809fbd83..53448b7d230 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -648,7 +648,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x3),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create io queue [%d]", n);
+        error_setg(errp, "Failed to create CQ io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
     }
@@ -659,7 +659,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x1 | (n << 16)),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create io queue [%d]", n);
+        error_setg(errp, "Failed to create SQ io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
     }
-- 
2.26.2


