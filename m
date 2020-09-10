Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C61CC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C4B206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cEG+BoEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C4B206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQfz-0007Iv-2U
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kGQes-0005b0-3k; Thu, 10 Sep 2020 13:46:54 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:46626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kGQep-0004Sn-3X; Thu, 10 Sep 2020 13:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=EqTfiZ0WO59oz4weWj5cngkc02H1ZzKg8OfPVRwasI4=; 
 b=cEG+BoEbodaqdpkTBB1Rz8TY/PJaSoZ/8XCvpdGd8tWj/ZfYDi4hawN09trtsnxKrEsxZ+UIpic5kdFXPpfG2ZzR609Hw2NNrQikA79kf0S7st+KL8xSZ1AaPbNTZXFGYpCWCfGn0yKN3WZfqtFgg8mzlhStxRTkytnzNeYD4R61PY598btIojUq4pA00GmN2tW2os3XCleGgQhabSDBdWRt+56WAqCgJgitMBftQgG8oKoIm76ZUc7kVT76Jf65hibpmG5mQML+Jw+iAWSqpYxsPNk1Z4xDi/zotphNKYWm7lGnWu2T+qaetEmr7few4Ws8ae0ljHxnfDissYzFmA==;
Received: from [81.0.34.67] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kGQeQ-0007H3-5Z; Thu, 10 Sep 2020 19:46:26 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kGQeC-0006q9-Q5; Thu, 10 Sep 2020 19:46:12 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Skip copy-on-write when allocating a zero cluster
Date: Thu, 10 Sep 2020 19:46:00 +0200
Message-Id: <cover.1599759873.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 13:46:27
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's the new version, there are two patches this time.

Berto

v3:
- Add a new patch to improve the reporting of BDRV_BLOCK_ZERO [Vladimir]
- Rename function to bdrv_co_is_zero_fast() [Vladimir, Kevin]
- Don't call bdrv_common_block_status_above() if bytes == 0

v2: https://lists.gnu.org/archive/html/qemu-block/2020-08/msg01165.html
- Add new, simpler API: bdrv_is_unallocated_or_zero_above()

v1: https://lists.gnu.org/archive/html/qemu-block/2020-08/msg00403.html

Alberto Garcia (2):
  qcow2: Report BDRV_BLOCK_ZERO more accurately in
    bdrv_co_block_status()
  qcow2: Skip copy-on-write when allocating a zero cluster

 include/block/block.h |  2 ++
 block/io.c            | 35 +++++++++++++++++++++++++++++++----
 block/qcow2.c         | 35 +++++++++++++++++++----------------
 3 files changed, 52 insertions(+), 20 deletions(-)

-- 
2.20.1


