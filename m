Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64432C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7B8206EB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 03:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7B8206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzAQU-0003p0-F6
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 23:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPS-00024S-T7
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33218 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1jzAPQ-0000k9-M3
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 22:59:38 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3B12DB09D2747DC3467B;
 Sat, 25 Jul 2020 10:59:28 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 10:59:20 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 0/8] *** A Method for evaluating dirty page rate ***
Date: Sat, 25 Jul 2020 11:11:01 +0800
Message-ID: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 22:59:28
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
Cc: zhang.zhanghailiang@huawei.com, linyilu@huawei.com, qemu-devel@nongnu.org,
 alex.chen@huawei.com, ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zheng Chuan <zhengchuan@huawei.com>

Sometimes it is neccessary to evaluate dirty page rate before migration.
Users could decide whether to proceed migration based on the evaluation
in case of vm performance loss due to heavy workload.
Unlikey simulating dirtylog sync which could do harm on runnning vm,
we provide a sample-hash method to compare hash results for samping page.
In this way, it would have hardly no impact on vm performance.

We evaluate the dirtypage rate on running vm.
The VM specifications for migration are as follows:
- VM use 4-K page;
- the number of VCPU is 32;
- the total memory is 32Gigabit;
- use 'mempress' tool to pressurize VM(mempress 4096 1024);

++++++++++++++++++++++++++++++++++++++++++
|                      |    dirtyrate    |
++++++++++++++++++++++++++++++++++++++++++
| no mempress          |     4MB/s       |
------------------------------------------
| mempress 4096 1024   |    1204MB/s     |
++++++++++++++++++++++++++++++++++++++++++
| mempress 4096 4096   |    4000Mb/s     |
++++++++++++++++++++++++++++++++++++++++++

Test dirtyrate by qmp command like this:
1.  virsh qemu-monitor-command [vmname] '{"execute":"cal_dirty_rate", "arguments": {"value": [sampletime]}}'
2.  virsh qemu-monitor-command [vmname] '{"execute":"get_dirty_rate"}'

Further test dirtyrate by libvirt api like this:
virsh getdirtyrate [vmname] [sampletime]

Zheng Chuan (8):
  migration/dirtyrate: Add get_dirtyrate_thread() function
  migration/dirtyrate: Add block_dirty_info to store dirtypage info
  migration/dirtyrate: Add dirtyrate statistics series functions
  migration/dirtyrate: Record hash results for each ramblock
  migration/dirtyrate: Compare hash results for recorded ramblock
  migration/dirtyrate: Implement get_sample_gap_period() and
    block_sample_gap_period()
  migration/dirtyrate: Implement calculate_dirtyrate() function
  migration/dirtyrate: Implement
    qmp_cal_dirty_rate()/qmp_get_dirty_rate() function

 migration/Makefile.objs |   1 +
 migration/dirtyrate.c   | 424 ++++++++++++++++++++++++++++++++++++++++++++++++
 migration/dirtyrate.h   |  67 ++++++++
 qapi/migration.json     |  24 +++
 qapi/pragma.json        |   3 +-
 5 files changed, 518 insertions(+), 1 deletion(-)
 create mode 100644 migration/dirtyrate.c
 create mode 100644 migration/dirtyrate.h

-- 
1.8.3.1


