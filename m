Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9430C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B182075A
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B182075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1RI-0002ZL-T8
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1ji1Pr-0000cR-Bp
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:57:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:14935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1ji1Pp-0006UC-If
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:57:10 -0400
IronPort-SDR: rPU9y5NXlnZCw0rEdSqdCsQnDNsH9hIOvQsVtVZCWWbp14eGRCh346egbyW8MqaNhjCvnTCoAS
 nYs3E7j7kvRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2020 12:57:07 -0700
IronPort-SDR: +ascfTKsMeK+uEI5JKfBkgoB0QH5AnoblQh0u+iidQSRfGROoSnlVL2hJYWf6p5dTPyxGX7Xzj
 StD0Y149nnog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,485,1583222400"; d="scan'208";a="446509251"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga005.jf.intel.com with ESMTP; 07 Jun 2020 12:57:05 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
Date: Mon,  8 Jun 2020 03:46:08 +0800
Message-Id: <20200607194611.24763-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chen.zhang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 15:57:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.999,
 FROM_WSP_TRAIL=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

This series optimize some code of COLO, please review.

Zhang Chen (3):
  migration/colo: Optimize COLO boot code path
  migration/colo: Update checkpoint time lately
  migration/migration.c: Remove MIGRATION_STATUS_ACTIVE in
    migration_iteration_finish

 migration/colo.c      |  7 ++-----
 migration/migration.c | 12 +++++-------
 2 files changed, 7 insertions(+), 12 deletions(-)

-- 
2.17.1


