Received: from eggs.gnu.org ([2001:4830:134:3::10]:35742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ffhl4-0005q5-UY
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ffhl3-0005nW-TO
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:24:26 -0400
Date: Tue, 17 Jul 2018 11:31:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180717103156.GB9927@stefanha-x1.localdomain>
References: <20180629124052.331406-1-dplotnikov@virtuozzo.com>
	<20180702151843.GJ2155@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20180702151843.GJ2155@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v0 0/2] Postponed actions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 04:18:43PM +0100, Stefan Hajnoczi wrote:
> On Fri, Jun 29, 2018 at 03:40:50PM +0300, Denis Plotnikov wrote:
> > There are cases when a request to a block driver state shouldn't have
> > appeared producing dangerous race conditions.
> > This misbehaviour is usually happens with storage devices emulated
> > without eventfd for guest to host notifications like IDE.
> >=20
> > The issue arises when the context is in the "drained" section
> > and doesn't expect the request to come, but request comes from the
> > device not using iothread and which context is processed by the main lo=
op.
> >=20
> > The main loop apart of the iothread event loop isn't blocked by the
> > "drained" section.
> > The request coming and processing while in "drained" section can spoil =
the
> > block driver state consistency.
> >=20
> > This behavior can be observed in the following KVM-based case:
> >=20
> > 1. Setup a VM with an IDE disk.
> > 2. Inside a VM start a disk writing load for the IDE device
> >   e.g: dd if=3D<file> of=3D<file> bs=3DX count=3DY oflag=3Ddirect
> > 3. On the host create a mirroring block job for the IDE device
> >   e.g: drive_mirror <your_IDE> <your_path>
> > 4. On the host finish the block job
> >   e.g: block_job_complete <your_IDE>
> > =20
> > Having done the 4th action, you could get an assert:
> > assert(QLIST_EMPTY(&bs->tracked_requests)) from mirror_run.
> > On my setup, the assert is 1/3 reproducible.
> >=20
> > The patch series introduces the mechanism to postpone the requests
> > until the BDS leaves "drained" section for the devices not using iothre=
ads.
> > Also, it modifies the asynchronous block backend infrastructure to use
> > that mechanism to release the assert bug for IDE devices.
>=20
> I don't understand the scenario.  IDE emulation runs in the vcpu and
> main loop threads.  These threads hold the global mutex when executing
> QEMU code.  If thread A is in a drained region with the global mutex,
> then thread B cannot run QEMU code since it would need to global mutex.
>=20
> So I guess the problem is not that thread B will submit new requests,
> but maybe that the IDE DMA code will run a completion in thread A and
> submit another request in the drained region?

Ping! :)

Stefan

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbTcWcAAoJEJykq7OBq3PIrrUH/2npsomJY/zTkpgP1Tn3MrXc
ntirIf6Tm4Rn/mAihmmzfJrkXvQt4P6kar/TVjsBa8893njaS8d1LJGh3ysCbu7L
htW7jvssryxq55U7WjqT4o1sl+EbViRNLRlpF9dgnUqeogMPNNmhdwPk5ZDIXv+s
dehMBpPVysiqemMcb02QEra50E4OztEQOluEjpG4h+SDv21J12u3knkyCDP7E/hw
Oq0DJHqbRFfp6BtsVB5XuDpoV1Xqa0eyLi5Kpl7GzTHatG8EG7+pbX8YWW0ye6gw
8T1lSpYFiq3WrmUDjeR5yb38ybw2Bwcjpoh9LR/ImnSnB2P/UwCiaX+LAruyBGc=
=wXC6
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
