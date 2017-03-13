Received: from eggs.gnu.org ([2001:4830:134:3::10]:59660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnYjD-000470-3V
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnYj8-0000KT-HA
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:46:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnYj8-0000Jf-4d
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:46:06 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4329f1e3-1f8e-7194-3bf6-55ae0d0aae82@redhat.com>
Date: Mon, 13 Mar 2017 17:46:03 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j9u0lkPi55EsITRpgrsHiAlFmK3kQdKKM"
Subject: Re: [Qemu-devel] [PATCH for-2.9 06/47] qapi: Have each QAPI schema
 declare its name rule violations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j9u0lkPi55EsITRpgrsHiAlFmK3kQdKKM
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <4329f1e3-1f8e-7194-3bf6-55ae0d0aae82@redhat.com>
Subject: Re: [PATCH for-2.9 06/47] qapi: Have each QAPI schema declare its
 name rule violations
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> qapi.py has a hardcoded white-list of type names that may violate the
> rule on use of upper and lower case.  Add a new pragma directive
> 'name-case-whitelist', and use it to replace the hard-coded
> white-list.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/qapi-code-gen.txt                  |  6 ++++++
>  qapi-schema.json                        | 11 ++++++++++-
>  scripts/qapi.py                         | 22 ++++++++++------------
>  tests/qapi-schema/enum-member-case.err  |  2 +-
>  tests/qapi-schema/enum-member-case.json |  1 +
>  5 files changed, 28 insertions(+), 14 deletions(-)
>=20

> +++ b/qapi-schema.json
> @@ -61,7 +61,16 @@
>          'query-migrate-cache-size',
>          'query-tpm-models',
>          'query-tpm-types',
> -        'ringbuf-read' ] } }
> +        'ringbuf-read' ],
> +    'name-case-whitelist': [
> +        'ACPISlotType',         # DIMM, visible through query-acpi-osp=
m-status
> +        'CpuInfoMIPS',          # PC, visible through query-cpu
> +        'CpuInfoTricore',       # PC, visible through query-cpu
> +        'QapiErrorClass',       # all members, visible through errors
> +        'UuidInfo',             # UUID, visible through query-uuid
> +        'X86CPURegister32',     # all members, visible indirectly thro=
ugh qom-get
> +        'q_obj_CpuInfo-base'    # CPU, visible through query-cpu
> +    ] } }

Interesting - here you bunch up 2 of the 3 pragmas into one dict, while
still leaving the third related to documentation in its own dict.

That 'q_obj_CpuInfo-base' is ugly, and I had a patch around previously
that used a saner name rather than making callers reverse-engineer the
implicit naming rules.  Related to my work on anonymous bases to flat
unions, so I'll get to rebase that work and post it on top of yours.
But not a show-stopper for this patch, where it is just moving the locati=
on.


> @@ -311,6 +302,13 @@ class QAPISchemaParser(object):
>                                     "Pragma returns-whitelist must be"
>                                     " a list of strings")
>              returns_whitelist =3D value
> +        elif name =3D=3D 'name-case-whitelist':
> +            if (not isinstance(value, list)
> +                    or any([not isinstance(elt, str) for elt in value]=
)):
> +                raise QAPISemError(info,
> +                                   "Pragma name-case-whitelist must be=
"
> +                                   " a list of strings")
> +            name_case_whitelist =3D value

Same comments as before - new error message with no testsuite coverage,
and no checking for duplicate assignment where last one silently wins;
but where I'm okay with deferring if you don't want to delay 2.9 for a
v2 respin.

So if you use it unchanged,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--j9u0lkPi55EsITRpgrsHiAlFmK3kQdKKM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxyErAAoJEKeha0olJ0NqzagH/1Mbo6I5F+r/cl23XnJ0jept
bxOlnFdaq825ZCL2paic6mTQkzxXsZcqzMX6nxJwyLf+jBzXx/Uj7vOY2/oa5BAI
ffuyj8yaPLvj12t1gxOhyqXdc4fVBl79AxEKlsBvzoNUxQgbWjriXkdl07oI35DZ
C7ufTJMAWV2zNPd7jJlV094cqC/nB8HsD9a6uQdDoIc/sscORWPKmj9YvqUqcETC
SurKLJdfEEJIe9L2wTphF7oEjiMZU4e0PupfCElNuXZ1NmzTcsaxvP9AY5kqo3lt
he0AD60c+sXjlxWJXEzMpf2wgUCGv1py96Fk8Cl0ghNOBELeLpR3lNgsU+HC4n4=
=pljY
-----END PGP SIGNATURE-----

--j9u0lkPi55EsITRpgrsHiAlFmK3kQdKKM--
