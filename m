Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04AAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9139206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="JdQ7rtt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9139206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0iis-0002hW-WA
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 05:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4d34d332e1aaa8a2cf8dc0b5da4fd7727f2a86e8@lizzy.crudebyte.com>)
 id 1k0ii7-0002IB-I5
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 05:49:19 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:53711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4d34d332e1aaa8a2cf8dc0b5da4fd7727f2a86e8@lizzy.crudebyte.com>)
 id 1k0ii5-000516-ST
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 05:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=qEwUnDHqEMQligmbTgkhNNF2r5wSKiMhdEz/8LydTcY=; b=JdQ7r
 tt7dm8wb0yncONfrBdq7nph+TsIdhirPll2Pr/hUvafEg5V+rdwl6BXx2In16BbLwKzvljiyb+Dyg
 O2yz3NCEjn3PRsFt0GMuL36Ok6zo1OiLpKh4lJsW0sQl46cdGfoH1ivpMVg4OBVziWaGD3FKtTtgz
 +pOu3Tx2kjFVb4FvaZWO3EJw95eDrAD05SC2T4+GIYRjizghmnK5WAGcz22Y20DoN6VwzkgPOiuoS
 nQ2G6O5v3GS5MYSW/dLIjUnMwAMrOizVjMBxQr0to1JZ64I03gNf5vjB4i1N9uDAvKgSBNVUo/+mw
 z5QD+LoKv2F7FgRMIm/UftzvRipzw==;
Message-Id: <cover.1596012787.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 29 Jul 2020 10:53:07 +0200
Subject: [PATCH v8 0/7] 9pfs: readdir optimization
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=4d34d332e1aaa8a2cf8dc0b5da4fd7727f2a86e8@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 05:20:03
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
T_readdir request handling. The actual performance optimization is patch 5.

v7->v8:

  * Split previous patch 3 into two patches [patch 3], [patch 4].

  * Error out if a 9p2000.u client sends a Treaddir request, likewise error
    out if a 9p2000.L client sends a Tread request on a directory [patch 6].

Unchanged patches: [patch 1], [patch 2], [patch 5], [patch 7].

Message-ID of previous version (v7):
  cover.1595166227.git.qemu_oss@crudebyte.com

Message-ID of version with performance benchmark (v4):
  cover.1579567019.git.qemu_oss@crudebyte.com

Christian Schoenebeck (7):
  tests/virtio-9p: added split readdir tests
  9pfs: make v9fs_readdir_response_size() public
  9pfs: split out fs driver core of v9fs_co_readdir()
  9pfs: add new function v9fs_co_readdir_many()
  9pfs: T_readdir latency optimization
  9pfs: differentiate readdir lock between 9P2000.u vs. 9P2000.L
  9pfs: clarify latency of v9fs_co_run_in_worker()

 hw/9pfs/9p.c                 | 159 ++++++++++++++--------------
 hw/9pfs/9p.h                 |  50 ++++++++-
 hw/9pfs/codir.c              | 196 +++++++++++++++++++++++++++++++++--
 hw/9pfs/coth.h               |  15 ++-
 tests/qtest/virtio-9p-test.c | 108 +++++++++++++++++++
 5 files changed, 434 insertions(+), 94 deletions(-)

-- 
2.20.1


