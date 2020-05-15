Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98454C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE16206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnQIbDX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE16206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWXV-0001EW-HW
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWVN-0005Xi-An
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:19:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51650
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWVL-0005Yq-Vc
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589534383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LF0tsEpR65YIc+luskV1kHZ6WOfSSsruPgdBzkTKH7s=;
 b=MnQIbDX81PCjg6ilJaph4w6u5ADP6mCGZzp2PuR0ZNZrOsZb+V4IgFrhkJDmVcJNrPPivs
 uZve6E1vk5gNSMxsKCh0WKcxWmd/xDQtDNFLjyhc3m/vW0q2ox0GRKFRjsuS719K77hbbU
 E+8rY4l1JQI8kacqDGC2sz5jTpSVMHc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-l4vp5rK7P5myWIo4t_8TTg-1; Fri, 15 May 2020 05:19:41 -0400
X-MC-Unique: l4vp5rK7P5myWIo4t_8TTg-1
Received: by mail-wr1-f70.google.com with SMTP id z5so866293wrt.17
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LF0tsEpR65YIc+luskV1kHZ6WOfSSsruPgdBzkTKH7s=;
 b=uNlPXZIMhYhkY2CT+xG0Kbz4ZNNQLFYisODPQABtUk6WvX1hC0aUWmjQ4vQqSKhd3/
 LTWDVhR8B1x9a4XX1fYsiWG7bafi01Iwkn+BLYczegNenCOMkPZTriEeEN0gCaZNJZoW
 x1+Z+LK3EiBpN4CGxp83kU7f1TvY3IIZ5FxCmpnool4tP9rSCov6dqIiH+qzjgCCRYcQ
 UQqW5e5cGRCZqZ0QPaW5DWPsAIJyYJlOh1X2ataPNZtSsitt3O+NCgV/b6tG2NkW40aN
 LsJXppG5SuSKpNL7xjma7+Js4/IVX+rdeR6PfH9O1/fwxS8YY9qKDL51I722blvVjA8p
 Gp1Q==
X-Gm-Message-State: AOAM532WjZUGK5xq2N7b+2TAfq6cT56k27GkiLe3vlEb9QGnLoM+2Kkc
 R5btnX0xKPO7ga9bK7i/ysUeIhnBBk7PimfcS363rZowPUm1XoFBIPlpKMLsRarbcNwW/tDn7K6
 VKmARj08QLvpFbAw=
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr3150553wma.159.1589534380547; 
 Fri, 15 May 2020 02:19:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLiq76g2NxXRpxdMzXZb6yLUfop6/o/xxODFq+49OENhv5SbJdjhDEoy93rEc+QuOAJ16e9A==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr3150539wma.159.1589534380389; 
 Fri, 15 May 2020 02:19:40 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b14sm2689293wmb.18.2020.05.15.02.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 02:19:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] block/block: Document BlockSizes fields
Date: Fri, 15 May 2020 11:19:22 +0200
Message-Id: <20200515091924.14380-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515091924.14380-1-philmd@redhat.com>
References: <20200515091924.14380-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As it is not obvious for a block neophyte what means
the 'log' value, document it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/block/block.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 480e6b6837..6836876da1 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -86,8 +86,8 @@ typedef enum {
 } BdrvRequestFlags;
 
 typedef struct BlockSizes {
-    uint32_t phys;
-    uint32_t log;
+    uint32_t phys;  /* physical block size */
+    uint32_t log;   /* logical block size */
 } BlockSizes;
 
 typedef struct HDGeometry {
-- 
2.21.3


