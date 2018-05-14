Received: from eggs.gnu.org ([2001:4830:134:3::10]:36292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIDqR-00036Q-GR
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIDqM-00067M-If
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:48:55 -0400
Date: Mon, 14 May 2018 14:48:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514134846.GD5182@stefanha-x1.localdomain>
References: <1514187226.13662.28.camel@intel.com>
	<6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
	<20180508150309.GC4065@localhost.localdomain>
	<20180509101618.GC19645@stefanha-x1.localdomain>
	<d8a06161-d611-4f27-f4c8-f14370f191d4@redhat.com>
	<20180510082659.GC1296@stefanha-x1.localdomain>
	<20180511172531.GB5016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <20180511172531.GB5016@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, He Junyan <junyan.he@intel.com>, qemu-devel@nongnu.org, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 07:25:31PM +0200, Kevin Wolf wrote:
> Am 10.05.2018 um 10:26 hat Stefan Hajnoczi geschrieben:
> > On Wed, May 09, 2018 at 07:54:31PM +0200, Max Reitz wrote:
> > > On 2018-05-09 12:16, Stefan Hajnoczi wrote:
> > > > On Tue, May 08, 2018 at 05:03:09PM +0200, Kevin Wolf wrote:
> > > >> Am 08.05.2018 um 16:41 hat Eric Blake geschrieben:
> > > >>> On 12/25/2017 01:33 AM, He Junyan wrote:
> > > >> 2. Make the nvdimm device use the QEMU block layer so that it is b=
acked
> > > >>    by a non-raw disk image (such as a qcow2 file representing the
> > > >>    content of the nvdimm) that supports snapshots.
> > > >>
> > > >>    This part is hard because it requires some completely new
> > > >>    infrastructure such as mapping clusters of the image file to gu=
est
> > > >>    pages, and doing cluster allocation (including the copy on write
> > > >>    logic) by handling guest page faults.
> > > >>
> > > >> I think it makes sense to invest some effort into such interfaces,=
 but
> > > >> be prepared for a long journey.
> > > >=20
> > > > I like the suggestion but it needs to be followed up with a concrete
> > > > design that is feasible and fair for Junyan and others to implement.
> > > > Otherwise the "long journey" is really just a way of rejecting this
> > > > feature.
> > > >=20
> > > > Let's discuss the details of using the block layer for NVDIMM and t=
ry to
> > > > come up with a plan.
> > > >=20
> > > > The biggest issue with using the block layer is that persistent mem=
ory
> > > > applications use load/store instructions to directly access data.  =
This
> > > > is fundamentally different from the block layer, which transfers bl=
ocks
> > > > of data to and from the device.
> > > >=20
> > > > Because of block DMA, QEMU is able to perform processing at each bl=
ock
> > > > driver graph node.  This doesn't exist for persistent memory because
> > > > software does not trap I/O.  Therefore the concept of filter nodes
> > > > doesn't make sense for persistent memory - we certainly do not want=
 to
> > > > trap every I/O because performance would be terrible.
> > > >=20
> > > > Another difference is that persistent memory I/O is synchronous.
> > > > Load/store instructions execute quickly.  Perhaps we could use KVM =
async
> > > > page faults in cases where QEMU needs to perform processing, but ag=
ain
> > > > the performance would be bad.
> > >=20
> > > Let me first say that I have no idea how the interface to NVDIMM look=
s.
> > > I just assume it works pretty much like normal RAM (so the interface =
is
> > > just that it=E2=80=99s a part of the physical address space).
> > >=20
> > > Also, it sounds a bit like you are already discarding my idea, but he=
re
> > > goes anyway.
> > >=20
> > > Would it be possible to introduce a buffering block driver that prese=
nts
> > > the guest an area of RAM/NVDIMM through an NVDIMM interface (so I
> > > suppose as part of the guest address space)?  For writing, we=E2=80=
=99d keep a
> > > dirty bitmap on it, and then we=E2=80=99d asynchronously move the dir=
ty areas
> > > through the block layer, so basically like mirror.  On flushing, we=
=E2=80=99d
> > > block until everything is clean.
> > >=20
> > > For reading, we=E2=80=99d follow a COR/stream model, basically, where=
 everything
> > > is unpopulated in the beginning and everything is loaded through the
> > > block layer both asynchronously all the time and on-demand whenever t=
he
> > > guest needs something that has not been loaded yet.
> > >=20
> > > Now I notice that that looks pretty much like a backing file model wh=
ere
> > > we constantly run both a stream and a commit job at the same time.
> > >=20
> > > The user could decide how much memory to use for the buffer, so it co=
uld
> > > either hold everything or be partially unallocated.
> > >=20
> > > You=E2=80=99d probably want to back the buffer by NVDIMM normally, so=
 that
> > > nothing is lost on crashes (though this would imply that for partial
> > > allocation the buffering block driver would need to know the mapping
> > > between the area in real NVDIMM and its virtual representation of it).
> > >=20
> > > Just my two cents while scanning through qemu-block to find emails th=
at
> > > don=E2=80=99t actually concern me...
> >=20
> > The guest kernel already implements this - it's the page cache and the
> > block layer!
> >=20
> > Doing it in QEMU with dirty memory logging enabled is less efficient
> > than doing it in the guest.
> >=20
> > That's why I said it's better to just use block devices than to
> > implement buffering.
> >=20
> > I'm saying that persistent memory emulation on top of the iscsi:// block
> > driver (for example) does not make sense.  It could be implemented but
> > the performance wouldn't be better than block I/O and the
> > complexity/code size in QEMU isn't justified IMO.
>=20
> I think it could make sense if you put everything together.
>=20
> The primary motivation to use this would of course be that you can
> directly map the guest clusters of a qcow2 file into the guest. We'd
> potentially fault on the first access, but once it's mapped, you get raw
> speed. You're right about flushing, and I was indeed thinking of
> Pankaj's work there; maybe I should have been more explicit about that.
>=20
> Now buffering in QEMU might come in useful when you want to run a block
> job on the device. Block jobs are usually just temporary, and accepting
> temporarily lower performance might be very acceptable when the
> alternative is that you can't perform block jobs at all.

Why is buffering needed for block jobs?  They access the image using
traditional block layer I/O requests.

> If we want to offer something nvdimm-like not only for the extreme
> "performance only, no features" case, but as a viable option for the
> average user, we need to be fast in the normal case, and allow to use
> any block layer features without having to restart the VM with a
> different storage device, even if at a performance penalty.

What are the details involved in making this possible?

Persistent memory does not trap I/O but that is what filter drivers and
before write notifiers need.  So a page protection mechanism is required
for the block layer to trap persistent memory accesses.

Next, this needs to be integrated with BdrvTrackedRequest and
req->serialising so that copy-on-read, blockjobs, etc work correctly
when both traditional block I/O requests from blockjobs and direct
memory access from guest are taking place at the same time.

Page protection is only realistic with KVM async page faults, otherwise
faults freeze the vcpu until they are resolved.  kvm.ko needs to return
the page fault information to QEMU and QEMU must be able to resolve the
async page fault once it has mapped.  Perhaps userfaultfd(2) can be used
for this.

This is as far as I've gotten before thinking about how buffering would
work.

> On iscsi, you still don't gain anything compared to just using a block
> device, but support for that might just happen as a side effect when you
> implement the interesting features.

If we get the feature for free as part of addressing another use case, I
won't complain :).

Stefan

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+ZO+AAoJEJykq7OBq3PIRkAH+wa+BJiVWcbL4Du6dKKoYpdX
bPYX3z/vln8NRMwIZeLbkBe1j/fUZfK79JuF8Ityq30y3QmxWnnxFZdElxRXsRmm
nDohYGz8CqVCzE3bsdX2IBzGvKrUXJ7Z1JFZstN+Lv901zQCCj/uvzd7e85EcWLO
jLsvdEAi8eh+EqkcLhJBeCv19f8iP/36v7xBvx7MsL5r9+zT1fWCZ1Qe9xAMMCIu
jG9L9erU5LfEXYuFO/gIDqwgjdaF6LBllENRuJ8cc3kbcqDwhQoEsBn3HcPoAjFD
hB52JgXcR+MizBNPmF/J88uok25IVXCRlVzj+75mgVoMAvGEbBwXuSOsdMLcDLA=
=ykEk
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
