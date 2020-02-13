Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929EEC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F8C21739
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F8C21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j23Ju-0007qE-H0
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 20:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j23It-0006Uo-81
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j23Is-0004HJ-Ag
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:28:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2761 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j23Ip-0003qA-Qr; Wed, 12 Feb 2020 20:28:28 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DD9E7CEBD0AD588AB3EA;
 Thu, 13 Feb 2020 09:28:20 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 09:28:14 +0800
From: <pannengyuan@huawei.com>
To: <mst@redhat.com>, <kwolf@redhat.com>, <mreitz@redhat.com>
Subject: [PATCH 0/2] delete virtio queues in vhost-user-blk-unrealize
Date: Thu, 13 Feb 2020 09:28:05 +0800
Message-ID: <20200213012807.45552-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

This series patch fix memleaks when detaching vhost-user-blk device.
1. use old virtio_del_queue to fix memleaks, it's easier for stable branc=
hes to merge.
   As the discussion in https://lists.nongnu.org/archive/html/qemu-devel/=
2020-01/msg02903.html

2. convert virtio_del_queue to the new one(virtio_delete_queue).

Pan Nengyuan (2):
  vhost-user-blk: delete virtioqueues in unrealize to fix memleaks
  vhost-use-blk: convert to new virtio_delete_queue

 hw/block/vhost-user-blk.c          | 15 +++++++++++++--
 include/hw/virtio/vhost-user-blk.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

--=20
2.21.0.windows.1



