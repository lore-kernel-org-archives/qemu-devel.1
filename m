Received: from eggs.gnu.org ([2001:4830:134:3::10]:42569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gCSUC-00008c-Uc
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gCSU6-0000vb-2R
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:46:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gCSU1-0000sA-O7
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 12:46:15 -0400
Date: Tue, 16 Oct 2018 10:46:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181016104607.2bc383c8@w520.home>
In-Reply-To: <20181016110735-mutt-send-email-mst@kernel.org>
References: <20181015141841.09b945e5@w520.home>
	<20181016110735-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU PCIe link "negotiation"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Tue, 16 Oct 2018 11:21:28 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Oct 15, 2018 at 02:18:41PM -0600, Alex Williamson wrote:
> > Hi,
> > 
> > I'd like to start a discussion about virtual PCIe link width and speeds
> > in QEMU to figure out how we progress past the 2.5GT/s, x1 width links
> > we advertise today.  This matters for assigned devices as the endpoint
> > driver may not enable full physical link utilization if the upstream
> > port only advertises minimal capabilities.  One GPU assignment users
> > has measured that they only see an average transfer rate of 3.2GB/s
> > with current code, but hacking the downstream port to advertise an
> > 8GT/s, x16 width link allows them to get 12GB/s.  Obviously not all
> > devices and drivers will have this dependency and see these kinds of
> > improvements, or perhaps any improvement at all.
> > 
> > The first problem seems to be how we expose these link parameters in a
> > way that makes sense and supports backwards compatibility and
> > migration.  
> 
> Isn't this just for vfio though? So why worry about migration?

Migration is coming for vfio devices, mdev devices in the near(er)
term, but I wouldn't be too terribly surprised to see device specific
migration support either.  Regardless, we support hotplug of vfio
devices therefore we cannot only focus on cold-plug scenarios and any
hotplug scenario must work irrespective of whether the VM has been
previously migrated.  If we start with a x16/8GT root port with an
assigned GPU, unplug the GPU, migrate, and hot-add a GPU on the target,
it might behave differently if that root port is only exposing x1/2.5GT
capabilities.

I did consider whether devices can dynamically change their speed and
width capabilities, for instance the supported speeds vector in LNKCAP2
is indicated as hardware-init, so I think software would reasonable
expect that these values cannot change, however the max link speed and
max link width values in LNKCAP are simply read-only.  Flirting with
which registers software might consider dynamic, when they're clearly
not dynamic on real hardware seems troublesome though.

> >  I think we want the flexibility to allow the user to
> > specify per PCIe device the link width and at least the maximum link
> > speed, if not the actual discrete link speeds supported.  However,
> > while I want to provide this flexibility, I don't necessarily think it
> > makes sense to burden the user to always specify these to get
> > reasonable defaults.  So I would propose that we a) add link parameters
> > to the base PCIe device class and b) set defaults based on the machine
> > type.  Additionally these machine type defaults would only apply to
> > generic PCIe root ports and switch ports, anything based on real
> > hardware would be fixed, ex. ioh3420 would stay at 2.5GT/s, x1 unless
> > overridden by the user.  Existing machine types would also stay at this
> > "legacy" rate, while pc-q35-3.2 might bring all generic devices up to
> > PCIe 4.0 specs, x32 width and 16GT/s, where the per-endpoint
> > negotiation would bring us back to negotiated widths and speeds
> > matching the endpoint.  Reasonable?  
> 
> Generally yes.  Last time I looked, there's a bunch of stuff the spec
> says we need to do for the negotiation. E.g. guest can at any time
> request width re-negotiation. Maybe most guests don't do it but it's
> still in the spec and we never know whether anyone will do it in the
> future.
> 
> VFIO is often a compromise but for virtual devices
> I'd prefer we are stictly compliant if possible.

I would also want to be as spec compliant as possible and we'll need to
think about how to incorporate things like link change notifications,
these may require additional support from vfio if we can capture the
event on the host and plumb it through the virtual downstream port.  In
general though, I think retraining a link width changes will be rather
transparently handled if the downstream port defers to mirroring the
link status of the connected endpoint.  I'll try to look specifically
at each interaction for compliance, but if you have any specific
things you think are going to be troublesome, please let me know. 

> > Next I think we need to look at how and when we do virtual link
> > negotiation.  We're mostly discussing a virtual link, so I think
> > negotiation is simply filling in the negotiated link and width with the
> > highest common factor between endpoint and upstream port.  For assigned
> > devices, this should match the endpoint's existing negotiated link
> > parameters, however, devices can dynamically change their link speed
> > (perhaps also width?), so I believe a current link seed of 2.5GT/s
> > could upshift to 8GT/s without any sort of visible renegotiation.  Does
> > this mean that we should have link parameter callbacks from downstream
> > port to endpoint?  Or maybe the downstream port link status register
> > should effectively be an alias for LNKSTA of devfn 00.0 of the
> > downstream device when it exists.  We only need to report a consistent
> > link status value when someone looks at it, so reading directly from
> > the endpoint probably makes more sense than any sort of interface to
> > keep the value current.  
> 
> Don't we need to reflect the physical downstream link speed
> somehow though?

The negotiated physical downstream port speed and width must match the
endpoint's speed and width, so I think the only concern here is that we
might have a mismatch of capabilities, right?  I'm not sure we have an
alternative though.  If the root port capabilities need to match the
physical device, then we've essentially precluded hotplug unless we're
going to suggest that we always hot-add a matching root port, into
which we'll then hot-add the assigned device.  Therefore I favored the
approach of simply over-spec'ing the virtual devices and I think there
are physical precedents for such as well.  For example, there exist a
range of passive adapter and expansion devices for PCIe which can
change the width and may also restrict the speed.  A x16 endpoint may
only negotiate a x1 width even though both the endpoint and slot are
x16 capable if one of these[1] is interposed between them.  The link
speed may be similarly restricted with one of these[2].

[1]https://www.amazon.com/gp/product/B0039XPS5W/
[2]https://www.amazon.com/Laptop-External-PCI-Graphics-Card/dp/B00Q4VMLF6

In the scheme I propose, the user would have the ability to set the
root port to speeds and widths that match the physical device, but the
default case would be to effectively over-provision the virtual device.

> > If we take the above approach with LNKSTA (probably also LNKSTA2), is
> > any sort of "negotiation" required?  We're automatically negotiated if
> > the capabilities of the upstream port are a superset of the endpoint's
> > capabilities.  What do we do and what do we care about when the
> > upstream port is a subset of the endpoint though?  For example, an
> > 8GT/s, x16 endpoint is installed into a 2.5GT/s, x1 downstream port.
> > On real hardware we obviously negotiate the endpoint down to the
> > downstream port parameters.  We could do that with an emulated device,
> > but this is the scenario we have today with assigned devices and we
> > simply leave the inconsistency.  I don't think we actually want to
> > (and there would be lots of complications to) force the physical device
> > to negotiate down to match a virtual downstream port.  Do we simply
> > trigger a warning that this may result in non-optimal performance and
> > leave the inconsistency?  
> 
> Also when guest pokes at the width do we need to tweak the
> physical device/downstream port?

How does the guest poke at width?  The guest can set a link target
speed in LNKCTL2, but the width seems to be only negotiated at the
physical level.  AIUI the standard procedure would be for a driver to
set a target link speed and then retrain the link from the downstream
port to implement that request.  The retraining may or may not achieve
the target link speed and retraining is transparent to the data layer
of the link, therefore it seems safe to do nothing on retraining, but
we may want to consider it as a future enhancement.  Physical link
retraining also gets us into scenarios where we need to think about
multifunction end points and the ownership of the endpoints affected by
a link retraining.  It might be like the bus reset support where the
user needs to own all the affected devices to initiate a link
retraining.  I don't think anything here precludes that, it'd be an
additional callback from the downstream port to the devfn 00.0 endpoint
to initiate a retraining and vfio would need to figure out what it can
do with that.  Thanks,

Alex
