Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7929BC33CAF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B2C20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 00:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ZABXNHTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B2C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irALF-0006xo-DM
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 19:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <d06e6257e5bce83c393df183514e61a380366f3a@lizzy.crudebyte.com>)
 id 1irAJS-0005PV-2Q
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <d06e6257e5bce83c393df183514e61a380366f3a@lizzy.crudebyte.com>)
 id 1irAJQ-0007MP-Sn
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:44:06 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:60919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <d06e6257e5bce83c393df183514e61a380366f3a@lizzy.crudebyte.com>)
 id 1irAJQ-0006mq-Ev
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 19:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=ZLIg8qwPtvXqEoy63HIHnfcQg889Yoc5UG7KUqwxvXk=; b=ZABXN
 HTRNcwa8futntB4df8n6jhQoH7qkbvuLTIGgRysyoCdjyMla7yIlV5k9tA5L8zNqNSNuUf0W2J4hq
 XVBav3Gy84/pcG6GaGtj7vUB83fjDrMWuw9dv2I1qoOCUH2wNA2B/scIUsgj2d2/4nMpIxvI8dCt2
 u/OvHIdRNzTfiU38y/LcYsJgd5KUt1/b+w6Z9mcrJtKFqRvfnC9xLhocqcKasM7yQ9IagONng4Erd
 MB7xmnwGT342VmiKUYffraJ/X1Wgnv9++ySuCVbOj4NtBrq+7Dzs+As3y2p8FRNpylo15SoR89Ouv
 cT7kMyO6lVAfOnZyBx4jjIfSF2qMQ==;
Message-Id: <cover.1578957500.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 14 Jan 2020 00:18:20 +0100
Subject: [PATCH v3 00/11] 9pfs: readdir optimization
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
T_readdir request handling. The actual performance fix is patch 10. I also
provided a convenient benchmark for comparing the performance improvements
by using the 9pfs "synth" driver (see patch 8 for instructions how to run
the benchmark), so no guest OS installation is required to peform this
benchmark A/B comparison. With patch 10 I achieved a performance improvement
of factor 40 on my test machine.

** NOTE: ** As outlined by patch 7 there seems to be an outstanding issue
(both with current, unoptimized readdir code, as well as with new, optimized
readdir code) causing a transport error with splitted readdir requests. This
issue only occurs if patch 7 is applied. I haven't investigated the cause of
this issue yet, it looks like a memory issue though. I am not sure if it is a
problem with the actual 9p server or rather "just" with the test environment.
Apart from that issue, the actual splitted readdir seems to work well with the
new performance optimized readdir code as well though.

v2->v3:

  * NEW patch: require msize >= 4096 [patch 2].

  * Shortened commit log message [patch 3]
    (since previously mentioned issue now addressed by new patch 2).

  * Merged previous 2 test case patches into one -> [patch 5]
    (since trivial enough for one patch).

  * Fixed code style issue [patch 5].

  * Fixed memory leak in test case [patch 5]
    (missing v9fs_req_free() in v9fs_rreaddir()).

  * NEW patch: added splitted readdir test [patch 6].

  * NEW patch: Failing splitted readdir issue [patch 7]
    (see issue description above).

  * Adjusted commit log message [patch 9]
    (that this patch would break the new splitted readdir test).

  * Fixed comment in code [patch 10].

Christian Schoenebeck (11):
  tests/virtio-9p: add terminating null in v9fs_string_read()
  9pfs: require msize >= 4096
  9pfs: validate count sent by client with T_readdir
  hw/9pfs/9p-synth: added directory for readdir test
  tests/virtio-9p: added readdir test
  tests/virtio-9p: added splitted readdir test
  tests/virtio-9p: failing splitted readdir test
  9pfs: readdir benchmark
  hw/9pfs/9p-synth: avoid n-square issue in synth_readdir()
  9pfs: T_readdir latency optimization
  hw/9pfs/9p.c: benchmark time on T_readdir request

 hw/9pfs/9p-synth.c     |  48 ++++++-
 hw/9pfs/9p-synth.h     |   5 +
 hw/9pfs/9p.c           | 163 +++++++++++++----------
 hw/9pfs/9p.h           |  34 +++++
 hw/9pfs/codir.c        | 183 ++++++++++++++++++++++++--
 hw/9pfs/coth.h         |   3 +
 tests/virtio-9p-test.c | 287 ++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 640 insertions(+), 83 deletions(-)

-- 
2.20.1


