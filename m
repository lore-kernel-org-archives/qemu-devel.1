Received: from eggs.gnu.org ([2001:4830:134:3::10]:41662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8qVF-0003bw-Ll
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 13:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8qVB-0006RQ-LU
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 13:04:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37798 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8qVB-0006R2-G4
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 13:04:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA6C54022909
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 17:04:08 +0000 (UTC)
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-2-marcandre.lureau@redhat.com>
	<ea5c5be8-2e0f-ed00-8ce1-aee6d6e117d4@redhat.com>
	<87po2wsbu6.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <444fc8f7-b86a-6b5b-f49d-34b9608164e6@redhat.com>
Date: Wed, 18 Apr 2018 12:04:01 -0500
MIME-Version: 1.0
In-Reply-To: <87po2wsbu6.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uCM6eUMgNI7ocoDqE4FlDc9X5f389rbAq"
Subject: Re: [Qemu-devel] [PATCH v5 1/5] qobject: ensure base is at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uCM6eUMgNI7ocoDqE4FlDc9X5f389rbAq
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Message-ID: <444fc8f7-b86a-6b5b-f49d-34b9608164e6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/5] qobject: ensure base is at offset 0
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
 <20180417133602.23832-2-marcandre.lureau@redhat.com>
 <ea5c5be8-2e0f-ed00-8ce1-aee6d6e117d4@redhat.com>
 <87po2wsbu6.fsf@dusky.pond.sub.org>
In-Reply-To: <87po2wsbu6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2018 11:45 AM, Markus Armbruster wrote:

>> Might also be worth mentioning that this explicitly guarantees that
>> existing casts work correctly (even though we'd prefer to get rid of
>> such casts in any location except the qobject.h macros); Markus pointe=
d out:
>>
>>>> Uh, there's another reason: existing type casts from QObject * to
>>>> subtypes.  I just spotted one in tests/check-qdict.c:
>>>>
>>>>     dst =3D (QDict *)qdict_crumple(src, &error_abort);
>=20
> As far as I'm concerned, that's the real reason.  The simplification
> plus the check to make it safe seems like a wash.
>=20
> The cast I spotted appears to be the only one, though:
>=20
>     $ git-grep '(Q[A-Z][a-z]* \*)'
>     hmp.c:    qmp_device_add((QDict *)qdict, NULL, &err);
>     include/qapi/qmp/qobject.h:        return (QObject *)obj;
>     qobject/qobject.c:static void (*qdestroy[QTYPE__MAX])(QObject *) =3D=
 {
>     tests/check-qdict.c:    dst =3D (QDict *)qdict_crumple(src, &error_=
abort);
>=20
> The first two cast away const, the third isn't a type cast.  The fourth=

> one should use qobject_to() instead, regardless of this patch.
>=20
> Do we want to force base to come first anyway?
>=20
> Where does PATCH 2 exploit "base first"?

It doesn't, but PATCH 4 does:

>  /**
>   * qobject_ref(): Increment QObject's reference count
> + *
> + * Returns: the same @obj. The type of @obj will be propagated to the
> + * return type.
>   */
> -#define qobject_ref(obj) qobject_ref_impl(QOBJECT(obj))
> +#define qobject_ref(obj) ((typeof(obj)) qobject_ref_impl(QOBJECT(obj))=
)
> =20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uCM6eUMgNI7ocoDqE4FlDc9X5f389rbAq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXeoEACgkQp6FrSiUn
Q2pCXAf/SXA8gttvNqTiOliPPtrwRvT0hato+3tCCH3Supp5cMmCzyAGjwZbGsr4
jD3TtdPNqEc35fpe50QufCpndTYYDzycOGJ9krhsEJeWue8gcc+BJJywfOFsPyOW
SKF8/JHiRaP1w9J/vUJmPsOT1w4HXQYtUC2ZtTz6lRWwUglirRwTK2+FUXYre59I
bmVUU8W5yQqbv5fOHAgwDBc7zD5sA0l7WhNDHe5NH503B0vxVW6L+FrnImX6VwIG
Wrialn5BJrRT4b6GK3r32A0d/HY4h1UDZv4FBBxHL6YFISMBuO0261IVm3RzyzK2
ZCxOc8oDQ/To8To0RNdO0HKzHbIKAQ==
=uknG
-----END PGP SIGNATURE-----

--uCM6eUMgNI7ocoDqE4FlDc9X5f389rbAq--
