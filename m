Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918D2C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 10:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE1520835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 10:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE1520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGhWn-0003qT-59
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 06:10:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGhVX-00038L-Nl
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 06:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGhVW-0003ty-Ps
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 06:09:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:47104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hGhVW-0003su-Ey; Wed, 17 Apr 2019 06:09:34 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hGhVS-0005Kr-BN; Wed, 17 Apr 2019 13:09:30 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 17 Apr 2019 13:09:27 +0300
Message-Id: <20190417100929.39943-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH for-4.0? 0/2] Fix overflow bug in qcow2 discard
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	den@virtuozzo.com, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417100927.JCgVWC1d2tY3oKQm2V-olO7tSV6h6VFyqPDV02Fc5zI@z>

Hi all. We faced an interesting bug, which may be simply reproduced:

prepare image:
./qemu-img create -f qcow2 -o cluster_size=1M /ssd/test 2300M
./qemu-io -c 'write 100M 2000M' -c 'write 2100M 200M' -c 'write 0 100M' /ssd/test

shrink:
./qemu-img resize --shrink /ssd/test 50M

bug:
./qemu-img info /ssd/test
image: /ssd/test
file format: qcow2
virtual size: 50M (52428800 bytes)
disk size: 2.2G
cluster_size: 1048576
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

Virtual size is shrunk, but file - not. It is due to the fact,
that merged qcow2 discard may exceed 2G, and then converting from
uint64_t to int in qcow2_process_discards when we call bdrv_pdiscard
make wrong thing.

So, here are proposal of fix and new iotest for it.

Vladimir Sementsov-Ogievskiy (2):
  block/io: bdrv_pdiscard: support int64_t bytes parameter
  iotests: test big qcow2 shrink

 include/block/block.h      |  4 +--
 block/io.c                 | 19 ++++++-----
 tests/qemu-iotests/249     | 69 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out | 30 +++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 5 files changed, 112 insertions(+), 11 deletions(-)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

-- 
2.18.0


