Received: from eggs.gnu.org ([2001:4830:134:3::10]:54603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZwq1-0001Ry-SC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZwpx-0004lc-G6
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:45:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eZwpw-0004ky-V1
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:45:25 -0500
Date: Fri, 12 Jan 2018 10:45:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180112104510.GG7356@stefanha-x1.localdomain>
References: <20171219162151.GA10889@stefanha-x1.localdomain>
	<1512291492.2209478.1513854089861.JavaMail.zimbra@redhat.com>
	<20180104104744.GC10106@stefanha-x1.localdomain>
	<5A4E0CDA.4060409@intel.com>
	<20180105154914.GH28322@stefanha-x1.localdomain>
	<5A53547D.2090602@intel.com>
	<20180108160921.GC11758@stefanha-x1.localdomain>
	<5A585B77.4040404@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w2JjAQZceEVGylhD"
Content-Disposition: inline
In-Reply-To: <5A585B77.4040404@intel.com>
Subject: Re: [Qemu-devel] vhost-user graceful connect/disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, mukawa@igel.co.jp, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, n nikolaev <n.nikolaev@virtualopensystems.com>


--w2JjAQZceEVGylhD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 02:53:43PM +0800, Wei Wang wrote:
> On 01/09/2018 12:09 AM, Stefan Hajnoczi wrote:
> > On Mon, Jan 08, 2018 at 07:22:37PM +0800, Wei Wang wrote:
> > > On 01/05/2018 11:49 PM, Stefan Hajnoczi wrote:
> > > > On Thu, Jan 04, 2018 at 07:15:38PM +0800, Wei Wang wrote:
> > > > > On 01/04/2018 06:47 PM, Stefan Hajnoczi wrote:
> > > > > > On Thu, Dec 21, 2017 at 06:01:29AM -0500, Marc-Andr=E9 Lureau w=
rote:
> > > > > >=20
> > > > > > I'm not going to prototype this yet, I'm working on virtio-vhos=
t-user
> > > > > > first, but eventually I might get back to -object vhost-user(-b=
ackend).
> > > > > >=20
> > > > > Hi Stefan, are you implementing the guest slave and vhost-pci dri=
ver (we've
> > > > > posted to the dpdk mailinglist) as well? and do you have an estim=
ation when
> > > > > would the prototype be ready?
> > > > I'm implementing the "[RFC virtio-dev] vhost-user-slave: add vhost-=
user
> > > > slave device type" device in QEMU and DPDK in order to show how the
> > > > ideas we've discussed work.
> > > >=20
> > > > Here is the VIRTIO spec link again:
> > > > https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007
> > > There are four virtqueues documented in the spec, would two suffice? =
Request
> > > and Response can be distinguished by VHOST_USER_REPLY_MASK.
> > That's a good idea and I'll do it for the master-to-slave virtqueue.
> >=20
> > Unfortunately virtqueues are asymmetric so a single virtqueue cannot
> > support the slave-to-master message flow (VHOST_USER_SET_SLAVE_REQ_FD):
> > 1. Master puts an empty buffer onto vq.
> > 2. Slave takes buffer and fills in a request.  The buffer is now used.
> > 3. Master pops the used buffer but there is no way to reply back to the
> >     slave!
>=20
>=20
> Essentially, I think two virtqueues should be sufficient for guest-to-host
> and host-to-guest communication.
>=20
> Host-to-guest virtqueue: used for master request/response messages passed=
 to
> the guest slave (driver). The buffer can be primed by the guest driver (l=
ike
> virtio-net rxq).
> Guest-to-host virtqueue: used for guest slave request/response messages,
> like virtio-net txq, it doesn't need to prime buffers in advance.

Yes, multiplexing all messages over an rx and tx virtqueue is possible.
QEMU needs to demultiplex them on to the appropriate AF_UNIX fds.

The downside to multiplexing is that it makes per-queue policies
impossible (e.g. per-queue interrupts and affinity, multiqueue, etc).  I
think that's okay because we don't need them for virtio-vhost-user.  And
it's possible to add a feature bit for a new virtqueue layout later if
we hit problems...

I'll give this a try.

Stefan

--w2JjAQZceEVGylhD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaWJG2AAoJEJykq7OBq3PIGWsIAK913a39ls0rzhLxqz5GYwbw
pHwnW83HbfLsUIRjWvIOxfq3jgVxKBIec1/6rgzZ+4+zapnKGF38jFX+uAL6btgG
XZxBOz4F3eNgX8WlbmzqEdgUFQrl2v04PRoSxTk3soFzK2vLuJt7NUBCsGpJmntp
NxRcubbPZQiAxr26CJLFn62gaPrUwyi4EqTNcFlDoyLD0xc7Ds7U536dtEyACr43
B0xb24z/di7H4qhUr36VW7ITWE+ddj/Pttddx2dJymlNlXUymV9HfgfGP8eHXkmw
RpcyRAF7UneIcBW9BrgOg3fszEfftl/obSENsKLfW51jmYq4BpbjMBA83PKJFpE=
=NSls
-----END PGP SIGNATURE-----

--w2JjAQZceEVGylhD--
