Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3DDC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F9C2077D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 22:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="gV00BIK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F9C2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHb3U-0008H0-PU
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 18:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <7c4e49a783c7b2f77aa81794892cf08b4feba914@lizzy.crudebyte.com>)
 id 1jHb27-0007Qz-7v
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <7c4e49a783c7b2f77aa81794892cf08b4feba914@lizzy.crudebyte.com>)
 id 1jHb24-0008EO-6A
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:31:26 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:43865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <7c4e49a783c7b2f77aa81794892cf08b4feba914@lizzy.crudebyte.com>)
 id 1jHb23-0007ZW-Cq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 18:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=L/QR5W5mCD3gzycwHZOJ92NxoawC1fkiwvh5xdRxRBo=; b=gV00B
 IK9Iskkc9Z2kLJsEvTeqFW1vIeCnYHVGxfhvouh3mmtRzI3s/9pmz90Fuk4O48YylYvfB4CTUr7dw
 Hp+0T8D4MnlW2H4/nDBGOr3JTYsm0e1M6mGbloc/UkHrxYAC4odw467Yecher0uXBt/GT6QHUPdj0
 QazoULBf7726mgLaOAjMz4RNFJn8nuFC1k7wbfUJnqd5vfTyQazSnbxtp7wVpwaxEowJrD7lXRRYd
 /QVkJfX/vtdGns2Yn1CF3So1zD1BjLM50ZV+ROlMdiQYtEguivPHJm6usuVZYtV+NoXv1XYGqjoAp
 mybqb/GhRVtN5kHUbIWX+31V/Eg+Q==;
Message-Id: <cover.1585258105.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 26 Mar 2020 22:28:25 +0100
Subject: [PATCH v5 0/6] 9pfs: readdir optimization
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
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

v4->v5:

  * Rebased to master (SHA-1 762fa6d7).

  * Dropped benchmark patches (see v4 if you want to run a benchmark on v5).

  * Divided split-readdir test into 3 individual tests, which also fixes the
    previously discussed transport error [patch 1].

  * Fixed English spelling for 'split' [patch 1].

  * Rename max_count -> maxsize [NEW patch 2].

  * Divided previous huge readdir optimization patch into individual patches
    [patch 3], [patch 4], [patch 5].

  * Added comment on v9fs_readdir_response_size() [patch 3].

  * Renamed v9fs_co_readdir_lowlat() -> v9fs_co_readdir_many() [patch 4].

  * Adjusted comment on v9fs_co_readdir_many() [patch 4].

  * Added comment on v9fs_co_run_in_worker() [NEW patch 6].

  * Adjusted commit log message of several patches.

Message-ID of previous version (v4):
  cover.1579567019.git.qemu_oss@crudebyte.com

Christian Schoenebeck (6):
  tests/virtio-9p: added split readdir tests
  9pfs readdir: rename max_count -> maxsize
  9pfs: make v9fs_readdir_response_size() public
  9pfs: add new function v9fs_co_readdir_many()
  9pfs: T_readdir latency optimization
  9pfs: clarify latency of v9fs_co_run_in_worker()

 hw/9pfs/9p.c                 | 148 ++++++++++++++--------------
 hw/9pfs/9p.h                 |  23 +++++
 hw/9pfs/codir.c              | 181 ++++++++++++++++++++++++++++++++---
 hw/9pfs/coth.h               |  15 ++-
 tests/qtest/virtio-9p-test.c | 108 +++++++++++++++++++++
 5 files changed, 386 insertions(+), 89 deletions(-)

-- 
2.20.1


