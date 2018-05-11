Received: from eggs.gnu.org ([2001:4830:134:3::10]:44623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fHBnY-0008JL-4z
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fHBnW-0005dV-KO
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:25:40 -0400
Date: Fri, 11 May 2018 19:25:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180511172531.GB5016@localhost.localdomain>
References: <1514187226.13662.28.camel@intel.com>
	<6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
	<20180508150309.GC4065@localhost.localdomain>
	<20180509101618.GC19645@stefanha-x1.localdomain>
	<d8a06161-d611-4f27-f4c8-f14370f191d4@redhat.com>
	<20180510082659.GC1296@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20180510082659.GC1296@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] Some question about savem/qcow2
 incremental snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, He Junyan <junyan.he@intel.com>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.05.2018 um 10:26 hat Stefan Hajnoczi geschrieben:
> On Wed, May 09, 2018 at 07:54:31PM +0200, Max Reitz wrote:
> > On 2018-05-09 12:16, Stefan Hajnoczi wrote:
> > > On Tue, May 08, 2018 at 05:03:09PM +0200, Kevin Wolf wrote:
> > >> Am 08.05.2018 um 16:41 hat Eric Blake geschrieben:
> > >>> On 12/25/2017 01:33 AM, He Junyan wrote:
> > >> 2. Make the nvdimm device use the QEMU block layer so that it is bac=
ked
> > >>    by a non-raw disk image (such as a qcow2 file representing the
> > >>    content of the nvdimm) that supports snapshots.
> > >>
> > >>    This part is hard because it requires some completely new
> > >>    infrastructure such as mapping clusters of the image file to guest
> > >>    pages, and doing cluster allocation (including the copy on write
> > >>    logic) by handling guest page faults.
> > >>
> > >> I think it makes sense to invest some effort into such interfaces, b=
ut
> > >> be prepared for a long journey.
> > >=20
> > > I like the suggestion but it needs to be followed up with a concrete
> > > design that is feasible and fair for Junyan and others to implement.
> > > Otherwise the "long journey" is really just a way of rejecting this
> > > feature.
> > >=20
> > > Let's discuss the details of using the block layer for NVDIMM and try=
 to
> > > come up with a plan.
> > >=20
> > > The biggest issue with using the block layer is that persistent memory
> > > applications use load/store instructions to directly access data.  Th=
is
> > > is fundamentally different from the block layer, which transfers bloc=
ks
> > > of data to and from the device.
> > >=20
> > > Because of block DMA, QEMU is able to perform processing at each block
> > > driver graph node.  This doesn't exist for persistent memory because
> > > software does not trap I/O.  Therefore the concept of filter nodes
> > > doesn't make sense for persistent memory - we certainly do not want to
> > > trap every I/O because performance would be terrible.
> > >=20
> > > Another difference is that persistent memory I/O is synchronous.
> > > Load/store instructions execute quickly.  Perhaps we could use KVM as=
ync
> > > page faults in cases where QEMU needs to perform processing, but again
> > > the performance would be bad.
> >=20
> > Let me first say that I have no idea how the interface to NVDIMM looks.
> > I just assume it works pretty much like normal RAM (so the interface is
> > just that it=E2=80=99s a part of the physical address space).
> >=20
> > Also, it sounds a bit like you are already discarding my idea, but here
> > goes anyway.
> >=20
> > Would it be possible to introduce a buffering block driver that presents
> > the guest an area of RAM/NVDIMM through an NVDIMM interface (so I
> > suppose as part of the guest address space)?  For writing, we=E2=80=99d=
 keep a
> > dirty bitmap on it, and then we=E2=80=99d asynchronously move the dirty=
 areas
> > through the block layer, so basically like mirror.  On flushing, we=E2=
=80=99d
> > block until everything is clean.
> >=20
> > For reading, we=E2=80=99d follow a COR/stream model, basically, where e=
verything
> > is unpopulated in the beginning and everything is loaded through the
> > block layer both asynchronously all the time and on-demand whenever the
> > guest needs something that has not been loaded yet.
> >=20
> > Now I notice that that looks pretty much like a backing file model where
> > we constantly run both a stream and a commit job at the same time.
> >=20
> > The user could decide how much memory to use for the buffer, so it could
> > either hold everything or be partially unallocated.
> >=20
> > You=E2=80=99d probably want to back the buffer by NVDIMM normally, so t=
hat
> > nothing is lost on crashes (though this would imply that for partial
> > allocation the buffering block driver would need to know the mapping
> > between the area in real NVDIMM and its virtual representation of it).
> >=20
> > Just my two cents while scanning through qemu-block to find emails that
> > don=E2=80=99t actually concern me...
>=20
> The guest kernel already implements this - it's the page cache and the
> block layer!
>=20
> Doing it in QEMU with dirty memory logging enabled is less efficient
> than doing it in the guest.
>=20
> That's why I said it's better to just use block devices than to
> implement buffering.
>=20
> I'm saying that persistent memory emulation on top of the iscsi:// block
> driver (for example) does not make sense.  It could be implemented but
> the performance wouldn't be better than block I/O and the
> complexity/code size in QEMU isn't justified IMO.

I think it could make sense if you put everything together.

The primary motivation to use this would of course be that you can
directly map the guest clusters of a qcow2 file into the guest. We'd
potentially fault on the first access, but once it's mapped, you get raw
speed. You're right about flushing, and I was indeed thinking of
Pankaj's work there; maybe I should have been more explicit about that.

Now buffering in QEMU might come in useful when you want to run a block
job on the device. Block jobs are usually just temporary, and accepting
temporarily lower performance might be very acceptable when the
alternative is that you can't perform block jobs at all.

If we want to offer something nvdimm-like not only for the extreme
"performance only, no features" case, but as a viable option for the
average user, we need to be fast in the normal case, and allow to use
any block layer features without having to restart the VM with a
different storage device, even if at a performance penalty.

On iscsi, you still don't gain anything compared to just using a block
device, but support for that might just happen as a side effect when you
implement the interesting features.

Kevin

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa9dILAAoJEH8JsnLIjy/WOD0P/j4kct48Y4E2Oo5wksj3jAB9
xK4QAfwRFbvSYkxB6RCVBqbR982pUzL5FICnnK/cuX2aHQz967lqbxARZ5nbf9WG
Z/95j/HtmTl1KntvLClWkbIn/tlp5VIBMObS+kJq8xNogfy1Z30ilWSN3E3XfxJc
Idzj2z84Eubak0WIZUv3fbgaaNYOTPH4FfHUvOkLofj7h1t51HAstu6z4aevizXK
p7uMFXhnzajkSKmyIXkjnCsbkZZm8Inbu25QfvFeu4oPP9VRmJjJBqoY6cKaIl8b
yAc15OxST8+5XCLx6fRZlwtHaY3jiNwjIj1nWBiD88ZYSsolTHqeslLjXPWDy7sA
gOq/nBSUnPNQ4S+Skj52+bjOWLaUIrxeAZgCwe4nE8oxj0WjET5y0JXxLv9TLTEI
e4Jn5ZI3SgmVg0r9j4JwoSQwkMQp/dx/x8N7g//EGAiAISZmvbxweYehvylKmj4C
4iKgAR7qX9Ji0BRgOuxQe6OosHJdzkHQ844zRf3/jPRqesWjHGcC5B2tA0phI3gd
EUIY6XJ05KjKYLE17WxtN4/m6uoPr2DTb1Aqb/V27aJfS10XRyWPjpBWtxowmSBf
lx2QBTaE4WB4xITG5pseU1FEW6jcv4NvcjlM+mW8W2pA2uguan9ofrHkqHqFy0tg
cw7tYgR9dYNIzM+XB7cf
=Mhfy
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
