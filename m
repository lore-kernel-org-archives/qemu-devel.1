Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA7BC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE58D21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE58D21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Uqm-0001R1-42
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 02:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j6Upd-0008N7-Ai
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j6Upc-0003ae-6B
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44816 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j6Upb-0003TJ-Re
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:40:40 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 751F5F81ADB0D0C0EC29;
 Tue, 25 Feb 2020 15:40:31 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Feb 2020 15:40:23 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <mst@redhat.com>
Subject: [PATCH 0/4] virtio: fix some virtio-queue leaks.
Date: Tue, 25 Feb 2020 15:55:50 +0800
Message-ID: <20200225075554.10835-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: euler.robot@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to other virtio device(https://patchwork.kernel.org/patch/11399237/), we aslo found some virtio-queue leaks in unrealize().
This series do the cleanup in unrealize to fix it.

Pan Nengyuan (4):
  vhost-user-fs: do delete virtio_queues in unrealize
  vhost-user-fs: convert to the new virtio_delete_queue function
  virtio-pmem: do delete rq_vq in virtio_pmem_unrealize
  virtio-crypto: do delete ctrl_vq in virtio_crypto_device_unrealize

 hw/virtio/vhost-user-fs.c         | 16 ++++++++++++++--
 hw/virtio/virtio-crypto.c         |  3 ++-
 hw/virtio/virtio-pmem.c           |  1 +
 include/hw/virtio/vhost-user-fs.h |  2 ++
 4 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.18.2


