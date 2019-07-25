Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C56C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB319206B8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB319206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqadl-0006gD-Np
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49305)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqadN-0005WI-RY
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqadJ-0006Q7-Mc
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:05:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:45728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqadI-0006O3-89; Thu, 25 Jul 2019 06:05:57 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqadC-0001mQ-Om; Thu, 25 Jul 2019 13:05:50 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 13:05:47 +0300
Message-Id: <20190725100550.33801-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 for-4.2 0/3] block: BDRV_REQ_PREFETCH
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here is small new read flag: BDRV_REQ_PREFETCH, which in combination with
BDRV_REQ_COPY_ON_READ does copy-on-read without
extra buffer for read data. This means that only parts that needs COR
will be actually read and only corresponding buffers allocated, no more.

This allows to improve a bit block-stream and NBD_CMD_CACHE

v3: rebase 02 on master, fix commit message of 03.

v2: change interface to be just one flag BDRV_REQ_PREFETCH

v1 was "[PATCH 0/3] block: blk_co_pcache"
   https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01047.html

Vladimir Sementsov-Ogievskiy (3):
  block: implement BDRV_REQ_PREFETCH
  block/stream: use BDRV_REQ_PREFETCH
  nbd: improve CMD_CACHE: use BDRV_REQ_PREFETCH

 include/block/block.h |  8 +++++++-
 block/io.c            | 18 ++++++++++++------
 block/stream.c        | 20 +++++++-------------
 nbd/server.c          | 43 +++++++++++++++++++++++++++++++++++--------
 4 files changed, 61 insertions(+), 28 deletions(-)

-- 
2.18.0


