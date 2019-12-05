Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA4BC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8A62073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8A62073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ichux-0001Mj-4t
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 22:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ichsQ-0007Xk-1R
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ichsN-0005eu-Tk
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:32:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2274 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ichsF-0005Uh-JV; Wed, 04 Dec 2019 22:32:19 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0493CB509227C515E934;
 Thu,  5 Dec 2019 11:32:08 +0800 (CST)
Received: from HGHY2P002143101.china.huawei.com (10.184.39.213) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Dec 2019 11:31:58 +0800
From: <pannengyuan@huawei.com>
To: <eblake@redhat.com>, <kwolf@redhat.com>, <mreitz@redhat.com>
Subject: [PATCH v4 0/2] block/nbd: fix memory leak in nbd_open
Date: Thu, 5 Dec 2019 11:29:00 +0800
Message-ID: <1575516542-54640-1-git-send-email-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.7.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
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
Cc: liyiting@huawei.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

This series add a new function to do the common cleanups, and fix a memory
leak in nbd_open when nbd_client_connect returns error status.

---
Changes v2 to v1:
- add a new function to do the common cleanups (suggested by Stefano Garzarella).
---
Changes v3 to v2:
- split in two patches(suggested by Stefano Garzarella)
---
Changes v4 to v3:
- replace function name from nbd_free_bdrvstate_prop to nbd_clear_bdrvstate and add Fixes tag(suggested by Eric Blake).
- remove static function prototype. (suggested by Eric Blake)

Pan Nengyuan (2):
  block/nbd: extract the common cleanup code
  block/nbd: fix memory leak in nbd_open()

 block/nbd.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

-- 
2.7.2.windows.1



