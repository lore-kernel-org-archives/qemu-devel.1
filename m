Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F88C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DDC206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DDC206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUi8-0006o6-Vj
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvE-00010X-TH
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvC-0001Ox-LX
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2294 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPvC-0001Jz-4k
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:50 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 008275BBEFFF4180DA30;
 Thu,  9 Jan 2020 12:59:40 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:30 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 00/12] *** mulitple RDMA channels for migration ***
Date: Thu, 9 Jan 2020 12:59:10 +0800
Message-ID: <20200109045922.904-1-fengzhimin1@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.198]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
X-Mailman-Approved-At: Thu, 09 Jan 2020 04:56:54 -0500
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
Cc: jemmy858585@gmail.com, fengzhimin <fengzhimin1@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: fengzhimin <fengzhimin1@huawei.com>

Currently there is a single channel for RDMA migration, this causes
the problem that the network bandwidth is not fully utilized for
25Gigabit NIC. Inspired by the Multifd, we use two RDMA channels to
send RAM pages, which we call MultiRDMA.

We compare the migration performance of MultiRDMA with origin
RDMA migration. The VM specifications for migration are as follows:
- VM use 4k page;
- the number of VCPU is 4;
- the total memory is 16Gigabit;
- use 'mempress' tool to pressurize VM(mempress 8000 500);
- use 25Gigabit network card to migrate;

For origin RDMA and MultiRDMA migration, the total migration times of
VM are as follows:
+++++++++++++++++++++++++++++++++++++++++++++++++
|             | NOT rdma-pin-all | rdma-pin-all |
+++++++++++++++++++++++++++++++++++++++++++++++++
| origin RDMA |       18 s       |     23 s     |
-------------------------------------------------
|  MultiRDMA  |       13 s       |     18 s     |
+++++++++++++++++++++++++++++++++++++++++++++++++

For NOT rdma-pin-all migration, the multiRDMA can improve the
total migration time by about 27.8%.
For rdma-pin-all migration, the multiRDMA can improve the
total migration time by about 21.7%.

Test the multiRDMA migration like this:
'virsh migrate --live --rdma-parallel --migrateuri
rdma://hostname domain qemu+tcp://hostname/system'


fengzhimin (12):
  migration: Add multiRDMA capability support
  migration: Export the 'migration_incoming_setup' function          =20
             and add the 'migrate_use_rdma_pin_all' function
  migration: Create the multi-rdma-channels parameter
  migration/rdma: Create multiRDMA migration threads
  migration/rdma: Create the multiRDMA channels
  migration/rdma: Transmit initial package
  migration/rdma: Be sure all channels are created
  migration/rdma: register memory for multiRDMA channels
  migration/rdma: Wait for all multiRDMA to complete registration
  migration/rdma: use multiRDMA to send RAM block for rdma-pin-all mode
  migration/rdma: use multiRDMA to send RAM block for NOT rdma-pin-all
                  mode
  migration/rdma: only register the virt-ram block for MultiRDMA

 migration/migration.c |   55 +-
 migration/migration.h |    6 +
 migration/rdma.c      | 1320 +++++++++++++++++++++++++++++++++++++----
 monitor/hmp-cmds.c    |    7 +
 qapi/migration.json   |   27 +-
 5 files changed, 1285 insertions(+), 130 deletions(-)

--=20
2.19.1



