Received: from eggs.gnu.org ([2001:4830:134:3::10]:48896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBmnF-0000u3-Ja
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBmnA-0002Qv-NE
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:38:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dBmnA-0002QS-Dz
	for qemu-devel@nongnu.org; Fri, 19 May 2017 14:38:24 -0400
Date: Fri, 19 May 2017 19:38:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170519183816.GT2081@work-vm>
References: <20170508173650.GJ2120@work-vm>
	<877c80d1-fa63-0fd1-e394-fb649281aea1@linux.vnet.ibm.com>
	<20170508175906.GK2120@work-vm>
	<b69e0df0-120f-6634-d7ff-4bea9ccb4e31@linux.vnet.ibm.com>
	<20170508184251.GM2120@work-vm>
	<f84db83a-4347-ef8c-56d3-ba3171d5a430@linux.vnet.ibm.com>
	<20170515190706.GD2324@work-vm>
	<0000bcfe-5d9f-e656-1819-9403a1663c39@linux.vnet.ibm.com>
	<20170519172838.GC2685@work-vm>
	<644cabb4-44ed-3b49-4c03-35b7b2266882@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644cabb4-44ed-3b49-4c03-35b7b2266882@linux.vnet.ibm.com>
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
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, dhildenb@redhat.com

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 05/19/2017 07:28 PM, Dr. David Alan Gilbert wrote:
> >> To sum it up although I'm currently leaning towards abandoning my idea
> >> of two sections for two devices, I'm not comfortable with making the
> >> call myself. I'm hoping for some maintainer guidance (s390x, virtio
> >> and migration). 
> > <A couple of hours of reading, the CCW and PCI code, chatting with
> > dhildenb etc>
> > 
> > OK, so I think:
> >   a) First split the series into two separate series; one that
> > VMStatifies the existing stuff without breaking compatibility;
> > and one that adds the new stuff.  Lets get the first of those
> > going in while we think about the second.
> > 
> >     a.1) I'd do this with patches that convert one chunk into
> >      vmstate and remove the corresponding C code at the same time.
> > 
> >   b) While the way PCI devices are done is weird, I think it'll
> > be a lot simpler if you can stick to a structure that's similar
> > to them while diverging.  It's hard enough for those of us
> > who don't do Virtio every day to get our minds around virtio-pci
> > without it being different for virtio-ccw/css.
> > 
> >   c) To do (b) I suggest:
> >       c.1) you *don't* add a vmsd to your virtio_ccw_device
> > 
> >       c.2) but *do* add a VMSTATE_CCW_DEVICE to the start of any
> >          non-virtio devices you migrate (like each of the PCI devices
> >           have)
> > 
> >       c.3) You can add extra state for CSS to the ->save_extra_state
> >            handle on virtio devices or to the config
> > 
> >   d) vmstatifying the config is OK as well.
> > 
> > I should say I'm no virtio expert, so if any of that's truly
> > mad say so.
> > 
> > Dave
> > 
> 
> Agreed (a,b,c,d). Reorganizing my patch set according to a) is
> going to require some effort, but it should not be too bad. 
> About c.2): I don't think we have any migratable non virtio devices
> yet, but I'll keep it in mind.
> 
> I do not understand what you mean by c.3) and extra_sate. Maybe
> it will settle with time. My idea of extending VirtioCcwDevice
> is just adding subsections to it's VMStateDescription. The
> call vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL)
> in save_config should take care of compatibility. Maybe some
> staring at virtio-pci is going to help, but right now I can't tell
> what's the extra_state for, and how/why is it 'extra'.

Yes adding extra subsections into the 'config' is probably fine;
but there's also another hook that Jason added, see a6df8adf3,
it's an existing subsection at the end of the virtio state
that can be linked for transport specific data.

Dave

> Thanks for your patience!
> 
> Regards,
> Halil
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
