Received: from eggs.gnu.org ([2001:4830:134:3::10]:33806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHBHm-0007B5-Kq
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHBHg-000619-A2
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:20:34 -0500
Date: Tue, 21 Nov 2017 17:20:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171121172022.5da16158.cohuck@redhat.com>
In-Reply-To: <1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
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

On Tue, 21 Nov 2017 16:47:29 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 11/21/2017 02:44 PM, Cornelia Huck wrote:
> > On Tue, 21 Nov 2017 12:18:25 +0100
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> > 
> > Subject: s/unresrict/unrestrict/  
> 
> Sure!
> 
> >   
> >> The default css 0xFE is currently restricted to virtual subchannel
> >> devices. The hope when the decision was made was, that non-virtual
> >> subchannel devices will come around when guest can exploit multiple
> >> channel subsystems. Since the guests generally don't do, the pain
> >> of the partitioned (cssid) namespace outweighs the gain.
> >>
> >> Let us remove the corresponding restrictions (virtual devices
> >> can be put only in 0xFE and non-virtual devices in any css except
> >> the 0xFE), and inform management software property on all ccw
> >> devices.  
> > 
> > I do not really like dropping the restrictions while still keeping the
> > default cssid as 0xfe. Putting virtual devices into css 0 seems
> > completely fine, but putting non-virtual devices into css 0xfe still
> > feels a bit wrong. What about:
> > 
> > - Add a property to specify the default cssid. Compat machines use a
> >   default cssid of 0xfe.
> > - Default to a cssid of 0.
> > - (optional) Warn when putting a non-virtual device into css 0xfe,
> >   unless it is the default css.
> >   
> 
> Please see Christians response. IMHO the libvirt perspective, and
> especially keeping the domain xmls as they are today viable is the
> key to a good solution.
> 
> AFAIU one should probably use vfio-ccw as devices having their own
> xml managed via attach-device and detach-device, as they are not
> migratable (thus need to be removed before migrating). If we want
> to be able to attach such devices to domains especially created
> with vfio-ccw in mind putting all the devices into 0xfe seems to
> be the only sane way.
> 
> Something like mcsse-squash isn't really a good solution, because
> doing it behind of the back of the user in libvirt feels wrong,
> and if we have to make the user put it in the domain xml then
> we are back at special domain definitions problem.

See my response in the other thread as well. I'm not really opposed to
keeping 0xfe as the default.

> 
> >>
> >> The adverse effect on migration should not be too severe as
> >> vfio-ccw devices are not live-migratable yet, and for virtual
> >> devices using the extra freedom would only make sense with
> >> the aforementioned guest support in place.
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> >>
> >> ---
> >> Hi!
> >>
> >> About indicating this at the ccw devices instead of, e.g. as a machine
> >> property (or otherwise globally), was requested by our libvirt guys. I
> >> have no strong opinion regarding in this matter.  
> > 
> > I would like to understand why. It feels very odd.
> >   
> 
> @Boris: I would like to delegate explaining to you. I did understand
> your arguments, but I'm not confident about being able to reproduce them
> authentically.
> 
> >>
> >> This patch is intended as a discussion starter. I would at least like to
> >> get a Tested-by by Shalini before promoting it to non-RFC (provided the
> >> discussion goes well).
> >>
> >> TODOs:
> >> * Consider adding a description for the new property.  
> > 
> > As it is, it is rather incomprehensible. But see below.
> >   
> 
> OK. The idea is that this property should be used for libvirt.

Yes, but what for? That was my problem.

> 
> Comprehensibility is a general problem as the user should not
> really have to care about mcss-e at all (see PoP). How should we
> explain mcss-e to the user? AFAIR this is what triggered the usability
> discussion.

I think we can expect an admin wanting to set up machines understand
the fact that there are multiple cssids, but only the default one can
be seen by most guests.

> 
> >> * Consider renaming VIRTUAL_CSSID.  
> > 
> > Why? This is still reserved for virtual devices in the architecture.
> > You just change qemu policy (and possibly what the default cssid is).
> >  
> 
> I don't think so. Where is it reserved in the architecture? The
> only reference I've found is our VSM book. Sorry I really can't
> find it.

It was reserved with some architecture folks; Christian should know (I
obviously don't have access to anything anymore).

>  
> >> * Consider changing the bus-id generation scheme (when
> >> devno is not specified by the user). his patch keep the current scheme in
> >> place: they won't go into the default css (but slots are filled up
> >> starting at cssid 0). This is theoretically good for migration
> >> compatibility same command line same addresses.  Practically since there
> >> is no migratable non-virtual ccw device, we should consider using the
> >> same bus-id generation scheme for virtual and non-virtual devices.  
> > 
> > How does this interact with the squash parameter?  
> 
> 
> With squash it would not change anything: we would start at default cssid which is 0
> with squash. Without squash it would have the effect that we first
> fill the default css and then proceed to the next one. Would change
> behavior. The hope is that nobody used non-virtual devices without
> squash on, as they are useless that way since there is no mcss-e
> guest around.
> 
> The expected benefit is that the devices would show up in the guest
> instead of being effectively inaccessible -- sane defaults.
> 
> I forgot to write, but I would actually like to deprecate the squash.
> I see it as something on top though.

I'd vote for getting rid of it as soon as possible.

> 
> > 
> > If we force the default css to 0xfe for compat machines, we should be
> > fine if we autogenerate to the default css. If you start at css 0
> > regardless of the default css, you might end up with a configuration
> > that the user did not expect at all.
> >   
> 
> I don't force anything in the compat machines here. So I don't understand
> your question.

It refers to my suggestion above (specifying a default css).

> 
> 
> >>
> >> ---
> >>  hw/s390x/ccw-device.c | 6 ++++++
> >>  hw/s390x/css.c        | 9 ---------
> >>  2 files changed, 6 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> >> index f9bfa154d6..2167ccea5d 100644
> >> --- a/hw/s390x/ccw-device.c
> >> +++ b/hw/s390x/ccw-device.c
> >> @@ -40,6 +40,10 @@ static Property ccw_device_properties[] = {
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >>  
> >> +static bool prop_get_true(Object *obj, Error **errp)
> >> +{
> >> +    return true;
> >> +}
> >>  static void ccw_device_class_init(ObjectClass *klass, void *data)
> >>  {
> >>      DeviceClass *dc = DEVICE_CLASS(klass);
> >> @@ -48,6 +52,8 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
> >>      k->realize = ccw_device_realize;
> >>      k->refill_ids = ccw_device_refill_ids;
> >>      dc->props = ccw_device_properties;
> >> +    object_class_property_add_bool(klass, "cssid-unrestricted",
> >> +                                   prop_get_true, NULL, NULL);  
> > 
> > This looks really, really strange. This is a property that is always
> > true if it exists.
> >   
> 
> Won't argue about that. The libvirt guys are actually not interested
> int he value at all: only that there is such a property.

So what about a machine property? Wouldn't that help as well?

Or a css object?

> 
> > What about compat machines? This qemu won't have the restriction, but
> > old qemus will.
> >   
> 
> Very true. But as the commit message implies it should not be a problem.

How is that supposed to play with libvirt detection, then?

> 
> > Also, I'd consider this a property of the machine, not of the
> > individual devices. Or of the ChannelSubsystem structure, which is not
> > qom'ified.
> >   
> 
> I've said the exact same thing to Boris. He said from libvirt perspective
> a device property is better.
> 
> > As an alternative, I think providing a machine default_cssid parameter
> > makes more sense: It is understandable, and you keep compatibility. I
> > think we want this in the long run anyway.
> >   
> 
> I think most of us had the idea. I support this idea fully (expose default
> cssid to the user (rw)). I see it as something that can be done on top
> and is not a pressing issue, but rather a nice to have.

TBH, this weird property is what I like least about this patch.

> 
> >>  }
> >>  
> >>  const VMStateDescription vmstate_ccw_dev = {
> >> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >> index f6b5c807cd..957cb9ec90 100644
> >> --- a/hw/s390x/css.c
> >> +++ b/hw/s390x/css.c
> >> @@ -2377,15 +2377,6 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
> >>      SubchDev *sch;
> >>  
> >>      if (bus_id.valid) {
> >> -        if (is_virtual != (bus_id.cssid == VIRTUAL_CSSID)) {
> >> -            error_setg(errp, "cssid %hhx not valid for %s devices",
> >> -                       bus_id.cssid,
> >> -                       (is_virtual ? "virtual" : "non-virtual"));
> >> -            return NULL;
> >> -        }
> >> -    }  
> > 
> > This allows building a commandline in a compat machine that will not
> > work with old qemus, no?
> >   
> 
> Yes. We have considered this. I was convinced by Christian that
> it ain't too bad. In the end, if we don't want non-virtual device
> aware domains (see above), then there is no way to make this work
> with libvirt. Actually to make the migration work with libvirt with
> old qemus the only way would be to use sqash. But libvirt does not
> want that.
> 
> Also consider that vfio-ccw (AFAIK the only non-virtual css device
> type) is not migratable. So having them on the command line and live
> migrating is a lost case already.
> 
> Yes, having a pre- 2.12 binary version and a post 2.12 binary version
> way to use vfio-ccw is ugly to some extent. The recommendation would
> be don't use it with pre 2.12 (libvirt is going to plainly refuse).
> 
> And yes with this one is going to be able to write a 2.12 command
> line which does not work with 2.11 but that is normal.
> 
> This patch keeps the squash so the 2.10 definition will still be
> viable for 2.12. Should we sometime get rid of the squash, then
> that would be a breaking change.

Removing squash is easy to detect. I'm a bit worried about
not-obvious-at-the-start breakage.

> 
> Regards,
> Halil
> 
> >> -
> >> -    if (bus_id.valid) {
> >>          if (squash_mcss) {
> >>              bus_id.cssid = channel_subsys.default_cssid;
> >>          } else if (!channel_subsys.css[bus_id.cssid]) {  
> >   
> 
