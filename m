Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B1C32771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A0222522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="QtSr8FXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A0222522
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itiV8-0002A3-7k
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 20:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <b6fef929757d4ea1d7ce6a0044563bb3ff68c92c@lizzy.crudebyte.com>)
 id 1itiTW-00011N-Qy
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <b6fef929757d4ea1d7ce6a0044563bb3ff68c92c@lizzy.crudebyte.com>)
 id 1itiTU-0002cV-WF
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:37:02 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:48695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <b6fef929757d4ea1d7ce6a0044563bb3ff68c92c@lizzy.crudebyte.com>)
 id 1itiTT-0002BI-LP
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=WrhlfVtHn07yiWC2NIXKbdcy1lsUFOnb97ObVbwxOqE=; b=QtSr8
 FXiy1nrog+lJFP3X8nhlegSjoJCEzOUwwiURKnaA4izlWaqEuGvZyzd1291IWC7V5nejCQ+J6Va58
 wvjDzKDOlnVXF8YMOAMdmJSx67aD3ECGno2ttKhSBAyij+Sc+QXxuJgA3AHVAr8IkSNFrY7dms544
 oBuoVIUZSUPMNnH5qS2JI5CT/mWCxBTaBhIMmAMfX/hJkFU5hvJkmRJfPKMh2wcRQaMzr/dgNQETZ
 GhBBG2hQTO0MaBZuaWCuhV+Ckbptq1eZrqgKiuPNE7x2s2Y2kFxbqzogd9tUPdnRI10rGAr2srlMU
 l0cvA6ciXeI5xlM23Z8dIRB7HUqrg==;
Message-Id: <cover.1579567019.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 21 Jan 2020 01:36:59 +0100
Subject: [PATCH v4 00/11] 9pfs: readdir optimization
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

v3->v4:

  * Rebased to master (SHA-1 43d1455c).

  * Adjusted commit log message [patch 2], [patch 3], [patch 8].

  * Fixed using Rreaddir header size of 11 (instead of P9_IOHDRSZ) for
    limiting 'count' parameter of Treaddir [patch 3], [patch 5].

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

 hw/9pfs/9p-synth.c           |  48 +++++-
 hw/9pfs/9p-synth.h           |   5 +
 hw/9pfs/9p.c                 | 163 ++++++++++++--------
 hw/9pfs/9p.h                 |  34 ++++
 hw/9pfs/codir.c              | 183 ++++++++++++++++++++--
 hw/9pfs/coth.h               |   3 +
 tests/qtest/virtio-9p-test.c | 290 ++++++++++++++++++++++++++++++++++-
 7 files changed, 643 insertions(+), 83 deletions(-)

-- 
2.20.1


