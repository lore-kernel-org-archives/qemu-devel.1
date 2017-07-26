Received: from eggs.gnu.org ([2001:4830:134:3::10]:55597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1daIGF-0002Mo-QH
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1daIGC-0007LA-Gp
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:05:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1daIGC-0007KL-2E
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:05:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6Q94QDw013765
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 05:05:38 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxnxuwxny-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 05:05:38 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 26 Jul 2017 10:05:35 +0100
References: <20170725153330.14966-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Jul 2017 11:05:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170725153330.14966-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9b07ee50-f36e-b9f3-9c1c-c7af836603c1@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/9] s390x: zPCI detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com



On 07/25/2017 05:33 PM, Cornelia Huck wrote:
> Next version, now without RFC. The goals are still the same:
> - Being able to disable PCI support in a build completely.
> - Properly fencing off PCI if the relevant facility bit is not provided.
> 
> Changes v2->v3:
> - Only enable the zpci bit conditionally, keep the aen bit always on.
>   Use a method that actually works...
> - Some reordering in the msi route patch to keep the change small.
> - Collected some r-bs.
> 
> Branch is still git://github.com/cohuck/qemu no-zpci-cpumodel
> 
> Likely 2.11 material, even though the 'fence off if facility bit is not
> set' part could count as bugfixes. Thoughts?

In general, this series looks pretty good already, but I would prefer to
have it in 2.11. The PCI code now seems to work ok for passthrough devices
and this change would certainly require some retesting. 
I think it would stretch things too far to consider the fencing a 
must have bug fix.

> 
> Cornelia Huck (9):
>   kvm: remove hard dependency on pci
>   s390x/pci: add stubs
>   s390x: chsc nt2 events are pci-only
>   s390x/pci: do not advertise pci on non-pci builds
>   s390x/ccw: create s390 phb conditionally
>   s390x/sclp: properly guard pci-specific functions
>   s390x/pci: fence off instructions for non-pci
>   s390x/kvm: msi route fixup for non-pci
>   s390x: refine pci dependencies
> 
>  default-configs/s390x-softmmu.mak |  2 +-
>  hw/pci/pci-stub.c                 | 12 ++++++
>  hw/s390x/Makefile.objs            |  3 +-
>  hw/s390x/s390-pci-bus.c           |  9 ++++-
>  hw/s390x/s390-pci-bus.h           |  5 ++-
>  hw/s390x/s390-pci-stub.c          | 78 +++++++++++++++++++++++++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c        | 12 +++---
>  hw/s390x/sclp.c                   | 19 ++++++++--
>  target/s390x/ioinst.c             | 16 ++++++++
>  target/s390x/kvm.c                | 61 +++++++++++++++++++++++-------
>  10 files changed, 188 insertions(+), 29 deletions(-)
>  create mode 100644 hw/s390x/s390-pci-stub.c
> 
