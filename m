Received: from eggs.gnu.org ([2001:4830:134:3::10]:44057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGM97-0006wv-Qe
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGM96-000382-Sj
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:16:29 -0400
Date: Wed, 9 May 2018 11:16:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180509101618.GC19645@stefanha-x1.localdomain>
References: <1514187226.13662.28.camel@intel.com>
	<6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
	<20180508150309.GC4065@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <20180508150309.GC4065@localhost.localdomain>
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
Cc: Eric Blake <eblake@redhat.com>, He Junyan <junyan.he@intel.com>, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, qemu block <qemu-block@nongnu.org>, Pankaj Gupta <pagupta@redhat.com>


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 05:03:09PM +0200, Kevin Wolf wrote:
> Am 08.05.2018 um 16:41 hat Eric Blake geschrieben:
> > On 12/25/2017 01:33 AM, He Junyan wrote:
> 2. Make the nvdimm device use the QEMU block layer so that it is backed
>    by a non-raw disk image (such as a qcow2 file representing the
>    content of the nvdimm) that supports snapshots.
>=20
>    This part is hard because it requires some completely new
>    infrastructure such as mapping clusters of the image file to guest
>    pages, and doing cluster allocation (including the copy on write
>    logic) by handling guest page faults.
>=20
> I think it makes sense to invest some effort into such interfaces, but
> be prepared for a long journey.

I like the suggestion but it needs to be followed up with a concrete
design that is feasible and fair for Junyan and others to implement.
Otherwise the "long journey" is really just a way of rejecting this
feature.

Let's discuss the details of using the block layer for NVDIMM and try to
come up with a plan.

The biggest issue with using the block layer is that persistent memory
applications use load/store instructions to directly access data.  This
is fundamentally different from the block layer, which transfers blocks
of data to and from the device.

Because of block DMA, QEMU is able to perform processing at each block
driver graph node.  This doesn't exist for persistent memory because
software does not trap I/O.  Therefore the concept of filter nodes
doesn't make sense for persistent memory - we certainly do not want to
trap every I/O because performance would be terrible.

Another difference is that persistent memory I/O is synchronous.
Load/store instructions execute quickly.  Perhaps we could use KVM async
page faults in cases where QEMU needs to perform processing, but again
the performance would be bad.

Most protocol drivers do not support direct memory access.  iscsi, curl,
etc just don't fit the model.  One might be tempted to implement
buffering but at that point it's better to just use block devices.

I have CCed Pankaj, who is working on the virtio-pmem device.  I need to
be clear that emulated NVDIMM cannot be supported with the block layer
since it lacks a guest flush mechanism.  There is no way for
applications to let the hypervisor know the file needs to be fsynced.
That's what virtio-pmem addresses.

Summary:
A subset of the block layer could be used to back virtio-pmem.  This
requires a new block driver API and the KVM async page fault mechanism
for trapping and mapping pages.  Actual emulated NVDIMM devices cannot
be supported unless the hardware specification is extended with a
virtualization-friendly interface in the future.

Please let me know your thoughts.

Stefan

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8spyAAoJEJykq7OBq3PIz1kH/jU257NJtPgnBNZFUhoXh7lg
LgjV3Ctn0k4iAK8L9Fe9E00XO7w6QLwyQT4NgwcK1ncR4GwiTiSI2Q15Bpdjk3Su
IBGKa4pf5exyMtFe7+WLScj2z26iKeWDqqRK/VuR9TRyVhAl2nVdqnbC0QyT0Ory
tmh8/E80pkDTpe9EnCs1gNxXtruUVavIuDmoJKNCkwopKoV0vEl4yvITPS5Ailtq
As7ofuYzGF6tii5QtJ4A9vwVJaAJdKfpj7gPISfpLKUiKuvBLprji/+uvdnhdkh0
nWrXt8XQ3yLH8+sOE13uNSmQf4JEBuzFnnDCVcu0Q7+TXUORGx2HVMzuFavuOC0=
=XfL5
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
