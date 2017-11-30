Received: from eggs.gnu.org ([2001:4830:134:3::10]:47655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eKQxr-0003Ub-59
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eKQxo-0007nU-05
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:41:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:1718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eKQxn-0007mv-MZ
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:41:23 -0500
Date: Thu, 30 Nov 2017 15:41:12 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171130154112.GA18336@work-vm>
References: <20171129185026.23632-1-dgilbert@redhat.com>
	<20171130122245.7e713d2f@redhat.com>
	<20171130120805.GA3952@work-vm>
	<20171130134057.1d8ecc3e@redhat.com>
	<20171130124720.GB3952@work-vm>
	<20171130135820.69eb5715@redhat.com>
	<20171130130628.GC3952@work-vm>
	<20171130160844.73470c50@redhat.com>
	<20171130151855.GE3952@work-vm>
	<20171130163243.190853ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130163243.190853ad@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/7] Rework vhost memory region updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: maxime.coquelin@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, groug@kaod.org

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Thu, 30 Nov 2017 15:18:55 +0000
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Igor Mammedov (imammedo@redhat.com) wrote:
> > > On Thu, 30 Nov 2017 13:06:29 +0000
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >   
> > > > * Igor Mammedov (imammedo@redhat.com) wrote:  
> > > > > On Thu, 30 Nov 2017 12:47:20 +0000
> > > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > > >     
> > > > > > * Igor Mammedov (imammedo@redhat.com) wrote:    
> > > > > > > On Thu, 30 Nov 2017 12:08:06 +0000
> > > > > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > > > > >       
> > > > > > > > * Igor Mammedov (imammedo@redhat.com) wrote:      
> > > > > > > > > On Wed, 29 Nov 2017 18:50:19 +0000
> > > > > > > > > "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > > > > > > > >         
> > > > > > > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > > > > > > 
> > > > > > > > > > Hi,
> > > > > > > > > >   This is an experimental set that reworks the way the vhost
> > > > > > > > > > code handles changes in physical address space layout that
> > > > > > > > > > came from a discussion with Igor.        
> > > > > > > > > Thanks for looking into it.
> > > > > > > > > 
> > > > > > > > >          
> > > > > > > > > > Instead of updating and trying to merge sections of address
> > > > > > > > > > space on each add/remove callback, we wait until the commit phase
> > > > > > > > > > and go through and rebuild a list by walking the Flatview of
> > > > > > > > > > memory and end up producing an ordered list.
> > > > > > > > > > We compare the list to the old list to trigger updates.
> > > > > > > > > > 
> > > > > > > > > > Note, only very lightly tested so far, I'm just trying to see if it's
> > > > > > > > > > the right shape.
> > > > > > > > > > 
> > > > > > > > > > Igor, is this what you were intending?        
> > > > > > > > > 
> > > > > > > > > I was thinking about a little less intrusive approach
> > > > > > > > > 
> > > > > > > > > where vhost_region_add/del are modified to maintain
> > > > > > > > > sorted by GPA array of mem_sections, vhost_dev::mem is dropped
> > > > > > > > > altogether and vhost_memory_region array is build/used/freed
> > > > > > > > > on every vhost_commit().
> > > > > > > > > Maintaining sorted array should roughly cost us O(2 log n) if
> > > > > > > > > binary search is used.
> > > > > > > > > 
> > > > > > > > > However I like your idea with iterator even more as it have
> > > > > > > > > potential to make it even faster O(n) if we get rid of
> > > > > > > > > quadratic and relatively complex vhost_update_compare_list().        
> > > > > > > > 
> > > > > > > > Note vhost_update_compare_list is complex,
> > > > > > > > but it is O(n) - it's
> > > > > > > > got nested loops, but the inner loop moves forward and oldi never
> > > > > > > > gets reset back to zero.      
> > > > > > > While skimming through patches I've overlooked it.
> > > > > > > 
> > > > > > > Anyways,
> > > > > > > why memcmp(old_arr, new_arr) is not sufficient
> > > > > > > to detect a change in memory map?      
> > > > > > 
> > > > > > It tells you that you've got a change, but doesn't give
> > > > > > the start/end of the range that's changed, and those
> > > > > > are used by vhost_commit to limit the work of
> > > > > > vhost_verify_ring_mappings.    
> > > > > Isn't memmap list a sorted and
> > > > >  dev->mem_changed_[start|end]_addr are the lowest|highest
> > > > > addresses of whole map?
> > > > > 
> > > > > If it's, so wouldn't getting values directly from 
> > > > > the 1st/last entries of array be sufficient?    
> > > > 
> > > > THat wasn't my understanding from the existing code;
> > > > my understanding was that changed_start_addr is set by
> > > > vhost_region_add->vhost_set_memory when a new region is added
> > > > (or removed) and is set to the limit of the section added.
> > > > But perhaps I'm misunderstanding.  
> > > changed_*_addr is actually lower/upper bound of memory transaction
> > > and in practice it often includes several memory sections that
> > > get mapped during transaction (between begin - commit).
> > > 
> > > but then again,
> > >   - how expensive vhost_verify_ring_mappings() is?
> > >   - do we really need optimization here (perhaps finding out changed range is more expensive)?
> > >   - how about calling vhost_verify_ring_mappings() unconditionally?  
> > 
> > My worry is that:
> >     vhost_verify_ring_mappings
> >        vhost_verify_ring_part_mapping
> >           vhost_verify_ring_part_mapping
> >              vhost_memory_map & vhost_memory_unmap
> >                (non-iommu case...)
> >                cpu_physical_memory_map & cpu_physical_memory_unmap
> >                  address_space_map/address_space_unmap
> >                     flatview_translate etc
> > 
> > so it's not cheap at all - I *think* it should end up doing very little
> > after it's gone all the way through that because it should already be
> > mapped; but still it's not trivial.
> neither trivial finding out changed range.
> How often it will be called and what actual time it takes
> for vhost_verify_ring_mappings and vhost_update_compare_list to complete.
> 
> note 
> vhost_memory_map() would be run only on ranges that
> overlap with rings (typically 1), while vhost_update_compare_list()
> would go over all ranges.
> So question is does optimization really saves us anything?

Frankly I don't know - I mean what causes and how often are these
changes anyway?  In my setup here I don't normally see any.
vhost_update_compare_list is a bit complex - but it is O(n) and none of
the things it does are actually expensive - they're just simple min/max;
so it should be pretty cheap.  The case where the entries match is
especially cheap.

Dave

> 
> > 
> > Dave
> > 
> > >   
> > > > (The logic in vhost_verify_ring_mappings doesn't make sense
> > > > to me either though; if vhost_verify_ring_part_mapping returns 0
> > > > on success, why is it doing   if (!r) { break; }  surely it
> > > > should be  if (r) { break; })  
> > > it looks like a bug (CCing Greg)
> > > 
> > > before (f1f9e6c5 vhost: adapt vhost_verify_ring_mappings() to virtio 1 ring layout)
> > > logic used to be
> > > 
> > >    if changed_*_addr doesn't contain ring
> > >       "IGNORE as we don't care"
> > >    
> > >    if changed_*_addr contain ring AND ring can't be mapped at the same place
> > >       ABORT
> > > 
> > > with f1f9e6c5 we have 3 rings so on any of them following could happen
> > >    if "IGNORE as we don't care"
> > >      break => false success 
> > >      since it's possible that the remaining rings in vq do overlap and didn't get checked
> > >   
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
