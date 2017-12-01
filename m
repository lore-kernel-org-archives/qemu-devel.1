Received: from eggs.gnu.org ([208.118.235.92]:54553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eKo1D-0004ey-04
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eKnzW-0008CJ-3w
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:18:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eKnzT-00085A-Bc
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:16:40 -0500
Date: Fri, 1 Dec 2017 10:19:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171201101908.GA2318@work-vm>
References: <20171129185026.23632-1-dgilbert@redhat.com>
	<20171201100220.GE23501@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201100220.GE23501@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC 0/7] Rework vhost memory region updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Wed, Nov 29, 2017 at 06:50:19PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Hi,
> >   This is an experimental set that reworks the way the vhost
> > code handles changes in physical address space layout that
> > came from a discussion with Igor.
> > 
> > Instead of updating and trying to merge sections of address
> > space on each add/remove callback, we wait until the commit phase
> > and go through and rebuild a list by walking the Flatview of
> > memory and end up producing an ordered list.
> > We compare the list to the old list to trigger updates.
> > 
> > Note, only very lightly tested so far, I'm just trying to see if it's
> > the right shape.
> 
> The cover letter doesn't mention why this change is necessary.  It would
> be helpful to know :).

The hope was to simplify it, and in particular make it easier for me
to add the bits I needed for postcopy support;  in the current code it
does a fairly complex merge procedure on each section ad/del call and
doesn't keep the structures in order.   Trying to add any more rules to
that just makes it more and more complex.

The hope is that this is simpler because we just do a linear walk of the
set of sections, which means any merging just happens with the top
element, and also the list is in order that's easier to work with.
Then it should be easier for me to add the postcopy stuff which needs
to do some hugepage merging.

(Bizarrely, after having rewritten the code from scratch completely
differently, the LoC is within a few lines of each other)

Dave

> Stefan


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
