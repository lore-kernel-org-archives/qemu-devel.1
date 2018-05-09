Received: from eggs.gnu.org ([2001:4830:134:3::10]:47299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGTIb-00045u-9X
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGTIa-0004fe-6B
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:54:45 -0400
References: <1514187226.13662.28.camel@intel.com>
	<6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
	<20180508150309.GC4065@localhost.localdomain>
	<20180509101618.GC19645@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d8a06161-d611-4f27-f4c8-f14370f191d4@redhat.com>
Date: Wed, 9 May 2018 19:54:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180509101618.GC19645@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tksrIbz38RtIdO5CbwYyqwVY7ux6LY1Z4"
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
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, He Junyan <junyan.he@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tksrIbz38RtIdO5CbwYyqwVY7ux6LY1Z4
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, qemu block <qemu-block@nongnu.org>,
 qemu-devel@nongnu.org, He Junyan <junyan.he@intel.com>
Message-ID: <d8a06161-d611-4f27-f4c8-f14370f191d4@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] Some question about savem/qcow2
 incremental snapshot
References: <1514187226.13662.28.camel@intel.com>
 <6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
 <20180508150309.GC4065@localhost.localdomain>
 <20180509101618.GC19645@stefanha-x1.localdomain>
In-Reply-To: <20180509101618.GC19645@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 12:16, Stefan Hajnoczi wrote:
> On Tue, May 08, 2018 at 05:03:09PM +0200, Kevin Wolf wrote:
>> Am 08.05.2018 um 16:41 hat Eric Blake geschrieben:
>>> On 12/25/2017 01:33 AM, He Junyan wrote:
>> 2. Make the nvdimm device use the QEMU block layer so that it is backe=
d
>>    by a non-raw disk image (such as a qcow2 file representing the
>>    content of the nvdimm) that supports snapshots.
>>
>>    This part is hard because it requires some completely new
>>    infrastructure such as mapping clusters of the image file to guest
>>    pages, and doing cluster allocation (including the copy on write
>>    logic) by handling guest page faults.
>>
>> I think it makes sense to invest some effort into such interfaces, but=

>> be prepared for a long journey.
>=20
> I like the suggestion but it needs to be followed up with a concrete
> design that is feasible and fair for Junyan and others to implement.
> Otherwise the "long journey" is really just a way of rejecting this
> feature.
>=20
> Let's discuss the details of using the block layer for NVDIMM and try t=
o
> come up with a plan.
>=20
> The biggest issue with using the block layer is that persistent memory
> applications use load/store instructions to directly access data.  This=

> is fundamentally different from the block layer, which transfers blocks=

> of data to and from the device.
>=20
> Because of block DMA, QEMU is able to perform processing at each block
> driver graph node.  This doesn't exist for persistent memory because
> software does not trap I/O.  Therefore the concept of filter nodes
> doesn't make sense for persistent memory - we certainly do not want to
> trap every I/O because performance would be terrible.
>=20
> Another difference is that persistent memory I/O is synchronous.
> Load/store instructions execute quickly.  Perhaps we could use KVM asyn=
c
> page faults in cases where QEMU needs to perform processing, but again
> the performance would be bad.

Let me first say that I have no idea how the interface to NVDIMM looks.
I just assume it works pretty much like normal RAM (so the interface is
just that it=92s a part of the physical address space).

Also, it sounds a bit like you are already discarding my idea, but here
goes anyway.

Would it be possible to introduce a buffering block driver that presents
the guest an area of RAM/NVDIMM through an NVDIMM interface (so I
suppose as part of the guest address space)?  For writing, we=92d keep a
dirty bitmap on it, and then we=92d asynchronously move the dirty areas
through the block layer, so basically like mirror.  On flushing, we=92d
block until everything is clean.

For reading, we=92d follow a COR/stream model, basically, where everythin=
g
is unpopulated in the beginning and everything is loaded through the
block layer both asynchronously all the time and on-demand whenever the
guest needs something that has not been loaded yet.

Now I notice that that looks pretty much like a backing file model where
we constantly run both a stream and a commit job at the same time.

The user could decide how much memory to use for the buffer, so it could
either hold everything or be partially unallocated.

You=92d probably want to back the buffer by NVDIMM normally, so that
nothing is lost on crashes (though this would imply that for partial
allocation the buffering block driver would need to know the mapping
between the area in real NVDIMM and its virtual representation of it).

Just my two cents while scanning through qemu-block to find emails that
don=92t actually concern me...

Max

> Most protocol drivers do not support direct memory access.  iscsi, curl=
,
> etc just don't fit the model.  One might be tempted to implement
> buffering but at that point it's better to just use block devices.
>=20
> I have CCed Pankaj, who is working on the virtio-pmem device.  I need t=
o
> be clear that emulated NVDIMM cannot be supported with the block layer
> since it lacks a guest flush mechanism.  There is no way for
> applications to let the hypervisor know the file needs to be fsynced.
> That's what virtio-pmem addresses.
>=20
> Summary:
> A subset of the block layer could be used to back virtio-pmem.  This
> requires a new block driver API and the KVM async page fault mechanism
> for trapping and mapping pages.  Actual emulated NVDIMM devices cannot
> be supported unless the hardware specification is extended with a
> virtualization-friendly interface in the future.
>=20
> Please let me know your thoughts.
>=20
> Stefan
>=20



--tksrIbz38RtIdO5CbwYyqwVY7ux6LY1Z4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrzNdcACgkQ9AfbAGHV
z0Afmgf8CbCsX2MjaO8L7M+Onj36JOa80LeeH99wFObh7cHtuB5fUtUQtYkimSCk
A3bWmr+jXFoiYJzfytjw3iHPc5BB9nEz6WawzmnepmenAKP0FpgAIgQX1GVFv4Zw
7qL9s8pyA6Vfbn7IwLwc7zl4dPJ09//7S/5JR1di/OirnCYvhiWNTNhlMCIKTvRo
9Tw4AsJqNB7oKDAQkuyC5iqhkytqWnfpzZxb/wq4+lWPp2yVucltyQoZr7acIaN1
SIKMEt8R7o0jrjQl93WYqCecLjzXpinFbU3w9qU4UF7GBmMYPoElknEQQKAxhDVy
TW9hBwTbDhwi+Uqo9YILyZITMjlTXw==
=2++j
-----END PGP SIGNATURE-----

--tksrIbz38RtIdO5CbwYyqwVY7ux6LY1Z4--
