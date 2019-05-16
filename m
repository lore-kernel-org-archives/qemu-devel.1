Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857F0C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFF520833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFF520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHOf-0005lZ-LH
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:30:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hRHMf-0004Xe-Kn
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hRHMd-0004In-FY
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:28:09 -0400
Received: from relay.sw.ru ([185.231.240.75]:39444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hRHMW-0003VS-4P; Thu, 16 May 2019 10:28:02 -0400
Received: from [172.16.25.154] (helo=xantnef-ws.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hRHMP-0007KE-Dw; Thu, 16 May 2019 17:27:53 +0300
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Thu, 16 May 2019 17:27:48 +0300
Message-Id: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v14 0/1] qcow2: cluster space preallocation
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
	den@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com,
	Anton Nefedov <anton.nefedov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

..apparently v13 ended up in a weird base64 that would not easily git-am.
Resending.

----

hi,

this used to be a large 10-patches series, but now thanks to Kevin's
BDRV_REQ_NO_FALLBACK series
(http://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg06389.html)
the core block layer functionality is already in place: the existing flag
can be reused.

A few accompanying patches were also dropped from the series as those can
be processed separately.

So,

new in v13:
   - patch 1 (was patch 9) rebased to use s->data_file pointer
   - comments fixed/added
   - other patches dropped ;)

v12: http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg02761.html
v11: http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg04342.html
v10: http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg00121.html

----

This pull request is to start to improve a few performance points of
qcow2 format:

  1. non cluster-aligned write requests (to unallocated clusters) explicitly
     pad data with zeroes if there is no backing data.
     Resulting increase in ops number and potential cluster fragmentation
     (on the host file) is already solved by:
       ee22a9d qcow2: Merge the writing of the COW regions with the guest data
     However, in case of zero COW regions, that can be avoided at all
     but the whole clusters are preallocated and zeroed in a single
     efficient write_zeroes() operation

  2. moreover, efficient write_zeroes() operation can be used to preallocate
     space megabytes (*configurable number) ahead which gives noticeable
     improvement on some storage types (e.g. distributed storage)
     where the space allocation operation might be expensive)
     (Not included in this patchset since v6).

  3. this will also allow to enable simultaneous writes to the same unallocated
     cluster after the space has been allocated & zeroed but before
     the first data is written and the cluster is linked to L2.
     (Not included in this patchset).

Efficient write_zeroes usually implies that the blocks are not actually
written to but only reserved and marked as zeroed by the storage.
Existing bdrv_write_zeroes() falls back to writing zero buffers if
write_zeroes is not supported by the driver, so BDRV_REQ_NO_FALLBACK is used.

simple perf test:

  qemu-img create -f qcow2 test.img 4G && \
  qemu-img bench -c $((1024*1024)) -f qcow2 -n -s 4k -t none -w test.img

test results (seconds):

    +-----------+-------+------+-------+------+------+
    |   file    |    before    |     after    | gain |
    +-----------+-------+------+-------+------+------+
    |    ssd    |      61.153  |      36.313  |  41% |
    |    hdd    |     112.676  |     122.056  |  -8% |
    +-----------+--------------+--------------+------+

Anton Nefedov (1):
  qcow2: skip writing zero buffers to empty COW areas

 qapi/block-core.json       |  4 +-
 block/qcow2.h              |  6 +++
 block/qcow2-cluster.c      |  2 +-
 block/qcow2.c              | 93 +++++++++++++++++++++++++++++++++++++-
 block/trace-events         |  1 +
 tests/qemu-iotests/060     |  7 ++-
 tests/qemu-iotests/060.out |  5 +-
 7 files changed, 112 insertions(+), 6 deletions(-)

-- 
2.17.1


