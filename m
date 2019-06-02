Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C05C28CC2
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C3227833
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C3227833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXHUL-00085Y-Mi
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 23:48:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hXHSo-0007Dv-Qq
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hXHSn-00039Z-QR
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:51833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hXHSn-00030z-Hz
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:47:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	01 Jun 2019 20:47:09 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
	by orsmga005.jf.intel.com with ESMTP; 01 Jun 2019 20:47:07 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Li Zhijian <lizhijian@cn.fujitsu.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Date: Sun,  2 Jun 2019 11:42:33 +0800
Message-Id: <20190602034239.23225-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.GIT
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: [Qemu-devel] [PATCH 0/6] Add Xen COLO support
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

Zhang Chen (6):
  COLO-compare: Add new parameter to communicate with remote colo-frame
  COLO-compare: Add remote notification chardev handler frame
  COLO-compare: Make the compare_chr_send() can send notification
    message.
  COLO-compare: Add colo-compare remote notify support
  COLO-compare: Rename the colo_compare_inconsistency_notify
  migration/colo.c: Add missed filter notify for Xen COLO.

 migration/colo.c   |   2 +
 net/colo-compare.c | 154 ++++++++++++++++++++++++++++++++++++++++-----
 qemu-options.hx    |  33 +++++++++-
 3 files changed, 174 insertions(+), 15 deletions(-)

-- 
2.17.GIT


