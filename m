Received: from eggs.gnu.org ([2001:4830:134:3::10]:58466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fWOBD-0007nM-92
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fWOBC-0004wK-8p
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:40:55 -0400
Date: Fri, 22 Jun 2018 16:40:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180622154042.GS23296@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622142513.GH4366@localhost.localdomain>
Subject: Re: [Qemu-devel] [PULL 25/26] block: Remove deprecated -drive
 option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, pkrempa@redhat.com

On Fri, Jun 22, 2018 at 04:25:13PM +0200, Kevin Wolf wrote:
> Am 22.06.2018 um 15:36 hat Christian Borntraeger geschrieben:
> > 
> > 
> > On 06/22/2018 02:55 PM, Kevin Wolf wrote:
> > > Am 22.06.2018 um 13:38 hat Christian Borntraeger geschrieben:
> > >>
> > >> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
> > >>> The -drive option serial was deprecated in QEMU 2.10. It's time to
> > >>> remove it.
> > >>>
> > >>> Tests need to be updated to set the serial number with -global instead
> > >>> of using the -drive option.
> > >>
> > >> libvirt 4.5 still creates those (at least on s390x)
> > >>
> > >>     <disk type='file' device='disk'>
> > >>       <driver name='qemu' type='qcow2' cache='none' io='native' iothread='1'/>
> > >>       <source file='/var/lib/libvirt/qemu/image.zhyp137'/>
> > >>       <target dev='hda' bus='virtio'/>
> > >>       <serial>skel</serial>
> > >>       <boot order='1'/>
> > >>       <address type='ccw' cssid='0xfe' ssid='0x0' devno='0x0000'/>
> > >>     </disk>
> > >>
> > >>
> > >> -> 
> > >> [...]
> > >> -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native -device virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0000,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on 
> > >> [...]
> > >>
> > >> 2018-06-22T11:25:20.946024Z qemu-system-s390x: -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native: Block format 'qcow2' does not support the option 'serial'
> > >> 2018-06-22 11:25:21.098+0000: shutting down, reason=failed
> > >>
> > >> So it seems that this breaks s390x.
> > 
> > To me it seems that this is also broken on x86.
> > > 
> > > Thanks for bringing this up. libvirt should fix this before QEMU 3.0 is
> > > released.
> > 
> > I think this is definitely too short notice. We should not break existing
> > setups just by insisting that users have to update libvirt when they update
> > QEMU. Yes, this might be our policy, but doing so "just because we can"
> > is certainly a very bad attitude. I see no fundamental technical reason why
> > we should not revert this change.
> 
> This was in fact one release longer than our deprecation policy says.
> Are we serious about the deprecation policy or aren't we?
> 
> I might consider reverting a change if it turned out that this requires
> some massive work in libvirt. But I think this one should be rather easy
> to fix in libvirt until 3.0 is released.

I've got a patch mostly ready that converts libvirt to setting these things
on the frontend device, however, I've got some queries...

 - usb-storage  - doesn't appear to support geometry or werror/rerror

   Will we loose functionality by stopping use of -drive for werror

   Loosing geometry feels relevant too, unless it was already ignored
   when set opf -drive ?

 - SD card - requires -drive with if=sd, no -device support AFAICT

   Will we loose functionality be stopping use of -drive for if=sd, or
   is this stuff ignored anyway ?

 - ide-cd/scsi-id - doesn't support geometry

   Presumably becuase its irrelevant for CDs


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
