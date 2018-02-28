Received: from eggs.gnu.org ([2001:4830:134:3::10]:42593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er69K-0006WA-4C
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er69J-0007aB-0H
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:08:18 -0500
References: <20180226170313.8178-1-mreitz@redhat.com>
	<20180227161743.GC32480@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
Date: Wed, 28 Feb 2018 19:08:09 +0100
MIME-Version: 1.0
In-Reply-To: <20180227161743.GC32480@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qGUCl9YDnRZhwsH6S0CGUmfXIO1xxDKDh"
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qGUCl9YDnRZhwsH6S0CGUmfXIO1xxDKDh
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <f0f0f6a0-bf09-8561-5c81-87d38ebef168@redhat.com>
Subject: Re: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
References: <20180226170313.8178-1-mreitz@redhat.com>
 <20180227161743.GC32480@stefanha-x1.localdomain>
In-Reply-To: <20180227161743.GC32480@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-02-27 17:17, Stefan Hajnoczi wrote:
> On Mon, Feb 26, 2018 at 06:03:13PM +0100, Max Reitz wrote:
>> There are filesystems (among which is tmpfs) that have a hard time
>> reporting allocation status.  That is definitely a bug in them.
>>
>> However, there is no good reason why qemu-img convert should query the=

>> allocation status in the first place.  It does zero detection by itsel=
f
>> anyway, so we can detect unallocated areas ourselves.
>>
>> Furthermore, if a filesystem driver has any sense, reading unallocated=

>> data should take just as much time as lseek(SEEK_DATA) + memset().  So=

>> the only overhead we introduce by dropping the manual lseek() call is =
a
>> memset() in the driver and a buffer_is_zero() in qemu-img, both of whi=
ch
>> should be relatively quick.
>=20
> This makes sense.  Which file systems did you test this patch on?

On tmpfs and xfs, so far.

> XFS, ext4, and tmpfs would be a good minimal test set to prove the
> patch.  Perhaps with two input files:
> 1. A file that is mostly filled with data.
> 2. A file that is only sparsely populated with data.

And probably with vmdk, which (by default) forbids querying any areas
larger than 64 kB.

> The time taken should be comparable with the time before this patch.

Yep, I'll do some benchmarks.

Max


--qGUCl9YDnRZhwsH6S0CGUmfXIO1xxDKDh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqW8AkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQGYH/A75iAWsUkwxF/EECKO54DjOy0pzVNAd
RKiyKNvG2jlYoWRppo5PIVDBX+Q1DdqKvGPMCUhFZAI7R8ESmz2t7MBkgyTm7AKS
3JpR/yf7TWw4Ykwmnjw0QXAgACljrpIWcpvvTLhmS8oFEx1ZTlLORP3456Rmo3Fy
Evc7nWHPa48ieQQzew/ikWqu8ya2nrN0BS6YqExhekkTF4rseE5UVkHMt5/DTAue
3lHlgEXkv3zL2fPEYNjmQtI2UyyOdcIrLkO+3xrTHrZZzTcd93+cbbycOGoLOrwP
yggLqmN31AjHJyEIoP4El4YI734xe2y2dt0I5nV3KgRNJJAQovUTapk=
=Kr4I
-----END PGP SIGNATURE-----

--qGUCl9YDnRZhwsH6S0CGUmfXIO1xxDKDh--
