Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBB4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FDB2087D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FDB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7VX2-0007zZ-Sb
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 23:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k7VW9-0006Bo-MI
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:09:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4195 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k7VW7-0008IV-GK
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:09:01 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E2E631EA2BCB6CCBDFA9;
 Mon, 17 Aug 2020 11:08:48 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 17 Aug 2020
 11:08:42 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <eblake@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v3 00/10] *** A Method for evaluating dirty page rate ***
Date: Mon, 17 Aug 2020 11:20:23 +0800
Message-ID: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/16 23:08:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

v2 -> v3:
    fix size_t compile warning
    fix codestyle checked by checkpatch.pl

v1 -> v2:
    use g_rand_new() to generate rand_buf
    move RAMBLOCK_FOREACH_MIGRATABLE into migration/ram.h
    add skip_sample_ramblock to filter sampled ramblock
    fix multi-numa vm coredump when query dirtyrate
    rename qapi interface and rename some structures and functions
    succeed to compile by appling each patch
    add test for migrating vm

Sometimes it is neccessary to evaluate dirty page rate before migration.
Users could decide whether to proceed migration based on the evaluation
in case of vm performance loss due to heavy workload.
Unlikey simulating dirtylog sync which could do harm on runnning vm,
we provide a sample-hash method to compare hash results for samping page.
In this way, it would have hardly no impact on vm performance.

Evaluate the dirtypage rate both on running and migration vm.
The VM specifications for migration are as follows:
- VM use 4-K page;
- the number of VCPU is 32;
- the total memory is 32Gigabit;
- use 'mempress' tool to pressurize VM(mempress 4096 1024);
- migration bandwidth is 1GB/s

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
|                      |  running  |                  migrating                    |
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
| no mempress          |   4MB/s   |          8MB/s      (migrated success)        |
------------------------------------------------------------------------------------
| mempress 4096 1024   |  1188MB/s |   536MB/s ~ 1044MB/s (cpu throttle triggered) |
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
| mempress 4096 4096   |  4152MB/s |     608MB/s ~ 4125MB/s (migation failed)      |
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Test dirtyrate by qmp command like this:
1.  virsh qemu-monitor-command [vmname] '{"execute":"calc-dirty-rate", "arguments": {"calc-time": [sleep-time]}}'; 
2.  sleep specific time which is a bit larger than sleep-time
3.  virsh qemu-monitor-command [vmname] '{"execute":"query-dirty-rate"}'

Further test dirtyrate by libvirt api like this:
virsh getdirtyrate [vmname] [sleep-time]

Zheng Chuan (10):
  migration/dirtyrate: Add get_dirtyrate_thread() function
  migration/dirtyrate: Add RamlockDirtyInfo to store sampled page info
  migration/dirtyrate: Add dirtyrate statistics series functions
  migration/dirtyrate: move RAMBLOCK_FOREACH_MIGRATABLE into ram.h
  migration/dirtyrate: Record hash results for each sampled page
  migration/dirtyrate: Compare page hash results for recorded sampled
    page
  migration/dirtyrate: skip sampling ramblock with size below
    MIN_RAMBLOCK_SIZE
  migration/dirtyrate: Implement get_sample_page_period() and
    block_sample_page_period()
  migration/dirtyrate: Implement calculate_dirtyrate() function
  migration/dirtyrate: Implement
    qmp_cal_dirty_rate()/qmp_get_dirty_rate() function

 migration/Makefile.objs |   1 +
 migration/dirtyrate.c   | 448 ++++++++++++++++++++++++++++++++++++++++++++++++
 migration/dirtyrate.h   |  86 ++++++++++
 migration/ram.c         |  11 +-
 migration/ram.h         |  10 ++
 qapi/migration.json     |  42 +++++
 6 files changed, 588 insertions(+), 10 deletions(-)
 create mode 100644 migration/dirtyrate.c
 create mode 100644 migration/dirtyrate.h

-- 
1.8.3.1


