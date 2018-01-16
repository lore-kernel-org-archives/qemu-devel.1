Received: from eggs.gnu.org ([2001:4830:134:3::10]:37215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebXpP-0003qH-9W
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebXpN-00009j-RP
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:27:27 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-3-kwolf@redhat.com>
	<9b4df0a9-a77e-32a9-457d-eacab0127cd5@redhat.com>
	<20180116201127.GC5719@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ad15ce05-7da3-d94c-f1ee-0f6489c2a4bb@redhat.com>
Date: Tue, 16 Jan 2018 14:27:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180116201127.GC5719@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aJKIdJM7OQZjAyAw9C6yeblElaxIIKGTr"
Subject: Re: [Qemu-devel] [RFC PATCH 02/10] block/qapi: Add qcow2 create
 options to schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aJKIdJM7OQZjAyAw9C6yeblElaxIIKGTr
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <ad15ce05-7da3-d94c-f1ee-0f6489c2a4bb@redhat.com>
Subject: Re: [RFC PATCH 02/10] block/qapi: Add qcow2 create options to schema
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-3-kwolf@redhat.com>
 <9b4df0a9-a77e-32a9-457d-eacab0127cd5@redhat.com>
 <20180116201127.GC5719@localhost.localdomain>
In-Reply-To: <20180116201127.GC5719@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2018 02:11 PM, Kevin Wolf wrote:

>>> +{ 'enum': 'BlockdevQcow2CompatLevel',
>>> +  'data': [ '0_10', '1_1' ] }
>>
>> Enums are allowed to start with digits while struct members are not; s=
o
>> you can get away with this naming.  Do we really want the names 0_10 a=
nd
>> 1_1, or are there better names we could come up with (it already
>> undergoes translation such that qemu-img reports 0.10 rather than 0_10=
).
>=20
> Yeah, I don't like 0_10/1_1 much.
>=20
> Either we allow dots in enum values so that we can keep 0.10/1.1, or
> something completely different. I was considering 'version': 'int' with=

> 2 and 3 as possible values, after all QMP is already rather low-level.
>=20

I can live with a lower-level 'version':'int' for qcow2 creation over QMP=
=2E

> The question is just what to do with the command line. Will we deprecat=
e
> compat=3D0.10/1.1 there, too, and tell users to switch to whatever new
> syntax we invent for QMP? Or are we planning to keep the "translation"
> from the old syntax forever?

At a minimum, we'll have to keep the translation syntax for as long as a
deprecation cycle with proper documentation is available (at least two
releases); keeping it longer than that depends on whether we think the
deprecation is worth the cleaner code in the long run.  But we do have a
deprecation policy, so we can start thinking about using that now so
that in another year we can do a release that gets rid of the
back-compat code.


>>> +  'data': { 'size':             'size',
>>
>> Is size mandatory even when we have a backing file specification?  It =
is
>> not mandatory for qemu-img create; but on the other hand, I think I ca=
n
>> live with requiring the QMP caller to supply a size.
>=20
> The qemu-img create implementation of this is common code at least, but=

> we're in driver-specific definitions here, so every driver would have t=
o
> call some function to guess the size given a backing file string. With
> the straightforward implementation of this series, it is really
> mandatory because otherwise you'd get zero-sized images.
>=20
> Accessing the backing file during image creation is also one of those
> things that tend to cause surprises, so if we don't have to, I wouldn't=

> do that.

Good point.  So mandatory size at the QMP layer makes sense (qemu-img
can still open multiple images to determine what size to pass to QMP
under the hood).

>=20
>>> +            '*compat':          'BlockdevQcow2CompatLevel',
>>> +            '*backing-file':    'str',
>>
>> Given Dan's comments, perhaps name this one 'backing-str' to make it
>> obvious that it is the string written into the qcow2 header, rather th=
an
>> the node we open as backing?
>=20
> If you guys think that this is clearer, I can change it.

Especially since you're convincing me that we DON'T want to open a
backing node during this operation, I think backing-str is a bit clearer
(of course, that's another place for command-line back-compat glue that
we may want to deprecate over time).

>=20
>> Or, maybe we support an optional '*backing-node' that can be used for
>> allowing a default size and backing string if not explicitly
>> overridden?
>=20
> Hm, it would make the interface a bit more complex. I'd try whether we
> can do without it.

I'm fine if you can manage the series without having a backing-node
argument.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--aJKIdJM7OQZjAyAw9C6yeblElaxIIKGTr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeYCMACgkQp6FrSiUn
Q2qJRAf+LF/MLToMHETBYkOFMF+TPWUNlI5OG/Z3cuxBPVzDwscT4QAK5iwpm19u
ijC6Z2I95c2qe0jX/TWwgcTHL3yAN0/MBljZfc+VHDxaExWYOvusCdG9XAMd9p9F
FWW8zAQomhedEQWFYnWLZ6AcAyanT83gNn3ayd9HVNN9D44WMlCdCDOHlnY0u06+
bV+3FKeYVw/D8zkIjXvdxMqLKDXPW8GurpctcGVYrj2vU3mIMixScDDDcPvEhyBc
a/Z3HbcLSr0Y2uWb20riZt5+SeXsUiWG3moHroYFImtbaepCstLj534Xmcb64Vhn
AzrobtjBP7mpLzuxrwZEbbI13X/NyQ==
=OB2C
-----END PGP SIGNATURE-----

--aJKIdJM7OQZjAyAw9C6yeblElaxIIKGTr--
