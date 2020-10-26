Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F655C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6F721BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6F721BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2o7-0006MN-Kb
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kX2mM-00043t-En
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:43:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kX2mJ-0000Jo-0J
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:43:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CKbd22ZnYz15M3t;
 Mon, 26 Oct 2020 21:43:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 26 Oct 2020
 21:42:48 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v1 0/4] migration/debug: Add migration ram consistency check
Date: Mon, 26 Oct 2020 21:58:41 +0800
Message-ID: <1603720725-81206-1-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 07:55:44
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: yubihong@huawei.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes we want to debug whether the ramblock we migrate is same between Src and Dst.
For example, we could want to check ram when develop something related to dirty log sync.
Consistency check is implemented in this series, it will sha256sum all migratable
ramblock and print both in Src and Dst.

Check results are shown as follow:
Src:
CheckPoint: migrate_fd_cleanup, Ramblock: mach-virt.ram, CheckValue: 4422e2e8f26835f32ee3a9f13e1df2772d48f973a58381f6a549ebbcfe485b72
CheckPoint: migrate_fd_cleanup, Ramblock: virt.flash0, CheckValue: d5584b740ffcf81df8123ebc833793a71a03d47c1bb5a97170d05d18665c8b2e
CheckPoint: migrate_fd_cleanup, Ramblock: virt.flash1, CheckValue: 1d6c818dfa81a88ca5b7b1da231a9ba57f4f87677c6ba8e76196195b5aa05f0c
CheckPoint: migrate_fd_cleanup, Ramblock: /rom@etc/acpi/tables, CheckValue: db4c25623cb0192a70b56b5700e304e87c46f3016bc4b43b458a831b93d1cd54
CheckPoint: migrate_fd_cleanup, Ramblock: /rom@etc/table-loader, CheckValue: b3e0b1026cd4df920884f7d090b90cfb64b4a3ab407feeb632300aabd9fb28fe
CheckPoint: migrate_fd_cleanup, Ramblock: /rom@etc/acpi/rsdp, CheckValue: 7af8a2bc8c5f78db788a47ed60b30bffee50f28783529ee55224f9e3613cc28a

Dst:
CheckPoint: qemu_loadvm_state, Ramblock: mach-virt.ram, CheckValue: 4422e2e8f26835f32ee3a9f13e1df2772d48f973a58381f6a549ebbcfe485b72
CheckPoint: qemu_loadvm_state, Ramblock: virt.flash0, CheckValue: d5584b740ffcf81df8123ebc833793a71a03d47c1bb5a97170d05d18665c8b2e
CheckPoint: qemu_loadvm_state, Ramblock: virt.flash1, CheckValue: 1d6c818dfa81a88ca5b7b1da231a9ba57f4f87677c6ba8e76196195b5aa05f0c
CheckPoint: qemu_loadvm_state, Ramblock: /rom@etc/acpi/tables, CheckValue: db4c25623cb0192a70b56b5700e304e87c46f3016bc4b43b458a831b93d1cd54
CheckPoint: qemu_loadvm_state, Ramblock: /rom@etc/table-loader, CheckValue: b3e0b1026cd4df920884f7d090b90cfb64b4a3ab407feeb632300aabd9fb28fe
CheckPoint: qemu_loadvm_state, Ramblock: /rom@etc/acpi/rsdp, CheckValue: 7af8a2bc8c5f78db788a47ed60b30bffee50f28783529ee55224f9e3613cc28a

Not for sure if it is valuable, any discussion and comment is welcome.

Chuan Zheng (4):
  migration/debug: Introduce foreach_migratable_block()
  migration/debug: Implement migration memory consistency check
  migration/debug: add checkpoint for migration consistency check
  migration/debug: add DEBUG_MIGRATION_CONSISTENCY_CHECK macros

 migration/migration.c |  3 ++
 migration/ram.c       | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++
 migration/ram.h       |  7 +++++
 migration/savevm.c    |  9 ++++++
 4 files changed, 105 insertions(+)

-- 
1.8.3.1


