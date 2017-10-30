Received: from eggs.gnu.org ([2001:4830:134:3::10]:45090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e95Qo-0004oi-9T
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e95Qk-00017p-Al
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:28:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e95Qk-00017O-1n
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:28:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9U8OSp2068951
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 04:28:14 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dwxpxn6w9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 04:28:14 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 30 Oct 2017 08:28:12 -0000
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Oct 2017 09:28:09 +0100
MIME-Version: 1.0
In-Reply-To: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <feea3ded-fecc-50ff-fe70-09e63966933b@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/5][RFC] Refactoring of AIS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, agraf@suse.de, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org

Now I thought about that for a while and I start to think that we cannot implement ais
in QEMU and cover all cases.
One aspect was certainly passthrough (like you handled in patch 4).
Another aspect is that some interrupts might be injected from the kernel - even for
emulated devices. e.g. virtio-pci together with vhost-net, will inject interrupts via
the set_irq callback. I think disabling irqfd for these cases is not a good idea.

So what about adding a new KVM capability (for 4.14), fixup the other things in
QEMU and then bind it to the new capability?

Christian

On 10/04/2017 03:49 PM, Pierre Morel wrote:
> Currently AIS support has several problems:
> 
> - AIS support in KVM is reported if KVM has AIS capability.
> - Testing if KVM FLIC attributes for AIS are supported does not take into
>   account if AIS is supported by KVM.
> - KVM report supporting the AIS FLIC features but denies their usage
>   if the host kernel does not support the AIS feature.
> - Testing if the Adapter interrupt must be suppressed is done looking at the
>   ISC and ignores the adapter properties.
> - Emulation of PCI devices can only be done with KVM support for AIS.
> - Migration of emulated devices can only be done if both side support AIS in KVM
> 
> I would like to make some modifications to the code where I think things are
> not handled at the right place.
> 
> Therefor I propose these changes.
> - Use the CPU model to enable AIS in the guest, even without KVM backup
> - Ask KVM for AIS support in kvm_flic realize
> - add simm/nimm attributes to the KVM FLIC interface to support emulation
>   and migration between hosts with and without AIS support in KVM.
> - Modify the zPCI VFIO realize function to refuse VFIO PCI devices without
>   AIS support in KVM.
> - Modify the AIS migration to support emulation and heterogeneous hosts.
> 
> 
> Pierre Morel (5):
>   s390x/kvm: Enable AIS from CPU model always
>   s390x/css: Use AIS AIRQ injection only if adapter support AIS
>   s390x/intc: Emulate Adapter Interrupt Suppression
>   s390x/pci: Refuse to realize VFIO-PCI if AIS needed but supported
>   s390x/intc: AIS is now always migratable
> 
>  hw/intc/s390_flic.c     |  3 +-
>  hw/intc/s390_flic_kvm.c | 94 ++++++++++++++++++++++++++++++++++++++-----------
>  hw/s390x/css.c          |  6 ++--
>  hw/s390x/s390-pci-bus.c | 12 +++++++
>  target/s390x/kvm.c      |  1 +
>  5 files changed, 91 insertions(+), 25 deletions(-)
> 
