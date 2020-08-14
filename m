Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8691EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 14:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF6320855
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 14:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jCRkElT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF6320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bB0-0007GP-Gf
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 10:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k6bA2-0006M4-LP; Fri, 14 Aug 2020 10:58:26 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k6bA0-0003v8-Az; Fri, 14 Aug 2020 10:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=JKNItfdeFsHWMxOlxMCkk0/qK7VYf5Xz3s5tmfVmfS4=; 
 b=jCRkElT0Lz+VW2JW8KG8tGG8xAC61CVpNv+NBKpbgJIf4D2Q4n+M6YbHF86O+xaFKUWNhaYHssRB9Fn5PDIA+3zxo1V46+IELVRby5elyG464ciWYlk1TmCztAFokKzPn30nREVKlZnPVY1BVCY1f2YCatrr8bKMfB7+RwCiJyhQG74udImV29J/iUCsppFvBVmkSMfj8m3Az9pPyvDAkw2ucGOJbjseJbCfXFaAgNB9/utTZED1DOJJYjW30BEdogKUbUjaYtUAKHJ+zsDwY20gNist4P3TLhg7+8mxmfDfv3wFDuVn1B7KIHjuldg4+tHzODz6xogfpQ8559VKmA==;
Received: from [81.0.33.30] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1k6b9a-00038X-SZ; Fri, 14 Aug 2020 16:57:59 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1k6b9N-00039Y-SW; Fri, 14 Aug 2020 16:57:45 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero cluster
Date: Fri, 14 Aug 2020 16:57:40 +0200
Message-Id: <cover.1597416317.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 10:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

the patch is self-explanatory, but I'm using the cover letter to raise
a couple of related questions.

Since commit c8bb23cbdbe / QEMU 4.1.0 (and if the storage backend
allows it) writing to an image created with preallocation=metadata can
be slower (20% in my tests) than writing to an image with no
preallocation at all.

So:

a) shall we include a warning in the documentation ("note that this
   preallocation mode can result in worse performance")?

b) why don't we also initialize preallocated clusters with
   QCOW_OFLAG_ZERO? (at least when there's no subclusters involved,
   i.e. no backing file). This would make reading from them (and
   writing to them, after this patch) faster.

Berto

Alberto Garcia (1):
  qcow2: Skip copy-on-write when allocating a zero cluster

 include/block/block.h |  2 +-
 block/commit.c        |  2 +-
 block/io.c            | 20 +++++++++++++++++---
 block/mirror.c        |  3 ++-
 block/qcow2.c         | 26 ++++++++++++++++----------
 block/replication.c   |  2 +-
 block/stream.c        |  2 +-
 qemu-img.c            |  2 +-
 8 files changed, 40 insertions(+), 19 deletions(-)

-- 
2.20.1


