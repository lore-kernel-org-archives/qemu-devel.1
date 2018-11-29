Received: from eggs.gnu.org ([2001:4830:134:3::10]:52919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gSOfM-0004ML-BC
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gSOfH-0003v4-7f
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:55:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gSOfG-0003rr-Si
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:55:43 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wATFpFBI137961
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 10:55:40 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p2k018pxy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 10:55:40 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 29 Nov 2018 15:55:37 -0000
Date: Thu, 29 Nov 2018 16:55:30 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181129165530.5bf723fc@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] s390x/vfio: VFIO-AP interrupt
 control interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, akrowiak@linux.ibm.com, peter.maydell@linaro.org, david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, agraf@suse.de, eric.auger@redhat.com, qemu-s390x@nongnu.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Thu, 22 Nov 2018 17:35:49 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> This series has 3 different type of patches:
> 
> The first two:
>   s390x/vfio: ap: Finding the AP bridge
>   s390x/vfio: ap: Use the APdevice as a child of the APBus
> 
> Are dealing with the QEMU Object Model and how we retrieve the
> AP devices from instruction interception.
> A lifting of the AP bridge, bus and device was necessary to
> ease the process and allow future extensions.
> 
> The third one is a place holder to ease reviewing:
>   s390x/vfio: ap: Linux uapi VFIO place holder
> 
> The last three are really dealing with PQAP/AQIC instruction
> interception and associate IOCTL calls to the VFIO AP device
> driver.
>   s390x/cpumodel: Set up CPU model for AQIC interception
>   s390x/vfio: ap: Definition for AP Adapter type
>   s390x/vfio: ap: Implementing AP Queue Interrupt Control
> 
> The S390 APQP/AQIC instruction is intercepted by the host
> to configure the AP queues interruption redirection.
> It retrieves the ISC used by the host and the one used
> by the guest and setup the indicator address.
> 
> This patch series
> - define the AQIC feature in the cpumodel,
> - extend the APDevice type for per card and queue interrupt handling,
> - intercept the APQP/AQIC instruction, uses the S390 adapter interface
>   to setup the adapter 
> - and use a VFIO ioctl to let the VFIO-AP driver handle the host
>   instruction associated with the intercepted guest instruction.
> 
> This patch serie can be tested with the Linux/KVM patch series
> for the VFIO-AP driver: "s390: vfio: ap: Using GISA for AP Interrupt"
> 

Sorry for raising concern this late, I hope it's better late than
never.

I have strong doubts that handling PQAP/AQCI via userspace is worth
the effort. IMHO we could do what we have to do on AQCI in kernel
iff the ap is done SIE interpreted, the appropriate feature is presented
to the guest, and the queue in question belongs to the given guest. Or
am I wrong?

I do understand that doing it like this *may* end up being beneficial
*if* we decide to do some sort of ap virtualization in QEMU. But I don't
see it coming in the foreseeable future, and for ap virtualization we
would need a solution for making the host do an NQAP and an DQAP on
behalf of the guest/emulator, and not only to do the same for PQAP/QCI.

In my understanding, with this, we would end up with an infrastructure
that only makes sense in a perspective of some 'future features' which
may never come to existence.

What I ask for is, please, let us examine the other option.

Regards,
Halil


> 
> Pierre Morel (6):
>   s390x/vfio: ap: Finding the AP bridge
>   s390x/vfio: ap: Use the APdevice as a child of the APBus
>   s390x/vfio: ap: Linux uapi VFIO place holder
>   s390x/cpumodel: Set up CPU model for AQIC interception
>   s390x/vfio: ap: Definition for AP Adapter type
>   s390x/vfio: ap: Implementing AP Queue Interrupt Control
> 
>  hw/s390x/ap-bridge.c            |  12 ++++
>  hw/s390x/ap-device.c            |  22 +++++++
>  hw/vfio/ap.c                    | 131 +++++++++++++++++++++++++++++++++++++---
>  include/hw/s390x/ap-bridge.h    |   1 +
>  include/hw/s390x/ap-device.h    |  65 ++++++++++++++++++++
>  include/hw/s390x/css.h          |   1 +
>  linux-headers/linux/vfio.h      |  25 ++++++++
>  target/s390x/cpu_features.c     |   1 +
>  target/s390x/cpu_features_def.h |   1 +
>  target/s390x/cpu_models.c       |   1 +
>  target/s390x/gen-features.c     |   1 +
>  target/s390x/kvm.c              |  31 ++++++++++
>  12 files changed, 282 insertions(+), 10 deletions(-)
> 
