Received: from eggs.gnu.org ([2001:4830:134:3::10]:38671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gCLz9-00048m-Oz
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 05:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gCLz4-0007Pf-Qj
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 05:49:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gCLz4-000796-4d
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 05:49:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1122837E74
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 09:49:35 +0000 (UTC)
Date: Tue, 16 Oct 2018 10:49:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181016094924.GA2427@work-vm>
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
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

* Alex Williamson (alex.williamson@redhat.com) wrote:
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
> migration.  I think we want the flexibility to allow the user to
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
> 
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
> 
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
> 
> This email is already too long, but I also wonder whether we should
> consider additional vfio-pci interfaces to trigger a link retraining or
> allow virtualized access to the physical upstream port config space.
> Clearly we need to consider multi-function devices and whether there
> are useful configurations that could benefit from such access.  Thanks
> for reading, please discuss,

I'm not sure about the consequences of the actual link speeds, but I
worry we'll hit things looking for PCIe v3 features; in particular
AMD's ROCm code needs PCIe atomics:

https://github.com/RadeonOpenCompute/ROCm_Documentation/blob/master/Installation_Guide/More-about-how-ROCm-uses-PCIe-Atomics.rst

so it feels like getting that to work with passthrough would
need some negotiation of features.

Dave

> Alex
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
