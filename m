Received: from eggs.gnu.org ([2001:4830:134:3::10]:38318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dALKw-0002dS-Ad
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dALKt-0007bW-5E
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:07:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dALKs-0007bJ-Rx
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:07:15 -0400
Date: Mon, 15 May 2017 20:07:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170515190706.GD2324@work-vm>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-7-pasic@linux.vnet.ibm.com>
	<20170508173650.GJ2120@work-vm>
	<877c80d1-fa63-0fd1-e394-fb649281aea1@linux.vnet.ibm.com>
	<20170508175906.GK2120@work-vm>
	<b69e0df0-120f-6634-d7ff-4bea9ccb4e31@linux.vnet.ibm.com>
	<20170508184251.GM2120@work-vm>
	<f84db83a-4347-ef8c-56d3-ba3171d5a430@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f84db83a-4347-ef8c-56d3-ba3171d5a430@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] virtio-ccw: use vmstate way for
 config migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 05/08/2017 08:42 PM, Dr. David Alan Gilbert wrote:
> > * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>
> >>
> >> On 05/08/2017 07:59 PM, Dr. David Alan Gilbert wrote:
> >>>>>>  const VMStateDescription vmstate_virtio_ccw_dev = {
> >>>>>>      .name = "s390_virtio_ccw_dev",
> >>>>>>      .version_id = 1,
> >>>>>> @@ -67,6 +93,14 @@ const VMStateDescription vmstate_virtio_ccw_dev = {
> >>>>>>          VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
> >>>>>>          VMSTATE_PTR_TO_IND_ADDR(indicators2, VirtioCcwDevice),
> >>>>>>          VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
> >>>>>> +        {
> >>>>>> +        /*
> >>>>>> +         * Ugly hack because VirtIODevice does not migrate itself.
> >>>>>> +         * This also makes legacy via vmstate_save_state possible.
> >>>>>> +         */
> >>>>>> +            .name         = "virtio/config_vector",
> >>>>>> +            .info         = &vmstate_info_config_vector,
> >>>>>> +        },
> >>>>> I'm a bit confused - isn't just this bit the bit going
> >>>>> through the vdev->load_config hook?
> >>>>>
> >>>> Exactly! If you examine the part underscored with ============== in
> >>>> virtio_ccw_(load|save)_config  (that is what is behind vdev->load_config)
> >>>> you should see that we use vmstate_virtio_ccw_dev (that is this
> >>>> VMStateDescription to implement these function. 
> >>>>
> >>>> Actually virtio_ccw_(load|save)_config won't do anything after patch 9
> >>>> and for new machines since the VirtIOCcwDevice is going to migrate
> >>>> itself via DeviceClass.vmsd like other "normal" devices, and we fall
> >>>> back to the VirtIO specific callbacks only in "legacy mode".
> >>>>
> >>>> I hope this helps!
> >>> Hmm, still confused!
> >>> Why are you changing a Virtio device not to use the same migration
> >>> oddities as all the other virtio devices?
> >>>
> >>> I was assuming we'd have to change the virtio core code to
> >>> solve that for all virtio devices.
> >>>
> >>
> >> You can ask difficult questions ;). First I'm not aware of any
> >> ongoing effort to solve this for all virtio devices by changing
> >> the core, and probably breaking compatibility for all devices
> >> (in a sense I break migration compatibility for all virtio-ccw
> >> devices). To be honest, I have considered that move unlikely,
> >> but the possibility is one of my reasons for seeking an upstream
> >> discussion and having You and Michael on cc.
> > 
> > Well I have been trying to improve it, but that code is particularly
> > nasty; and I don't want to break compatibility.  I had some ideas,
> > for example I was thinking of changing the vdev->load_config to
> > a VMState* and then calling a vmstate_load_state(f, vdc->config,...
> > from virtio_load - but there's some challenging casting and hackery
> > there.
> > 
> >>
> >> Why not use virtio oddities? Because they are oddities. I have
> >> figured, it's a good idea to separate the migration of the 
> >> proxy form the rest: we have two QEMU Device objects and it
> >> should be good practice, that these are migrating themselves via
> >> DeviceClass.vmsd. That's what I get with this patch set, 
> >> for new machine versions (since we can not fix the past), and
> >> with the notable difference of config_vector, because it is
> >> defined as a common infrastructure (struct VirtIODevice) but
> >> ain't migrated as a common virtio infrastructure.
> > 
> > Have you got a bit of a description of your classes/structure - it's
> > a little hard to get my head around.
> > 
> 
> Unfortunately I do not have any extra description besides the comments
> and the commit messages. What exactly do you mean  by 'my
> classes/structure'?  I would like to provide some helpful developer
> documentation on how migration works for s390x. There were voices on the
> internal mailing list too requesting something like that, but I find it
> hard, because for me, the most challenging part was understanding how
> qemu migration works in general and the virtio oddities come next. 

Yes, there are only about 2 people who have the overlap of understanding
migration AND s390 IO.

> Fore example, I still don't understand why is is (virtio) load_config
> called like that, when what it mainly does is loading state of the proxy
> which is basically the reification of the device side of the virtio spec
> calls the transport within QOM. (I say mainly, because of this
> config_vector which resides in core but is migrated by via a callback for
> some strange reason I do not understand).

I think the idea is that virtio_load is trying to act as a generic
save/load with a number of virtual components that are specialised for:
  a) The device (e.g. rng, serial, gpu, net, blk)
  b) The transport (PCI, MMIO, CCW etc)
  c) The virtio queue content
  d) But has a load of core stuff (features, the virtio ring management)

(a) & (b) are very much virtual-function like that doesn't fit that
well with the migration macro structure.

The split between (a) & (c) isn't necessary clean - gpu does it a
different way.
And the order of a/b/c/d is very random (aka wrong).

> Could tell me to which (specific) questions should I provide an answer?
> It would make my job much easier.
> 
> About the general approach. First step was to provide VMStateDescription
> for the entities which have migration relevant state but no
> VMStateDescription (patches 3, 4 and 5).  This is done so that
> lots of qemu_put/qem_get calls can be replaced with few
> vmstate_save_state/vmstate_save_state calls (patch 6 and 7) on one hand,
> and that state not migrated yet but needed is also included, if the
> compat. switch (property) added in patch 2 is on. Then in patch 8, I add
> ORB which is a state we wanted to add for some time now, but we needed
> vmstate to add it without breaking migration. So we waited.

I'm most interested at this point in understanding which bits aren't
changing behaviour - if we've got stuff that's just converting qemu_get
to vmstate then lets go for it, no problem; easy to check.
I'm just trying to make sure I understand the bit where you're
converting from being a virtio device.

> >> Would you suggest to rather keep the oddities? Should I expect
> >> to see a generic solution to the problem sometime soon?
> > 
> > Not soon I fear; virtio_load is just too hairy.
> 
> Of course it ain't a problem for me to omit assigning an vmsd to
> VirtioCcwDeviceClass, but since I have to introduce a new section anyway
> (for the css stuff) it ain't hurting me to put the state of
> VirtioCcwDevice, that is the virtio proxy, into a separate section.
> 
> I can't think of any decisive benefit in favor of having separate
> sections for the proxy (transport) providing a virtio bus and the generic
> virtio device sitting on that bus, but I think it should be slightly more
> robust. One of the reasons I included this change is to make thinking
> about the question easier by clearing the questions: is it viable and
> complex/ugly is it to implement.
> 
> What is your preference, keep the migration of the two devices lumped
> together in one section, or rather go with two?

I'm not sure!
But my main worries with you changing it are:
  a) What happens when something changes in virtio and they need to add
     some new virtio field somewhere - if you do it different will it
     make it harder.
  b) If you have a virtio device which does it differently, is it going
     to make cleaning up virtio_load/save even harder?

Dave

> Halil
> 
> > 
> > Dave
> > 
> >> Halil
> >>
> >>> Dave
> >>>
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
