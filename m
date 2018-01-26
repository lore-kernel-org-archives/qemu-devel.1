Received: from eggs.gnu.org ([2001:4830:134:3::10]:45104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef8PR-0001fh-Df
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef8PQ-0008DR-Fq
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:07:29 -0500
References: <20180118115158.17219-1-edgar.kaziakhmedov@virtuozzo.com>
	<1b55edad-f820-6898-1630-ccc76e6c4845@redhat.com>
	<5858df64-9495-1332-3c53-fab0204f79a9@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b87f82d-2a90-d6cf-0fc4-aee0d704a403@redhat.com>
Date: Fri, 26 Jan 2018 08:28:21 -0600
MIME-Version: 1.0
In-Reply-To: <5858df64-9495-1332-3c53-fab0204f79a9@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TQRq5f9XZpG7zhcHcJCEQb6DajP787fIa"
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: implement bdrv_get_info callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TQRq5f9XZpG7zhcHcJCEQb6DajP787fIa
From: Eric Blake <eblake@redhat.com>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <8b87f82d-2a90-d6cf-0fc4-aee0d704a403@redhat.com>
Subject: Re: [PATCH 1/1] nbd: implement bdrv_get_info callback
References: <20180118115158.17219-1-edgar.kaziakhmedov@virtuozzo.com>
 <1b55edad-f820-6898-1630-ccc76e6c4845@redhat.com>
 <5858df64-9495-1332-3c53-fab0204f79a9@virtuozzo.com>
In-Reply-To: <5858df64-9495-1332-3c53-fab0204f79a9@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 06:39 AM, Edgar Kaziakhmedov wrote:
> PIng
>=20
> So, let me know if I need to make any changes in patch
>=20
> On 1/18/18 1:09 PM, Paolo Bonzini wrote:
>> On 18/01/2018 12:51, Edgar Kaziakhmedov wrote:
>>> +static int nbd_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if (bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP=
) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdi->can_write_zeroes_wit=
h_unmap =3D true;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>> Other drivers set the flag always, while NBD only sets it if the serve=
r
>> knows the flag.

Well, other drivers may be able to always implement it (NBD can only
implement it if the server supports WRITE_ZEROES - and I'm even in the
middle of working up an nbdkit patch [1] that makes it easier to write
an NBD server that specifically does not support WRITE_ZEROES to make
code paths like this easier to test)

[1]

>>
>> I think NBD is more correct, so:
>>
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Agreed; I'm fine queueing this on my NBD queue, except I'd first like to
hear Kevin's opinion:

>>
>> However, it would be nice to remove can_write_zeroes_with_unmap from
>> BlockDriverInfo, and make bdrv_can_write_zeroes_with_unmap just return=

>> !!(bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP).=C2=A0 Kevin, what d=
o you
>> think?

Actually, I may even just give a shot at writing this alternative patch,
to make Kevin's decision easier.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TQRq5f9XZpG7zhcHcJCEQb6DajP787fIa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprOwUACgkQp6FrSiUn
Q2rpOwgAkb9tE+uf5q40HuP+gofCTezurWgUq+ASt9UqoPZ2UFzgVPT7o375X/i1
/OXMeEQBkbVm21sTW9Gbu+Jg7E/0ye/Sx+OW4mXP7sR6xWljmGgXbhs5rgOBM29I
SL4jKU7RYYplNJhhiW3jGo5msrfFv/Wk5NSMUuUWS8SauG03PKScQhEknMgvDujk
nSfUzPgYexQK1SFlDoprwtYRvCRxsG5kMqSJf6H8vqJzu1cj44d49Whgz+Uo9zHq
N4skRjrmkPHIrUdNTcgkd8KAZIrLJzEwMbKrnixM95b0e6/5biw1qwhCtmjPzsgY
oiz9A99xfeQRdrBB49ATf2eaEsodbA==
=dKEs
-----END PGP SIGNATURE-----

--TQRq5f9XZpG7zhcHcJCEQb6DajP787fIa--
