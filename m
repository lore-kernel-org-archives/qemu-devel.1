Received: from eggs.gnu.org ([2001:4830:134:3::10]:47816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRDo0-0006wM-TY
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRDng-0004Tk-1L
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:03:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRDnf-0004SO-Ok
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:02:59 -0500
Date: Tue, 19 Dec 2017 09:02:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171219090251.GB3242@stefanha-x1.localdomain>
References: <20171215170519.31392-1-stefanha@redhat.com>
	<5A38C70D.30207@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <5A38C70D.30207@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [RFC virtio-dev]
 vhost-user-slave: add vhost-user slave device type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:00:13PM +0800, Wei Wang wrote:
> On 12/16/2017 01:05 AM, Stefan Hajnoczi wrote:
> > The vhost-user slave device facilitates vhost-user device emulation
> > through vhost-user protocol exchanges and access to shared memory.
> > Software-defined networking, storage, and other I/O appliances can
> > provide services through this device.
> >=20
> > This device is based on Wei Wang's vhost-pci work.  The vhost-user slave
> > device differs from vhost-pci because it is a single virtio device type
> > that exposes the vhost-user protocol instead of a family of new virtio
> > device types, one for each vhost-user device type.
> >=20
> > This device supports vhost-user slave and vhost-user master
> > reconnection.  It also contains a UUID so that vhost-user slave programs
> > can identify a specific device among many without using bus addresses.
> >=20
> > It is somewhat unconventional for a virtio device because it makes use
> > of additional resources called doorbells, notifications, and shared
> > memory.  A mapping of these resources to the virtio PCI transport is
> > provided.  Other transports, such as CCW may not be able to support
> > this device.
>=20
> Hi Stefan,
>=20
> Sorry for being late. I need to shift my focus to some other things for a
> week or two.

No problem.  I will be offline 25 Dec - 1 Jan for the winter holidays.

Regardless of which approach we use in the end, the virtio PCI transport
extensions for doorbell, notification, and shared memory resources
defined in this RFC will be necessary.  I hope you'll find that part
interesting.

> I still couldn't see how those problems can be solved with this slave dev=
ice
> proposal (which vhost-pci doesn't have):

I'm not sure if we are thinking of the same design.  I've answered your
questions below.

I'm also implementing the vhost-user-slave device to show exactly how
this approach works and will share the code once it's ready.

> - The complexity of the "relaying" mechanism for two directions
> (GuestSlave<->QemuSlave<->Master). I couldn't think of a simple way to do
> this. If you know a *simple* way, could you please describe the detailed
> steps or show a picture of the details? (I think most of us couldn't see =
the
> true advantage over the vhost-pci's method)

I posted a list of vhost-user protocol messages and what action QEMU
needs to take before relaying them:

  https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg02315.html

What is complex about this?

How is it more complex than the vhost-pci approach?  vhost-pci needs to
parse everything too, plus it also needs to translate that into new
virtio devices that would need to be defined for each device type (net,
blk, scsi).

> - Reusability. We seem to have no chance to reuse one slave implementation
> for GuestSlave and QemuSlave, which also wasn't your intention as you
> mentioned. If this couldn't be solved, shall we give up this option?

Reusability means that vhost-user slaves can support both UNIX domain
sockets and the vhost-user-slave device.  For example, vhost-user-slave
device support can be added to the DPDK vhost-user slave without
rewriting the net device:

  http://dpdk.org/browse/dpdk/tree/lib/librte_vhost

The same can be done in QEMU's contrib/libvhost-user.  It means that a
slave program can run on UNIX domain sockets or the vhost-user-slave
device without significant modifications.

The vhost-pci approach exposes a new virtio device that is totally
different from vhost-user.  Do you plan on writing a whole new driver
=66rom scratch for DPDK?

Stefan

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaONW7AAoJEJykq7OBq3PICWkIALSxaCAp88p3lu9ZUda/BUdI
qaXWEAFgkw5nU08DaWVgnARYp+VuK2KxkNv7l4HClCboZzbyaF0GkvHwUxt5WcZ9
kHwFWdY+Ge1R5f3xSz9ghO33jiEpSoBLA+VEgq8SerEKFruSOhftedyFfbeO0dzl
IuVlimxtt+zMGWCK8Yt8pnteH+7sWdHRJ87lne8hM25N+wNlsjQK8p5zKOF8h88Y
uIfTJQfaXBWoUUlLyHW67P15In938+I7GVcIJKpTxWoc617y69ZceHsQ5aZO58qd
OSKCfImjwk7YdA8YtcPg9jivPsClFPpnaVOANQvyg0CBZ6fuiw0iIB5jBLVbHMQ=
=ycxf
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
