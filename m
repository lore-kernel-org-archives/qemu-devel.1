Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98CBC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 14:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830562080D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 14:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="meTzvAwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830562080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxAVy-0005Rm-Rb
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 10:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cb67ffe2c8e5bddc31511d62a859cebfda0b7feb@lizzy.crudebyte.com>)
 id 1jxAVM-0004wc-Mh
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 10:41:28 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:35909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cb67ffe2c8e5bddc31511d62a859cebfda0b7feb@lizzy.crudebyte.com>)
 id 1jxAVI-0005OK-EK
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 10:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=qUnVgMmJwCCmefD8hN6aBd1Wz6oGOT8goAe+C5cdzkw=; b=meTzv
 AwDU43nLnONwBGZwQ8njJqAaaGTzMnJG2mWK2DaQzH7TLeql6RtrLvBlgBW++5ZhBt5q7FJNdlKKq
 T+ILpAGJynspmI2EomNuH2LspQX2ElUyIZDTOwdsoIhzKt8QmAzKy6YsRlkm0Q+yiVaCeSBWKQgym
 JU4R1qanWru5oez3x2yS3hdvTr4VGYBTXZEbPZ1mj4jGEaVqefojzMEjBco5gm4uCrtB/EPrBr/28
 UKc6g8sKEaakcYndDOt5xJIUroPHd75gFz8L4NTpc3qd5n2NiL7IdsecrnMtO4zESn46L/GWaMMEr
 TeCk1KYpcZbzzYmYSMOv4m4Uzhr2A==;
Message-Id: <cover.1595166227.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 19 Jul 2020 15:43:47 +0200
Subject: [PATCH v7 0/6] 9pfs: readdir optimization
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=cb67ffe2c8e5bddc31511d62a859cebfda0b7feb@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 10:12:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As previously mentioned, I was investigating performance issues with 9pfs.
Raw file read/write of 9pfs is actually quite good, provided that client
picked a reasonable high msize (maximum message size). I would recommend
to log a warning on 9p server side if a client attached with a small msize
that would cause performance issues for that reason.

However there are other aspects where 9pfs currently performs suboptimally,
especially readdir handling of 9pfs is extremely slow, a simple readdir
request of a guest typically blocks for several hundred milliseconds or
even several seconds, no matter how powerful the underlying hardware is.
The reason for this performance issue: latency.
Currently 9pfs is heavily dispatching a T_readdir request numerous times
between main I/O thread and a background I/O thread back and forth; in fact
it is actually hopping between threads even multiple times for every single
directory entry during T_readdir request handling which leads in total to
huge latencies for a single T_readdir request.

This patch series aims to address this severe performance issue of 9pfs
T_readdir request handling. The actual performance optimization is patch 4.

v6->v7:

  * Rebased to master: SHA-1 b442119329

  * Handle directory seeking more consistently by doing it in
    do_readdir_many() instead of in v9fs_readdir() [patch 3], [patch 4].

  * Updated API doc on v9fs_co_readdir_many(): make it clear that
    v9fs_free_dirents() must always be called, including error cases
    [patch 3].

  * New patch: use different lock type for 9p2000.u vs. 9p2000.L
    [patch 5].

Unchanged patches: [patch 1], [patch 2], [patch 6].

Message-ID of previous version (v6):
  cover.1587309014.git.qemu_oss@crudebyte.com

Message-ID of version with performance benchmark (v4):
  cover.1579567019.git.qemu_oss@crudebyte.com

Christian Schoenebeck (6):
  tests/virtio-9p: added split readdir tests
  9pfs: make v9fs_readdir_response_size() public
  9pfs: add new function v9fs_co_readdir_many()
  9pfs: T_readdir latency optimization
  9pfs: differentiate readdir lock between 9P2000.u vs. 9P2000.L
  9pfs: clarify latency of v9fs_co_run_in_worker()

 hw/9pfs/9p.c                 | 144 ++++++++++++-------------
 hw/9pfs/9p.h                 |  50 ++++++++-
 hw/9pfs/codir.c              | 196 +++++++++++++++++++++++++++++++++--
 hw/9pfs/coth.h               |  15 ++-
 tests/qtest/virtio-9p-test.c | 108 +++++++++++++++++++
 5 files changed, 419 insertions(+), 94 deletions(-)

-- 
2.20.1


