Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA0EC2D0C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AEA222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AEA222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJI3-0001Am-R6
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iiIxq-0004WS-KW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iiIxp-00088H-7N
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:09:10 -0500
Received: from relay.sw.ru ([185.231.240.75]:58354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iiIxo-0007zL-T7
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:09:09 -0500
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iiIxl-0007UT-Rk; Fri, 20 Dec 2019 17:09:06 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/2] virtio: make seg_max virtqueue size dependent
Date: Fri, 20 Dec 2019 17:09:03 +0300
Message-Id: <20191220140905.1718-1-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com, mst@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v5:
  * rebased on the recent master [MST]
  * NOTE: the test doesn't pass because 5.0 machine type use 4.2 compat
          instead of it's own or no compat at all. The test will pass
          once the new 5.0 compat is used. 

v4:
  * rebased on 4.2 [MST]

v3:
  * add property to set in machine type [MST]
  * add min queue size check [Stefan]
  * add avocado based test [Max, Stefan, Eduardo, Cleber]

v2:
  * the standalone patch to make seg_max virtqueue size dependent
  * other patches are postponed

v1:
  the initial series

Denis Plotnikov (2):
  virtio: make seg_max virtqueue size dependent
  tests: add virtio-scsi and virtio-blk seg_max_adjust test

 hw/block/virtio-blk.c                     |   9 +-
 hw/core/machine.c                         |   3 +
 hw/scsi/vhost-scsi.c                      |   2 +
 hw/scsi/virtio-scsi.c                     |  10 +-
 include/hw/virtio/virtio-blk.h            |   1 +
 include/hw/virtio/virtio-scsi.h           |   1 +
 tests/acceptance/virtio_seg_max_adjust.py | 134 ++++++++++++++++++++++
 7 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100755 tests/acceptance/virtio_seg_max_adjust.py

-- 
2.17.0


