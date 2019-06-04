Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4ABC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B284520693
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B284520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54943 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCEn-0007bB-Nn
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:24:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6F-00016U-Ta
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYC6B-0005h4-B1
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:15:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:41664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC6A-0005C3-NU; Tue, 04 Jun 2019 12:15:43 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hYC5i-0005Pq-PQ; Tue, 04 Jun 2019 19:15:15 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  4 Jun 2019 19:15:02 +0300
Message-Id: <20190604161514.262241-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for io
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is new parameter qiov_offset for io path, to avoid
a lot of places with same pattern of creating local_qiov or hd_qiov
variables.

These series also includes my
"[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
with some changes [described in 01 and 03 emails]

Vladimir Sementsov-Ogievskiy (12):
  util/iov: introduce qemu_iovec_init_extended
  util/iov: improve qemu_iovec_is_zero
  block/io: refactor padding
  block: define .*_part io handlers in BlockDriver
  block/io: bdrv_co_do_copy_on_readv: use and support qiov_offset
  block/io: bdrv_co_do_copy_on_readv: lazy allocation
  block/io: bdrv_aligned_preadv: use and support qiov_offset
  block/io: bdrv_aligned_pwritev: use and support qiov_offset
  block/io: introduce bdrv_co_p{read,write}v_part
  block/qcow2: refactor qcow2_co_preadv to use buffer-based io
  block/qcow2: implement .bdrv_co_preadv_part
  block/qcow2: implement .bdrv_co_pwritev(_compressed)_part

 block/qcow2.h             |   1 +
 include/block/block_int.h |  21 ++
 include/qemu/iov.h        |  10 +-
 block/backup.c            |   2 +-
 block/io.c                | 532 ++++++++++++++++++++++----------------
 block/qcow2-cluster.c     |  14 +-
 block/qcow2.c             | 131 +++++-----
 qemu-img.c                |   4 +-
 util/iov.c                | 153 +++++++++--
 9 files changed, 559 insertions(+), 309 deletions(-)

-- 
2.18.0


