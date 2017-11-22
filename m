Received: from eggs.gnu.org ([2001:4830:134:3::10]:44907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eHb55-0001tO-KR
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eHb52-0000Nl-UH
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:53:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eHb52-0000NN-LT
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 14:53:08 -0500
Date: Wed, 22 Nov 2017 19:53:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171122195303.GD2443@work-vm>
References: <1b862cf2-2fee-3243-cb54-2780ace6f25b@profihost.ag>
	<971cc10f-7930-9830-0528-27e8faac7282@redhat.com>
	<748c4d0d-f84b-303d-f9a6-bafa6037d669@profihost.ag>
	<f4b0cb70-7f86-f7cf-bb89-3a9f7ae15dc2@redhat.com>
	<4c2913e2-5946-47db-cced-a5702538bc3b@profihost.ag>
	<dc3bf74f-fbd6-573d-0d7c-d456469fcf1d@profihost.ag>
	<9c8673a5-faf7-ca9c-27d3-398df4223d6a@redhat.com>
	<20171122194153.GB4338@work-vm>
	<e7719946-8d87-71c1-54e8-bdbdf429e092@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7719946-8d87-71c1-54e8-bdbdf429e092@profihost.ag>
Subject: Re: [Qemu-devel] kvm: virtio-net: saved image requires TUN_F_UFO
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Jason Wang (jasowang@redhat.com)" <jasowang@redhat.com>

* Stefan Priebe - Profihost AG (s.priebe@profihost.ag) wrote:
> Hello,
> 
> Am 22.11.2017 um 20:41 schrieb Dr. David Alan Gilbert:
> > * Paolo Bonzini (pbonzini@redhat.com) wrote:
> >> On 06/11/2017 12:09, Stefan Priebe - Profihost AG wrote:
> >>> HI Paolo,
> >>>
> >>> could this patchset be related?
> >>
> >> Uh oh, yes it should.  Jason, any ways to fix it?  I suppose we need to
> >> disable UFO in the newest machine types, but do we also have to do
> >> (software) UFO in vhost-net and QEMU for migration compatibility?
> > 
> > Was there a solution to this?
> 
> it will be this one:
> https://patchwork.ozlabs.org/patch/840094/

Thanks; I've added a link to:
https://wiki.qemu.org/Features/Migration/Troubleshooting#virtio-net:_saved_image_requires_TUN_F_UFO_support

Dave

> 
> Stefan
> 
> > Dave
> > 
> >> Thanks,
> >>
> >> Paolo
> >>
> >>> Greets,
> >>> Stefan
> >>>
> >>> Am 06.11.2017 um 10:52 schrieb Stefan Priebe - Profihost AG:
> >>>> Hi Paolo,
> >>>>
> >>>> Am 06.11.2017 um 10:49 schrieb Paolo Bonzini:
> >>>>> On 06/11/2017 10:48, Stefan Priebe - Profihost AG wrote:
> >>>>>> Hi Paolo,
> >>>>>>
> >>>>>> Am 06.11.2017 um 10:40 schrieb Paolo Bonzini:
> >>>>>>> On 06/11/2017 10:38, Stefan Priebe - Profihost AG wrote:
> >>>>>>>> Hello,
> >>>>>>>>
> >>>>>>>> i've upgraded some servers from kernel 4.4 to 4.12 - both running Qemu
> >>>>>>>> 2.9.1.
> >>>>>>>>
> >>>>>>>> If i migrate a VM from a host running kernel 4.4 to a host running 4.12
> >>>>>>>> i get:
> >>>>>>>>
> >>>>>>>> kvm: virtio-net: saved image requires TUN_F_UFO support
> >>>>>>>> kvm: Failed to load virtio-net-device:tmp
> >>>>>>>> kvm: Failed to load virtio-net:virtio
> >>>>>>>> kvm: error while loading state for instance 0x0 of device
> >>>>>>>> '0000:00:12.0/virtio-net'
> >>>>>>>> kvm: load of migration failed: Invalid argument
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> while migrating from 4.12 to 4.4 works fine.
> >>>>>>>>
> >>>>>>>> Can anybody help? Is this expected?
> >>>>>>>
> >>>>>>> Can you check why peer_has_ufo failed (in hw/net/virtio-net.c)?
> >>>>>>
> >>>>>> May be - how can i archieve this? Patching the code is not a problem if
> >>>>>> you can give me a hint.
> >>>>>>
> >>>>>>> Also, did this ioctl fail when the tap device was set up on the 4.12 destination?
> >>>>>>> int tap_probe_has_ufo(int fd)
> >>>>>>> {
> >>>>>>>     unsigned offload;
> >>>>>>>
> >>>>>>>     offload = TUN_F_CSUM | TUN_F_UFO;
> >>>>>>>
> >>>>>>>     if (ioctl(fd, TUNSETOFFLOAD, offload) < 0)
> >>>>>>>         return 0;
> >>>>>>>
> >>>>>>>     return 1;
> >>>>>>> }
> >>>>>>
> >>>>>> Should there be any kernel output or how can i detect / check it?
> >>>>>
> >>>>> For both, the simplest answer is probably just using printf.
> >>>>
> >>>> arg i missed an important part. The kernel is an opensuse SLE15 one.
> >>>>
> >>>> I've seen it contains the following patchset:
> >>>> https://www.spinics.net/lists/netdev/msg443821.html
> >>>>
> >>>> Greets,
> >>>> Stefan
> >>>>
> >>
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
