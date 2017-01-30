Received: from eggs.gnu.org ([2001:4830:134:3::10]:36388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYA61-0005xs-MR
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 06:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYA5w-0002dC-NF
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 06:26:05 -0500
Date: Mon, 30 Jan 2017 11:25:50 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130112550.GA2118@stefanha-x1.localdomain>
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<CAJ+F1C+WV7OhxpYb3RgmtRjXU7_kfygr2jh2cawYwZq8MMrJGQ@mail.gmail.com>
	<79bc9757-3ba0-87c3-3502-a25a30e304a3@siemens.com>
	<20170117095910.GC4265@stefanha-x1.localdomain>
	<7586642a42833441c2bbe5ac3403e44b@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <7586642a42833441c2bbe5ac3403e44b@suse.de>
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: msuchanek <msuchanek@suse.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jailhouse <jailhouse-dev@googlegroups.com>, Wei Wang <wei.w.wang@intel.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Qemu-devel <qemu-devel-bounces+msuchanek=suse.de@nongnu.org>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 29, 2017 at 12:56:23PM +0100, msuchanek wrote:
> On 2017-01-17 10:59, Stefan Hajnoczi wrote:
> > On Mon, Jan 16, 2017 at 02:10:17PM +0100, Jan Kiszka wrote:
> > > On 2017-01-16 13:41, Marc-Andr=E9 Lureau wrote:
> > > > On Mon, Jan 16, 2017 at 12:37 PM Jan Kiszka <jan.kiszka@siemens.com
> > > > <mailto:jan.kiszka@siemens.com>> wrote:
> > > >     So, this is our proposal. Would be great to hear some opinions =
if you
> > > >     see value in adding support for such an "ivshmem 2.0" device to=
 QEMU as
> > > >     well and expand its ecosystem towards Linux upstream, maybe als=
o DPDK
> > > >     again. If you see problems in the new design /wrt what QEMU pro=
vides so
> > > >     far with its ivshmem device, let's discuss how to resolve them.=
 Looking
> > > >     forward to any feedback!
> > > >
> > > >
> > > > My feeling is that ivshmem is not being actively developped in qemu=
, but
> > > > rather virtio-based solutions (vhost-pci for vm2vm).
> > >=20
> > > As pointed out, for us it's most important to keep the design simple -
> > > even at the price of "reinventing" some drivers for upstream (at
> > > least,
> > > we do not need two sets of drivers because our interface is fully
> > > symmetric). I don't see yet how vhost-pci could achieve the same, but
> > > I'm open to learn more!
> >=20
> > The concept of symmetry is nice but only applies for communications
> > channels like networking and serial.
> >=20
> > It doesn't apply for I/O that is fundamentally asymmetric like disk I/O.
> >=20
> > I just wanted to point this out because lack symmetry has also bothered
> > me about virtio but it's actually impossible to achieve it for all
> > device types.
> >=20
>=20
> What's asymetric about storage? IIRC both SCSI and Firewire which can be
> used for storage are symmetric. All asymmetry only comes from usage
> convention or less capable buses like IDE/SATA.

I'll also add Intel NVMe and virtio-blk to the list of interfaces that
are not symmetric.

Even for SCSI, separate roles for initiator and target are central to
the SCSI Architecture Model.  The consequence is that hardware
interfaces and software stacks are not symmetric.  For example, the
Linux SCSI target only supports a small set of FC HBAs with explicit
target mode support rather than all SCSI HBAs.

Intuitively this makes sense - if the I/O has clear "client" and
"server" roles then why should both sides implement both roles?  It adds
cost and complexity for no benefit.

The same goes for other device types like graphics cards.  They are
inherently asymmetric.  Only one side has the actual hardware to perform
the I/O so it doesn't make sense to be symmetric.

You can pretend they are symmetric by restricting the hardware interface
and driver to just message passing.  Then another layer of software
handles the asymmetric behavior.  But then you may as well use iSCSI,
VNC, etc and not have a hardware interface for disk and graphics.

Stefan

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYjyK+AAoJEJykq7OBq3PI+fAH/R/7F76OG8qq3WlJeFRSrdI2
xrn25BZMEfWgr0u8lnKuugHmegqlXVGGTD6Us15iuIOJT9NcVO9r0N5Mwg0iE/uu
EnPwf9BZ9stQ76drnJB2v1Xnd/HfaaJl5YT6k8x0+Zk2E7V1CAR5rdPaq/O8gClk
91MosneJakeGOpQhUxnFHXQI+k9Z95fdbsAAHJ42bg88Fp5maOFzuLIfiJLMSXG1
4anlrEGuWibFGqVKABS/vqQNzHCap2JNnTvahzOA+VLlCssRUYe9ImVgOTsv/Agn
hdvOeSCa9x4Q42co+pJPWQARvTuAs2BLig7Lnpui6FaCoHKSvkd4mx5fc+D/nTY=
=jmgb
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
