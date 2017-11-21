Received: from eggs.gnu.org ([2001:4830:134:3::10]:58163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eH2PJ-0004Ch-0p
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 01:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eH2PE-0004wR-2Y
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 01:51:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eH2PD-0004vu-Ol
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 01:51:40 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAL6mwET090932
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 01:51:33 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ecdrmmcca-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 01:51:33 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 21 Nov 2017 01:51:31 -0500
Date: Tue, 21 Nov 2017 14:51:26 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171114082547.GB12696@bjsdjshi@linux.vnet.ibm.com>
	<20171114115014.3b3d709d.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114115014.3b3d709d.cohuck@redhat.com>
Message-Id: <20171121065125.GG5859@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] Questions about usability mess that caused by
 differentiating address based on devices types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, fiuczy@linux.vnet.ibm.com, bwalk@linux.vnet.ibm.com, shalini@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org

* Cornelia Huck <cohuck@redhat.com> [2017-11-14 11:50:14 +0100]:

Hallo Conny,

After spending some time, just some updates for this one.

> On Tue, 14 Nov 2017 16:25:47 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > Dear Conny,
> > 
> > Good day!
> > 
> > Just now, our Libvirt folks pointed out a "usability mess" for the
> > design of differentiating address based on devices classes (real |
> > virtual). The complaints are mainly about the "s390-squash-mcss"
> > property and restrictions to define virtual device in the special 0xFE
> > css, and define real devices in non-0xFE.
> > 
> > We have some discussions internally, but failed to get it cleared. As we
> > think this is about the architecture, so hereby, I as a representative,
> > forward our arguments and questions here to ask you for help:
> > 
> > 1. What benifit do we get to put virtual devices in css 0xFE?
> 
> Some background here (for the benefit of innocent bystanders):
:)

> 
> In the past, I had been involved with some cases where Linux guests
> under z/VM died after a customer followed the recommended procedure to
> vary off a path before applying service. That path was supposed to be a
> path to a disk; unfortunately, z/VM had mapped all kinds of virtual
> paths to it, including the only path to the console device. Oops.
> 
> With that in mind, we wanted to make sure that qemu would not be
> susceptible to the same problem; IOW, we wanted to make sure that
> chpids etc. were not mashed together for devices that did not have
> anything to do with each other. At one point in time, the idea came up
> to use a reserved css for virtio devices, which was deemed an elegant
> solution as 'real' devices were still something far in the future. (And
> I was under the delusion that we would have MCSS-E support in Linux by
> then; that has not happened...)
> 
> So the basic idea of css 0xfe is: Maintain a clear separation between
> devices emulated by qemu and pass-through devices (a more divisive
> separation than by simply separating chpids).
> 
Thanks for the information. I think now everybody are clear about the
background.

[I sometime found it is a pleasure to listen to your story. Clear and
interesting.]

> > 
> > 2. Since we could accept squashing virtual devices into css 0, can we
> > accept to not trading 0xFE as a special css?
> 
> Using css 0xfe seemed like a good idea; but as things worked out
> differently in the meantime, it seems it causes more problems right now
> than it avoids.
> 
Have to agree. In particular after knowing the background.

> > So that we can remove the restrictions for the cssid validation for each
> > type of device. Even we could drop the s390-squash-mcss, and just allow
> > the user to define any device in any css.
> 
> Opening up the different csses for all devices might help, but we need
> to be careful:
> - We still want to keep the chpids separated. Probably not a problem
>   right now.
> - We need to be able to point to a default css, especially as there are
>   no MCSS-E capable OSs around yet.
> - You need to double check if there are further restrictions on the
>   allowed css ids. (I know that 0xff is reserved for special usage as
>   well; but I can't find out more.)
> - Backwards compatibility and migration: We certainly don't want old
>   setups to break, and compat machines need to force the old scheme.
> 
> All best tested out via a prototype :)
> 
After a round of internal discussion, Halil now has a prototype. I think
sooner he will post his patch with our internal agreement, and we can
continuing talking based on that then.

> > 
> > 3. If we have to keep the squash property, then when squashing, it's
> > somewhat like "I don't care for the cssid", so is it possible for us to
> > not check the cssid in the device devno?
> > Libvirt would be benifited with this when automatically generating the
> > addresses.
> 
> I think we still need to keep the squashing around for compatibility,
> but we may be able to give it the chop for something like 3.0.
> 
> (And we probably need to keep the existing restrictions in compat mode.)
> 
Can we just drop the squash property, right after we opened up all the
csses?
We do not support LGM for vfio-ccw, and there is no libvirt user until
now. So what else case could it be to stop us from dropping it?

> > 
> > 4. Error message for devno conflict is not helpful. For the following
> > case:
> >   -M s390-ccw-virtio,s390-squash-mcss=on \
> >   -drive file=/dev/disk/by-path/ccw-0.0.3f3e,if=none,id=drive-virtio-disk1,format=raw \
> >   -device virtio-blk-ccw,devno=fe.0.2222,scsi=off,drive=drive-virtio-disk1,id=virtio-disk1,bootindex=0 \
> >   -device vfio-ccw,devno=0.0.2222,sysfsdev=/sys/devices/css0/0.0.013f/6dfd3ec5-e8b3-4e18-a6fe-57bc9eceb920 \
> > 
> > We get this error message:
> > qemu-system-s390x: -device vfio-ccw,devno=0.0.2222,sysfsdev=/sys/devices/css0/0.0.013f/6dfd3ec5-e8b3-4e18-a6fe-57bc9eceb920: Device 0.0.2222 already exists
> > 
> > By checking 0.0.2222 from the cmd line, users can not find out the root
> > cause - squashing, easily. So, if we have to keep the squash property,
> > we could improve this message by adding a hint.
> 
> That's probably a change that can be done quickly, without any compat
> implications, right?
Right on. I will suspend this until we got a final agreement.

> 
> > 
> > To sum up, we got the feeling that, this mess is not only for Libvirt
> > but also for QEMU cmd line users. And we are wondering if there is some
> > way to improve it.
> 
> Using css 0xfe seems to be an idea that turned out not to be as useful
> as we hoped it would be. Maybe the right way forward is indeed to open
> up the csses for all devices (although there might be a case for
> putting non-virtual devices not into 0xfe by default and instead making
> 0 the default css).
> 
> Another thing: Should libvirt give its users enough rope to hang
> themselves by allowing to create domains with devices all over the
> channel subsystem images?
> 
I think the commit message of Halil's patch will show you the idea.
Let's wait for some moment.

Thanks!

-- 
Dong Jia Shi
