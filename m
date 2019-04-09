Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD16EC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A19620830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A19620830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42377 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDrZD-00075x-8r
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 10:17:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1hDrY1-0006Tu-DV
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1hDrY0-0001iN-A9
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:16:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33392 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ann.zhuangyanying@huawei.com>)
	id 1hDrXz-0001Zk-NF
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:16:24 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 6E8EC8F02F61C763DB8E;
	Tue,  9 Apr 2019 22:16:16 +0800 (CST)
Received: from localhost (10.177.21.2) by DGGEMS406-HUB.china.huawei.com
	(10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 9 Apr 2019
	22:16:08 +0800
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
To: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Date: Tue, 9 Apr 2019 14:14:56 +0000
Message-ID: <1554819296-14960-1-git-send-email-ann.zhuangyanying@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.177.21.2]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: [Qemu-devel] [PATCH] msix: fix interrupt aggregation problem at the
 passthrough of NVMe SSD
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
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org,
	Zhuang Yanying <ann.zhuangyanying@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409141456.b-Hrt3AHSnFNlaF9w8ZZ57kn-63R91e8ISACX_9pCxc@z>

From: Zhuang Yanying <ann.zhuangyanying@huawei.com>

Recently I tested the performance of NVMe SSD passthrough and found that interrupts
were aggregated on vcpu0(or the first vcpu of each numa) by /proc/interrupts,when
GuestOS was upgraded to sles12sp3 (or redhat7.6). But /proc/irq/X/smp_affinity_list
shows that the interrupt is spread out, such as 0-10, 11-21,.... and so on.
This problem cannot be resolved by "echo X > /proc/irq/X/smp_affinity_list", because
the NVMe SSD interrupt is requested by the API pci_alloc_irq_vectors(), so the
interrupt has the IRQD_AFFINITY_MANAGED flag.

GuestOS sles12sp3 backport "automatic interrupt affinity for MSI/MSI-X capable devices",
but the implementation of __setup_irq has no corresponding modification. It is still
irq_startup(), then setup_affinity(), that is sending an affinity message when the
interrupt is unmasked. The bare metal configuration is successful, but qemu will
not trigger the msix update, and the affinity configuration fails.
The affinity is configured by /proc/irq/X/smp_affinity_list, implemented at
apic_ack_edge(), the bitmap is stored in pending_mask,
mask->__pci_write_msi_msg()->unmask,
and the timing is guaranteed, and the configuration takes effect.

The GuestOS linux-master incorporates the "genirq/cpuhotplug: Enforce affinity
setting on startup of managed irqs" to ensure that the affinity is first issued
and then __irq_startup(), for the managerred interrupt. So configuration is
successful.

It now looks like sles12sp3 (up to sles15sp1, linux-4.12.x), redhat7.6
(3.10.0-957.10.1) does not have backport the patch yet.
"if (is_masked == was_masked) return;" can it be removed at qemu?
What is the reason for this check?

Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
---
 hw/pci/msix.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 4e33641..e1ff533 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -119,10 +119,6 @@ static void msix_handle_mask_update(PCIDevice *dev, int vector, bool was_masked)
 {
     bool is_masked = msix_is_masked(dev, vector);
 
-    if (is_masked == was_masked) {
-        return;
-    }
-
     msix_fire_vector_notifier(dev, vector, is_masked);
 
     if (!is_masked && msix_is_pending(dev, vector)) {
-- 
1.8.3.1



