Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837E0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B97720737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B97720737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3Os-00060M-LS
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jr3Mp-0002Hu-26; Thu, 02 Jul 2020 13:51:24 -0400
Received: from charlie.dont.surf ([128.199.63.193]:51958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jr3Mm-0001ge-9n; Thu, 02 Jul 2020 13:51:22 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 2B182BF621;
 Thu,  2 Jul 2020 17:51:17 +0000 (UTC)
Date: Thu, 2 Jul 2020 19:51:13 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v4 2/2] nvme: allow cmb and pmr to be enabled on same
 device
Message-ID: <20200702175113.6qtnpxqimpavzx7h@apples.localdomain>
References: <20200701214858.28515-1-andrzej.jakowski@linux.intel.com>
 <20200701214858.28515-3-andrzej.jakowski@linux.intel.com>
 <20200702101318.rmd65uzwfpcmb24n@apples.localdomain>
 <20200702103127.hoonqkas3bw2v7re@apples.localdomain>
 <8f871a0d-47f1-1c8a-fcc2-aab2638c70cf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f871a0d-47f1-1c8a-fcc2-aab2638c70cf@linux.intel.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 13:51:17
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

On Jul  2 08:07, Andrzej Jakowski wrote:
> On 7/2/20 3:31 AM, Klaus Jensen wrote:
> > Aight, an update here. This only happens when QEMU is run with a virtual
> > IOMMU. Otherwise, the kernel is happy.
> > 
> > With the vIOMMU, qemu also craps out a bit:
> > 
> > qemu-system-x86_64: vtd_iova_to_slpte: detected slpte permission error (iova=0xfd200000, level=0x2, slpte=0x0, write=0)
> > qemu-system-x86_64: vtd_iommu_translate: detected translation failure (dev=03:00:00, iova=0xfd200000)
> > 
> > So I think we are back in QEMU land for the bug.
> 
> Can you share command line for that?
> 
> 

qemu-system-x86_64 \
  -nodefaults \
  -display none \
  -device intel-iommu,pt,intremap=on,device-iotlb=on \
  -machine type=q35,accel=kvm,kernel_irqchip=split \
  -cpu host \
  -smp 4 \
  -m 8G \
  -nic user,model=virtio-net-pci,hostfwd=tcp::2222-:22 \
  -device virtio-rng-pci \
  -drive id=boot,file=/home/kbj/work/src/vmctl/state/pmr/boot.qcow2,format=qcow2,if=virtio,discard=on,detect-zeroes=unmap \
  -device pcie-root-port,id=pcie_root_port1,chassis=1,slot=0 \
  -device x3130-upstream,id=pcie_upstream1,bus=pcie_root_port1 \
  -device xio3130-downstream,id=pcie_downstream1,bus=pcie_upstream1,chassis=1,slot=1 \
  -drive id=nvme0n1,file=/home/kbj/work/src/vmctl/state/pmr/nvme0n1.img,format=raw,if=none,discard=on,detect-zeroes=unmap \
  -object memory-backend-file,id=pmr,share=on,mem-path=pmr.bin,size=1M \
  -device nvme,id=nvme0,serial=deadbeef,bus=pcie_downstream1,drive=nvme0n1,msix_qsize=1,pmrdev=pmr,cmb_size_mb=2 \
  -pidfile /home/kbj/work/src/vmctl/run/pmr/pidfile \
  -kernel /home/kbj/work/src/kernel/linux/arch/x86_64/boot/bzImage \
  -append root=/dev/vda1 console=ttyS0,115200 audit=0 nokaslr \
  -virtfs local,path=/home/kbj/work/src/kernel/linux,security_model=none,readonly,mount_tag=modules \
  -serial mon:stdio \
  -trace pci_nvme*



