Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13456C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 04:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD4220774
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 04:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD4220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt1xe-0004yb-55
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 00:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jt1ws-0004Nz-Nm; Wed, 08 Jul 2020 00:44:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:43178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jt1wq-0007I4-Cf; Wed, 08 Jul 2020 00:44:46 -0400
IronPort-SDR: 52eW/wS9QmQkBJ3RoYwWaSFcpUukoCnmq9m5CjAxaCyrDe6NL4ym2DXaAveswbgEJ4TGoD1un+
 byYTBp95Wi8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135972754"
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; d="scan'208";a="135972754"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 21:44:39 -0700
IronPort-SDR: IHL5hUvzcyWrtTQk2z35XQQ64SK5CCJyDDzZVzXcu0Thh5i5E/l0IO81ZGLaJjF7KCdrlZy4iF
 XgOLyGUbKFnA==
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; d="scan'208";a="279830406"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain)
 ([10.251.141.17])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 21:44:39 -0700
Subject: Re: [PATCH v4 2/2] nvme: allow cmb and pmr to be enabled on same
 device
To: Klaus Jensen <its@irrelevant.dk>
References: <20200701214858.28515-1-andrzej.jakowski@linux.intel.com>
 <20200701214858.28515-3-andrzej.jakowski@linux.intel.com>
 <20200702101318.rmd65uzwfpcmb24n@apples.localdomain>
 <20200702103127.hoonqkas3bw2v7re@apples.localdomain>
 <8f871a0d-47f1-1c8a-fcc2-aab2638c70cf@linux.intel.com>
 <20200702175113.6qtnpxqimpavzx7h@apples.localdomain>
 <191b39ed-0588-b5db-d352-965efd19128a@linux.intel.com>
 <20200706071545.md4tivimefffgyi6@apples.localdomain>
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Message-ID: <16d74d40-bd55-997d-7fd6-e7ec59566a68@linux.intel.com>
Date: Tue, 7 Jul 2020 21:44:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706071545.md4tivimefffgyi6@apples.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=134.134.136.20;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 00:44:40
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 7/6/20 12:15 AM, Klaus Jensen wrote:
> On Jul  2 16:33, Andrzej Jakowski wrote:
>> On 7/2/20 10:51 AM, Klaus Jensen wrote:
>>> On Jul  2 08:07, Andrzej Jakowski wrote:
>>>> On 7/2/20 3:31 AM, Klaus Jensen wrote:
>>>>> Aight, an update here. This only happens when QEMU is run with a virtual
>>>>> IOMMU. Otherwise, the kernel is happy.
>>>>>
>>>>> With the vIOMMU, qemu also craps out a bit:
>>>>>
>>>>> qemu-system-x86_64: vtd_iova_to_slpte: detected slpte permission error (iova=0xfd200000, level=0x2, slpte=0x0, write=0)
>>>>> qemu-system-x86_64: vtd_iommu_translate: detected translation failure (dev=03:00:00, iova=0xfd200000)
>>>>>
>>>>> So I think we are back in QEMU land for the bug.
>>>>
>>>> Can you share command line for that?
>>>>
>>>>
>>>
>>> qemu-system-x86_64 \
>>>   -nodefaults \
>>>   -display none \
>>>   -device intel-iommu,pt,intremap=on,device-iotlb=on \
>>>   -machine type=q35,accel=kvm,kernel_irqchip=split \
>>>   -cpu host \
>>>   -smp 4 \
>>>   -m 8G \
>>>   -nic user,model=virtio-net-pci,hostfwd=tcp::2222-:22 \
>>>   -device virtio-rng-pci \
>>>   -drive id=boot,file=/home/kbj/work/src/vmctl/state/pmr/boot.qcow2,format=qcow2,if=virtio,discard=on,detect-zeroes=unmap \
>>>   -device pcie-root-port,id=pcie_root_port1,chassis=1,slot=0 \
>>>   -device x3130-upstream,id=pcie_upstream1,bus=pcie_root_port1 \
>>>   -device xio3130-downstream,id=pcie_downstream1,bus=pcie_upstream1,chassis=1,slot=1 \
>>>   -drive id=nvme0n1,file=/home/kbj/work/src/vmctl/state/pmr/nvme0n1.img,format=raw,if=none,discard=on,detect-zeroes=unmap \
>>>   -object memory-backend-file,id=pmr,share=on,mem-path=pmr.bin,size=1M \
>>>   -device nvme,id=nvme0,serial=deadbeef,bus=pcie_downstream1,drive=nvme0n1,msix_qsize=1,pmrdev=pmr,cmb_size_mb=2 \
>>>   -pidfile /home/kbj/work/src/vmctl/run/pmr/pidfile \
>>>   -kernel /home/kbj/work/src/kernel/linux/arch/x86_64/boot/bzImage \
>>>   -append root=/dev/vda1 console=ttyS0,115200 audit=0 nokaslr \
>>>   -virtfs local,path=/home/kbj/work/src/kernel/linux,security_model=none,readonly,mount_tag=modules \
>>>   -serial mon:stdio \
>>>   -trace pci_nvme*
>>>
>>>
>>
>> I focused on reproduction and it looks to me that my patch doesn't 
>> necessarily introduce regression. I run it w/ and w/o patch in both cases
>> getting error while registering. Here is kernel guest log:
>>
>> [   87.606482] nvme nvme0: pci function 0000:00:04.0
>> [   87.635577] dev=0000000095b0a83b bar=2 size=134217728 offset=0
>> [   87.636593] nvme nvme0: failed to register the CMB ret=-95
>> [   87.643262] nvme nvme0: 12/0/0 default/read/poll queues
>>
>> Any thoughts?
>>
> 
> Hmm, that's not what I am seeing.
> 
> With kernel v5.8-rc4, I'm not seeing any issues with CMB with and
> without IOMMU on QEMU master. With your patches, my kernel (v5.8-rc4)
> pukes both with and without iommu.
> 
> BUT! This doesn't mean that your patch is bad, it looks more like an
> issue in the kernel. I still think the BAR configuration looks sane, but
> I am not expert on this.
> 
> To satisify my curiosity I tried mending your patch to put the CMB on
> offset 0 and move the MSI-X vector table and PBA to BAR 0 (like I
> suggested back in the day). That works. With and without IOMMU. So, I
> think it is an issue with the Linux kernel not being too happy about the
> CMB being at an offset. It doesn't directly look like an issue in the
> nvme driver since the issue shows up far lower in the memory subsystem,
> but it would be nice to have the linux nvme gang at least acknowledge
> the issue.
> 

I have managed to reproduce that problem and played with patch to see
when the problem occurs vs not. 
When I put MSIX back to BAR2 (no PMR at all) and CMB left at BAR4 but 
starting at offset 0 I was still able to reproduce issue.
So then I've played with memory region API and interesting observed that
problem occurs when region overlaying is used via:

memory_region_init(&n->bar4, OBJECT(n), "nvme-bar4",  bar_size);$
$  
if (n->params.cmb_size_mb) {$
    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,$
                          "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));$
$  
    memory_region_add_subregion_overlap(&n->bar4, cmb_offset, &n->ctrl_mem, 1);$
}$

on the other hand when cmb memory region is initialized w/o region
overlaying that is:

memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,$
                      "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));

I get no reproduction.

Also observed qemu complaing about failed translation:
qemu-system-x86_64: vtd_iova_to_slpte: detected slpte permission error (iova=0xfe400000, level=0x2, slpte=0x0, write=0)
qemu-system-x86_64: vtd_iommu_translate: detected translation failure (dev=03:00:00, iova=0xfe400000)

Not sure how we want to proceed. Any suggestions?

