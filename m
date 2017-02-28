Received: from eggs.gnu.org ([2001:4830:134:3::10]:36704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cil5R-0006BD-Ds
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cil5Q-0004E6-4J
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:57:17 -0500
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-4-git-send-email-armbru@redhat.com>
	<20170228154836.GF4090@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7bf9848-a8a1-718c-9dd7-4f2d1659cbe1@redhat.com>
Date: Tue, 28 Feb 2017 10:57:10 -0600
MIME-Version: 1.0
In-Reply-To: <20170228154836.GF4090@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CGcAihpsGtfC2l1gUNWMiiohlMVp215SQ"
Subject: Re: [Qemu-devel] [PATCH 03/24] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pkrempa@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CGcAihpsGtfC2l1gUNWMiiohlMVp215SQ
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pkrempa@redhat.com
Message-ID: <a7bf9848-a8a1-718c-9dd7-4f2d1659cbe1@redhat.com>
Subject: Re: [PATCH 03/24] keyval: New keyval_parse()
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
 <1488194450-28056-4-git-send-email-armbru@redhat.com>
 <20170228154836.GF4090@noname.redhat.com>
In-Reply-To: <20170228154836.GF4090@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 09:48 AM, Kevin Wolf wrote:
> Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
>> keyval_parse() parses KEY=3DVALUE,... into a QDict.  Works like
>> qemu_opts_parse(), except:
>>

>> +
>> +/*
>> + * KEY=3DVALUE,... syntax:
>> + *
>> + *   key-vals     =3D [ key-val { ',' key-vals } ]

Just refreshing my memory: in this grammar, [] means optional (0 or 1),
and {} means repeating (0 or more).

That means an empty string satisfies key-vals (as in "-option ''"),
intentional?

I don't see how this permits a trailing comma, but isn't that one of
your goals to allow "-option key=3Dval," the same as "-option key=3Dval"?=


>> + *   key-val      =3D key '=3D' val
>> + *   key          =3D key-fragment { '.' key-fragment }

Ambiguous.

>> + *   key-fragment =3D / [^=3D,.]* /

Do you want + instead of * in the regex, so as to require a non-empty
string for key-fragment?  After all, you want to reject "-option a..b=3Dv=
al".

>> + *   val          =3D { / [^,]* / | ',,' }

Here, * makes sense, since an empty value is permitted in '-option key=3D=
".

>> + *
>> + * Semantics defined by reduction to JSON:
>> + *
>> + *   key-vals defines a tree of objects rooted at R
>> + *   where for each key-val =3D key-fragment . ... =3D val in key-val=
s
>> + *       R op key-fragment op ... =3D val'
>> + *       where (left-associative) op is member reference L.key-fragme=
nt
>=20
> Maybe it's just me, but I can't say that I fully understand what these
> last two lines are supposed to tell me.

I think it's trying to portray dictionary member lookup semantics (each
key-fragment represents another member lookup one dictionary deeper,
before reaching the final lookup to the scalar value) - but yeah, it was
a confusing read to me as well.

>=20
>> + *             val' is val with ',,' replaced by ','
>> + *   and only R may be empty.
>> + *
>> + *   Duplicate keys are permitted; all but the last one are ignored.
>> + *
>> + *   The equations must have a solution.  Counter-example: a.b=3D1,a=3D=
2
>> + *   doesn't have one, because R.a must be an object to satisfy a.b=3D=
1
>> + *   and a string to satisfy a=3D2.
>> + *
>> + * The length of any key-fragment must be between 1 and 127.
>> + *
>> + * Design flaw: there is no way to denote an empty non-root object.
>> + * While interpreting "key absent" as empty object seems natural
>> + * (removing a key-val from the input string removes the member when
>> + * there are more, so why not when it's the last), it doesn't work:
>> + * "key absent" already means "optional object absent", which isn't
>> + * the same as "empty object present".
>> + *
>> + * Additional syntax for use with an implied key:
>> + *
>> + *   key-vals-ik  =3D val-no-key [ ',' key-vals ]
>> + *   val-no-key   =3D / [^,]* /

I think this needs to be [^,=3D]*, since the presence of an =3D means you=
've
supplied a key, and are not using the implied-key sugar.

>> + *
>> + * where no-key is syntactic sugar for implied-key=3Dval-no-key.
>=20
> s/no-key/val-no-key/ ?
>=20
>> + *
>> + * TODO support lists
>> + * TODO support key-fragment with __RFQDN_ prefix (downstream extensi=
ons)
>=20
> Worth another TODO comment for implied values that contain a comma? The=

> current restriction feels a bit artificial.

It may be a bit artificial, but at least we can document it: implied
keys are sugar that can only be used for certain values, but you can
always avoid the sugar and explicitly provide the key=3Dvalue for
problematic values that can't be done with the implied key.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CGcAihpsGtfC2l1gUNWMiiohlMVp215SQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtavmAAoJEKeha0olJ0NqG/4H/RK9xvagdmP7m+Wr1xnNfOfH
+q32zQlGl4lHYqluLwdrSGlqwR94RUeTgfj1q+CNjzklB1qhtm7Yh0eGGzwyVqgx
1HsNtbnsAy0ZSuU3hrwnuEtBLC6uYpEYwJBA3oxLmtrgqWcAKKJf9dMk/pzYAzpG
1wVJ1FQag5G7vVILr4WDYpQ9F/uXd37RrH1Di+IrJHBRE9qPyt5FLtskS1fT94rn
N//Bzk6J0VBmvhgufFNFcrIKx0ntfQ5o1CpH5K1Gt9r4KVXUq7hTwfQ18UKNBcet
U6l9le8P3qvhkSBT2Ss5NAmo934jbsG6SEi/Y0/3IrNYQ4zvBfoqQhhb3q2OQEY=
=x3uK
-----END PGP SIGNATURE-----

--CGcAihpsGtfC2l1gUNWMiiohlMVp215SQ--
