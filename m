Received: from eggs.gnu.org ([2001:4830:134:3::10]:57424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctZpv-00019u-Bx
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctZpp-0005Jn-Jl
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:09:59 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-5-git-send-email-armbru@redhat.com>
	<5e1790e7-5e12-adc6-a049-ca004682025d@redhat.com>
	<87fuhvfe96.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2e07453b-4d48-3acb-91bd-526de637c5c2@redhat.com>
Date: Thu, 30 Mar 2017 08:09:33 -0500
MIME-Version: 1.0
In-Reply-To: <87fuhvfe96.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0tXFCjNsbOttuO9o4sBAkvuUHgTHuTVTO"
Subject: Re: [Qemu-devel] [for-2.9 4/8] block: Document -drive problematic
 code and bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-devel@nongnu.org, namei.unix@gmail.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0tXFCjNsbOttuO9o4sBAkvuUHgTHuTVTO
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 jcody@redhat.com, qemu-devel@nongnu.org, namei.unix@gmail.com,
 pbonzini@redhat.com
Message-ID: <2e07453b-4d48-3acb-91bd-526de637c5c2@redhat.com>
Subject: Re: [Qemu-devel] [for-2.9 4/8] block: Document -drive problematic
 code and bugs
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-5-git-send-email-armbru@redhat.com>
 <5e1790e7-5e12-adc6-a049-ca004682025d@redhat.com>
 <87fuhvfe96.fsf@dusky.pond.sub.org>
In-Reply-To: <87fuhvfe96.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 01:52 AM, Markus Armbruster wrote:

>>> +++ b/block.c
>>> @@ -1157,6 +1157,12 @@ static int bdrv_open_common(BlockDriverState *=
bs, BlockBackend *file,
>>>      if (file !=3D NULL) {
>>>          filename =3D blk_bs(file)->filename;
>>>      } else {
>>> +       /*
>>> +        * Caution: direct use of non-string @options members is
>>> +        * problematic.  When they come from -blockdev or blockdev_ad=
d,
>>> +        * members are typed according to the QAPI schema, but when
>>> +        * they come from -drive, they're all QString.
>>> +        */
>>>          filename =3D qdict_get_try_str(options, "filename");
>>
>> For instance this one: Well, yes, for -drive, this will always be a
>> QString. Which is OK, because that's what we're trying to get.
>>
>> The comment makes this confusing, IMO. If you really want a comment he=
re
>> it should at least contain a mention that it's totally fine in practic=
e
>> here. Calling the code "problematic" sounds like this could blow up wh=
en
>> it reality it can't; and I would think it actually is the most sane
>> solution given the current state of the whole infrastructure (i.e. how=

>> -drive and -blockdev work).
>=20
> Well, if it could blow up, I'd call it wrong, and start the comment wit=
h
> FIXME :)
>=20
> Even though qdict_get_try_str() is indeed fine, I propose to have a
> comment, because someone with less detailed understanding of how the
> configuration machine works (me, until yesterday, and probably again
> after next month) could conclude that qdict_get_try_bool() would be jus=
t
> as fine.
>=20
> What about:
>=20
>    /*
>     * Caution: while qdict_get_try_str() is fine, getting non-string
>     * types would require more care.  When @options come from -blockdev=

>     * or blockdev_add, its members are typed according to the QAPI
>     * schema, but when they come from -drive, they're all QString.
>     */

Yes, that's better - it makes it obvious that our current usage works,
but that the code must not be carelessly edited if we add another field
in the future.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0tXFCjNsbOttuO9o4sBAkvuUHgTHuTVTO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3QONAAoJEKeha0olJ0Nq1fwIAKM5DXW7RfDI+bCYAmY9wC2q
9T/or73FJAZB6uCZDjWCyNkPPpNz4QkA5dWVl34+zgD7GQiZy/x9DogIKz1L6TvU
Mo9xN2LWgXDphakIbTA1uvjcSDfUuDsseVuVTrpTHjPnDR1WlA2fEvxqdw9F8CQo
6bqzxkkZdt8X5n6OPiLn1nXd0acFidhUjR7NXHPmgG12FuiSCRSO0RjJeNqbj+pQ
CktFZ6zZNJtTas/yw8iAcfY06a+k526AARyjFOSaoCm4b3NrF9Q+zglR0srOQvdC
qLRPZK2Ho6eS1g2HMHVhAvmUZAASXg8sd7J5MvjlynsNTXpXop1815vaw25oErE=
=ZqT0
-----END PGP SIGNATURE-----

--0tXFCjNsbOttuO9o4sBAkvuUHgTHuTVTO--
