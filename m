Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E89C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42AC20838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="D3pM2OND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42AC20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9UV6-0008Sp-P4
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@daynix.com>) id 1j9UUF-0007w7-QD
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@daynix.com>) id 1j9UUE-0006AR-OT
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:54:59 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37523)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <andrew@daynix.com>) id 1j9UUE-00068H-6Z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:54:58 -0500
Received: by mail-lj1-x241.google.com with SMTP id q23so2117047ljm.4
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 05:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GMkn4ztugkUGH3KUuIke087dqODGIqhh153qkwjX2vA=;
 b=D3pM2ONDlrjxgu5NrUaDj+BXP7z37Yie1JKPwuWrQHC25bhLRrPXyDmeqafnS9GxRK
 O5ynByIBuCNRsoFnzHXGSiBXwsA9/xGTU71etyxy+OB3xynbNEn8xWdRgryMESl6VkmI
 jsZtSaRFKn8XE+PyjVT9Kg6eNK1MaAv2eS1LW7ud/TRZLtLMhwrTel05gMSiCm4xxP3O
 4bgvbFDsUxGfsEUzDMh8WfdoDck7NYmExSmEYPS7Kqi68acaYadjH7VIqe7nth9+B0GS
 C7F20XbcQ+Znoiy/h+IvfP7FVbb/e+ne7PffQXJM2lKYzyXzQeuA4gol0Y5FvKCsuyDs
 CNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GMkn4ztugkUGH3KUuIke087dqODGIqhh153qkwjX2vA=;
 b=Iu1xfWeabQ17iDFyPMUEOrqqqciItHVXXAA2qVejPoLFwNltpZ2QaA02uk+svZ9DE6
 A+AI3fPOTcwkvF7561s941J1fiZrqvs5HZUBHStkF53lBg2zb9D2AM9IPL/QC0BuR/UH
 Az+GbZIaMlMN06ukaudBVUn9KwgKGL4C8rmUBGzAmQxW87SMXe2q21iZsMB4eQxZZzO2
 EZKM/zGEzy/659eLcWXXNkCuyqrFvVV4wE6M5SzM1iWQZfRiQEV6uXfUw8vcOoNIP19I
 2YeEWODwJKAny6m4QWAxa06hYkVc5H0PqyLKpcrAyZpzm4Gwblr5pu3bKvx5yJ48V285
 gSSA==
X-Gm-Message-State: ANhLgQ3+1iLd5KDtO7+0mg9jZ0FK+AR7BYsvcEpVAdOHrUIpG9Okwoo8
 OGV8tZJqo2QWCZZJPaxezhVboQ==
X-Google-Smtp-Source: ADFU+vsEJkAetSa3p4pZZdKXoDOCwfdbZTRywdtwAv5S9ItedpRKMz49FT+lDaZfWxu9ZDesJQXuLQ==
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr2130673ljk.201.1583330096318; 
 Wed, 04 Mar 2020 05:54:56 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id k11sm2697556lfd.17.2020.03.04.05.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 05:54:55 -0800 (PST)
From: andrew@daynix.com
To: dmitry.fleytman@gmail.com
Subject: [PATCH v2] Fixed integer overflow in e1000e
Date: Wed,  4 Mar 2020 16:20:58 +0200
Message-Id: <20200304142058.52458-1-andrew@daynix.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Melnychenko <andrew@daynix.com>

Fixes: 6f3fbe4ed06
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1737400
Fixed setting max_queue_num if there are no peers in NICConf. qemu_new_nic() creates NICState with 1 NetClientState(index 0) without peers, set max_queue_num to 0 - It prevents undefined behavior and possible crashes, especially during pcie hotplug.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/e1000e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index a91dbdca3c..f2cc1552c5 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -328,7 +328,7 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice *pci_dev, uint8_t *macaddr)
     s->nic = qemu_new_nic(&net_e1000e_info, &s->conf,
         object_get_typename(OBJECT(s)), dev->id, s);
 
-    s->core.max_queue_num = s->conf.peers.queues - 1;
+    s->core.max_queue_num = s->conf.peers.queues ? s->conf.peers.queues - 1 : 0;
 
     trace_e1000e_mac_set_permanent(MAC_ARG(macaddr));
     memcpy(s->core.permanent_mac, macaddr, sizeof(s->core.permanent_mac));
-- 
2.24.1


