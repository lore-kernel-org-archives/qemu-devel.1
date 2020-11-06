Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E70C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2812151B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IGRk6Npc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2812151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5nY-00033f-LO
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kb5mh-00027h-Pk; Fri, 06 Nov 2020 12:44:23 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:56599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kb5mf-0007hb-Dm; Fri, 06 Nov 2020 12:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=0T+2H2pIRRu6B0aCD0TkVm4zcfR4m2aOp1/uvMdp/Lg=; 
 b=IGRk6Npc5oIgZtMAn2lTj2wD6GpN4+mwiwDhY+597/aFNpQin7Y4NUBZ06fr6Js/y37F0uKTL1HILyBPOrXWFZ/Ec+SRjGDzckkfrL1DjLVcp/kGvDQtb63PcNoyjYjq10SNpaMihl9Byx+wGW03/T7Yfe+pNNnXf6g/Go/EyLIRpGrYcRtfZLQOX/Pbh316l+q4usl+Ohh+fWXFC82ZFLOAH3OMARbF+OKtCYOnJTdGncPY6FshEGcAFjorbBPYtoH9t50bVA6aiR40r8SWd7yeDd2Q8oalxGIB7UDb850ITVerILZaZe1FbVryIwQmK9580ge1CYIrvti4a4H9NQ==;
Received: from [81.0.39.238] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kb5mb-0003zj-Ag; Fri, 06 Nov 2020 18:44:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kb5mO-0007fO-AN; Fri, 06 Nov 2020 18:44:04 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] quorum: Implement bdrv_co_block_status()
Date: Fri,  6 Nov 2020 18:43:46 +0100
Message-Id: <cover.1604684432.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 12:44:18
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
Cc: Kevin Wolf <kwolf@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The first patch is the same as in v1, but now that we're at it I
decided to also implement bdrv_co_pwrite_zeroes()

Berto

v2:
- Implement bdrv_co_pwrite_zeroes() for quorum

v1: https://lists.gnu.org/archive/html/qemu-block/2020-11/msg00163.html

Alberto Garcia (2):
  quorum: Implement bdrv_co_block_status()
  quorum: Implement bdrv_co_pwrite_zeroes()

 block/quorum.c             |  67 +++++++++++++++-
 tests/qemu-iotests/312     | 155 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/312.out |  71 +++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 292 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/312
 create mode 100644 tests/qemu-iotests/312.out

-- 
2.20.1


