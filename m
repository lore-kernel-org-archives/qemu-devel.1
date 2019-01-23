Received: from eggs.gnu.org ([209.51.188.92]:40509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmFs0-00009t-8t
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmFrz-0000Pv-G6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:34:56 -0500
Date: Wed, 23 Jan 2019 11:34:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190123113447.04354ae4.cohuck@redhat.com>
In-Reply-To: <20190122200331.14ff2818@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190121212018.4e377e59@oc2783563651>
	<20190122112926.4ff54f9f.cohuck@redhat.com>
	<20190122121737.49c3f900@oc2783563651>
	<20190122125322.4bb04921.cohuck@redhat.com>
	<20190122134612.40a7745e@oc2783563651>
	<20190122182617.23fab5e9.cohuck@redhat.com>
	<20190122200331.14ff2818@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 22 Jan 2019 20:03:31 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 22 Jan 2019 18:26:17 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Tue, 22 Jan 2019 13:46:12 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:

> > > Unsolicited interrupts are another
> > > piece of cake -- I have no idea how may of those do we get.  
> > 
> > They at least don't have the "free the cp before we got final state"
> > bug. But I think both are reasons to get away from "use the BUSY state
> > to ensure the right sequence".
> >   
> 
> I'm not sure I understand you correctly. I was under the impression that
> the whole point in having a state machine was to ensure the states are
> traversed in the right sequence with the right stuff being done on each
> transition. At least in theory.

Sequence in user space programs, not in the state machine.

> 
> You've probably figured out that IMHO vfio-ccw is not in a good shape
> (to put it mildly). I have a hard time reviewing a non-holistic
> concurrency fix. Please tell sould I get perceived as non-constructive,
> I will try to cut back on criticism. 

I'm afraid this is just confusing me :(

> 
> > > And because
> > > of this the broken sequencing in userspace could actually be the kernels
> > > fault.  
> > 
> > Here, I can't follow you at all :(
> >   
> 
> Should we ever deliver a zeroed out IRB to the userspace, for the next
> ioinst it would look like we have no status nor FC bit set. That is, the
> guest could end up with stuff in parallel that was never supposed to
> be in parallel (i.e. broken sequencing because kernel feeds false
> information due to race with unsolicited interrupt).
> 
> Does that help?

Not at all, I'm afraid :( User space programs still need to make sure
they poke the interfaces in the right order IMO...

At this point, I'm mostly confused... I'd prefer to simply fix things
as they come up so that we can finally move forward with the halt/clear
handling (and probably rework the state machine on top of that.)
