Received: from eggs.gnu.org ([2001:4830:134:3::10]:37332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXUe4-0005eI-Ts
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eXUe1-0001yG-K2
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:15:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eXUe1-0001xH-6C
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:14:57 -0500
Date: Fri, 5 Jan 2018 16:14:53 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180105161453.GI28322@stefanha-x1.localdomain>
References: <20171219162151.GA10889@stefanha-x1.localdomain>
	<20180104184236-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline
In-Reply-To: <20180104184236-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] vhost-user graceful connect/disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, mukawa@igel.co.jp, marcandre.lureau@redhat.com, Wei Wang <wei.w.wang@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, n.nikolaev@virtualopensystems.com


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2018 at 06:53:07PM +0200, Michael S. Tsirkin wrote:
> On Tue, Dec 19, 2017 at 04:21:51PM +0000, Stefan Hajnoczi wrote:
> > Hi,
> > Vhost-user implementations assume the slave is already running before
> > the master starts.  The slave is required during virtio device
> > initialization (e.g. feature bit negotiation) and so it is simplest to
> > assume that the master is already available and will respond immediately
> > to the VHOST_USER_GET_FEATURES message.
> >=20
> > I have thought about how to let master and slave start in any order.
> > Some approaches involve changes to the VIRTIO specification so that
> > guest drivers can wait until the vhost-user connection is established.
> >=20
> > We can avoid spec changes using PCI hotplug:
> >=20
> > 1. Introduce a new vhost-user object that manages a connection:
> >=20
> >    -chardev ...
> >    -object vhost-user,id=3Dvhost-user0,chardev=3Dchr0
> >=20
> >    Note this object is *not* a NetClient.  It's a resource for managing
> >    a vhost-user connection and can be used with any device type (net,
> >    scsi, blk, etc).
> >=20
> >    This object tries to establish a connection.  When a connection is
> >    established it sends vhost-user protocol messages to fetch
> >    information needed for virtio device initialization (like the number
> >    of virtqueues supported, features bits, etc).  This information is
> >    stashed so that vhost_*() calls later on do not require synchronous
> >    communication with the vhost-user slave.
>=20
> I'm not sure how important or feasible this last part is.

The guest should not hang if the vhost-user slave fails to respond in a
timely manner.  This is important to prevent failures cascading if a
vhost-user network switch hangs, for example.

There are a few points where device emulation requires a full vhost-user
message exchange.  Theses are the vulnerable points.

Depending on how virtio emulation is implemented, it may be possible to
perform the vhost-user communication out-of-line with vcpu execution.
That way the vcpu continues to execute while vhost-user communication is
in progress.

Unfortunately the VIRTIO_PCI_STATUS/VIRTIO_PCI_COMMON_STATUS hardware
register writes are points where vhost-user message exchanges need to
happen.  That means the vcpu will hang until vhost-user communication
has finished.

It's not possible to resume guest execution without waiting for the
vhost-user slave because the guest might start using the device before
the vhost-user slave has been fully initialized.

I don't see a way around this problem yet.  If everything was async at
the virtio hardware level then it would be easy to prevent hangs.

Stefan

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaT6R9AAoJEJykq7OBq3PIKlgH/3anx5iiAJc10+/h0hVIZqH4
cAykX6z6Csu68ZfAhYnhtkobS/qc+lqnGAeroHdkHDm41ck/s128Zt02QPKj2DuS
HDZ++F+Nzg8IdjM2jOjgdxR4AoZASIF54D5mVEgJdIYGBT2tpwuYLYt/zrqb88RL
OVCZMKWDwYNZtCp8VEKOtD/82V3dA1WsvVKNHKA1nrSo9AMS12la+aBCmlvCiL0U
6V3LHo+8+94asLmNpdzaMjigF0rkhi3sL7+1pw2CvqW+ZitnjLynsfIVYZO1PlNi
GyxBAAfSrD93MQo2kbwZNyS1x/slNVo48J3hV+IppM4Tv8alW0Yz8LlS4l8VjbM=
=ZP/E
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
