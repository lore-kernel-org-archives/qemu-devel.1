Received: from eggs.gnu.org ([2001:4830:134:3::10]:49590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eKO9P-0000Tm-CL
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eKO9L-0003Rx-9b
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:41:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eKO9L-0003Qn-1Q
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:41:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 351D180099
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 12:41:06 +0000 (UTC)
Date: Thu, 30 Nov 2017 13:40:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171130134057.1d8ecc3e@redhat.com>
In-Reply-To: <20171130120805.GA3952@work-vm>
References: <20171129185026.23632-1-dgilbert@redhat.com>
	<20171130122245.7e713d2f@redhat.com>
	<20171130120805.GA3952@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/7] Rework vhost memory region updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, mst@redhat.com

On Thu, 30 Nov 2017 12:08:06 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Igor Mammedov (imammedo@redhat.com) wrote:
> > On Wed, 29 Nov 2017 18:50:19 +0000
> > "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> >   
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Hi,
> > >   This is an experimental set that reworks the way the vhost
> > > code handles changes in physical address space layout that
> > > came from a discussion with Igor.  
> > Thanks for looking into it.
> > 
> >    
> > > Instead of updating and trying to merge sections of address
> > > space on each add/remove callback, we wait until the commit phase
> > > and go through and rebuild a list by walking the Flatview of
> > > memory and end up producing an ordered list.
> > > We compare the list to the old list to trigger updates.
> > > 
> > > Note, only very lightly tested so far, I'm just trying to see if it's
> > > the right shape.
> > > 
> > > Igor, is this what you were intending?  
> > 
> > I was thinking about a little less intrusive approach
> > 
> > where vhost_region_add/del are modified to maintain
> > sorted by GPA array of mem_sections, vhost_dev::mem is dropped
> > altogether and vhost_memory_region array is build/used/freed
> > on every vhost_commit().
> > Maintaining sorted array should roughly cost us O(2 log n) if
> > binary search is used.
> > 
> > However I like your idea with iterator even more as it have
> > potential to make it even faster O(n) if we get rid of
> > quadratic and relatively complex vhost_update_compare_list().  
> 
> Note vhost_update_compare_list is complex,
> but it is O(n) - it's
> got nested loops, but the inner loop moves forward and oldi never
> gets reset back to zero.
While skimming through patches I've overlooked it.

Anyways,
why memcmp(old_arr, new_arr) is not sufficient
to detect a change in memory map?

> 
> > Pls, see comments on individual patches.  
> 
> Thanks; I have fixed a couple of bugs since I posted, so I'm
> more interested in structure/shape.  Any good ideas how to test
> it are welcome.
> 
> Dave
> 
> >   
> > > Dave
> > > 
> > > Dr. David Alan Gilbert (7):
> > >   memory: address_space_iterate
> > >   vhost: Move log_dirty check
> > >   vhost: New memory update functions
> > >   vhost: update_mem_cb implementation
> > >   vhost: Compare new and old memory lists
> > >   vhost: Copy updated region data into device state
> > >   vhost: Remove vhost_set_memory and children
> > > 
> > >  hw/virtio/trace-events |   8 +
> > >  hw/virtio/vhost.c      | 424 ++++++++++++++++++++++---------------------------
> > >  include/exec/memory.h  |  23 +++
> > >  memory.c               |  22 +++
> > >  4 files changed, 241 insertions(+), 236 deletions(-)
> > >   
> >   
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
