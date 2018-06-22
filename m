Received: from eggs.gnu.org ([2001:4830:134:3::10]:42917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fWN0F-0000JJ-8w
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fWN0E-0004kr-21
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:25:31 -0400
Date: Fri, 22 Jun 2018 15:25:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180622142519.GN23296@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<8736xec39q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8736xec39q.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, pkrempa@redhat.com

On Fri, Jun 22, 2018 at 04:19:29PM +0200, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 22.06.2018 um 13:38 hat Christian Borntraeger geschrieben:
> >> 
> >> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
> >> > The -drive option serial was deprecated in QEMU 2.10. It's time to
> >> > remove it.
> >> > 
> >> > Tests need to be updated to set the serial number with -global instead
> >> > of using the -drive option.
> >> 
> >> libvirt 4.5 still creates those (at least on s390x)
> >> 
> >>     <disk type='file' device='disk'>
> >>       <driver name='qemu' type='qcow2' cache='none' io='native' iothread='1'/>
> >>       <source file='/var/lib/libvirt/qemu/image.zhyp137'/>
> >>       <target dev='hda' bus='virtio'/>
> >>       <serial>skel</serial>
> >>       <boot order='1'/>
> >>       <address type='ccw' cssid='0xfe' ssid='0x0' devno='0x0000'/>
> >>     </disk>
> >> 
> >> 
> >> -> 
> >> [...]
> >> -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native -device virtio-blk-ccw,iothread=iothread1,scsi=off,devno=fe.0.0000,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on 
> >> [...]
> >> 
> >> 2018-06-22T11:25:20.946024Z qemu-system-s390x: -drive file=/var/lib/libvirt/qemu/image.zhyp137,format=qcow2,if=none,id=drive-virtio-disk0,serial=skel,cache=none,aio=native: Block format 'qcow2' does not support the option 'serial'
> >> 2018-06-22 11:25:21.098+0000: shutting down, reason=failed
> >> 
> >> So it seems that this breaks s390x.
> >
> > Thanks for bringing this up. libvirt should fix this before QEMU 3.0 is
> > released.
> >
> > Sadly, it also shows that deprecation warnings in log files go
> > unnoticed.
> 
> Nobody reads log files until things have gone belly up, and even then
> unrelated log entries get ignored.
> 
> The way to get deprecation warnings noticed it to have the management
> application fail its "make check".
> 
> Perhaps we could use a more structured notification, to make detecting
> use of deprecated features programmatically trivial.  A QMP event might
> do.

Libvirt currently has CI that is largely focused on unit testing. We
recently did some work, however, to get our functional test suite
working properly again (Sys-Virt-TCK) and are trying to get some
new CI hardware. So if we get that running, we coud run tests on real
QEMU versions and check the /var/log/libvirt/qemu/$GUEST.logs to
make sure we're not triggering unexpected warnings from QEMU

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
