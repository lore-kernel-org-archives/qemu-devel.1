Received: from eggs.gnu.org ([2001:4830:134:3::10]:49580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fC8hk-0005EK-7A
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fC8hf-0004oR-Gw
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:06:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fC8hf-0004lW-Ap
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:06:43 -0400
Date: Fri, 27 Apr 2018 20:06:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180427190629.GQ2608@work-vm>
References: <20180427173416.19233-1-dgilbert@redhat.com>
	<bd81d081-e7ca-95af-7922-ae5f149e6edf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd81d081-e7ca-95af-7922-ae5f149e6edf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] migration: update docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, bala24@linux.vnet.ibm.com, peterx@redhat.com, quintela@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 04/27/2018 12:34 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Update the migration docs:
> > 
> > Among other changes:
> >   * Added a general list of advice for device authors
> >   * Reordered the section on conditional state (subsections etc)
> >     into the order we prefer.
> >   * Add a note about firmware
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  docs/devel/migration.rst | 531 +++++++++++++++++++++++++++------------
> >  1 file changed, 375 insertions(+), 156 deletions(-)
> 
> > +
> > +General advice for device developers
> > +------------------------------------
> > +
> > +- The migration state saved should reflect the device being modelled rather
> > +  than the way your implementation works.   That way if you change the implementation
> 
> Three spaces between sentences is unusual.
> 

Fixed.

> > +
> > +- The migration might happen at an inconvenient point,
> > +  e.g. right in the middle of the guest reprogramming the device, during
> > +  guest reboot or shutdown or while the device is waiting for external IO.
> > +  It's strongly preferred that migrations do not fail in this situation,
> > +  since in the cloud environment migrations might happen automatically to
> > +  VMs that the administrator doesn't directly control.
> 
> Not for this patch, but is there any mechanism for a device to request
> that migration be delayed just long enough for the device to have a
> chance to get out of that inconsistent state, rather than having to
> migrate the inconvenient state?

Not generally no;  for an iterative device you can lie and say you've
still got data to migrate but it gets very messy.
For a non-iterative device it's too late, the CPU is already paused and
you're expected to stream the device state.

> > +When we migrate a device, we save/load the state as a series
> > +of fields.  Some times, due to bugs or new functionality, we need to
> 
> Sometimes

Done.

> 
> > @@ -328,9 +329,12 @@ Sometimes members of the VMState are no longer needed:
> >  
> >    - removing them will break migration compatibility
> >  
> > -  - making them version dependent and bumping the version will break backwards migration compatibility.
> > +  - making them version dependent and bumping the version will break backward migration compatibility.
> 
> Is it worth worrying about long lines?

I'm not too bothered, but I've wrapped this one.

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
