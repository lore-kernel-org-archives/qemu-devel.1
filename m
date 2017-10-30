Received: from eggs.gnu.org ([2001:4830:134:3::10]:38893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e94vt-0005t0-Em
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 03:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e94vq-0008RR-9F
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 03:56:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e94vp-0008Qz-VZ
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 03:56:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45F2A5F7B2
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 07:56:24 +0000 (UTC)
Date: Mon, 30 Oct 2017 08:56:20 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171030075620.GC31767@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171027085548.3472-1-berrange@redhat.com>
	<92d471c6-2d30-01fe-ddfb-ca872d32f45b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92d471c6-2d30-01fe-ddfb-ca872d32f45b@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: detect errors from probing vnet hdr
 flag for TAP devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Oct 30, 2017 at 03:37:33PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B410=E6=9C=8827=E6=97=A5 16:55, Daniel P. Berrange wrote:
> > When QEMU sets up a tap based network device backend, it mostly ignor=
es errors
> > reported from various ioctl() calls it makes, assuming the TAP file d=
escriptor
> > is valid. This assumption can easily be violated when the user is pas=
sing in a
> > pre-opened file descriptor. At best, the ioctls may fail with a -EBAD=
F, but if
> > the user passes in a bogus FD number that happens to clash with a FD =
number that
> > QEMU has opened internally for another reason, a wide variety of errn=
os may
> > result, as the TUNGETIFF ioctl number may map to a completely differe=
nt command
> > on a different type of file.
> >=20
> > By ignoring all these errors, QEMU sets up a zombie network backend t=
hat will
> > never pass any data. Even worse, when QEMU shuts down, or that networ=
k backend
> > is hot-removed, it will close this bogus file descriptor, which could=
 belong to
> > another QEMU device backend.
> >=20
> > There's no obvious guaranteed reliable way to detect that a FD genuin=
ely is a
> > TAP device, as opposed to a UNIX socket, or pipe, or something else. =
Checking
> > the errno from probing vnet hdr flag though, does catch the big commo=
n cases.
> > ie calling TUNGETIFF will return EBADF for an invalid FD, and ENOTTY =
when FD is
> > a UNIX socket, or pipe which catches accidental collisions with FDs u=
sed for
> > stdio, or monitor socket.
> >=20
> > Previously the example below where bogus fd 9 collides with the FD us=
ed for the
> > chardev saw:
> >=20
> > $ ./x86_64-softmmu/qemu-system-x86_64 -netdev tap,id=3Dhostnet0,fd=3D=
9 \
> >    -chardev socket,id=3Dcharchannel0,path=3D/tmp/qga,server,nowait \
> >    -monitor stdio -vnc :0
> > qemu-system-x86_64: -netdev tap,id=3Dhostnet0,fd=3D9: TUNGETIFF ioctl=
() failed: Inappropriate ioctl for device
> > TUNSETOFFLOAD ioctl() failed: Bad address
> > QEMU 2.9.1 monitor - type 'help' for more information
> > (qemu) Warning: netdev hostnet0 has no peer
> >=20
> > which gives a running QEMU with a zombie network backend.
> >=20
> > With this change applied we get an error message and QEMU immediately=
 exits
> > before carrying on and making a bigger disaster:
> >=20
> > $ ./x86_64-softmmu/qemu-system-x86_64 -netdev tap,id=3Dhostnet0,fd=3D=
9 \
> >    -chardev socket,id=3Dcharchannel0,path=3D/tmp/qga,server,nowait \
> >    -monitor stdio -vnc :0
> > qemu-system-x86_64: -netdev tap,id=3Dhostnet0,vhost=3Don,fd=3D9: Unab=
le to query TUNGETIFF on FD 9: Inappropriate ioctl for device
> >=20
> > Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >   net/tap-bsd.c     |  2 +-
> >   net/tap-linux.c   | 12 +++++++++---
> >   net/tap-solaris.c |  2 +-
> >   net/tap-stub.c    |  2 +-
> >   net/tap.c         | 25 ++++++++++++++++++++-----
> >   net/tap_int.h     |  2 +-
> >   6 files changed, 33 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> > index 6c9692263d..4f1d633b08 100644
> > --- a/net/tap-bsd.c
> > +++ b/net/tap-bsd.c
> > @@ -211,7 +211,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOption=
s *tap, Error **errp)
> >   {
> >   }
> > -int tap_probe_vnet_hdr(int fd)
> > +int tap_probe_vnet_hdr(int fd, Error **errp)
> >   {
> >       return 0;
> >   }
> > diff --git a/net/tap-linux.c b/net/tap-linux.c
> > index 535b1ddb61..de74928407 100644
> > --- a/net/tap-linux.c
> > +++ b/net/tap-linux.c
> > @@ -147,13 +147,19 @@ void tap_set_sndbuf(int fd, const NetdevTapOpti=
ons *tap, Error **errp)
> >       }
> >   }
> > -int tap_probe_vnet_hdr(int fd)
> > +int tap_probe_vnet_hdr(int fd, Error **errp)
> >   {
> >       struct ifreq ifr;
> >       if (ioctl(fd, TUNGETIFF, &ifr) !=3D 0) {
> > -        error_report("TUNGETIFF ioctl() failed: %s", strerror(errno)=
);
> > -        return 0;
> > +        /* Kernel pre-dates TUNGETIFF support */
> > +        if (errno =3D=3D -EINVAL) {
> > +            return 0;
>=20
> This looks still unsafe, e.g some other device may return -EINVAL too.
>=20
> Is this better to check stat.st_rdev through fstat()?

Hmm, yes, that might be possible. Let me investigate...


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
