Received: from eggs.gnu.org ([2001:4830:134:3::10]:48111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chLVG-0000Ud-Gj
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chLVF-0005L4-3x
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 14:26:06 -0500
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-3-git-send-email-armbru@redhat.com>
	<5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
	<878toxmeol.fsf@dusky.pond.sub.org> <877f4g2f6m.fsf@dusky.pond.sub.org>
	<c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com>
	<87h93j2ytj.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86ea8b80-f2ae-088f-ae2d-cf529d2db02b@redhat.com>
Date: Fri, 24 Feb 2017 13:25:53 -0600
MIME-Version: 1.0
In-Reply-To: <87h93j2ytj.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lScd1AD2K791g1eDa0LCR2nX34Memp9Ee"
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lScd1AD2K791g1eDa0LCR2nX34Memp9Ee
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <86ea8b80-f2ae-088f-ae2d-cf529d2db02b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
 <1487710908-26356-3-git-send-email-armbru@redhat.com>
 <5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
 <878toxmeol.fsf@dusky.pond.sub.org> <877f4g2f6m.fsf@dusky.pond.sub.org>
 <c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com>
 <87h93j2ytj.fsf@dusky.pond.sub.org>
In-Reply-To: <87h93j2ytj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 01:06 PM, Markus Armbruster wrote:

>=20
> The value of an implied key is not subject to key desugaring.

And that's a good thing.

>=20
> Without an implied key, the "node" would desugar to "de=3Doff".
>=20
>> How about:
>>
>> for 2.9: -blockdev has no magic at all (you HAVE to spell 'foo=3Doff'
>> rather than 'foo' for any boolean parameters that you want disabled in=

>> -blockdev);
>=20
> You mean "rather than 'nofoo'".

Yes.  Thanks for catching the intent.

>=20
> "No magic at all" implies you also have to spell "foo=3Don" rather than=

> "foo".

I'm a little more lenient for allowing 'foo' meaning 'foo=3Don' as a
shortcut (although making it force a QBool rather than a string "on" may
be nicer).  I'm also okay if -blockdev has no sugar at all in 2.9 (we
can add "foo" =3D> "foo=3Don" sugar later if it makes QemuOpts conversion=

easier in 2.10; that's much more palatable than adding "nofoo" =3D>
"foo=3Doff" sugar).

>=20
> I believe we need to have both or none in 2.9.  If we have only the "on=
"
> sugar, "no-flush" works, and we can't add the "off" sugar without
> breaking it.

I think the "off" sugar should die, if we can convince ourselves that no
one is using it that can't catch up to modern usage.

>=20
>> -blockdev); and in QemuOpts, we issue deprecation warnings but keep
>> existing behavior any time someone uses 'noFOO' that we turn into
>> 'FOO=3Dno'.  Then, for 2.10, we can decide to remove the deprecation
>> warnings if they pointed out real (ab)use of the sugar in the wild, or=

>> (hopefully) to kill the sugar entirely (as part of converting QemuOpts=

>> over to keyval_parse).
>>
>> In short, getting rid of the 'no' prefix magic, after suitable
>> deprecation warnings, seems like a good plan to me; and having -blockd=
ev
>> be slightly tighter than the rest of command line options for 2.9 only=

>> is no real loss (no one uses -blockdev yet, so they can be written to
>> avoid the use of 'no' magic to begin with).
>=20
> Okay, I'll post QemuOpts patch to deprecate noKEY sugar.  Let's see
> whether anyone screams.

Summarizing to make sure we're on the same track:

2.9:
QemuOpts:
  "noFOO" =3D> "FOO=3Doff" sugar - deprecation warning
  "FOO" =3D> "FOO=3Don" sugar - silently stays the same

-blockdev option 1:
  "FOO" =3D> error, no '=3D' present (we haven't decided on sugaring this=
 yet)
  "noFOO" =3D> error, no '=3D' present (no off sugar, but also avoids
"noFOO" =3D> "noFOO=3Don" sugar)

-blockdev option 2:
  "FOO" =3D> "FOO=3Don" - enabled boolean sugar remains compact, if it is=

not ambiguous, but anything we can do to limit it to just boolean values
rather than the string "on" might be nice
  "noFOO" =3D> "noFOO=3Don" - different behavior than QemuOpts, but less =
magic

2.10:
QemuOpts will be implemented on keyval_parse(), behaving the same as
-blockdev. If we took option 1 in 2.9, we have:
  "noFOO" =3D> "noFOO=3Don" (which probably triggers an error that "noFOO=
"
is not an option when strict parsing is in effect) (the deprecation
period is over, so we changed command-line behavior, but only for people
that didn't pay attention to the warnings in 2.9)
  "FOO" =3D> "FOO=3Don" - keep this one to minimize back-compat breakage

If we took option 2 in 2.9, we can still turn on "FOO" =3D> "FOO=3Don" su=
gar
to get back to option 1 in 2.10

or we can stick to option 2 forevermore:
  "FOO" =3D> error, no '=3D' present. No longer possible to specify boole=
ans
without the more verbose "FOO=3Don"

I have a preference for option 1 in the long run, but as it seems to be
upwards compatible from option 2 for -blockdev in 2.9, I'm leaning
towards option 2 for this release.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lScd1AD2K791g1eDa0LCR2nX34Memp9Ee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsIjBAAoJEKeha0olJ0NqnxkH/RkVkGG3RjzfvBETIhrVUbnn
rFFlpJ0a6/HQQnY2q9HPy4Y709cStfEoS1HwTAUI6lPudl1A0xGTfzgw95CIQeQz
1FndX3s7fifIJx4rQEBf94UzBh4gmHoR4XzYHzDysoY99sgWRHRxRquYBuitc2Bh
XgFlRc/AykKCT/hNMHvdcf0RoY5CrknJruhetX5ujeZykLvt0Oj1SdF+P4srVvbM
6oitlJ8OZqABolChgL7vp5Ftm+NB2sBF73U22inRTjeXK0WwpWyqBrm1wARXJOag
kczypZ61fDklli6WIxFnwXmUkb0sYTbmOXlyJp4LygFQqWVXuiNilcWU1xnA2Sc=
=r3c7
-----END PGP SIGNATURE-----

--lScd1AD2K791g1eDa0LCR2nX34Memp9Ee--
