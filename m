Received: from eggs.gnu.org ([209.51.188.92]:47719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gn3yG-00033W-RI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gn3yE-0001xj-S8
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:04:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52542
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gn3y9-0001r3-5N
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:04:39 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0PG3rcI040444
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 11:04:14 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q85bn91x0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 11:04:14 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 25 Jan 2019 16:04:12 -0000
Date: Fri, 25 Jan 2019 17:04:04 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190125152154.05120461.cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<20190125150101.3b61f0a1@oc2783563651>
	<20190125152154.05120461.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190125170404.28c61eab@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Fri, 25 Jan 2019 15:21:54 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 25 Jan 2019 15:01:01 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Fri, 25 Jan 2019 13:58:35 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > > - We currently do not want the user space to submit another channel
> > >   program while the first one is still in flight. As submitting another
> > >   one is a valid request, however, we should allow this in the future
> > >   (once we have the code to handle that in place).  
> > 
> > I don't agree. There is at most one channel program processed by a
> > subchannel at any time. I would prefer an early error code if channel
> > programs are issued on top of each other (our virtual subchannel
> > is channel pending or FC start function bit set or similar).
> 
> You can submit a new request if the subchannel is pending with primary,
> but not with secondary state.
> 
> Regardless of that, I think it is much easier to push as much as
> possible of sorting out of requests to the hardware.
> 

Do we expect userspace/QEMU to fence the bad scenarios as tries to do
today, or is this supposed to change to hardware should sort out
requests whenever possible.

The problem I see with the let the hardware sort it out is that, for that
to work, we need to juggle multiple translations simultaneously (or am I
wrong?). Doing that does not appear particularly simple to me.
Furthermore we would go through all that hassle knowingly that the sole
reason is working around bugs. We still expect our Linux guests
serializing it's ssch() stuff as it does today. Thus I would except this
code not getting the love nor the coverage that would guard against bugs
in that code.

Regards,
Halil
