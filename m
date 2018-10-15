Received: from eggs.gnu.org ([2001:4830:134:3::10]:48906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gC0LF-0005lq-BJ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gC0LA-0004Gt-QG
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:43:17 -0400
Date: Mon, 15 Oct 2018 06:43:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181015063430-mutt-send-email-mst@kernel.org>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-2-david@gibson.dropbear.id.au>
	<20181012140306-mutt-send-email-mst@kernel.org>
	<996ed901-14b6-7461-a094-771a715cd6b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996ed901-14b6-7461-a094-771a715cd6b2@redhat.com>
Subject: Re: [Qemu-devel] [RFC 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Mon, Oct 15, 2018 at 08:54:27AM +0200, David Hildenbrand wrote:
> On 12/10/2018 20:05, Michael S. Tsirkin wrote:
> > On Fri, Oct 12, 2018 at 02:24:27PM +1100, David Gibson wrote:
> >> When the balloon is inflated, we discard memory place in it using madvise()
> >> with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, which
> >> sounds like it makes sense but is actually unnecessary.
> >>
> >> The misleadingly named MADV_DONTNEED just discards the memory in question,
> >> it doesn't set any persistent state on it in-kernel; all that's necessary
> >> to bring the memory back is to touch it.  MADV_WILLNEED in contrast
> >> specifically says that the memory will be used soon and faults it in.
> >>
> >> Memory that's being given back to the guest by deflating the balloon
> >> *might* be used soon, but it equally could just sit around in the guest's
> >> pools until it actually needs it.  And, over the general timescale that
> >> memory ballooning operates, it seems unlikely that one extra fault for the
> >> guest will be a vast performance issue.
> > 
> > Thinking about it, it might be for RT guests.
> > 
> > So I suspect if you want to drop MADV_WILLNEED you need a flag
> > telling qemu that's not the usecase.
> > 
> 
> As far as I know RT guests
> 
> 1. mlock all memory
> 2. use huge pages
> 
> "MADV_DONTNEED cannot be applied to locked pages, Huge TLB pages, or
> VM_PFNMAP pages."
> 
> As DONTNEED never succeeded, WILLNEED will do nothing. (e.g. postcopy
> temporarily has to unlock all memory in order to make DONTNEED work)


Hmm you are right.
Document this in commit log?


> (And "Expect access in the near future." does not sound like guarantees
> to me either way)

Should we be concerned about impact on performance though?

Thinking aloud it might have an impact.  But there is also a benefit.
Let's document known effects so people know what to look for
if they see issues?

	WILLNEED aggressively faults all memory in, removing it
	will cause just as much memory as needed to be allocated on access,
	slowing down the CPU at that point but conserving host memory.

	With this patch device assignment (e.g. with VFIO) hotplug will take longer
	as it needs to allocate all this memory on hotplug.
	While this happens all VM is paused right now.


> So I think this can go.
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
