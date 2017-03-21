Received: from eggs.gnu.org ([2001:4830:134:3::10]:39577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqJkx-0002pf-Bz
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqJku-00011D-9A
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:23:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqJku-000111-1D
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:23:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 079F080F7B
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 13:23:20 +0000 (UTC)
References: <20170321031705.22291-1-eblake@redhat.com>
	<87shm7rnbu.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32d7d7b9-e6d5-3835-3802-23fe64cc99bb@redhat.com>
Date: Tue, 21 Mar 2017 08:23:17 -0500
MIME-Version: 1.0
In-Reply-To: <87shm7rnbu.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X0ltr3rk85XaElO8qUXDDegdsxwBABMeP"
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] Fix QemuOpts regression on
 bogus keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, Igor Mammedov <imammedo@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X0ltr3rk85XaElO8qUXDDegdsxwBABMeP
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com,
 Igor Mammedov <imammedo@redhat.com>
Message-ID: <32d7d7b9-e6d5-3835-3802-23fe64cc99bb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] Fix QemuOpts regression on bogus
 keys
References: <20170321031705.22291-1-eblake@redhat.com>
 <87shm7rnbu.fsf@dusky.pond.sub.org>
In-Reply-To: <87shm7rnbu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2017 04:28 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Reported to me off-list by Laurent Vivier, who found the
>> problem while working on https://bugzilla.redhat.com/1433193
>> Broken since 2.7, but the fix is a one-liner (pointing out my
>> embarrassing mistake of mis-converting a pre-decrement operator);
>> as a bug fix, it still qualifies for 2.9 in spite of hard freeze,
>> on the other hand, as the regression was not introduced in 2.9,
>> I also understand if it is postponed.
>>
>> Eric Blake (2):
>>   tests: Expose regression in QemuOpts visitor
>>   qapi: Fix QemuOpts visitor regression on unvisited input
>>
>>  qapi/opts-visitor.c       |  6 +++---
>>  tests/test-opts-visitor.c | 29 ++++++++++++++++++++++++++---
>>  2 files changed, 29 insertions(+), 6 deletions(-)
>=20
> Regresses
>=20
>     $ qemu-system-x86_64 -object memory-backend-ram,id=3Dmem1,size=3D4k=

>     qemu-system-x86_64: -object memory-backend-ram,id=3Dmem1,size=3D4k:=
 Invalid parameter 'id'

D'oh - you caught me running just 'make check-unit' instead of the
longer 'make check' (which includes the failing 'make check-qtest').

>=20
> I guess the culprit is commit 3a4641:
>=20
>     pdict =3D qemu_opts_to_qdict(opts, NULL);
>     qdict_del(pdict, "qom-type");
>     qdict_del(pdict, "id");
>=20
>     v =3D opts_visitor_new(opts);
>     obj =3D user_creatable_add_type(type, id, pdict, v, errp);
>     visit_free(v);
>=20
> This deletes "qom-type" and "id" from pdict, but not opts.  The deletio=
n
> makes user_creatable_add_type() skip visiting them as intended, but it
> also makes visit_check_struct() fail, because the opts visitor still
> expects the two to be visited.

I'll come up with a solution, and post v2.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--X0ltr3rk85XaElO8qUXDDegdsxwBABMeP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0SlFAAoJEKeha0olJ0NqxMIH/2u6AJDvk6HBXEcZ1YnRuQyP
CVUkKJY0RNUzwy9/KpD77j64DianEGyC1cW3TAy+0qgo5EicxstzrxGc1RrQe4pr
mAK3fpbZLDfB9/8/YcGVbomjue6pJf/PAkt/UiyyiNlDSmjuuG428/nJ8EImhm9p
I+iwDdwyR22o0N1KyXBN0EC2rFGPqM/6uZAmyXp3uIqqD7LMPU+g8qdIgLk2XsyU
XgWx2BR/OkEAuJ67LeZ/mQ4RAnUV+QkEvqsnBlm+1DfwBmNI2wAHAi3Yp+h+Wzv8
x2GU7HZ03s+HxY8V1DbdfwV5IprRkP9+fegxYsJhR6/Q3Uz1lgYOAPDfeeaeOyI=
=X1lv
-----END PGP SIGNATURE-----

--X0ltr3rk85XaElO8qUXDDegdsxwBABMeP--
