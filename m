Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4318C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D73820BED
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D73820BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwW9-0006jS-QH
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqwVE-0006Dc-5j; Thu, 02 Jul 2020 06:31:36 -0400
Received: from charlie.dont.surf ([128.199.63.193]:51378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqwVB-0003zy-Mb; Thu, 02 Jul 2020 06:31:35 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id CA66EBF64C;
 Thu,  2 Jul 2020 10:31:30 +0000 (UTC)
Date: Thu, 2 Jul 2020 12:31:27 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v4 2/2] nvme: allow cmb and pmr to be enabled on same
 device
Message-ID: <20200702103127.hoonqkas3bw2v7re@apples.localdomain>
References: <20200701214858.28515-1-andrzej.jakowski@linux.intel.com>
 <20200701214858.28515-3-andrzej.jakowski@linux.intel.com>
 <20200702101318.rmd65uzwfpcmb24n@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200702101318.rmd65uzwfpcmb24n@apples.localdomain>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 06:13:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kbusch@kernel.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul  2 12:13, Klaus Jensen wrote:
> On Jul  1 14:48, Andrzej Jakowski wrote:
> > So far it was not possible to have CMB and PMR emulated on the same
> > device, because BAR2 was used exclusively either of PMR or CMB. This
> > patch places CMB at BAR4 offset so it not conflicts with MSI-X vectors.
> > 
> 
> Linux craps out when I test this (1MB CMB):
> 
> Misaligned __add_pages start: 0xfdd00 end: #fdeff
> 
> I tracked it down to check_pfn_span (mm/memory_hotplug.c) failing
> because it's not on a 2MB boundary. I then tried to monkey patch the
> cmb_offset to be 2MB instead and it succeeds in registering the cmb:
> 
> [    8.384565] memmap_init_zone_device initialised 512 pages in 0ms
> [    8.385715] nvme 0000:03:00.0: added peer-to-peer DMA memory [mem 0xfd200000-0xfd3fffff 64bit
> pref]
> [    8.419372] nvme nvme0: 1/0/0 default/read/poll queues
> 
> But the kernel then continues to really crap out with a kernel panic:
> 
> [    8.440891] DMAR: DRHD: handling fault status reg 2
> [    8.440934] BUG: kernel NULL pointer dereference, address: 0000000000000120
> [    8.441713] DMAR: [DMA Read] Request device [03:00.0] PASID ffffffff fault addr fd200000 [faul
> t reason 06] PTE Read access is not set
> [    8.442630] #PF: supervisor write access in kernel mode
> [    8.444972] #PF: error_code(0x0002) - not-present page
> [    8.445640] PGD 0 P4D 0
> [    8.445965] Oops: 0002 [#1] PREEMPT SMP PTI
> [    8.446499] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.8.0-rc1-00034-gb6cf9836d07f-dirty #19
> [    8.447547] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb0
> 2-prebuilt.qemu.org 04/01/2014
> [    8.448898] RIP: 0010:nvme_process_cq+0xc4/0x200 [nvme]
> [    8.449525] Code: cf 00 00 00 48 8b 57 70 48 8b 7c c2 f8 e8 14 e9 32 c1 49 89 c7 0f 1f 44 00 0
> 0 41 0f b7 44 24 0e 49 8b 14 24 4c 89 ff 66 d1 e8 <49> 89 97 20 01 00 00 66 41 89 87 2a 01 00 00
> e8 28 04 33 c1 0f b7
> [    8.451662] RSP: 0018:ffffc9000015cf20 EFLAGS: 00010803
> [    8.452321] RAX: 000000000000400b RBX: ffff88826faad0c0 RCX: 0000000000000000
> [    8.453293] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [    8.454312] RBP: ffff8882725d38e4 R08: 00000001f71e225c R09: 0000000000000000
> [    8.455319] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888270bb0000
> [    8.456334] R13: 0000000000000000 R14: ffffc9000015cfac R15: 0000000000000000
> [    8.457311] FS:  0000000000000000(0000) GS:ffff888277d80000(0000) knlGS:0000000000000000
> [    8.458441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    8.459380] CR2: 0000000000000120 CR3: 0000000271c8c006 CR4: 0000000000360ee0
> [    8.460507] Call Trace:
> [    8.460906]  <IRQ>
> [    8.461272]  nvme_irq+0x10/0x20 [nvme]
> [    8.461951]  __handle_irq_event_percpu+0x45/0x1b0
> [    8.462803]  ? handle_fasteoi_irq+0x210/0x210
> [    8.463585]  handle_irq_event+0x58/0xb0
> [    8.464312]  handle_edge_irq+0xae/0x270
> [    8.465027]  asm_call_on_stack+0x12/0x20
> [    8.465686]  </IRQ>
> [    8.466053]  common_interrupt+0x120/0x1f0
> [    8.466717]  asm_common_interrupt+0x1e/0x40
> [    8.467429] RIP: 0010:default_idle+0x21/0x170
> [    8.468140] Code: eb a6 e8 82 27 ff ff cc cc 0f 1f 44 00 00 41 54 55 53 e8 e2 2e ff ff 0f 1f 4
> 4 00 00 e9 07 00 00 00 0f 00 2d f3 d4 44 00 fb f4 <e8> ca 2e ff ff 89 c5 0f 1f 44 00 00 5b 5d 41
> 5c c3 89 c5 65 8b 05
> [    8.471286] RSP: 0018:ffffc9000009fec8 EFLAGS: 00000282
> [    8.472202] RAX: 0000000000000003 RBX: ffff888276ff0000 RCX: 0000000000000001
> [    8.473405] RDX: 0000000000000001 RSI: ffffffff8212355f RDI: ffffffff8212d699
> [    8.474571] RBP: 0000000000000003 R08: ffff888277d9e4a0 R09: 0000000000000020
> [    8.475717] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [    8.476921] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    8.478110]  ? default_idle+0xe/0x170
> [    8.478728]  do_idle+0x1e1/0x240
> [    8.479283]  ? _raw_spin_lock_irqsave+0x19/0x40
> [    8.480040]  cpu_startup_entry+0x19/0x20
> [    8.480705]  start_secondary+0x153/0x190
> [    8.481400]  secondary_startup_64+0xb6/0xc0
> [    8.482114] Modules linked in: libata nvme nvme_core scsi_mod t10_pi crc_t10dif crct10dif_gene
> ric crct10dif_common virtio_net net_failover failover virtio_rng rng_core
> [    8.484675] CR2: 0000000000000120
> [    8.485264] ---[ end trace ff1849437c76af12 ]---
> [    8.486065] RIP: 0010:nvme_process_cq+0xc4/0x200 [nvme]
> [    8.486953] Code: cf 00 00 00 48 8b 57 70 48 8b 7c c2 f8 e8 14 e9 32 c1 49 89 c7 0f 1f 44 00 0
> 0 41 0f b7 44 24 0e 49 8b 14 24 4c 89 ff 66 d1 e8 <49> 89 97 20 01 00 00 66 41 89 87 2a 01 00 00
> e8 28 04 33 c1 0f b7
> [    8.490234] RSP: 0018:ffffc9000015cf20 EFLAGS: 00010803
> [    8.491144] RAX: 000000000000400b RBX: ffff88826faad0c0 RCX: 0000000000000000
> [    8.492445] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [    8.493681] RBP: ffff8882725d38e4 R08: 00000001f71e225c R09: 0000000000000000
> [    8.494907] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888270bb0000
> [    8.496130] R13: 0000000000000000 R14: ffffc9000015cfac R15: 0000000000000000
> [    8.497363] FS:  0000000000000000(0000) GS:ffff888277d80000(0000) knlGS:0000000000000000
> [    8.498726] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    8.499713] CR2: 0000000000000120 CR3: 0000000271c8c006 CR4: 0000000000360ee0
> [    8.500935] Kernel panic - not syncing: Fatal exception in interrupt
> [    8.502113] Kernel Offset: disabled
> [    8.502728] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> I'm out of my depth here, but the CMB/BAR offsets/setup seems sane enough -
> could this be a kernel bug?
> 
> Keith, any thoughts on this?
> 

Aight, an update here. This only happens when QEMU is run with a virtual
IOMMU. Otherwise, the kernel is happy.

With the vIOMMU, qemu also craps out a bit:

qemu-system-x86_64: vtd_iova_to_slpte: detected slpte permission error (iova=0xfd200000, level=0x2, slpte=0x0, write=0)
qemu-system-x86_64: vtd_iommu_translate: detected translation failure (dev=03:00:00, iova=0xfd200000)

So I think we are back in QEMU land for the bug.

