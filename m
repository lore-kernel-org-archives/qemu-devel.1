Received: from eggs.gnu.org ([2001:4830:134:3::10]:56354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX528-00036B-V6
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX525-0007Vz-4X
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:58:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gX524-0007VP-Qo
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:58:37 -0500
Date: Wed, 12 Dec 2018 13:58:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181212135825.GE31033@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181210173151.16629-1-dgilbert@redhat.com>
	<20181212123059.GD31033@redhat.com> <20181212135203.GD2370@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212135203.GD2370@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] virtio-fs: shared file system for
 virtual machines3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, sweil@redhat.com, swhiteho@redhat.com, stefanha@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu

On Wed, Dec 12, 2018 at 01:52:03PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Mon, Dec 10, 2018 at 05:31:44PM +0000, Dr. David Alan Gilbert (git=
) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >=20
> > > Hi,
> > >   This is the first RFC for the QEMU side of 'virtio-fs';
> > > a new mechanism for mounting host directories into the guest
> > > in a fast, consistent and secure manner.  Our primary use
> > > case is kata containers, but it should be usable in other scenarios
> > > as well.
> > >=20
> > > There are corresponding patches being posted to Linux kernel,
> > > libfuse and kata lists.
> > >=20
> > > For a fuller design description, and benchmark numbers, please see
> > > Vivek's posting of the kernel set here:
> > >=20
> > > https://marc.info/?l=3Dlinux-kernel&m=3D154446243024251&w=3D2
> > >=20
> > > We've got a small website with instructions on how to use it, here:
> > >=20
> > > https://virtio-fs.gitlab.io/
> > >=20
> > > and all the code is available on gitlab at:
> > >=20
> > > https://gitlab.com/virtio-fs
> > >=20
> > > QEMU's changes
> > > --------------
> > >=20
> > > The QEMU changes are pretty small;=20
> > >=20
> > > There's a new vhost-user device, which is used to carry a stream of
> > > FUSE messages to an external daemon that actually performs
> > > all the file IO.  The FUSE daemon is an external process in order t=
o
> > > achieve better isolation for security and resource control (e.g. nu=
mber
> > > of file descriptors) and also because it's cleaner than trying to
> > > integrate libfuse into QEMU.
> >=20
> > Overall I like the virtio-fs architecture more than the virtio-vsock+=
NFS
> > approach, as virtio-fs feels simpler and closer to virtio-9p with the
> > latter's proxy backends.
> >=20
> > I never really liked the idea of having to mess around with the host
> > NFS server to exposed filesystems to guests, as that's systemwide
> > service.  The ability to have an isolated virtio-fs backend process
> > per filesystem share per guest is simpler from a mgmt pov.
> >=20
> > One think I would like to see though is a general purpose, production
> > quality backend impl that is shipped by the QEMU project.  It is fine
> > if projects like Kata want to write a custom impl tailored to their
> > specific needs, but I think QEMU should have something as standard th=
at
> > isn't just demoware.=20
>=20
> Our patches sent to libfuse may provide that - after we tidy them up a
> bit more; but it is the result of adding the fuse example code to qemu'=
s
> contrib vhost-user example code.    Given that this is the intersection
> of so many projects I'm not sure I care which project distributes a
> working implementation.

Right, but that's my point - the stuff in QEMU's contrib/ directories is
just demoware - not something we actually support as QEMU maintainers,
nor expect users to run in production. Likewise for stuff in libfuse
example/ directory AFAIK.

IMHO we need something whose support status is on a par with what you'd
get if we had the impl in-process for the main QEMU system emulator.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
