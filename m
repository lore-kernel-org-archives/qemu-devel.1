Received: from eggs.gnu.org ([2001:4830:134:3::10]:44933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRJu-0004zl-FV
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCRJq-00082a-Ah
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:27:10 -0500
References: <cover.1510093478.git.jcody@redhat.com>
	<41ed8543e005205118438328c7e162532729d9c7.1510093478.git.jcody@redhat.com>
	<20171108104737.xtxfex7leabfbqyc@starbug-vm.ie.oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a888b534-f285-6d02-fdb6-9faae79879fb@redhat.com>
Date: Wed, 8 Nov 2017 08:26:57 -0600
MIME-Version: 1.0
In-Reply-To: <20171108104737.xtxfex7leabfbqyc@starbug-vm.ie.oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bCfJBd8vmrTE3vEGMR4fBFpd3K5D2RehV"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 7/7] block/curl: code
 cleanup to comply with coding style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, rjones@redhat.com, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bCfJBd8vmrTE3vEGMR4fBFpd3K5D2RehV
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com,
 qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, rjones@redhat.com,
 namei.unix@gmail.com
Message-ID: <a888b534-f285-6d02-fdb6-9faae79879fb@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 7/7] block/curl: code cleanup
 to comply with coding style
References: <cover.1510093478.git.jcody@redhat.com>
 <41ed8543e005205118438328c7e162532729d9c7.1510093478.git.jcody@redhat.com>
 <20171108104737.xtxfex7leabfbqyc@starbug-vm.ie.oracle.com>
In-Reply-To: <20171108104737.xtxfex7leabfbqyc@starbug-vm.ie.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 04:47 AM, Darren Kenny wrote:
> Hi Jeff,
>=20
> While I'm relatively new to this community, I do have some comments
> about the styling in this file.
>=20
> I don't see anything in the CODING_STYLE file that tells me I'm
> wrong here, but it's certainly possible...
>=20
> More inline.
>=20

>> -// #define DEBUG_CURL
>> -// #define DEBUG_VERBOSE

This is definitely against style (checkpatch.pl flags it),

>> +/*
>> + #define DEBUG_CURL
>> + #define DEBUG_VERBOSE
>> +*/
>=20

while you are correct that this is not quite usual style.

> Is it not more common to use the style:
>=20
> =C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0 * text
> =C2=A0=C2=A0=C2=A0 */

But, since checkpatch.pl doesn't flag it, and since it is easier to
remove the leading and trailing /* and */ to enable the debug #defines
(compared to editing every single line of the comment), I don't see a
problem with the style chosen here.


>> @@ -235,7 +236,7 @@ static size_t curl_header_cb(void *ptr, size_t
>> size, size_t nmemb, void *opaque)
>> /* Called from curl_multi_do_locked, with s->mutex held.=C2=A0 */
>> static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void
>> *opaque)
>> {
>> -=C2=A0=C2=A0=C2=A0 CURLState *s =3D ((CURLState*)opaque);
>> +=C2=A0=C2=A0=C2=A0 CURLState *s =3D opaque;
>=20
> Not sure about this one - while it may not be strictly necessary to
> do the casting, from a readability point of view it is helpful to
> see the cast - possibly with the outer brackets removed:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 CURLState *s =3D (CURLState*)opaque;

I _am_ sure about it. The cast from void* is pointless (this is C, not
C++), and this is one of the changes that Jeff specifically made in v3
that was not present in v2, because I requested that we lose the cast
(in general, we try to avoid as many casts as possible).

>> @@ -876,13 +880,13 @@ static void curl_setup_preadv(BlockDriverState
>> *bs, CURLAIOCB *acb)
>>
>> =C2=A0=C2=A0=C2=A0 qemu_mutex_lock(&s->mutex);
>>
>> -=C2=A0=C2=A0=C2=A0 // In case we have the requested data already (e.g=
=2E read-ahead),
>> -=C2=A0=C2=A0=C2=A0 // we can just call the callback and be done.
>> +=C2=A0=C2=A0=C2=A0 /* In case we have the requested data already (e.g=
=2E read-ahead),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 we can just call the callback an=
d be done. */
>=20
> Please don't do a multi-line comment like this, it is much more
> obvious that the second line is a comment if you use the more normal
> format of as outlined earlier by me.

Indeed, while I don't mind the style used on the #define DEBUG_*, this
one could be touched up to be more idiomatic.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bCfJBd8vmrTE3vEGMR4fBFpd3K5D2RehV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloDFDEACgkQp6FrSiUn
Q2ocVwf/agnbpoUny+k5eYmnHbcr0PXCyh5BZijxA1xj7Dlvluo7NmJQZ8l1URBT
CwyPSin2KE9YkdubtR1J20KBRAaadEjKKLda8EzEqylEkv8Crnu6uI618qf1o9m6
47lINIl3uN9jSh33z42jHXWhhKT4LPkHLOm0gqBryYaXbzZ0Eo/zWwUYnkwh5QXR
yUNqvKSTSrgoFx9DskEisYfnw9B/ztlNZgJY6PhnyK8CAi2ez0t4PlRAxPN+5Cd4
jg05z4dLBhpHlyFiiuQ8B6l2Ndiot44r6ZB7bC/T2B5PAu1kJ6PX0lOIbsXLtvEK
hKfsKtYDHWm6zMwD7PSPavE1yti3kw==
=BB8c
-----END PGP SIGNATURE-----

--bCfJBd8vmrTE3vEGMR4fBFpd3K5D2RehV--
