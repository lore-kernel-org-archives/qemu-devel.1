Received: from eggs.gnu.org ([2001:4830:134:3::10]:46705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chIfW-0000l6-KJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chIfV-0002Vb-Gs
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:24:30 -0500
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-3-git-send-email-armbru@redhat.com>
	<5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
	<878toxmeol.fsf@dusky.pond.sub.org> <877f4g2f6m.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com>
Date: Fri, 24 Feb 2017 10:24:21 -0600
MIME-Version: 1.0
In-Reply-To: <877f4g2f6m.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nUE3OEiblC9ge8VSOHtN4QPOnC1rjbpo1"
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nUE3OEiblC9ge8VSOHtN4QPOnC1rjbpo1
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com,
 qemu-block@nongnu.org
Message-ID: <c00ea08f-f596-6e3e-4084-7f183c92a04d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
 <1487710908-26356-3-git-send-email-armbru@redhat.com>
 <5f90e39c-e4ea-8638-d057-25eff232ad3d@redhat.com>
 <878toxmeol.fsf@dusky.pond.sub.org> <877f4g2f6m.fsf@dusky.pond.sub.org>
In-Reply-To: <877f4g2f6m.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 01:58 AM, Markus Armbruster wrote:

>> I hate the 'no$key' sugar, and would love to get rid of it.  It makes
>> things ambiguous (thus confusing) for precious little gain: 'novocaine=
'
>> can mean 'novocaine=3Don' or 'vocaine=3Doff'.  QemuOpts picks the latt=
er,
>> even when a QemuOpt named 'novocaine' has been declared.
>>
>> keyval_parse() is meant to behave like QemuOpts, so I'm reproducing th=
is
>> bit of bad sugar, reluctantly.
>=20
> Implied value alternatives / variations:
>=20
> (1) Don't implement the "no" sugar
>=20
>     I think we'd have to deprecate it in QemuOpts now, to give users
>     some time to adapt before keyval_parse() replaces QemuOpts.
>=20

>=20
> If we're happy with bad sugar like "can't abbreviate novocaine=3Don to
> novocaine" (confusing), "filename without a value gets you the file
> 'on'", we reimplement the bad sugar and move on.
>=20
> If not, we have the choice between less magic or more magic.
>=20
> Less magic: (1) and/or (2).
>=20
> More magic: (3) or something like it.
>=20
> If we don't want to decide right now, we can do
>=20
> (4) Don't implement any implied value sugar for now
>=20
>     You have to spell out =3Don and =3Doff.  Big fat comment to remind =
us
>     about the QemuOpts incompatibility.
>=20
> I think this would be acceptable for -blockdev in 2.9.
>=20
> Opinions?

Do any existing blockdev sub-parameters begin with 'no'?  Ouch:
BlockdevOptions has '*cache':'BlockdevCacheOptions' which in turn has
'*no-flush':'bool'.  Even worse, I think you could abuse 'nono-flush' to
enable flushing - my head hurts.

And of course, there's the obvious BlockDevOptions '*node-name':'str'.
No one in their right mind would expect 'node-name' without parameters
to result in 'de-name=3Dno'.

Also, I found that at least libvirt has existing command line usage
-numa node,nodeid=3D0, where qemu_numa_opts uses .implied_opt_name=3D"typ=
e",
=2Edesc =3D {{0}} to be visited by OptsVisitor.  Because of the implied o=
pt,
we get the desired "type=3Dnode" rather than the accidental "de=3Dno", bu=
t
the magic of implied keys can certainly make it weird to think about.

How about:

for 2.9: -blockdev has no magic at all (you HAVE to spell 'foo=3Doff'
rather than 'foo' for any boolean parameters that you want disabled in
-blockdev); and in QemuOpts, we issue deprecation warnings but keep
existing behavior any time someone uses 'noFOO' that we turn into
'FOO=3Dno'.  Then, for 2.10, we can decide to remove the deprecation
warnings if they pointed out real (ab)use of the sugar in the wild, or
(hopefully) to kill the sugar entirely (as part of converting QemuOpts
over to keyval_parse).

In short, getting rid of the 'no' prefix magic, after suitable
deprecation warnings, seems like a good plan to me; and having -blockdev
be slightly tighter than the rest of command line options for 2.9 only
is no real loss (no one uses -blockdev yet, so they can be written to
avoid the use of 'no' magic to begin with).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nUE3OEiblC9ge8VSOHtN4QPOnC1rjbpo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsF41AAoJEKeha0olJ0Nq/nEH/ihMueEXCnfC9637t7f0S3gF
PTzR2PE1w+EVchsPcECj2yrK5ziTrsmojrAd8BpZEclIA+O7RhPQ49OLL/VASpiR
hw2VFDVf1Eh43OiGbXmE/2ih9FIMCwuo9Unpgpt7Tp8gJ/W466DMYaDkRyobTR4c
xb+gf4I7aY2cLeBvL8n6eyDa0lv0K+aeJ+Kn+pJn37tWATAANCEFHqOgoYNht151
kABCn2sir4POvxY/qNUzsMICA4jMFDSuKe2H30Kh8CZkhtuKRAXux8tWHU31EeU8
/OGBzFHknqCZLnzwnfn1l9IOZKQRincKqhVKwXNdxhyYWvc5+IXAfp7BJJWah/s=
=SjgZ
-----END PGP SIGNATURE-----

--nUE3OEiblC9ge8VSOHtN4QPOnC1rjbpo1--
