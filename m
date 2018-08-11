Received: from eggs.gnu.org ([2001:4830:134:3::10]:44045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1foUUX-0000Fi-4T
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 10:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1foUUW-0001oQ-Ah
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 10:03:41 -0400
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
	<20180809114417.28718-3-marcandre.lureau@redhat.com>
	<87r2j6u44f.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <165ace92-3b41-3d56-19f4-d2aa6edf8d8e@redhat.com>
Date: Sat, 11 Aug 2018 16:03:24 +0200
MIME-Version: 1.0
In-Reply-To: <87r2j6u44f.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SMyoUIgLnSwiSNxXfSl9xLZqbXC0prx79"
Subject: Re: [Qemu-devel] [PATCH 2/4] tests: fix bdrv-drain leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SMyoUIgLnSwiSNxXfSl9xLZqbXC0prx79
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.com>,
 Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <165ace92-3b41-3d56-19f4-d2aa6edf8d8e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] tests: fix bdrv-drain leak
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
 <20180809114417.28718-3-marcandre.lureau@redhat.com>
 <87r2j6u44f.fsf@dusky.pond.sub.org>
In-Reply-To: <87r2j6u44f.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-10 08:28, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
>> Spotted by ASAN:
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =3D=3D5378=3D=3DERROR: LeakSanitizer: detected memory leaks
>>
>> Direct leak of 65536 byte(s) in 1 object(s) allocated from:
>>     #0 0x7f788f83bc48 in malloc (/lib64/libasan.so.5+0xeec48)
>>     #1 0x7f788c9923c5 in g_malloc (/lib64/libglib-2.0.so.0+0x523c5)
>>     #2 0x5622a1fe37bc in coroutine_trampoline /home/elmarco/src/qq/uti=
l/coroutine-ucontext.c:116
>>     #3 0x7f788a15d75f in __correctly_grouped_prefixwc (/lib64/libc.so.=
6+0x4c75f)
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  tests/test-bdrv-drain.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
>> index 17bb8508ae..abc8bbe6f0 100644
>> --- a/tests/test-bdrv-drain.c
>> +++ b/tests/test-bdrv-drain.c
>> @@ -948,6 +948,7 @@ static void coroutine_fn test_co_delete_by_drain(v=
oid *opaque)
>>      }
>> =20
>>      dbdd->done =3D true;
>> +    g_free(buffer);
>>  }
>> =20
>>  /**
>=20
> Screwed up in commit 4c8158e359d.
>=20
> Max, could the coroutine's stack accomodate the buffer?

I don't know.  How big is a coroutine's stack?  The buffer size
apparently is 64k.  (Which is my opinion is generally too much to put on
any stack.)

But why would you want to put it on the stack anyway?  It's not like it
would make the patch any simpler.

Max


--SMyoUIgLnSwiSNxXfSl9xLZqbXC0prx79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltu7KwACgkQ9AfbAGHV
z0Ay2AgAsubLJ0aMCT0mJ3xynh03XXu25eNar37bWthcX+EzYphCsy/N6l9C41tH
6JhFfuHck7tWcQtsZ3zqJ+IRJP26K2uLs/DaWLyAqwGUO97TS2D7CIOdFCXiFmza
keSAlzvaqittBbcTZriAZFq5wml2Mv4lpTTIge/ge6J8mbyV3pAiIQMk0ufjXDHf
hedXepvCeXamaJXs9U0UvE602FT0EB2tBKC8LwX9wOmzY6AU945wkEs+w3262zb8
R560vRj28DVO0FouHbXJjBDbjT5dT+GaWFYRjRATorPZowsKYHkiwN3IZ+9JHJCl
HF0i7IGt/Tj2jYkcDAaHWEcyEMOOuQ==
=XRVI
-----END PGP SIGNATURE-----

--SMyoUIgLnSwiSNxXfSl9xLZqbXC0prx79--
