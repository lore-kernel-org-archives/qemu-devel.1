Received: from eggs.gnu.org ([2001:4830:134:3::10]:41077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gSitJ-0001R1-8h
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gSitF-0007U1-7V
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:31:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49364
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gSitF-0007Ts-13
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:31:29 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAUDRqkd144948
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:31:28 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p33ed74r4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 08:31:28 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 30 Nov 2018 13:31:26 -0000
Date: Fri, 30 Nov 2018 14:31:18 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <d2ac761b-d936-6da7-9f0a-5cfa3043319d@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<20181129165530.5bf723fc@oc2783563651>
	<d2ac761b-d936-6da7-9f0a-5cfa3043319d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181130143118.32ca3010@oc2783563651>
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

On Fri, 30 Nov 2018 14:01:42 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 29/11/2018 16:55, Halil Pasic wrote:
> > On Thu, 22 Nov 2018 17:35:49 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> > 
> >> This series has 3 different type of patches:
> >>
> >> The first two:
> >>    s390x/vfio: ap: Finding the AP bridge
> >>    s390x/vfio: ap: Use the APdevice as a child of the APBus
> >>
> >> Are dealing with the QEMU Object Model and how we retrieve the
> >> AP devices from instruction interception.
> >> A lifting of the AP bridge, bus and device was necessary to
> >> ease the process and allow future extensions.
> >>
> >> The third one is a place holder to ease reviewing:
> >>    s390x/vfio: ap: Linux uapi VFIO place holder
> >>
> >> The last three are really dealing with PQAP/AQIC instruction
> >> interception and associate IOCTL calls to the VFIO AP device
> >> driver.
> >>    s390x/cpumodel: Set up CPU model for AQIC interception
> >>    s390x/vfio: ap: Definition for AP Adapter type
> >>    s390x/vfio: ap: Implementing AP Queue Interrupt Control
> >>
> >> The S390 APQP/AQIC instruction is intercepted by the host
> >> to configure the AP queues interruption redirection.
> >> It retrieves the ISC used by the host and the one used
> >> by the guest and setup the indicator address.
> >>
> >> This patch series
> >> - define the AQIC feature in the cpumodel,
> >> - extend the APDevice type for per card and queue interrupt handling,
> >> - intercept the APQP/AQIC instruction, uses the S390 adapter interface
> >>    to setup the adapter
> >> - and use a VFIO ioctl to let the VFIO-AP driver handle the host
> >>    instruction associated with the intercepted guest instruction.
> >>
> >> This patch serie can be tested with the Linux/KVM patch series
> >> for the VFIO-AP driver: "s390: vfio: ap: Using GISA for AP Interrupt"
> >>
> > 
> > Sorry for raising concern this late, I hope it's better late than
> > never.
> > 
> > I have strong doubts that handling PQAP/AQCI via userspace is worth
> > the effort. IMHO we could do what we have to do on AQCI in kernel
> > iff the ap is done SIE interpreted, the appropriate feature is presented
> > to the guest, and the queue in question belongs to the given guest. Or
> > am I wrong?
> > 
> > I do understand that doing it like this *may* end up being beneficial
> > *if* we decide to do some sort of ap virtualization in QEMU. But I don't
> > see it coming in the foreseeable future, and for ap virtualization we
> > would need a solution for making the host do an NQAP and an DQAP on
> > behalf of the guest/emulator, and not only to do the same for PQAP/QCI.
> > 
> > In my understanding, with this, we would end up with an infrastructure
> > that only makes sense in a perspective of some 'future features' which
> > may never come to existence.
> > 
> > What I ask for is, please, let us examine the other option.
> > 
> > Regards,
> > Halil
> > 
> > 
> 
> As we discussed offline, I already began to implement prototypes for 
> both options.
> This is a clear design choice.
> 
> If we examine the pro and contra, I can list:
> 
> 1- Pro kernel implementation of the PQAP/AQIC
> -> rapidity of the reaction
> 
> Question: is this important?
> Answer: NO,
> Why: The PQAP/AQIC is rarely used by the AP driver of the guest. 
> exclusively during RESET of the AP queue.
> I do not think we need a rapid reaction there.
> 
> 
> 2- Pro userland implementation of PQAP/AQIC
> -> standard implementation, already used by PCI, CCW
> 
> Question: is it important?
> Answer: YES
> Why:  like following the standard
> It is easily extend-able to other virtualization implementation like 
> interception based VFIO and emulation
> 
> 
> There is no implementation which would be really more complicated as the 
> other, for both we will need to introduce new pro APQN (queue) 
> structures to hold the interrupt information (ISC, NIB), for both we 
> will need to ping the NIB in memory.
> 
> So as long as there are no other opinion against the design I presented 
> here I will continue this way while considering the comments I got on 
> this series.
> 

I'm a bit confused. Your first sentence reads like you in a process of
providing a kernel-heavy version. Your last sentence however reads like,
based on the discussion following the first sentence, you decided to not
explore, if the kernel-heavy variant (we still need a cpu model feature
in QEMU) is simpler.

Frankly, my feeling was that a kernel heavy implementation can be done
with less lines of code (considering QEMU and Linux) and without
introducing new ioctl interfaces. I may be wrong. You certainly seem to
dispute that a kernel-heavy implementation is likely to be simpler. If
you don't want to explore that option, I would like to ask you for your
permission to do it myself if my time allows.

Regards,
Halil
