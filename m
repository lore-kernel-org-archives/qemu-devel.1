Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627C7C4727E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E1E2389F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E1E2389F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMWO3-000187-SR
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 09:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kMWMS-0007ql-IM
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:05:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60248 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kMWMQ-0003N1-Av
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:05:04 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 980EB216B337DA865F73;
 Sun, 27 Sep 2020 21:04:48 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sun, 27 Sep 2020
 21:04:38 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC PATCH 0/7] block-backend: Introduce I/O hang
Date: Sun, 27 Sep 2020 21:04:13 +0800
Message-ID: <20200927130420.1095-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 09:04:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, Ying Fang <fangying1@huawei.com>,
 zhang.zhanghailiang@huawei.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A VM in the cloud environment may use a virutal disk as the backend storage,
and there are usually filesystems on the virtual block device. When backend
storage is temporarily down, any I/O issued to the virtual block device will
cause an error. For example, an error occurred in ext4 filesystem would make
the filesystem readonly. However a cloud backend storage can be soon recovered.
For example, an IP-SAN may be down due to network failure and will be online
soon after network is recovered. The error in the filesystem may not be
recovered unless a device reattach or system restart. So an I/O rehandle is
in need to implement a self-healing mechanism.

This patch series propose a feature called I/O hang. It can rehandle AIOs
with EIO error without sending error back to guest. From guest's perspective
of view it is just like an IO is hanging and not returned. Guest can get
back running smoothly when I/O is recovred with this feature enabled.


Ying Fang (7):
  block-backend: introduce I/O rehandle info
  block-backend: rehandle block aios when EIO
  block-backend: add I/O hang timeout
  block-backend: add I/O hang drain when disbale
  virtio-blk: disable I/O hang when resetting
  qemu-option: add I/O hang timeout option
  qapi: add I/O hang and I/O hang timeout qapi event

 block/block-backend.c          | 285 +++++++++++++++++++++++++++++++++
 blockdev.c                     |  11 ++
 hw/block/virtio-blk.c          |   8 +
 include/sysemu/block-backend.h |   5 +
 qapi/block-core.json           |  26 +++
 5 files changed, 335 insertions(+)

-- 
2.23.0


