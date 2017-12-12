Received: from eggs.gnu.org ([2001:4830:134:3::10]:36821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOiM8-0006Jw-HF
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOiM5-000396-Ak
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:04:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eOiM5-00037t-2R
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 06:04:09 -0500
Date: Tue, 12 Dec 2017 11:03:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171212110357.GD2409@work-vm>
References: <20171211194610.3962-1-dgilbert@redhat.com>
	<20171211194610.3962-2-dgilbert@redhat.com>
	<97feaaf8-b08e-2c49-6cdb-b1556f6326cd@redhat.com>
	<20171212103138.GC2409@work-vm>
	<7677f3f3-72b9-0f0c-13ca-ace1196ed45b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7677f3f3-72b9-0f0c-13ca-ace1196ed45b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] memory: address_space_iterate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, maxime.coquelin@redhat.com, groug@kaod.org, mst@redhat.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 12/12/2017 11:31, Dr. David Alan Gilbert wrote:
> > * Paolo Bonzini (pbonzini@redhat.com) wrote:
> >> On 11/12/2017 20:46, Dr. David Alan Gilbert (git) wrote:
> >>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>>
> >>> Iterate through an address space calling a function for each
> >>> section.  The iteration is done in order.
> >>>
> >>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>
> >> It seems to me that you can achieve the same effect by implementing the
> >> region_add and region_nop callbacks, and leaving out region_del.  Am I
> >> missing something?
> > 
> > What's the semantics of region_nop (and for that matter region_add/del)?
> 
> nop means that attributes (readonly, romd_mode, mr+offset_in_region)
> haven't changed; nop is optionally followed by log_start or log_stop.
> If any of them changes, you get del+add (del is always before add).
> 
> > Th nice thing we have here is we get a full walk of the physical memory
> > in order; keeping it in order makes our data structure easy for merging.
> 
> That's the same that you get with region_del/add.

Hmm it would be good if that was documented somewhere.
I thought you'd only get an _add/_del and then a commit.

However, what do I do in vhost_dev_start?  At the moment I'm forcfully
regenerating it using the same code.

Dave

> Thanks,
> 
> Paolo
> 
> > Dave
> > 
> > 
> >> Thanks,
> >>
> >> Paolo
> >>
> >>> ---
> >>>  include/exec/memory.h | 23 +++++++++++++++++++++++
> >>>  memory.c              | 22 ++++++++++++++++++++++
> >>>  2 files changed, 45 insertions(+)
> >>>
> >>> diff --git a/include/exec/memory.h b/include/exec/memory.h
> >>> index 5ed4042f87..f5a9df642e 100644
> >>> --- a/include/exec/memory.h
> >>> +++ b/include/exec/memory.h
> >>> @@ -1987,6 +1987,29 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
> >>>      address_space_write(cache->as, cache->xlat + addr, MEMTXATTRS_UNSPECIFIED, buf, len);
> >>>  }
> >>>  
> >>> +/**
> >>> + * ASIterateCallback: Function type called by address_space_iterate
> >>> + *
> >>> + * Return 0 on success or a negative error code.
> >>> + *
> >>> + * @mrs: Memory region section for this range
> >>> + * @opaque: The opaque value passed in to the iterator.
> >>> + */
> >>> +typedef int (*ASIterateCallback)(MemoryRegionSection *mrs, void *opaque);
> >>> +
> >>> +/**
> >>> + * address_space_iterate: Call the function for each address range in the
> >>> + *                        AddressSpace, in sorted order.
> >>> + *
> >>> + * Return 0 on success or a negative error code.
> >>> + *
> >>> + * @as: Address space to iterate over
> >>> + * @cb: Function to call.  If the function returns none-0 the iteration will
> >>> + *     stop.
> >>> + * @opaque: Value to pass to the function
> >>> + */
> >>> +int
> >>> +address_space_iterate(AddressSpace *as, ASIterateCallback cb, void *opaque);
> >>>  #endif
> >>>  
> >>>  #endif
> >>> diff --git a/memory.c b/memory.c
> >>> index e26e5a3b1d..f45137f25e 100644
> >>> --- a/memory.c
> >>> +++ b/memory.c
> >>> @@ -2810,6 +2810,28 @@ void address_space_destroy(AddressSpace *as)
> >>>      call_rcu(as, do_address_space_destroy, rcu);
> >>>  }
> >>>  
> >>> +int address_space_iterate(AddressSpace *as, ASIterateCallback cb,
> >>> +                          void *opaque)
> >>> +{
> >>> +    int res = 0;
> >>> +    FlatView *fv = address_space_to_flatview(as);
> >>> +    FlatRange *range;
> >>> +
> >>> +    flatview_ref(fv);
> >>> +
> >>> +    FOR_EACH_FLAT_RANGE(range, fv) {
> >>> +        MemoryRegionSection mrs = section_from_flat_range(range, fv);
> >>> +        res = cb(&mrs, opaque);
> >>> +        if (res) {
> >>> +            break;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    flatview_unref(fv);
> >>> +
> >>> +    return res;
> >>> +}
> >>> +
> >>>  static const char *memory_region_type(MemoryRegion *mr)
> >>>  {
> >>>      if (memory_region_is_ram_device(mr)) {
> >>>
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
