Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BD7C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C5B206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3xsFcYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C5B206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPov-0003HA-Ic
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTw-0003r5-HH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTu-0004UB-2D
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsADHQhtdYEPnOhTT91bO7gVSjhtNIdy1KjQXQ/oHWM=;
 b=K3xsFcYlUVm8MTqiLCCb4znQfkF+dmMWN4WY9dhG+Woc7PuqDjirQ/tm+GidOTHGR+Bkub
 CK85IfxFjd+TWTMc6N11HyE6gMZlphx+57WI6E6wlX17sdVMNnuZ0BH88L3pDJ9yIa93XG
 Uno2J4Cgt781hjGVrfBxp8eSaj/H6og=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-fKCki7y_Ng-ffzAdNbNKow-1; Tue, 27 Oct 2020 09:57:39 -0400
X-MC-Unique: fKCki7y_Ng-ffzAdNbNKow-1
Received: by mail-ej1-f72.google.com with SMTP id f11so859121eja.23
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rsADHQhtdYEPnOhTT91bO7gVSjhtNIdy1KjQXQ/oHWM=;
 b=JihVVOYb0fFBbREO2pyp/SRQMCEJLsK4+JjSl4o5xPp0pRUL740lk9kDFAMdiomITj
 NXubVpUnV0BNl64pCQ/6pkN8F3fIoq0Koovv73zDJFKBAW4TRzXjFTMRo7HnqZPMHjzV
 fIdPyLB1oQRC3SRF5sEbV4z7b3qJyCit6PTO1nhDP+UFlrqjCKWShTFYG4/74Sqxw53b
 Lx1uIjlzQTuaGd/qXqzwamulJEb20zi0BU/15X9QL4SE1doDdku+ubhS+jnfcYk2yzp2
 6Fq9xGHTEbwpxHjmhyuw9LQompT4k73lNFX0jMnW6/aeMh5hUnx/gSijthek5lga4J7C
 2QjQ==
X-Gm-Message-State: AOAM532LG2ADjN4ikEbxnMlvCeNKvl32f7qePdp97uDA+DouM5Mi/2bp
 w9IRslJUF6ZWrcowvjs8bO+63Nd2+65bQVgst5h93g7hfS71Yppa9IRyijQX+agGH+ymE+g+DfU
 oTJRt5HIBQaZTgLo=
X-Received: by 2002:a17:906:1804:: with SMTP id
 v4mr2599343eje.201.1603807058348; 
 Tue, 27 Oct 2020 06:57:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQg64kvfwxBTN6dBbJosJW+jhiXkzsWkbQRbAwazI6wMTkUszv724DkBTtGmnHEKM0pFdGdA==
X-Received: by 2002:a17:906:1804:: with SMTP id
 v4mr2599331eje.201.1603807058175; 
 Tue, 27 Oct 2020 06:57:38 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id o15sm1094135ejm.38.2020.10.27.06.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:57:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/25] block/nvme: Correct minimum device page size
Date: Tue, 27 Oct 2020 14:55:42 +0100
Message-Id: <20201027135547.374946-21-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While trying to simplify the code using a macro, we forgot
the 12-bit shift... Correct that.

Fixes: fad1eb68862 ("block/nvme: Use register definitions from 'block/nvme.h'")
Reported-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 682946ad840..d2d57a287cc 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -756,7 +756,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         goto out;
     }
 
-    s->page_size = MAX(4096, 1 << NVME_CAP_MPSMIN(cap));
+    s->page_size = 1u << (12 + NVME_CAP_MPSMIN(cap));
     s->doorbell_scale = (4 << NVME_CAP_DSTRD(cap)) / sizeof(uint32_t);
     bs->bl.opt_mem_alignment = s->page_size;
     bs->bl.request_alignment = s->page_size;
-- 
2.26.2


