Received: from eggs.gnu.org ([2001:4830:134:3::10]:51442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB6zm-0003LX-4v
	for qemu-devel@nongnu.org; Wed, 17 May 2017 18:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB6zi-0003wb-8t
	for qemu-devel@nongnu.org; Wed, 17 May 2017 18:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dB6zh-0003vl-UU
	for qemu-devel@nongnu.org; Wed, 17 May 2017 18:00:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C52153680F
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 22:00:32 +0000 (UTC)
References: <20170517212547.4767-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8873ed46-aa36-aae3-1f74-90f247094fab@redhat.com>
Date: Wed, 17 May 2017 17:00:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170517212547.4767-1-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fXxhqSJKTE0vSuctlCCpbS8iAboa5bMl9"
Subject: Re: [Qemu-devel] [RFC] qmp: Return 'user_creatable' &
 'hotpluggable' fields on qom-list-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fXxhqSJKTE0vSuctlCCpbS8iAboa5bMl9
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <8873ed46-aa36-aae3-1f74-90f247094fab@redhat.com>
Subject: Re: [RFC] qmp: Return 'user_creatable' & 'hotpluggable' fields on
 qom-list-types
References: <20170517212547.4767-1-ehabkost@redhat.com>
In-Reply-To: <20170517212547.4767-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 04:25 PM, Eduardo Habkost wrote:
> Currently there's no way for QMP clients to get a list of device types
> that are really usable with -device.  This information would be useful
> for management software and test scripts (like the device-crash-test
> script I have submitted recently).  Interestingly, the "info qdm" HMP
> command provides this information, but no QMP command does.
>=20
> Add two new fields to the return value of qom-list-types:
> "user-creatable-device" and "hotpluggable-device".  Also, add extra
> arguments for filtering the list of types based on the new fields.
>=20
> I'm not sure about the naming of the new command arguments.  Maybe the
> names are too long, but I believe that "user-creatable-devices-only=3Df=
alse"
> would have more obvious semantics than "user-creatable-devices=3Dfalse"=

> (the latter looks ambiguous: it could mean "return only
> non-user-creatable devices" or "return all devices").

Since this is still RFC, here's a bikeshed idea:

"just-user-creatable":false

is shorter, and still conveys whether we care about just user_creatable
devices or all devices.

> +++ b/qapi-schema.json
> @@ -3034,12 +3034,24 @@
>  #
>  # @name: the type name found in the search
>  #
> +# @user-creatable-device: If true, the type is a user-creatable device=
 that
> +#                         can be used with the "-device" command-line =
option.
> +#                         Note that this does not guarantee that the d=
evice
> +#                         is going to be accepted by all machine-types=
=2E
> +#                         (since 2.10)
> +#
> +# @hotpluggable-device: If true, the type is a hotpluggable device tha=
t can
> +#                       be plugged using the "device_add" monitor comm=
and.
> +#                       Note that this does not guarantee that the dev=
ice can
> +#                       be hotplugged on any machine-type. (since 2.10=
)

Do we need the '-device' suffix in both names?  I'm not opposed to it,
but don't know if it is adding any useful information.


>  ##
>  { 'command': 'qom-list-types',
> -  'data': { '*implements': 'str', '*abstract': 'bool' },
> +  'data': { '*implements': 'str', '*abstract': 'bool',
> +            '*user-creatable-devices-only': 'bool', '*hotpluggable-dev=
ices-only': 'bool' },

Long line, try to keep it under 80 columns.

The idea looks reasonable to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fXxhqSJKTE0vSuctlCCpbS8iAboa5bMl9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHMf9AAoJEKeha0olJ0Nqb5YH/1371ERIMljUu5S3CnSp6fUk
A3VawfEG3dONxDam5hMyPvfYfbMPW0ry0jchMvMu1AYvp+Sb27zQvWqsFmG6LGOk
Z+dIg5lsMIdJze1l5fhBjFEq5UQjOfhce2b+LM1esjkGFPxGQz05a8YawwP6RU9j
rjJjNSdufp16P1KU1F+jvxBoJ4b9xYfU0zLtbC/ScnyC5DFuW+Y1PHCeYv2Zkmyn
nsEnIVLnBCRjXPS892t00JWsLLUNdfq0+tSasxBSOXNGK9INqDwbPMKg9/4v426o
nqpxJpHXomBAgpawHv0CsP1sBALgKFaD8NpmbxMwIBHzBnwy5IW+i985QaqMpfU=
=bDoj
-----END PGP SIGNATURE-----

--fXxhqSJKTE0vSuctlCCpbS8iAboa5bMl9--
