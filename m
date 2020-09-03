Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E67EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463F42072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Apt/dPtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463F42072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsGk-0004Ib-Da
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kDsFX-000264-JW; Thu, 03 Sep 2020 12:38:11 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:40467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kDsFU-0003uO-9x; Thu, 03 Sep 2020 12:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=f+aURP5tahbgQPG11UIHb+f4tSfCyGbj38AJEy1M3+s=; 
 b=Apt/dPtFJCwmS0CJpQhHcc4Qi6CoGI7zRK8vT0TIdDR5e6/fUbC9EZui4ktkxZIbUpHYEny8nxxfS06nr3q5A4fqkH6shWDnO+qIEvVgTSEDbPG2PXltbVOPyUSN0vhBm/oKK7+4/gtPhkBCgq6Q7BID3ugmC2MxhQUaGSXL2NfY7Y415sy/zWDzTHSq39VZnEYkTIpMpt4Nt4s+ySud73C46TpVyc1bQ53RV6EbFVD7J4uff3zJDTOtdgI+DX/d4t0AS4edPHRT0yhwyMgY7tkp+UL6dUmhvt1VQoJ5bcNPAxPuw4Iy89ZzTtWarfEJt74iyFjdFaD4Cu6NqMfhlg==;
Received: from [81.0.33.67] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kDsFO-0002En-TJ; Thu, 03 Sep 2020 18:38:02 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kDsFB-00082d-U7; Thu, 03 Sep 2020 18:37:49 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] qcow2: Fix removal of list members from
 BDRVQcow2State.cluster_allocs
Date: Thu,  3 Sep 2020 18:37:46 +0200
Message-Id: <cover.1599150873.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:38:03
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

Hi,

here are the changes from v1:

- Split changes into three different patches.
- Rewrite the documentation of qcow2_alloc_cluster_offset() [Max]
- Use peek_file_be in the test case to read the offset of the refcount
  table [Max].
- Extend the list of unsupported options for the test case [Max].

Berto

Alberto Garcia (3):
  qcow2: Fix removal of list members from BDRVQcow2State.cluster_allocs
  qcow2: Don't check nb_clusters when removing l2meta from the list
  qcow2: Rewrite the documentation of qcow2_alloc_cluster_offset()

 block/qcow2-cluster.c      | 27 +++++++-------
 block/qcow2.c              |  4 +--
 tests/qemu-iotests/305     | 74 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/305.out | 16 +++++++++
 tests/qemu-iotests/group   |  1 +
 5 files changed, 106 insertions(+), 16 deletions(-)
 create mode 100755 tests/qemu-iotests/305
 create mode 100644 tests/qemu-iotests/305.out

-- 
2.20.1


