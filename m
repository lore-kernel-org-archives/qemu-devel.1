Received: from eggs.gnu.org ([2001:4830:134:3::10]:33204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGguy-0002HQ-Fm
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGguu-0003MW-HD
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:27:16 -0400
Date: Thu, 10 May 2018 09:26:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510082659.GC1296@stefanha-x1.localdomain>
References: <1514187226.13662.28.camel@intel.com>
	<6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
	<20180508150309.GC4065@localhost.localdomain>
	<20180509101618.GC19645@stefanha-x1.localdomain>
	<d8a06161-d611-4f27-f4c8-f14370f191d4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <d8a06161-d611-4f27-f4c8-f14370f191d4@redhat.com>
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
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, He Junyan <junyan.he@intel.com>


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 07:54:31PM +0200, Max Reitz wrote:
> On 2018-05-09 12:16, Stefan Hajnoczi wrote:
> > On Tue, May 08, 2018 at 05:03:09PM +0200, Kevin Wolf wrote:
> >> Am 08.05.2018 um 16:41 hat Eric Blake geschrieben:
> >>> On 12/25/2017 01:33 AM, He Junyan wrote:
> >> 2. Make the nvdimm device use the QEMU block layer so that it is backed
> >>    by a non-raw disk image (such as a qcow2 file representing the
> >>    content of the nvdimm) that supports snapshots.
> >>
> >>    This part is hard because it requires some completely new
> >>    infrastructure such as mapping clusters of the image file to guest
> >>    pages, and doing cluster allocation (including the copy on write
> >>    logic) by handling guest page faults.
> >>
> >> I think it makes sense to invest some effort into such interfaces, but
> >> be prepared for a long journey.
> >=20
> > I like the suggestion but it needs to be followed up with a concrete
> > design that is feasible and fair for Junyan and others to implement.
> > Otherwise the "long journey" is really just a way of rejecting this
> > feature.
> >=20
> > Let's discuss the details of using the block layer for NVDIMM and try to
> > come up with a plan.
> >=20
> > The biggest issue with using the block layer is that persistent memory
> > applications use load/store instructions to directly access data.  This
> > is fundamentally different from the block layer, which transfers blocks
> > of data to and from the device.
> >=20
> > Because of block DMA, QEMU is able to perform processing at each block
> > driver graph node.  This doesn't exist for persistent memory because
> > software does not trap I/O.  Therefore the concept of filter nodes
> > doesn't make sense for persistent memory - we certainly do not want to
> > trap every I/O because performance would be terrible.
> >=20
> > Another difference is that persistent memory I/O is synchronous.
> > Load/store instructions execute quickly.  Perhaps we could use KVM async
> > page faults in cases where QEMU needs to perform processing, but again
> > the performance would be bad.
>=20
> Let me first say that I have no idea how the interface to NVDIMM looks.
> I just assume it works pretty much like normal RAM (so the interface is
> just that it=E2=80=99s a part of the physical address space).
>=20
> Also, it sounds a bit like you are already discarding my idea, but here
> goes anyway.
>=20
> Would it be possible to introduce a buffering block driver that presents
> the guest an area of RAM/NVDIMM through an NVDIMM interface (so I
> suppose as part of the guest address space)?  For writing, we=E2=80=99d k=
eep a
> dirty bitmap on it, and then we=E2=80=99d asynchronously move the dirty a=
reas
> through the block layer, so basically like mirror.  On flushing, we=E2=80=
=99d
> block until everything is clean.
>=20
> For reading, we=E2=80=99d follow a COR/stream model, basically, where eve=
rything
> is unpopulated in the beginning and everything is loaded through the
> block layer both asynchronously all the time and on-demand whenever the
> guest needs something that has not been loaded yet.
>=20
> Now I notice that that looks pretty much like a backing file model where
> we constantly run both a stream and a commit job at the same time.
>=20
> The user could decide how much memory to use for the buffer, so it could
> either hold everything or be partially unallocated.
>=20
> You=E2=80=99d probably want to back the buffer by NVDIMM normally, so that
> nothing is lost on crashes (though this would imply that for partial
> allocation the buffering block driver would need to know the mapping
> between the area in real NVDIMM and its virtual representation of it).
>=20
> Just my two cents while scanning through qemu-block to find emails that
> don=E2=80=99t actually concern me...

The guest kernel already implements this - it's the page cache and the
block layer!

Doing it in QEMU with dirty memory logging enabled is less efficient
than doing it in the guest.

That's why I said it's better to just use block devices than to
implement buffering.

I'm saying that persistent memory emulation on top of the iscsi:// block
driver (for example) does not make sense.  It could be implemented but
the performance wouldn't be better than block I/O and the
complexity/code size in QEMU isn't justified IMO.

Stefan

> > Most protocol drivers do not support direct memory access.  iscsi, curl,
> > etc just don't fit the model.  One might be tempted to implement
> > buffering but at that point it's better to just use block devices.
> >=20
> > I have CCed Pankaj, who is working on the virtio-pmem device.  I need to
> > be clear that emulated NVDIMM cannot be supported with the block layer
> > since it lacks a guest flush mechanism.  There is no way for
> > applications to let the hypervisor know the file needs to be fsynced.
> > That's what virtio-pmem addresses.
> >=20
> > Summary:
> > A subset of the block layer could be used to back virtio-pmem.  This
> > requires a new block driver API and the KVM async page fault mechanism
> > for trapping and mapping pages.  Actual emulated NVDIMM devices cannot
> > be supported unless the hardware specification is extended with a
> > virtualization-friendly interface in the future.
> >=20
> > Please let me know your thoughts.
> >=20
> > Stefan
> >=20
>=20
>=20




--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9AJTAAoJEJykq7OBq3PInsEH/jxLUrmPM+nPEr8lCjUqUe0M
xAcWz2X7oBTZUgLrXp0Ha0ee00/H52wDPhxFWvgqSCQ+gpZKNoTRZTtLylzTDL7J
xfeL1jvRIqht4FtNMXb4V8k+BqSCRHnuge5WPZIciybqxcsEWz9FQDnwQFXPgbCa
QsE8KbeCvld9LKN5x++nNgpOvzFK4zLGFQmpT4r+Ef5wSLwbdQkCnKvCycBA2t9b
QJjfEoPx/TJeN7aCi7T7GjvwBNbzwb60Ly/5pHnsHHaLEpnaGrjNyd1fLHr6y+Cr
ymLOFxqFpF9VqbFknfysgLGIjlPxyZ62tG5Im9K7lz6v0fONy0uCC5tS4+cVVIA=
=Penv
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
