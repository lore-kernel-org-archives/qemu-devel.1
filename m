Return-Path: <SRS0=Ju6v=UI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72898C468BE
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 16:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1C420868
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 16:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1C420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37058 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha12A-0002MM-3N
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 12:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56501)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1ha10R-0000QD-LH
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 12:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1ha10Q-0007Fr-Mg
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 12:49:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:62029)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1ha10Q-0007BK-F1
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 12:49:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jun 2019 09:49:09 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga005.jf.intel.com with ESMTP; 09 Jun 2019 09:49:07 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Li Zhijian <lizhijian@cn.fujitsu.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 10 Jun 2019 00:44:28 +0800
Message-Id: <20190609164433.5866-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.GIT
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH V2 0/5] Add Xen COLO support
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

Xen COLO based on KVM COLO architecture, it shared COLO proxy and block
replication with KVM COLO. The only differece is Xen COLO have own
COLO-frame to handle live migration related function, so we need this
series make Xen COLO frame can communicate with other COLO modules in
qemu. Xen side related patches have been merged.

V2:
 - Rebase on upstream code.
 - Optimize code by Zhijian's comments in patch 4/5.
 - Remove origin 5/6 patch.

V1:
 - Initial patch.

Zhang Chen (5):
  COLO-compare: Add new parameter to communicate with remote colo-frame
  COLO-compare: Add remote notification chardev handler frame
  COLO-compare: Make the compare_chr_send() can send notification
    message.
  COLO-compare: Add colo-compare remote notify support
  migration/colo.c: Add missed filter notify for Xen COLO.

 migration/colo.c   |   2 +
 net/colo-compare.c | 155 +++++++++++++++++++++++++++++++++++++++------
 qemu-options.hx    |  33 +++++++++-
 3 files changed, 171 insertions(+), 19 deletions(-)

-- 
2.17.GIT


