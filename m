Received: from eggs.gnu.org ([2001:4830:134:3::10]:57885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIwdL-0004eN-DG
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIwdI-0004DM-Al
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:38:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fIwdI-0004Co-5c
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:38:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7315E814FDCF
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 13:38:19 +0000 (UTC)
References: <20180417140802.16711-1-pbonzini@redhat.com>
	<0a51d026-8b9f-9925-1229-10e3766907bb@redhat.com>
	<02617670-8b06-e5b9-d763-65453b5f706a@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <222e8530-6bd1-086a-cecf-1a755a38ce99@redhat.com>
Date: Wed, 16 May 2018 15:38:18 +0200
MIME-Version: 1.0
In-Reply-To: <02617670-8b06-e5b9-d763-65453b5f706a@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] exec: reintroduce MemoryRegion caching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi Paolo

On 05/16/2018 12:42 PM, Paolo Bonzini wrote:
> On 16/05/2018 12:41, Auger Eric wrote:
>> This patch seems to cause a regression with ARM vsmmu +
>> virtio-blk-pci. Reverting it looks to fix the issue. Otherwise I
>> get:
> 
> What's the command line for a reproducer?
> 
> Thanks,
> 
> Paolo
> 

here is my command line:

TCG:

sudo /home/augere/UPSTREAM/qemu/aarch64-softmmu/qemu-system-aarch64 -M virt-2.12,gic-version=3,iommu=smmuv3 \
-cpu cortex-a57 -smp 8 -m 4096 -display none -machine accel=tcg \
-serial tcp:localhost:4444,server -trace events=/home/augere/TEST/QEMU/hw-arm-smmu \
-qmp unix:/home/augere/TEST/QEMU/qmp-sock,server,nowait \
-device virtio-blk-pci,bus=pcie.0,scsi=off,drive=drv0,id=drv0,bootindex=1,iommu_platform,disable-modern=off,disable-legacy=on,werror=stop,rerror=stop \
-drive file=/home/augere/VM/IMAGES/vm0.qcow2,format=qcow2,if=none,id=drv0 \
-device virtio-net-pci,bus=pcie.0,netdev=nic0,mac=6a:f5:10:b1:3d:d2,iommu_platform,disable-modern=off,disable-legacy=on \
-netdev tap,id=nic0,script=/home/augere/TEST/SCRIPTS/qemu-ifup,downscript=/home/augere/TEST/SCRIPTS/qemu-ifdown \
-net none

or with acceleration:

sudo /home/augere/UPSTREAM/qemu/aarch64-softmmu/qemu-system-aarch64 -M virt-2.12,gic-version=3,iommu=smmuv3 -cpu host -smp 8 -m 4096 -display none --enable-kvm ../..

I reproduce with both, 100% of the cases.

Trying to reproduce with intel iommu as well.

Thanks

Eric
