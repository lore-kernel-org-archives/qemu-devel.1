Received: from eggs.gnu.org ([2001:4830:134:3::10]:44011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fWN5M-0004tO-P0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fWN5L-0006fB-Mu
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:30:48 -0400
Date: Fri, 22 Jun 2018 15:30:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180622143034.GP23296@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<8736xec39q.fsf@dusky.pond.sub.org>
	<20180622142519.GN23296@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622142519.GN23296@redhat.com>
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 22, 2018 at 03:25:19PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jun 22, 2018 at 04:19:29PM +0200, Markus Armbruster wrote:
> > Kevin Wolf <kwolf@redhat.com> writes:
> >=20
> > > Am 22.06.2018 um 13:38 hat Christian Borntraeger geschrieben:
> > >>=20
> > >> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
> > >> > The -drive option serial was deprecated in QEMU 2.10. It's time =
to
> > >> > remove it.
> > >> >=20
> > >> > Tests need to be updated to set the serial number with -global i=
nstead
> > >> > of using the -drive option.
> > >>=20
> > >> libvirt 4.5 still creates those (at least on s390x)
> > >>=20
> > >>     <disk type=3D'file' device=3D'disk'>
> > >>       <driver name=3D'qemu' type=3D'qcow2' cache=3D'none' io=3D'na=
tive' iothread=3D'1'/>
> > >>       <source file=3D'/var/lib/libvirt/qemu/image.zhyp137'/>
> > >>       <target dev=3D'hda' bus=3D'virtio'/>
> > >>       <serial>skel</serial>
> > >>       <boot order=3D'1'/>
> > >>       <address type=3D'ccw' cssid=3D'0xfe' ssid=3D'0x0' devno=3D'0=
x0000'/>
> > >>     </disk>
> > >>=20
> > >>=20
> > >> ->=20
> > >> [...]
> > >> -drive file=3D/var/lib/libvirt/qemu/image.zhyp137,format=3Dqcow2,i=
f=3Dnone,id=3Ddrive-virtio-disk0,serial=3Dskel,cache=3Dnone,aio=3Dnative =
-device virtio-blk-ccw,iothread=3Diothread1,scsi=3Doff,devno=3Dfe.0.0000,=
drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3D=
on=20
> > >> [...]
> > >>=20
> > >> 2018-06-22T11:25:20.946024Z qemu-system-s390x: -drive file=3D/var/=
lib/libvirt/qemu/image.zhyp137,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio=
-disk0,serial=3Dskel,cache=3Dnone,aio=3Dnative: Block format 'qcow2' does=
 not support the option 'serial'
> > >> 2018-06-22 11:25:21.098+0000: shutting down, reason=3Dfailed
> > >>=20
> > >> So it seems that this breaks s390x.
> > >
> > > Thanks for bringing this up. libvirt should fix this before QEMU 3.=
0 is
> > > released.
> > >
> > > Sadly, it also shows that deprecation warnings in log files go
> > > unnoticed.
> >=20
> > Nobody reads log files until things have gone belly up, and even then
> > unrelated log entries get ignored.
> >=20
> > The way to get deprecation warnings noticed it to have the management
> > application fail its "make check".
> >=20
> > Perhaps we could use a more structured notification, to make detectin=
g
> > use of deprecated features programmatically trivial.  A QMP event mig=
ht
> > do.
>=20
> Libvirt currently has CI that is largely focused on unit testing. We
> recently did some work, however, to get our functional test suite
> working properly again (Sys-Virt-TCK) and are trying to get some
> new CI hardware. So if we get that running, we coud run tests on real
> QEMU versions and check the /var/log/libvirt/qemu/$GUEST.logs to
> make sure we're not triggering unexpected warnings from QEMU

This could be even easier if there was a --no-deprecations flag to
QEMU which triggered abort() whenever mgmt app uses a deprecated
feature.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
