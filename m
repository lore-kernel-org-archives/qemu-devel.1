Received: from eggs.gnu.org ([2001:4830:134:3::10]:32892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAJdl-0001Ko-G0
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAJdf-0003b6-Rh
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:50:49 -0400
References: <20171102120223.GI32533@redhat.com>
	<20171102164028.lkl3cv52stkdiywj@eukaryote>
	<20171102170448.GX32533@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c41f881-d773-85e1-f18a-ea1b6c77cf9c@redhat.com>
Date: Thu, 2 Nov 2017 12:50:39 -0500
MIME-Version: 1.0
In-Reply-To: <20171102170448.GX32533@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s6K9OKDlOK3MlRDgEC4wwrRwTKgRAonWr"
Subject: Re: [Qemu-devel] [Qemu-block] RFC: use case for adding QMP,
 block jobs & multiple exports to qemu-nbd ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mbooth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s6K9OKDlOK3MlRDgEC4wwrRwTKgRAonWr
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mbooth@redhat.com
Message-ID: <3c41f881-d773-85e1-f18a-ea1b6c77cf9c@redhat.com>
Subject: Re: [Qemu-block] RFC: use case for adding QMP, block jobs & multiple
 exports to qemu-nbd ?
References: <20171102120223.GI32533@redhat.com>
 <20171102164028.lkl3cv52stkdiywj@eukaryote>
 <20171102170448.GX32533@redhat.com>
In-Reply-To: <20171102170448.GX32533@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/02/2017 12:04 PM, Daniel P. Berrange wrote:

> vm-a-disk1.qcow2 open - its just a regular backing file setup.
>=20
>>
>>> 	    |  (format=3Dqcow2, proto=3Dfile)
>>>           |
>>>           +-  vm-a-disk1.qcow2  (qemu-system-XXX)
>>>
>>> The problem is that many VMs are wanting to use cache-disk1.qcow2 as
>>> their disk's backing file, and only one process is permitted to be
>>> writing to disk backing file at any time.
>>
>> Can you explain a bit more about how many VMs are trying to write to
>> write to the same backing file 'cache-disk1.qcow2'?  I'd assume it's
>> just the "immutable" local backing store (once the previous 'mirror' j=
ob
>> is completed), based on which Nova creates a qcow2 overlay for each
>> instance it boots.
>=20
> An arbitrary number of  vm-*-disk1.qcow2 files could exist all using
> the same cache-disk1.qcow2 image. Its only limited by how many VMs
> you can fit on the host. By definition you can only ever have a single
> process writing to a qcow2 file though, otherwise corruption will quick=
ly
> follow.

So if I'm following, your argument is that the local qemu-nbd process is
the only one writing to the file, while all other overlays are backed by
the NBD process; and then as any one of the VMs reads, the qemu-nbd
process pulls those sectors into the local storage as a result.

>=20
>> When I pointed this e-mail of yours to Matt Booth on Freenode Nova IRC=

>> channel, he said the intermediate image (cache-disk1.qcow2) is a COR
>> Copy-On-Read).  I realize what COR is -- everytime you read a cluster
>> from the backing file, you write that locally, to avoid reading it
>> again.
>=20
> qcow2 doesn't give you COR, only COW. So every read request would have =
a miss
> in cache-disk1.qcow2 and thus have to be fetched from master-disk1.qcow=
2. The
> use of drive-mirror to pull master-disk1.qcow2 contents into cache-disk=
1.qcow
> makes up for the lack of COR by populating cache-disk1.qcow2 in the bac=
kground.

Ah, but qcow2 (or more precisely, any protocol qemu BDS) DOES have
copy-on-read, built in to the block layer.  See qemu-iotest 197 for an
example of it in use.  If we use COR correctly, then every initial read
request will miss in the cache, but the COR will populate the cache
without having to have a background drive-mirror.  A background
drive-mirror may still be useful to populate the cache faster, but COR
populates the parts you want now regardless of how fast the background
task is running.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s6K9OKDlOK3MlRDgEC4wwrRwTKgRAonWr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln7WvAACgkQp6FrSiUn
Q2qhxQf9F/R6aYHD6EqvWJpnOpLUl8lA95NqU4g9RAHUjuRPsrFQhJYUD7AV8326
TjvEC6bfJebwDfO6X2BPyVsDl3FWBKsiWtQfkLoWY9/404QFOGOJ/ErXsyBaAqY5
IZFQ0kV1auBmOSmOHA1/FALO5tHHB3Y9R3xcYrwGLLkXqEFUXEPJg/H49PYRKwME
sq+heDHnMeogar+Hk99MpbwJQD6Kj6bLN7tdELqf57XX2xzpKUHKuqkENRawUxD4
aGbN8izqnLMj1udhyIE9oXISpw2jj5tp9RcdkXybbuv1hCIkAbVvjd35vKmQ7A/A
zDmnuVChB6OAoWfLF2ARJVadVrxV4Q==
=Qh1j
-----END PGP SIGNATURE-----

--s6K9OKDlOK3MlRDgEC4wwrRwTKgRAonWr--
