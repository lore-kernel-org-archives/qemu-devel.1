Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CBBC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A639820672
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oxSnnaby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A639820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeKh-0004yS-Pj
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kFeJ4-0002fL-Ur; Tue, 08 Sep 2020 10:09:10 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:33998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kFeJ0-0004GN-3g; Tue, 08 Sep 2020 10:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=c8WDRwQ17bQmtwhgpzqZzV3Yud3zLUNyqJc/GCvARhM=; 
 b=oxSnnaby24ynjKRkWn2vIzQAsreOV6X5OnYTaUE5Fx7QYVFhPC52qQ34teQvZmeh37JVI++HcPMUuojN4wIV+F41GVrC0L3fTSjr30iLLubUOLuTBOi+5xsPwxuqlvdbW0VRSYo3khOLG+bHLXWZnatFYy0lknwlgjSl4PG7BlEoefu/pKYWZBQrVvu72gLnU3ZePeHHJvYWrZglAheDE3QyBJw0fzjkLCGCta1dA6fSJ1ioj/zjIAVCQTc29bQMjr/ujzaXQAzChpbGX+o0i76z8CYLIkvtVSEfSRqXU59Km8XxpBF/Q7a5TAHdGLvgBNPof5ddroS18wxWvfTkmA==;
Received: from [81.0.33.67] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kFeId-0007AE-6v; Tue, 08 Sep 2020 16:08:43 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kFeIQ-0001zL-BE; Tue, 08 Sep 2020 16:08:30 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix error handling in preallocate_co()
Date: Tue,  8 Sep 2020 16:08:26 +0200
Message-Id: <cover.1599573989.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 10:08:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a follow-up to "Fix removal of list members from
BDRVQcow2State.cluster_allocs":

   https://lists.gnu.org/archive/html/qemu-block/2020-09/msg00247.html

However the patches themselves are independent and can be applied
separately.

Regards,

Berto

Alberto Garcia (2):
  qcow2: Handle QCowL2Meta on error in preallocate_co()
  qcow2: Make qcow2_free_any_clusters() free only one cluster

 block/qcow2.h          |  4 ++--
 block/qcow2-cluster.c  |  6 +++---
 block/qcow2-refcount.c |  8 ++++----
 block/qcow2.c          | 40 +++++++++++++++++-----------------------
 4 files changed, 26 insertions(+), 32 deletions(-)

-- 
2.20.1


