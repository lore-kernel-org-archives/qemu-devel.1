Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9108C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88FBA2071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Le9ii+5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FBA2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXkn-0002dX-MA
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgr-000581-AK
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:47:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgq-0004GV-LG
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588585627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvIOGdjqIkzytmiWyY1qnAlUnGlQqd6ywNbmnMw49Uo=;
 b=Le9ii+5FqkeWhPlxgjxzGfhdbxKHVYTDdhOrStSx1NO7eSTff1vOxS2MyLeKgj15X+vafj
 XwEOBfsJadCbGrA1RsS7ygTaSn9DVREQE7efd+DpKbo58f0m+2SKLs/KKhcy2TxHXCctvP
 XpMEH7gxDbdK8skcJVMdhuJzlY2awBc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-guUDtxNfNXWAsaEhdgcH1A-1; Mon, 04 May 2020 05:47:03 -0400
X-MC-Unique: guUDtxNfNXWAsaEhdgcH1A-1
Received: by mail-wm1-f71.google.com with SMTP id o26so3224175wmh.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0cHqmvxZVKll/YDWdGdgBQsGWJ3nu/ONs4V6i1R5aFg=;
 b=HGKBFL92evv6ME03PBPn0oWEtLVQIck93yqF+CUL38jhi8JqSvmdGV+DKWfI2hHuuY
 +Z/kbpvPjc9UPDFJgSu6Au2RT1ieU4g2nubW4+p/9uzV6G+xNsvc0skRVAjmFuLjCcxC
 6+23HY+Ka+Y3xUX6exYNYQaoCXYbEIJed+E6Qw6LcisD/aB1hpctSjr9Oe57iRHroJAr
 qVBp0qYvCJdrqW0cRzH2cIibqU7XUniwaqCOTNK4ci2HozWjiEXdvfHnA2YP/OZLvhGt
 nOIVaHxLOfTEyJr8pck0w5s6AmNk9aZHk6QUFPRpSzBeL2u7R/mydJ8YIqTp4p4/f58Q
 BBew==
X-Gm-Message-State: AGi0PuYDD0BFj86tVNnay81bWR+hwZs4auZtsu4c0ywKtnltXYUEXCsp
 OAKEjOmLhsaRWMJi+ld5D6xtwtWF6gD5spb+jDAIM4OJ8g8NLyHrXbH2Wd9N2kc6FtddXd/y1J+
 E/l8sQX1TTN/fkSw=
X-Received: by 2002:a5d:6850:: with SMTP id o16mr17620779wrw.309.1588585622338; 
 Mon, 04 May 2020 02:47:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypIDtNONPhZkTPwQdW6eLEOwCIYTz7AhsLlWKZ71vdMIAmvOq1vzhv8BNDUtr9Ma0tZ8UWbh8g==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr17620766wrw.309.1588585622200; 
 Mon, 04 May 2020 02:47:02 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id g186sm12685573wme.7.2020.05.04.02.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:47:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] block/block: Document BlockSizes fields
Date: Mon,  4 May 2020 11:46:39 +0200
Message-Id: <20200504094641.4963-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504094641.4963-1-philmd@redhat.com>
References: <20200504094641.4963-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As it is not obvious for a block neophyte what means
the 'log' value, document it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/block/block.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index c57fdecf9a..94517c92b6 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -86,8 +86,8 @@ typedef enum {
 } BdrvRequestFlags;
=20
 typedef struct BlockSizes {
-    uint32_t phys;
-    uint32_t log;
+    uint32_t phys;  /* physical block size */
+    uint32_t log;   /* logical block size */
 } BlockSizes;
=20
 typedef struct HDGeometry {
--=20
2.21.3


