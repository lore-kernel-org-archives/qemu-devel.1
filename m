Received: from eggs.gnu.org ([2001:4830:134:3::10]:37790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZNvH-0002fn-7T
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZNvG-0000gE-2R
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:24:03 -0500
References: <87bmukmlau.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f546e25b-cd7f-abc4-ece6-0be122483561@redhat.com>
Date: Thu, 2 Feb 2017 14:23:53 -0600
MIME-Version: 1.0
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S5k71j4jwRH2O9Va0kCEgNQsaAnjPcvSn"
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S5k71j4jwRH2O9Va0kCEgNQsaAnjPcvSn
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <f546e25b-cd7f-abc4-ece6-0be122483561@redhat.com>
Subject: Re: Non-flat command line option argument syntax
References: <87bmukmlau.fsf@dusky.pond.sub.org>
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2017 01:42 PM, Markus Armbruster wrote:

>=20
> =3D=3D=3D Structured values =3D=3D=3D
>=20
> The dotted key convention messes with KEY syntax to permit structured
> values.  Works, but the more conventional way to support structured
> values is a syntax for structured values. =20
>=20
> An obvious one is to use { KEY=3DVALUE, ...} for objects, and [ VALUE,
> ... ] for arrays.  Looks like this:
>=20
>     -drive 'driver=3Dquorum,
>             child=3D[{ driver=3Dfile, filename=3Ddisk1.img },
>                    { driver=3Dhost_device, filename=3D/dev/sdb },
>                    { driver=3Dnbd, host=3Dlocalhost } ]'
>=20
> Again, lines broken and indented for legibility; you need to join them
> for actual use.
>=20
> There's a syntactic catch, though: a value of the form [ ... ] can
> either be an array or a string.  Which one it is depends on the type of=

> the key.  To parse this syntax, you need to know the types, unlike JSON=

> or traditional QemuOpts.  Unless we outlaw strings starting with '{' or=

> '[', which feels impractical.

Another syntactic catch: from the shell,

-drive driver=3Dquorum,child=3D[...]

is insufficiently quoted, and MIGHT glob to a completely different
argument (or even multiple arguments) depending on the (oddly-named)
contents of the current directory.  Any use of [] HAS to consistently
recommend use with shell quotes.  Using straight JSON already has to use
shell quotes (generally '' for the overall argument, and "" for key
names and string values within the JSON, although our parser as an
extension supports '' for key names and string values which pairs with
"" for the overall argument and allows the use of $var shell interpolatio=
n).

>=20
> =3D=3D=3D Comparison =3D=3D=3D
>=20
> In my opinion, dotted keys are weird and ugly, but at least they don't
> add to the quoting mess.  Structured values look better, except when
> they do add to the quoting mess.
>=20
> I'm having a hard time deciding which one I like less :)

Both are a bit awkward.  I think dotted keys require more typing but
less shell quoting than structured values.  And with either approach, it
would STILL be nice if we taught QemuOpts to strip whitespace after
delimiting commas - the only requirement is that no key value can start
with space, which QAPI enforces, and QOM is unlikely to break, although
the benefits of stripping whitespace are only apparent when you remember
to use shell quoting over the entire argument (which partially defeats
the purpose of trying to come up with a syntax that needs less shell
quoting).

>=20
> Opinions?  Other ideas?

I don't think command line length is a problem; most command lines are
generated. I'm torn on whether a simplified structured values is nicer
than full-blown JSON; your argument about having the same JSON work on
both the command line and through QMP resulting in less work for
management apps is interesting.  And reusing an existing syntax instead
of inventing yet another one always has the benefit of less code to
maintain.  So even though it's harder to type by hand, I'm somewhat
leaning towards full JSON (where a leading '{' says to parse using JSON
until the closing '}'), rather than any other structured value
representation.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--S5k71j4jwRH2O9Va0kCEgNQsaAnjPcvSn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYk5VZAAoJEKeha0olJ0Nq+LAIAJYir8RCXkUTJ6hVK2qXspRW
blXFdqThCccTvpfFYKwmWxALtYkUDPi4ABESP0uGAvSYHwxYZ0pJJEdimIvRuhQR
1mK4sWq64LbflQaxeS9ezC9PVHoTr4grgKx+/6pen321j+WGe/Wyb/IZFmB8OXJP
OY9cOscAwLvtwp5dgdBnfl79xiAvwYz8JfBsXsuvwM1F9O6ZQ/F0peX1wj+ZK4nf
0lac9a51ODY/Hgsl3UY/LEx3xVRg4ZTcBoyHegTjNH8Ijlmp2YE9iXJWdiS0Yr8M
VTdWIp4hau9AVrkTqPdnLwBNQBZYWSFfRIzwYfFWJldLD5+knptbkymjSNYvhIc=
=kvoT
-----END PGP SIGNATURE-----

--S5k71j4jwRH2O9Va0kCEgNQsaAnjPcvSn--
