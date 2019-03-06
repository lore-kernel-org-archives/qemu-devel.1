Received: from eggs.gnu.org ([209.51.188.92]:47084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1KCM-00028T-HX
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 19:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1KCL-0002Z3-9N
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 19:14:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h1KCL-0002Yh-3C
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 19:14:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id a48so10976382qtb.4
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 16:14:12 -0800 (PST)
Date: Tue, 5 Mar 2019 19:14:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190305191334-mutt-send-email-mst@kernel.org>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190214043916.22128-2-david@gibson.dropbear.id.au>
	<20190228083317-mutt-send-email-mst@kernel.org>
	<20190305005207.GA7877@umbus.fritz.box>
	<20190304211451-mutt-send-email-mst@kernel.org>
	<20190305050300.GI7877@umbus.fritz.box>
	<20190305094050-mutt-send-email-mst@kernel.org>
	<20190305233512.GB19715@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305233512.GB19715@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>

On Wed, Mar 06, 2019 at 10:35:12AM +1100, David Gibson wrote:
> On Tue, Mar 05, 2019 at 09:41:34AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Mar 05, 2019 at 04:03:00PM +1100, David Gibson wrote:
> > > On Mon, Mar 04, 2019 at 09:29:24PM -0500, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 05, 2019 at 11:52:08AM +1100, David Gibson wrote:
> > > > > On Thu, Feb 28, 2019 at 08:36:58AM -0500, Michael S. Tsirkin wrote:
> > > > > > On Thu, Feb 14, 2019 at 03:39:12PM +1100, David Gibson wrote:
> > > > > > > When the balloon is inflated, we discard memory place in it using madvise()
> > > > > > > with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, which
> > > > > > > sounds like it makes sense but is actually unnecessary.
> > > > > > > 
> > > > > > > The misleadingly named MADV_DONTNEED just discards the memory in question,
> > > > > > > it doesn't set any persistent state on it in-kernel; all that's necessary
> > > > > > > to bring the memory back is to touch it.  MADV_WILLNEED in contrast
> > > > > > > specifically says that the memory will be used soon and faults it in.
> > > > > > > 
> > > > > > > This patch simplify's the balloon operation by dropping the madvise()
> > > > > > > on deflate.  This might have an impact on performance - it will move a
> > > > > > > delay at deflate time until that memory is actually touched, which
> > > > > > > might be more latency sensitive.  However:
> > > > > > > 
> > > > > > >   * Memory that's being given back to the guest by deflating the
> > > > > > >     balloon *might* be used soon, but it equally could just sit around
> > > > > > >     in the guest's pools until needed (or even be faulted out again if
> > > > > > >     the host is under memory pressure).
> > > > > > > 
> > > > > > >   * Usually, the timescale over which you'll be adjusting the balloon
> > > > > > >     is long enough that a few extra faults after deflation aren't
> > > > > > >     going to make a difference.
> > > > > > > 
> > > > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > > > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > 
> > > > > > I'm having second thoughts about this. It might affect performance but
> > > > > > probably won't but we have no idea.  Might cause latency jitter after
> > > > > > deflate where it previously didn't happen.  This kind of patch should
> > > > > > really be accompanied by benchmarking results, not philosophy.
> > > > > 
> > > > > I guess I see your point, much as it's annoying to spend time
> > > > > benchmarking a device that's basically broken by design.
> > > > 
> > > > Because of 4K page thing?
> > > 
> > > For one thing.  I believe David H has bunch of other reasons.
> > > 
> > > > It's an annoying bug for sure.  There were
> > > > patches to add a feature bit to just switch to plan s/g format, but they
> > > > were abandoned. You are welcome to revive them though.
> > > > Additionally or alternatively, we can easily add a field specifying
> > > > page size.
> > > 
> > > We could, but I'm pretty disinclined to work on this when virtio-mem
> > > is a better solution in nearly every way.
> > 
> > Then one way would be to just let balloon be. Make it behave same as
> > always and don't make changes to it :)
> 
> I'd love to, but it is in real world use, so I think we do need to fix
> serious bugs in it - at least if they can be fixed on one side,
> without needing to roll out both qemu and guest changes (which adding
> page size negotiation would require).


Absolutely I'm just saying don't add optimizations in that case :)

> > 
> > > > > That said.. I don't really know how I'd go about benchmarking it.  Any
> > > > > guesses at a suitable workload which would be most likely to show a
> > > > > performance degradation here?
> > > > 
> > > > Here's one idea - I tried to come up with a worst case scenario here.
> > > > Basically based on idea by Alex Duyck. All credits are his, all bugs are
> > > > mine:
> > > 
> > > Ok.  I'll try to find time to implement this and test it.
> > > 
> > > > Setup:
> > > > Memory-15837 MB
> > > > Guest Memory Size-5 GB
> > > > Swap-Disabled
> > > > Test Program-Simple program which allocates 4GB memory via malloc, touches it via memset and exits.
> > > > Use case-Number of guests that can be launched completely including the successful execution of the test program.
> > > > Procedure:
> > > > Setup:
> > > > A first guest is launched and once its console is up,
> > > > test allocation program is executed with 4 GB memory request (Due to
> > > > this the guest occupies almost 4-5 GB of memory in the host)
> > > > Afterwards balloon is inflated by 4Gbyte in the guest.
> > > > We continue launching the guests until a guest gets
> > > > killed due to low memory condition in the host.
> > > > 
> > > > 
> > > > Now repeatedly, in each guest in turn, balloon is deflated and
> > > > test allocation program is executed with 4 GB memory request (Due to
> > > > this the guest occupies almost 4-5 GB of memory in the host)
> > > > After program finishes balloon is inflated by 4GB again.
> > > > 
> > > > Then we switch to another guest.
> > > > 
> > > > Time how many cycles of this we can do.
> > > > 
> > > > 
> > > > Hope this helps.
> > > > 
> > > > 
> > > > 
> > > 
> > 
> > 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
