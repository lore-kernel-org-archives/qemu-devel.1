Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AA6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E278220848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHyBFkhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E278220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfVA-0004NX-Ql
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLl-0000SY-Iu
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLj-0000YI-Q8
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTVh2AtSozqPFxInc/ksQHh3UVKG/5ht671RHOKC4pA=;
 b=DHyBFkhY2Wpl+NaaAJpjF58I4KldH6jQBWKRR+HqwHzgzqMgA2aX1eFkdwGqMr/xHNB5lm
 JlnvUnw6nHrzDqniaR+lijppbI39w43DCVE2F10nHGxF1SdHss0AWUy46S0B0oP2jxkPiI
 kZBsAtMvbxdTAZCujUHVKI3wowOOBwk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-y1mOYzmAOZKEBwlyNuuGhA-1; Wed, 14 Oct 2020 07:53:41 -0400
X-MC-Unique: y1mOYzmAOZKEBwlyNuuGhA-1
Received: by mail-wr1-f71.google.com with SMTP id q15so1178099wrw.8
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 04:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uTVh2AtSozqPFxInc/ksQHh3UVKG/5ht671RHOKC4pA=;
 b=MilO2ydp5G6bK9zdsHJtK4BJdXnLPAL8p39cCCw0Lx6pdEw1dwWWX8VB5wPCAvHv1k
 epwuPwAKFXHC4UlIzssRo2geRofS3uhbzJzY33mvImPZ/2HNJv8CwQb/etTr47lphw2m
 HdDZS4RLQPdoZKcCISQLgQvlxHL6Xr2Kd2CnMTrIvkj+fsCemWTl202J5ouXDKUtZiue
 19uZQwLKtZ4jbP0SulF4kMwzZOZVe2znSsfJd9G1Z/50Pzg9jtOh8ZGo+wSeuhmcKW5I
 AFnjFTK6BFj8zVZ2A+T6TpAj7v73tqPPOaPX5YbJW0TAL3wCxDVQvAIJMaKBufDtzItN
 flxg==
X-Gm-Message-State: AOAM532lai1xBILLo2JSNFp6simK7qcQLB27ld8dbClpNVah0+CwlxYG
 UG4vGo6rC4lCQE09VAIhG0s+tAgbC7LTKr/b+yUxJrBgNLWJKL+Nv8z6aFQVsXccmsEbIX/GwmE
 8srSgsLnWtobRSi8=
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr5507274wrq.254.1602676419947; 
 Wed, 14 Oct 2020 04:53:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZTq3DOuNlD4CjLYuFd9cTUF2hAZlueRat6xzS8TZp5RX2oIrBnEpKOMREHnmI2CSqIK2tWQ==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr5507251wrq.254.1602676419740; 
 Wed, 14 Oct 2020 04:53:39 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f14sm4742637wrt.53.2020.10.14.04.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 04:53:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 9/9] util/vfio-helpers: Let qemu_vfio_verify_mappings() use
 error_report()
Date: Wed, 14 Oct 2020 13:52:53 +0200
Message-Id: <20201014115253.25276-10-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014115253.25276-1-philmd@redhat.com>
References: <20201014115253.25276-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of displaying the error on stderr, use error_report()
which also report to the monitor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 2c4598d7faa..488ddfca2a9 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -661,13 +661,13 @@ static bool qemu_vfio_verify_mappings(QEMUVFIOState *s)
     if (QEMU_VFIO_DEBUG) {
         for (i = 0; i < s->nr_mappings - 1; ++i) {
             if (!(s->mappings[i].host < s->mappings[i + 1].host)) {
-                fprintf(stderr, "item %d not sorted!\n", i);
+                error_report("item %d not sorted!", i);
                 qemu_vfio_dump_mappings(s);
                 return false;
             }
             if (!(s->mappings[i].host + s->mappings[i].size <=
                   s->mappings[i + 1].host)) {
-                fprintf(stderr, "item %d overlap with next!\n", i);
+                error_report("item %d overlap with next!", i);
                 qemu_vfio_dump_mappings(s);
                 return false;
             }
-- 
2.26.2


