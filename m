Received: from eggs.gnu.org ([2001:4830:134:3::10]:54034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK6AX-0003My-Rw
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK6AU-0001rQ-KY
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:29:09 -0500
Date: Wed, 29 Nov 2017 18:29:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171129182900.409be40f.cohuck@redhat.com>
In-Reply-To: <6f7547b8-1346-53ce-3d80-6839c556d724@linux.vnet.ibm.com>
References: <20171128130758.67556-1-pasic@linux.vnet.ibm.com>
	<20171129133733.7fc11968.cohuck@redhat.com>
	<6f7547b8-1346-53ce-3d80-6839c556d724@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/1] s390x/css: unrestrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Wed, 29 Nov 2017 17:25:59 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 11/29/2017 01:37 PM, Cornelia Huck wrote:
> > On Tue, 28 Nov 2017 14:07:58 +0100
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> The default css 0xfe is currently restricted to virtual subchannel
> >> devices. The hope when the decision was made was, that non-virtual
> >> subchannel devices will come around when guest can exploit multiple  
> > 
> > s/guest/guests/  
> 
> OK.
> 
> >   
> >> channel subsystems. Since the guests generally don't do, the pain  
> > 
> > s/the guests generally don't do/current guests don't do that/
> >   
> 
> OK.
> 
> >> of the partitioned (cssid) namespace outweighs the gain.
> >>
> >> Let us remove the corresponding restrictions (virtual devices
> >> can be put only in 0xfe and non-virtual devices in any css except
> >> the 0xfe -- while s390-squash-mcss then remaps everything to cssid 0).
> >>
> >> With this change, however, our schema for generating a css bus ids, if
> >> none is specified does not make much sense. Currently we start at cssid
> >> 0x0 for non-virtual devices and use the default css (without
> >> s390-squash-mcss exclusively) for virtual devices.  That means for
> >> non-virtual device the device would auto-magically end up non-visible for
> >> guests (which can't use the other channel subsystems).
> >>
> >> Thus let us also change the css bus id auto assignment algorithm,
> >> so that we first fill the default css, and then proceed to the
> >> next one (modulo MAX_CSSID).  
> > 
> > Let's reword the previous two paragraphs:
> > 
> > "At the same time, change our schema for generating css bus ids to put
> > both virtual and non-virtual devices into the default css (spilling
> > over into other css images, if needed) so that devices without a
> > specified id don't end up hidden to guests not supporting multiple
> > channel subsystems."
> >   
> 
> What I don't like about your explanation is, that "so that devices without
> a specified id don't end up hidden to guests not supporting multiple channel 
> subsystems" is not necessarily true: if we spill the devices are going
> to end up hidden.

Let's make this "don't always end up hidden".

> 
> >>
> >> The adverse effect of getting rid of the restriction on migration should
> >> not be too severe.  Vfio-ccw devices are not live-migratable yet, and for
> >> virtual devices using the extra freedom would only make sense with the
> >> aforementioned guest support in place.
> >>
> >> The auto-generated bus ids are affected by both changes. We hope to not
> >> encounter any auto-generated bus ids in production as Libvirt is always
> >> explicit about the bus id.  Since 8ed179c937 ("s390x/css: catch section
> >> mismatch on load", 2017-05-18) the worst that can happen because the same
> >> device ended up having a different bus id is a cleanly failed migration.
> >> I find it hard to reason about the impact of changed auto-generated bus
> >> ids on migration for command line users as I don't know which rules is
> >> such an user supposed to follow.
> >>
> >> Another pain-point is down- or upgrade of QEMU for command line users.
> >> The old way and the new way of doing vfio-ccw are mutually incompatible.
> >> Libvirt is only going to support the new way, so for libvirt users, the
> >> possible problems at QEMU downgrade are the following. If a domain
> >> contains virtual devices placed into a css different than 0xfe the domain
> >> wil refuse to start with a QEMU not having this patch. Putting devices
> >> into a css different that 0xfe however won't make much sense in the
> >> near future (guest support). Libvirt will refuse to do vfio-ccw with
> >> a QEMU not having this patch. This is business as usual.  
> > 
> > All of this is valuable information, but I don't think a changelog is
> > the right place for it. We should really have a place where we can also
> > save things like Dong Jia's writeup downthread. In the documentation
> > folder or on the QEMU wiki (or both). We can be much more verbose there
> > (including examples, which make this stuff way easier to understand).
> > I'd recommend adding a documentation file with this patch (or patch
> > series, as I'd also like to see a squash-mcss deprecation patch).
> >   
> 
> I tired to be quite elaborate, because at some point of the v1
> discussion, you said if we are planting landmines you want them explained
> in the commit message. I'm not sure how this document file is supposed
> to be called, and look like. I think this stuff is relevant for
> the decision why is this patch a good one, and what are the trade-offs
> we make. Referencing to a document would be also OK with me.

I don't think there will be landmines left, no? Or do I misread?

> 
> Regarding the deprecation patch. It's already on the list as RFC. You
> have even commented on it. I intend to make a v2 once we know what are
> we going to do here.

This needs to be a patch series with a cover letter. Discussing in
multiple places is draining.

> 
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>
> >> ---
> >> Hi all!
> >>
> >> Moving the property to the machine turned out very ugly (IMHO).  Libvirt
> >> detects machine properties via query-command-line-options.  This is
> >> however decoupled from the existence of the actual property: one needs to
> >> touch util/qemu-config.c (see patch) so the property shows up.
> >> Furthermore this stuff is global. I've also noticed that the infamous
> >> s390-squash-mcss does not show up.  
> > 
> > s390x-softmmu/qemu-system-s390x -machine s390-ccw-virtio,help
> > 
> > shows it, as does qom-list on /machine.  
> 
> For qom-list you need an instance. Libvirt probes such stuff using
> (btw probing is done with machine type none, and qom-list /machine
> should not list squash if we are running machine type none).
> 
> > 
> > Output of <qemu binary> --help is very haphazard anyway and you should
> > rely on the interfaces above.
> >   
> 
> I disagree. AFAIK management software should probe using the
> query-command-line-options QMP command. Or am I missing something?
> 
> I don't speak about the output of <qemu binary> --help here.

It's the same interface. It both over- and underreports. Querying the
actual object is the only way to get this reliable. If that is not
possible today, it needs to be implemented.

> 
> >>
> >> On the other hand to get the property displayed by -machine
> >> s390-ccw-virtio,help one needs a setter on the property. So I have
> >> created a fake setter which produces an error each time called.  
> > 
> > Yes, this is fugly. A css object would be a better place, but way too
> > much work for now.
> >   
> 
> Actually not necessarily. We could simply put this at the virtual-css-bridge.
> I don't know if Libvirt would accept that though. The problem regarding
> virtual-css-bridge (and css object) was rw properties: we can't set a value
> for a property of the virtual-css-bridge on the command line. That was a
> problem for default-css or whatever but is completely fine for the read
> only property 'cssid-unrestricted'.
> 
> >>
> >> I would strongly prefer putting back the property to the device level!  
> > 
> > I continue to strongly oppose that. The device is entirely the wrong
> > level.
> >   
> 
> I don't recall you ever explaining why. If it's completely wrong
> I would have expected Boris and also me being for long enough around
> to get it at least after the first hint.

Just once again: This is a property of the whole css/machine, not of
the individual device.

No more from me today.
