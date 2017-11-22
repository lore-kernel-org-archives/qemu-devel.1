Received: from eggs.gnu.org ([2001:4830:134:3::10]:32848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHTud-0002cI-GZ
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHTuY-0004Ll-HG
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:13:55 -0500
Date: Wed, 22 Nov 2017 13:13:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171122131343.26da0482.cohuck@redhat.com>
In-Reply-To: <88bc72cf-732c-fc07-9898-18d7b58b947d@linux.vnet.ibm.com>
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
	<20171121172022.5da16158.cohuck@redhat.com>
	<88bc72cf-732c-fc07-9898-18d7b58b947d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
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

On Tue, 21 Nov 2017 18:05:46 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 11/21/2017 05:20 PM, Cornelia Huck wrote:
> > On Tue, 21 Nov 2017 16:47:29 +0100
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> On 11/21/2017 02:44 PM, Cornelia Huck wrote:  
> >>> On Tue, 21 Nov 2017 12:18:25 +0100
> >>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:  

> >>>> * Consider changing the bus-id generation scheme (when
> >>>> devno is not specified by the user). his patch keep the current scheme in
> >>>> place: they won't go into the default css (but slots are filled up
> >>>> starting at cssid 0). This is theoretically good for migration
> >>>> compatibility same command line same addresses.  Practically since there
> >>>> is no migratable non-virtual ccw device, we should consider using the
> >>>> same bus-id generation scheme for virtual and non-virtual devices.    
> >>>
> >>> How does this interact with the squash parameter?    
> >>
> >>
> >> With squash it would not change anything: we would start at default cssid which is 0
> >> with squash. Without squash it would have the effect that we first
> >> fill the default css and then proceed to the next one. Would change
> >> behavior. The hope is that nobody used non-virtual devices without
> >> squash on, as they are useless that way since there is no mcss-e
> >> guest around.
> >>
> >> The expected benefit is that the devices would show up in the guest
> >> instead of being effectively inaccessible -- sane defaults.
> >>
> >> I forgot to write, but I would actually like to deprecate the squash.
> >> I see it as something on top though.  
> > 
> > I'd vote for getting rid of it as soon as possible.
> >  
> 
> Me to. I've already got my patch for deprecation half baked ;).
>  
> The original question was about weather keep the start putting
> non-virtual devices into (the non-guest-visible) 0 if no devno is
> specified, or rather fill the default first and only then spill
> to the next css.

Combined with what I said right below, I think we should be fine
autogenerating into the default css. Anything else will just generate
unusable configurations when the squash parameter is gone.

> 
> >>  
> >>>
> >>> If we force the default css to 0xfe for compat machines, we should be
> >>> fine if we autogenerate to the default css. If you start at css 0
> >>> regardless of the default css, you might end up with a configuration
> >>> that the user did not expect at all.

> >>>> +    object_class_property_add_bool(klass, "cssid-unrestricted",
> >>>> +                                   prop_get_true, NULL, NULL);    
> >>>
> >>> This looks really, really strange. This is a property that is always
> >>> true if it exists.
> >>>     
> >>
> >> Won't argue about that. The libvirt guys are actually not interested
> >> int he value at all: only that there is such a property.  
> > 
> > So what about a machine property? Wouldn't that help as well?
> >   
> 
> Technically it is doable. The property would be still a weird
> one, but from QEMU perspective in a less weird place. I was also
> arguing that from OO perspective this kind of a don't care about
> it's value property is weird, but AFAIK not having the info if
> we can do something with a device at the device is weird from
> Libvirt perspective. I'm really uncomforble with speaking for
> Libvirt/Boris. Hope he will make his point tomorrow.
> 
> > Or a css object?
> >   
> 
> My first internal-only version used this approach, but
> I was asked to do it like this.

If we formulate this rather as "we now expose the default css", we (a)
have something that really makes the most sense at a channel subsystem
or machine level, and (b) can be detected by libvirt as an indicator of
"no restriction for virtual vs. non-virtual".

> 
> >>  
> >>> What about compat machines? This qemu won't have the restriction, but
> >>> old qemus will.
> >>>     
> >>
> >> Very true. But as the commit message implies it should not be a problem.  
> > 
> > How is that supposed to play with libvirt detection, then?
> >   
> 
> As written above. Libvirt will simply refuse to use vfio-ccw if the property
> is not defined. This results in no prior history to care about for libvirt
> users: vfio-ccw effectively becomes available with qemu 2.12.

I'm not worried about vfio-ccw. As you said, this should work. We just
need to make sure that we don't break existing setups. (I don't think
we will.)

> 
> >>  
> >>> Also, I'd consider this a property of the machine, not of the
> >>> individual devices. Or of the ChannelSubsystem structure, which is not
> >>> qom'ified.
> >>>     
> >>
> >> I've said the exact same thing to Boris. He said from libvirt perspective
> >> a device property is better.
> >>  
> >>> As an alternative, I think providing a machine default_cssid parameter
> >>> makes more sense: It is understandable, and you keep compatibility. I
> >>> think we want this in the long run anyway.
> >>>     
> >>
> >> I think most of us had the idea. I support this idea fully (expose default
> >> cssid to the user (rw)). I see it as something that can be done on top
> >> and is not a pressing issue, but rather a nice to have.  
> > 
> > TBH, this weird property is what I like least about this patch.
> >   
> 
> I'm fine with any of the 3 alternatives (as is, new type, new machine prop).
> 
> I do agree the property is weird, but a machine property would in my opinion
> also be weird (especially form libvirt perspective, but also from qemu
> perspective e.g. compat handling and machine type none).
> 
> I used to think that using a trait type is the cleanest, but one advantage

What is a "trait type"?

> of the approach taken in this patch is that it can be introspected via command
> line (it is quite weird though).

Any property should be introspectable, no?

> 
> >>>>  }
> >>>>  
> >>>>  const VMStateDescription vmstate_ccw_dev = {
> >>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >>>> index f6b5c807cd..957cb9ec90 100644
> >>>> --- a/hw/s390x/css.c
> >>>> +++ b/hw/s390x/css.c
> >>>> @@ -2377,15 +2377,6 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
> >>>>      SubchDev *sch;
> >>>>  
> >>>>      if (bus_id.valid) {
> >>>> -        if (is_virtual != (bus_id.cssid == VIRTUAL_CSSID)) {
> >>>> -            error_setg(errp, "cssid %hhx not valid for %s devices",
> >>>> -                       bus_id.cssid,
> >>>> -                       (is_virtual ? "virtual" : "non-virtual"));
> >>>> -            return NULL;
> >>>> -        }
> >>>> -    }    
> >>>
> >>> This allows building a commandline in a compat machine that will not
> >>> work with old qemus, no?
> >>>     
> >>
> >> Yes. We have considered this. I was convinced by Christian that
> >> it ain't too bad. In the end, if we don't want non-virtual device
> >> aware domains (see above), then there is no way to make this work
> >> with libvirt. Actually to make the migration work with libvirt with
> >> old qemus the only way would be to use sqash. But libvirt does not
> >> want that.
> >>
> >> Also consider that vfio-ccw (AFAIK the only non-virtual css device
> >> type) is not migratable. So having them on the command line and live
> >> migrating is a lost case already.
> >>
> >> Yes, having a pre- 2.12 binary version and a post 2.12 binary version
> >> way to use vfio-ccw is ugly to some extent. The recommendation would
> >> be don't use it with pre 2.12 (libvirt is going to plainly refuse).
> >>
> >> And yes with this one is going to be able to write a 2.12 command
> >> line which does not work with 2.11 but that is normal.
> >>
> >> This patch keeps the squash so the 2.10 definition will still be
> >> viable for 2.12. Should we sometime get rid of the squash, then
> >> that would be a breaking change.  
> > 
> > Removing squash is easy to detect. I'm a bit worried about
> > not-obvious-at-the-start breakage.
> >   
> 
> Again won't happen with libvirt. With a direct command line user
> downgrading or moving to a qemu 2.10 or 2.11 it is a risk we can
> take IMHO.

I want to avoid setting landmines, though.

> 
> Also I can't find anything about vfio-ccw in the upstream users
> manual for 2.10.91. 

We have an "upstream users manual"?

> So I would argue using vfio-ccw is using an
> undocumented feature: if undocumented features changing in a non
> compatible way hits you, it's partly your own fault.

If it's an x- interface, it is preliminary. If not, we should avoid
breaking it.
