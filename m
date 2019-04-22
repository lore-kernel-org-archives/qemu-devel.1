Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2DAC282CE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF6A20693
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 15:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF6A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIaQr-00020o-82
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 11:00:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP5-0000nm-Ms
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-00037z-KZ
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:55308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIaP4-00036Q-B0; Mon, 22 Apr 2019 10:58:42 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hIaP1-0003k3-0b; Mon, 22 Apr 2019 17:58:39 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 22 Apr 2019 17:58:29 +0300
Message-Id: <20190422145838.70903-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 0/9] block: buffer-based io
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
	stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422145829.l-tNsJhzSgS92n2gPAcmPTILi7JDi4fTnFqU1yOH10Q@z>

Hi all!

We often need to do read/write with buffer, not qiov. Instead of
creating qiov in such cases, let's introduce corresponding helpers.

Vladimir Sementsov-Ogievskiy (9):
  block: introduce byte-based io helpers
  block/qcow2: use buffer-based io
  block/qcow: use buffer-based io
  block/qed: use buffer-based io
  block/parallels: use buffer-based io
  block/backup: use buffer-based io
  block/commit: use buffer-based io
  block/stream: use buffer-based io
  qemu-img: use buffer-based io

 include/block/block_int.h      | 16 ++++++++++++++++
 include/sysemu/block-backend.h | 19 +++++++++++++++++++
 block/backup.c                 | 14 ++++++--------
 block/commit.c                 |  5 ++---
 block/parallels.c              | 14 ++++++--------
 block/qcow.c                   | 19 ++++++-------------
 block/qcow2.c                  |  9 ++-------
 block/qed-table.c              | 12 +++++-------
 block/qed.c                    |  6 ++----
 block/stream.c                 |  4 +---
 qemu-img.c                     | 13 ++++---------
 11 files changed, 69 insertions(+), 62 deletions(-)

-- 
2.18.0


