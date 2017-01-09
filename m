Received: from eggs.gnu.org ([2001:4830:134:3::10]:49626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQilX-0001d4-DW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 17:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQilR-0002nk-B9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 17:50:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQilR-0002nU-29
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 17:50:05 -0500
Date: Tue, 10 Jan 2017 00:50:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110004725-mutt-send-email-mst@kernel.org>
References: <20161216003520-mutt-send-email-mst@kernel.org>
	<586328DD.3040203@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <586328DD.3040203@cn.fujitsu.com>
Subject: Re: [Qemu-devel] vfio/pci: guest error recovery proposal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, izumi.taku@jp.fujitsu.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Wed, Dec 28, 2016 at 10:52:13AM +0800, Cao jin wrote:
> 
> 
> On 12/16/2016 07:02 AM, Michael S. Tsirkin wrote:
> > 
> >>  1) We need to do the right thing for the guest, I don't think we
> >>     should be presuming that different reset types are equivalent,
> >>     leaving gaps where we expect the guest/host to do a reset and don't
> >>     follow through on other reset requests, and we need to notify the
> >>     guest immediately for the error.
> > c>  2) We need to do the right thing for the host, that means we should
> >>     not give the user the opportunity to leave a device in a state
> >>     where we haven't at least performed a bus reset on link error (this
> >>     may be our current state and if so we should fix it).
> > 
> > Ok so here is a concrete proposal for improving guest device error
> > recovery (1).  This is not trying to fix current bugs for 2, but
> > also does not lock us into not fixing them.
> > 
> > I'll write up proposal for (2) but I feel we can't properly
> > fix host without fixing (1) first and without breaking compatibility.
> > 
> > Background:
> > 
> > non-fatal errors:
> > 
> > - These errors are due to data link problems.
> >   The problem is that a transaction was lost, so driver and device are
> >   out of sync. Device reset is in theory enough to recover from these,
> >   in practice some drivers might try to do link level reset instead.
> > 
> > 
> > fatal errors:
> > 
> > - These errors are due to physical problems.
> >   The problem is that a transaction was lost, so driver and device are
> >   out of sync. Link reset might be necessary to recover from these,
> >   sometimes device reset might be enough for very simple devices.
> >   If a link above the device reports errors, device might have went away,
> >   link reset is the only thing that might being it back.
> > 
> > current behaviour:
> > 
> > - vfio will always report that it recovered function from an error.
> > - whether link reset will trigger depends on whether any other
> >   function on the same link has a host driver that reports an error.
> > - also, if there's a host driver that can't handle errors,
> >   link reset will never trigger
> > 
> > 
> > proposed enhancement:
> > 
> > 1- allow userspace to request reporting non fatal/fatal errors separately
> > 2- report errors on monitor as events as well
> > 3- forward correct error type to guest
> > 4- set link error flag in userspace (this is optional, used for 5 below)
> > 5- if guest requests link reset, and error flag is set,
> >   stop vm (I hope we can distinguish this
> >   from resets that happen on reboot here.
> >   if yes we might not need error flag in 4 above)
> > 
> 
> Hi,
> 
> I have a question about vm stop on fatal error.
> Recently, When test my patches, I often saw fatal error(Malformed TLP
> Status) happens, which disturbed my test. So I am wondering: why vm stop
> is a better choice than qdev_unplug? Although we told user "Please
> collect any data possible and then kill the guest", I still don't know
> how to save any possible data. For example, if user is editing document,
> vm_stop caused by a device fatal error will destroy user's effort.
> 
> -- 
> Sincerely,
> Cao jin

Why vm stop might not always be the right thing to do
it happens to be what we already do.

This patchset isn't making any progress for a long time.

Focusing on incremental enhancements with minimal changes
at each step is probably the only
chance there is to make meaningful progress.


> > 
> > Results:
> > The advantage of this is that we don't need to manage any state at all.
> > Most drivers will handle non fatal errors by FLR and will recover fine.
> > Drivers that attempt link reset will get vmstop which is not
> > worse than what we have now.
> > 
> > I don't see how this can break any reasonable configuration
> > that is not already broken, but we might want a flag
> > to suppress aer reports to guest and just do vmstop
> > unconditionally.
> > Alternatively, management can pause vm itself when it sees the error.
> > 
> > 
> > Pls remember to Cc qemu list on discussion, not just kvm.
> > 
> 
> 
> 
