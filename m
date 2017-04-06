Received: from eggs.gnu.org ([2001:4830:134:3::10]:49988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw9lC-0006MK-0M
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw9l7-0000zN-Uw
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:55:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cw9l7-0000z9-IM
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:55:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8519B7E9FE
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 15:55:40 +0000 (UTC)
References: <20170406154107.9178-1-dgilbert@redhat.com>
	<48d5bb0d-25a9-365c-04fa-e3dad7ecf6e8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a5a2849-1ae4-cd54-d4f6-00d32f4d7e29@redhat.com>
Date: Thu, 6 Apr 2017 10:55:38 -0500
MIME-Version: 1.0
In-Reply-To: <48d5bb0d-25a9-365c-04fa-e3dad7ecf6e8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Asb2TCcIGsjiguMIkD23QB4VBBWa27Gw0"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] tests/check-qdict: Fix missing
 brackets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Asb2TCcIGsjiguMIkD23QB4VBBWa27Gw0
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com
Message-ID: <6a5a2849-1ae4-cd54-d4f6-00d32f4d7e29@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] tests/check-qdict: Fix missing
 brackets
References: <20170406154107.9178-1-dgilbert@redhat.com>
 <48d5bb0d-25a9-365c-04fa-e3dad7ecf6e8@redhat.com>
In-Reply-To: <48d5bb0d-25a9-365c-04fa-e3dad7ecf6e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 10:49 AM, Eric Blake wrote:
> On 04/06/2017 10:41 AM, Dr. David Alan Gilbert (git) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> Gcc 7 (on Fedora 26) spotted odd use of integers instead of a
>> boolean; it's got a point.
>>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>  tests/check-qdict.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/check-qdict.c b/tests/check-qdict.c
>> index 81162ee572..6f3fbcf9c1 100644
>> --- a/tests/check-qdict.c
>> +++ b/tests/check-qdict.c
>> @@ -559,7 +559,7 @@ static void qdict_join_test(void)
>>          g_assert(qdict_size(dict1) =3D=3D 2);
>>          g_assert(qdict_size(dict2) =3D=3D !overwrite);
>> =20
>> -        g_assert(qdict_get_int(dict1, "foo") =3D=3D overwrite ? 84 : =
42);
>> +        g_assert(qdict_get_int(dict1, "foo") =3D=3D (overwrite ? 84 :=
 42));
>=20
> How is the test passing pre-patch, and why does it not change the test
> post-patch?  Does that mean that overwrite is not doing what we expecte=
d?

Replying to myself:

Pre-patch, it was reached twice (once for overwrite=3Dfalse, once for
overwrite=3Dtrue), as:

(42 =3D=3D false) ? 84 : 42
(84 =3D=3D true) ? 84 : 42

which simplifies to 42 on both iterations, and g_assert(42) succeeds.
In fact, this is a tautology - no matter WHAT value we encounter, the
assert succeeds, so we are not actually testing that the value matters.

Post-patch, it becomes:

42 =3D=3D (false ? 84 : 42)
84 =3D=3D (true ? 84 : 42)

which is then asserting that we actually have the value we expect.

Reviewed-by: Eric Blake <eblake@redhat.com>

Safe for 2.9, but late enough that it also doesn't matter if it slips
until 2.10.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Asb2TCcIGsjiguMIkD23QB4VBBWa27Gw0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5mT6AAoJEKeha0olJ0NqCxAH+gPKOEN2bXWpFOP9/e/ncxcB
Htm0UyT1jOWcasVlyL8xiqn5QdALH+uK65rFMRwWWItxWUnrAxHizW/bQzE5+GNb
273O6oliDM2AH8xhGh0qqsxmu7vGET44ceGrmcVOxl2g+4ASvm+4083MKQqaIbZj
KUgvTjJZlcKNczRH9VDPFXeUbdopCZh5bLwts+Eq27P+oZyyzptiOilkSPD+Izzy
bq6vvJ+CnYKMfD2pbT8tF+RPcfPfODyks4ycbivD5ROzPuvuM2m0SMt0gZdKv/9+
lrGMRJAFHBBffwFZ9uSPpTXObwZi/vGpcT7TguyrlvAzaTNiUm9r82vStsIQL1g=
=JbIO
-----END PGP SIGNATURE-----

--Asb2TCcIGsjiguMIkD23QB4VBBWa27Gw0--
