Received: from eggs.gnu.org ([2001:4830:134:3::10]:52873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj7ul-0007W5-9b
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj7ug-0004xc-B1
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:19:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cj7ug-0004x9-2P
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:19:42 -0500
Date: Wed, 1 Mar 2017 19:19:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170301191628-mutt-send-email-mst@kernel.org>
References: <20170228152411.81609-1-cornelia.huck@de.ibm.com>
	<20170301174738-mutt-send-email-mst@kernel.org>
	<20170301171554.1bd4107b.cornelia.huck@de.ibm.com>
	<20170301184527-mutt-send-email-mst@kernel.org>
	<20170301180044.507969c9.cornelia.huck@de.ibm.com>
	<20170301190237-mutt-send-email-mst@kernel.org>
	<20170301181452.0eee70dd.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170301181452.0eee70dd.cornelia.huck@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: guard vring access when setting
 notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, borntraeger@de.ibm.com

On Wed, Mar 01, 2017 at 06:14:52PM +0100, Cornelia Huck wrote:
> On Wed, 1 Mar 2017 19:04:56 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Wed, Mar 01, 2017 at 06:00:44PM +0100, Cornelia Huck wrote:
> > > On Wed, 1 Mar 2017 18:50:34 +0200
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > > > Yes all these callbacks complicate code to the point it's barely
> > > > readable. I really don't see why are we poking at device beforeha=
nd at
> > > > all. IMHO this is closer to the root of the problem. Don't do it.=
  One
> > > > way to look at it is to say that we start aio too early. Do it at
> > > > driver_ok for virtio 1 and on kick for virtio 0 and problems will=
 go
> > > > away.
> > >=20
> > > The problem exists for the case where the guest sets up only the fi=
rst
> > > queue, but the host has more than one queue. The guest setting up o=
ther
> > > queues later is probably patholotical, but not really forbidden by =
the
> > > spec (I think).
> >=20
> > I think it's forbidden.  spec explains how queues are set up:
> >=20
> > 1. Reset the device.
> > 2. Set the ACKNOWLEDGE status bit: the guest OS has notice the device=
.
> > 3. Set the DRIVER status bit: the guest OS knows how to drive the dev=
ice.
> > 4. Read device feature bits, and write the subset of feature bits und=
erstood by the OS and driver to the
> > device. During this step the driver MAY read (but MUST NOT write) the=
 device-specific configuration
> > fields to check that it can support the device before accepting it.
> > 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new fea=
ture bits after this step.
> > 6. Re-read device status to ensure the FEATURES_OK bit is still set: =
otherwise, the device does not
> > support our subset of features and the device is unusable.
> > 7. Perform device-specific setup, including discovery of virtqueues f=
or the device, optional per-bus setup,
> > reading and possibly writing the device=E2=80=99s virtio configuratio=
n space, and population of virtqueues.
> > 8. Set the DRIVER_OK status bit. At this point the device is =E2=80=9C=
live=E2=80=9D.
>=20
> It seems I managed to read over this statement in step 7 several
> times... So "make sure that we only start aio after DRIVER_OK, and
> forbid any setup for !desc permanently" will take care of virtio-1
> devices.
>=20
> >=20
> > And it goes on to mention a bug in legacy drivers:
> > Legacy driver implementations often used the device before setting th=
e DRIVER_OK bit, and sometimes
> > even before writing the feature bits to the device.
>=20
> I wonder whether we need to accommodate legacy drivers doing both that
> _and_ setting up virtqueues between using the device for the first time
> and setting DRIVER_OK? Just using the logic of "if there were no rings
> setup when we first try to start aio, ignore that queue until reset"
> would cover all but those very odd drivers, and I highly doubt anybody
> cares about such broken setups.


kick on a vq before this vq is setup would be a broken thing to do.

They did this though

	for each ring
		add buffer
		kick
	driver ok

so it's a per-ring thing.

--=20
MST
