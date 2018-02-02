Received: from eggs.gnu.org ([2001:4830:134:3::10]:53691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehhDS-0001K6-HD
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehhDO-0002DS-K7
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:41:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ehhDO-0002Bx-AS
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:41:38 -0500
Date: Fri, 2 Feb 2018 15:25:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180202152538.GA16064@stefanha-x1.localdomain>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<5A65C652.6080307@intel.com>
	<20180123111238.GC6565@stefanha-x1.localdomain>
	<5A673369.6050408@intel.com>
	<20180124114055.GC17193@stefanha-x1.localdomain>
	<5A69AF21.5000209@intel.com>
	<20180126144429.GD17788@stefanha-x1.localdomain>
	<5A70606F.3030307@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <5A70606F.3030307@intel.com>
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 08:09:19PM +0800, Wei Wang wrote:
> On 01/26/2018 10:44 PM, Stefan Hajnoczi wrote:
> > On Thu, Jan 25, 2018 at 06:19:13PM +0800, Wei Wang wrote:
> > > On 01/24/2018 07:40 PM, Stefan Hajnoczi wrote:
> > > > On Tue, Jan 23, 2018 at 09:06:49PM +0800, Wei Wang wrote:
> > > > > On 01/23/2018 07:12 PM, Stefan Hajnoczi wrote:
> > > > > > On Mon, Jan 22, 2018 at 07:09:06PM +0800, Wei Wang wrote:
> > > > > > > On 01/19/2018 09:06 PM, Stefan Hajnoczi wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > >     - Suppose in the future there is also a kernel virtio-vho=
st-user driver as
> > > > > > > other PCI devices, can we unbind the kernel driver first, and=
 then bind the
> > > > > > > device to the dpdk driver? A normal PCI device should be able=
 to smoothly
> > > > > > > switch between the kernel driver and dpdk driver.
> > > > > > It depends what you mean by "smoothly switch".
> > > > > >=20
> > > > > > If you mean whether it's possible to go from a kernel driver to
> > > > > > vfio-pci, then the answer is yes.
> > > > > >=20
> > > > > > But if the kernel driver has an established vhost-user connecti=
on then
> > > > > > it will be closed.  This is the same as reconnecting with AF_UN=
IX
> > > > > > vhost-user.
> > > > > >=20
> > > > > Actually not only the case of switching to testpmd after kernel e=
stablishes
> > > > > the connection, but also for several runs of testpmd. That is, if=
 we run
> > > > > testpmd, then exit testpmd. I think the second run of testpmd won=
't work.
> > > > The vhost-user master must reconnect and initialize again (SET_FEAT=
URES,
> > > > SET_MEM_TABLE, etc).  Is your master reconnecting after the AF_UNIX
> > > > connection is closed?
> > > Is this an explicit qmp operation to make the master re-connect?
> > I haven't tested it myself but I'm aware of two modes of operation:
> >=20
> > 1. -chardev socket,id=3Dchardev0,...,server
> >     -netdev vhost-user,chardev=3Dchardev0
> >=20
> >     When the vhost-user socket is disconnected the peer needs to
> >     reconnect.  In this case no special commands are necessary.
> >=20
> >     Here we're relying on DPDK librte_vhost's reconnection behavior.
> >=20
> > Or
> >=20
> > 2. -chardev socket,id=3Dchardev0,...,reconnect=3D3
> >     -netdev vhost-user,chardev=3Dchardev0
> >=20
> >     When the vhost-user socket is disconnected a new connection attempt
> >     will be made after 3 seconds.
> >=20
> > In both cases vhost-user negotiation will resume when the new connection
> > is established.
> >=20
> > Stefan
>=20
> I've been thinking about the issues, and it looks vhost-pci outperforms in
> this aspect.
> Vhost-pci is like using a mail box. messages are just dropped into the bo=
x,
> and whenever vhost-pci pmd gets booted, it can always get the messages fr=
om
> the box, the negotiation between vhost-pci pmd and virtio-net is
> asynchronous.
> Virtio-vhost-user is like a phone call, which is a synchronous
> communication. If one side is absent, then the other side will hang on
> without knowing when it could get connected or hang up with messages not
> passed (lost).
>=20
> I also think the above solutions won't help. Please see below:
>=20
> Background:
> The vhost-user negotiation is split into 2 phases currently. The 1st phase
> happens when the connection is established, and we can find what's done in
> the 1st phase in vhost_user_init(). The 2nd phase happens when the master
> driver is loaded (e.g. run of virtio-net pmd) and set status to the devic=
e,
> and we can find what's done in the 2nd phase in vhost_dev_start(), which
> includes sending the memory info and virtqueue info. The socket is
> connected, till one of the QEMU devices exits, so pmd exiting won't end t=
he
> QEMU side socket connection.
>
> Issues:
> Suppose we have both the vhost and virtio-net set up, and vhost pmd <->
> virtio-net pmd communication works well. Now, vhost pmd exits (virtio-net
> pmd is still there). Some time later, we re-run vhost pmd, the vhost pmd
> doesn't know the virtqueue addresses of the virtio-net pmd, unless the
> virtio-net pmd reloads to start the 2nd phase of the vhost-user protocol.=
 So
> the second run of the vhost pmd won't work.

This isn't a problem for virtio-vhost-user since the vhost-pmd resets
the virtio-vhost-user device when it restarts.  The vhost-user AF_UNIX
socket reconnects and negotiation restarts.

Stefan

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJadILyAAoJEJykq7OBq3PI0vEH/05NLv1rUJeTWSXlJrM6P7yo
aIb4baUIhhoLXdemiTndoU3RAbUskm8E2Tz5eS5H2EN9tJXn8fR4C5Ij4nFYsR5p
ycufKSzSFM2H217/zBVHA68S3kaWgKozKu942zuAyfGOiAW+5vRKa7Hu+2PVAY7M
Bthe+XfXL8ogn/8s1nd5//PXG8vtKGDblozyW8Fb6jHcVOT+/0w3MvY0HNjqazj4
dAe7SMm2OsasEU8ImrduI5bl16heYlt1NyBS4Fuka8LVlIDHYMAYVg20QZ04X0pt
MWw+EGzTDABT0tOn/8wkrJWX8UWqnBF5Io61sfOUO1TYm51LqRdWPZysCCdV8TI=
=HBbl
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
