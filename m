Received: from eggs.gnu.org ([2001:4830:134:3::10]:42015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gCRAF-0008J9-GJ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gCRA7-0002um-Q9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:21:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gCRA5-0002gJ-LS
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:21:33 -0400
Date: Tue, 16 Oct 2018 11:21:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181016110735-mutt-send-email-mst@kernel.org>
References: <20181015141841.09b945e5@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015141841.09b945e5@w520.home>
Subject: Re: [Qemu-devel] QEMU PCIe link "negotiation"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Mon, Oct 15, 2018 at 02:18:41PM -0600, Alex Williamson wrote:
> Hi,
> 
> I'd like to start a discussion about virtual PCIe link width and speeds
> in QEMU to figure out how we progress past the 2.5GT/s, x1 width links
> we advertise today.  This matters for assigned devices as the endpoint
> driver may not enable full physical link utilization if the upstream
> port only advertises minimal capabilities.  One GPU assignment users
> has measured that they only see an average transfer rate of 3.2GB/s
> with current code, but hacking the downstream port to advertise an
> 8GT/s, x16 width link allows them to get 12GB/s.  Obviously not all
> devices and drivers will have this dependency and see these kinds of
> improvements, or perhaps any improvement at all.
> 
> The first problem seems to be how we expose these link parameters in a
> way that makes sense and supports backwards compatibility and
> migration.

Isn't this just for vfio though? So why worry about migration?

>  I think we want the flexibility to allow the user to
> specify per PCIe device the link width and at least the maximum link
> speed, if not the actual discrete link speeds supported.  However,
> while I want to provide this flexibility, I don't necessarily think it
> makes sense to burden the user to always specify these to get
> reasonable defaults.  So I would propose that we a) add link parameters
> to the base PCIe device class and b) set defaults based on the machine
> type.  Additionally these machine type defaults would only apply to
> generic PCIe root ports and switch ports, anything based on real
> hardware would be fixed, ex. ioh3420 would stay at 2.5GT/s, x1 unless
> overridden by the user.  Existing machine types would also stay at this
> "legacy" rate, while pc-q35-3.2 might bring all generic devices up to
> PCIe 4.0 specs, x32 width and 16GT/s, where the per-endpoint
> negotiation would bring us back to negotiated widths and speeds
> matching the endpoint.  Reasonable?

Generally yes.  Last time I looked, there's a bunch of stuff the spec
says we need to do for the negotiation. E.g. guest can at any time
request width re-negotiation. Maybe most guests don't do it but it's
still in the spec and we never know whether anyone will do it in the
future.

VFIO is often a compromise but for virtual devices
I'd prefer we are stictly compliant if possible.

> Next I think we need to look at how and when we do virtual link
> negotiation.  We're mostly discussing a virtual link, so I think
> negotiation is simply filling in the negotiated link and width with the
> highest common factor between endpoint and upstream port.  For assigned
> devices, this should match the endpoint's existing negotiated link
> parameters, however, devices can dynamically change their link speed
> (perhaps also width?), so I believe a current link seed of 2.5GT/s
> could upshift to 8GT/s without any sort of visible renegotiation.  Does
> this mean that we should have link parameter callbacks from downstream
> port to endpoint?  Or maybe the downstream port link status register
> should effectively be an alias for LNKSTA of devfn 00.0 of the
> downstream device when it exists.  We only need to report a consistent
> link status value when someone looks at it, so reading directly from
> the endpoint probably makes more sense than any sort of interface to
> keep the value current.

Don't we need to reflect the physical downstream link speed
somehow though?


> If we take the above approach with LNKSTA (probably also LNKSTA2), is
> any sort of "negotiation" required?  We're automatically negotiated if
> the capabilities of the upstream port are a superset of the endpoint's
> capabilities.  What do we do and what do we care about when the
> upstream port is a subset of the endpoint though?  For example, an
> 8GT/s, x16 endpoint is installed into a 2.5GT/s, x1 downstream port.
> On real hardware we obviously negotiate the endpoint down to the
> downstream port parameters.  We could do that with an emulated device,
> but this is the scenario we have today with assigned devices and we
> simply leave the inconsistency.  I don't think we actually want to
> (and there would be lots of complications to) force the physical device
> to negotiate down to match a virtual downstream port.  Do we simply
> trigger a warning that this may result in non-optimal performance and
> leave the inconsistency?

Also when guest pokes at the width do we need to tweak the
physical device/downstream port?

> This email is already too long, but I also wonder whether we should
> consider additional vfio-pci interfaces to trigger a link retraining or
> allow virtualized access to the physical upstream port config space.
> Clearly we need to consider multi-function devices and whether there
> are useful configurations that could benefit from such access.  Thanks
> for reading, please discuss,
> 
> Alex
