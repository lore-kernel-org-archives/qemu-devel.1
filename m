Received: from eggs.gnu.org ([209.51.188.92]:55924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmIfu-0001Dw-4B
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmIft-0001Pj-6T
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:34:38 -0500
Date: Wed, 23 Jan 2019 14:34:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190123143429.7a8da112.cohuck@redhat.com>
In-Reply-To: <20190123140601.54b2c768@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190121212018.4e377e59@oc2783563651>
	<20190122112926.4ff54f9f.cohuck@redhat.com>
	<20190122121737.49c3f900@oc2783563651>
	<20190122125322.4bb04921.cohuck@redhat.com>
	<20190122134612.40a7745e@oc2783563651>
	<20190122182617.23fab5e9.cohuck@redhat.com>
	<20190122200331.14ff2818@oc2783563651>
	<20190123113447.04354ae4.cohuck@redhat.com>
	<20190123140601.54b2c768@oc2783563651>
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

On Wed, 23 Jan 2019 14:06:01 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 23 Jan 2019 11:34:47 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:

> Yes, one can usually think of interfaces as contracts: both sides need
> to keep their end for things to work as intended. Unfortunately the
> vfio-ccw iterface is not a very well specified one, and that makes
> reasoning about right order so much harder.

That's probably where our disconnect comes from.

> 
> I was under the impression that the right ordering is dictated by the
> SCSW in userspace. E.g. if there is an FC bit set there userspace is not
> ought to issue a SSCH request (write to the io_region). The kernel part
> however may say 'userspace read the actual SCSW' by signaling
> the io_trigger eventfd. Userspace is supposed to read the IRB from the
> region and update it's SCSW.
> 
> Now if userspace reads a broken SCSW from the IRB, because of a race
> (due to poorly written kernel part -- userspace not at fault), it is
> going to make wrong assumptions about currently legal and illegal
> operations (ordering).

My understanding of the interface was that writing to the I/O region
triggers a ssch (unless rejected with error) and that reading it just
gets whatever the kernel wrote there the last time it updated its
internal structures. The eventfd simply triggers to say "the region has
been updated with an IRB", not to say "userspace, read this".

> 
> Previously I described a scenario where IRB can break without userspace
> being at fault (race between unsolicited interrupt -- can happen at any
> time -- and a legit io request). I was under the impression we agreed on
> this.

There is a bug in there (clearing the cp for non-final interrupts), and
it needs to be fixed. I'm not so sure if the unsolicited interrupt
thing is a bug (beyond that the internal state machine is confused).

> 
> This in turn could lead to userspace violating the contract, as perceived
> by the kernel side.

Which contract? ;)

Also, I'm not sure if we'd rather get a deferred cc 1?

> 
> > At this point, I'm mostly confused... I'd prefer to simply fix things
> > as they come up so that we can finally move forward with the halt/clear
> > handling (and probably rework the state machine on top of that.)
> >   
> 
> I understand. I guess you will want to send a new version because of the
> stuff that got lost in the rebase, or?

Yes, I'll send a new version; but I'll wait for more feedback for a bit.
