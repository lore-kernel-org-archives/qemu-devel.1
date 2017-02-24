Received: from eggs.gnu.org ([2001:4830:134:3::10]:59129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chJV0-0001sd-3c
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chJUy-0000z5-OC
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:17:42 -0500
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<87o9xr60dp.fsf@dusky.pond.sub.org> <20170224163948.GG17452@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a42e86c-7c21-4a1b-067d-f842533593a3@redhat.com>
Date: Fri, 24 Feb 2017 11:17:33 -0600
MIME-Version: 1.0
In-Reply-To: <20170224163948.GG17452@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cGhBvhw0MGImBsvT4eKMGl9xEJGtnB2Xa"
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cGhBvhw0MGImBsvT4eKMGl9xEJGtnB2Xa
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Message-ID: <2a42e86c-7c21-4a1b-067d-f842533593a3@redhat.com>
Subject: Re: Non-flat command line option argument syntax
References: <87bmukmlau.fsf@dusky.pond.sub.org>
 <87o9xr60dp.fsf@dusky.pond.sub.org> <20170224163948.GG17452@redhat.com>
In-Reply-To: <20170224163948.GG17452@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 10:39 AM, Daniel P. Berrange wrote:
> On Fri, Feb 24, 2017 at 05:04:34PM +0100, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>> [...]
>>> =3D=3D=3D Dotted keys =3D=3D=3D
>>>
>>> One sufficiently powerful syntax extension already exists: the dotted=

>>> key convention.  It's syntactically unambiguous only when none of the=

>>> KEYs involved contains '.'  To adopt it across the board, we'd have t=
o
>>> outlaw '.' in KEYs.  QAPI outlaws '.' already,
>>
>> *Except* in __RFQDN_ prefixes.
>>

>> Possible solutions:
>>
>> (a) Outlaw domain names with '_'.  If KEY starts with "__", everything=

>>     up to the third '_' is an __RFQDN_ prefix.

While there ARE valid DNS names with _ (such as
_http._sctp.www.example.com mentioned on
https://en.wikipedia.org/wiki/Hostname), we are at least told by RFC 952
that _ is not valid in hostnames.  Note that '-' is permitted, and that
transliterates to '_', so from the flattened name used in C code it's
harder to tell what is meant, but from the QMP side, I think we are
guaranteed that no RFQDN will confuse us with any extra _.

>>
>> (b) Outlaw '_' in the name part that follows __RFQDN_.  If KEY starts
>>     with "__", everything up to the last '_' is an __RFQDN_ prefix.

Reasonable enough, since we ask new interfaces to use '-' rather than
'_'. But does break existing vendors (a quick grep of RHEL 7.3
downstream finds at least:

qapi-schema.json:{ 'command': '__com.redhat_qxl_screendump', 'data': {
'id' : 'str',

So we'd have to get downstream buy-in to this plan, and downstreams may
have to hack around our new restrictions for a while.

>>
>> (c) Your bright idea.
>=20
> Define a new downstream vendor naming convention. IMHO it is reasonable=

> to argue that the downstream vendor extensions are outside the scope of=

> backwards compatibility guarantees we normally apply for our CLI args.
>=20
> Thus, simply say that vendors must replace all '.' with _ in their
> namespace prefix. eg They should use '__com_example_medium.rare=3Don'
> which would mean a property '__com_example_medium' which is a struct
> containing a property rare with value on

Same argument as (b) - we'd have to get downstream buy-in (and in this
case, it affects even more cases: ALL downstream extensions have to be
changed, rather than just the ones using _ after the __RFQDN_ portion).
But has the slightly nice appeal of avoiding the '.' vs. '_'
transliteration confusion that catches us only on downstream extensions
(it's hard to special-case '.' as being permitted in QAPI, but only for
downstream, because we can easily forget to test it).

If we are happy with the change forced on downstream vendors, I'm okay
with (c); if not, I think (a) is safe.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--cGhBvhw0MGImBsvT4eKMGl9xEJGtnB2Xa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsGqtAAoJEKeha0olJ0NqcJoH/3Xnnqxd8fYlfvU9Ri4BuJO7
i+TjKlqvTxQtLc9ddp8rc8/AZ+5kQPF+EV9CssJQ7v8RQ/3j3Hm4aQ2jWOvc/Xyo
YAsQa6c4tqbrJrkCGv/gQagm/esNmVbX5z1W8EEiBuj9pFvRuU4R2a3dSgu6LTU3
EYW0oear4nurDEd5+aglT2qPExu1KJ6+F2HeWz10nhQorJmBWOuu//un4lxdX1c/
jncVSFE94mX6CKM38C3Y+PmHNWsRga8/n/pqPTcd/sliAEvtiuzR9I7gyIn1RcDK
3gAZzVdxJRs0oixqgtamgvLZ+Kga9vuJ57BPAJeU6G7Nh6NXqkzrsZOEUp5xSI4=
=8435
-----END PGP SIGNATURE-----

--cGhBvhw0MGImBsvT4eKMGl9xEJGtnB2Xa--
