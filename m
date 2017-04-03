Received: from eggs.gnu.org ([2001:4830:134:3::10]:35785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7gQ-0000ze-Pe
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7gM-0004Lv-QT
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:30:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cv7gM-0004LH-Hi
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:30:30 -0400
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<1490965817-16913-8-git-send-email-amarnath.valluri@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a22cfed1-49db-48d1-c204-132ece5f27ed@redhat.com>
Date: Mon, 3 Apr 2017 14:30:26 -0500
MIME-Version: 1.0
In-Reply-To: <1490965817-16913-8-git-send-email-amarnath.valluri@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D8HIQFnAbuPu2FW6KMWPPJaFHgvaJ9XPd"
Subject: Re: [Qemu-devel] [PATCH 7/7] Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D8HIQFnAbuPu2FW6KMWPPJaFHgvaJ9XPd
From: Eric Blake <eblake@redhat.com>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com
Message-ID: <a22cfed1-49db-48d1-c204-132ece5f27ed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/7] Added support for TPM emulator
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
 <1490965817-16913-8-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1490965817-16913-8-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 08:10 AM, Amarnath Valluri wrote:
> This change introduces a new TPM backend driver that can communicates w=
ith
> swtpm(software TPM emulator) using unix domain socket interface.
>=20
> Swtpm uses two unix sockets, one for plain TPM commands and responses, =
and one
> for out-of-band control messages.
>=20
> The swtpm and associated tools can be found here:
>     https://github.com/stefanberger/swtpm
>=20
> Usage:
>     # setup TPM state directory
>     mkdir /tmp/mytpm
>     chown -R tss:root /tmp/mytpm
>     /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek
>=20
>     # Ask qeum to use TPM emulator with given tpm state directory
>     qemu-system-x86_64 \
>         [...] \
>         -tpmdev emulator,id=3Dtpm0,tpmstatedir=3D/tmp/mytpm,logfile=3D/=
tmp/swtpm.log \
>         -device tpm-tis,tpmdev=3Dtpm0 \
>         [...]
>=20
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---

Just an interface review for now:


> +++ b/qapi-schema.json
> @@ -5117,10 +5117,11 @@
>  # An enumeration of TPM types
>  #
>  # @passthrough: TPM passthrough type
> +# @emulator: Software Emulator TPM type

Missing a '(since 2.10)' designator on @emulator

>  #
>  # Since: 1.5
>  ##
> -{ 'enum': 'TpmType', 'data': [ 'passthrough' ] }
> +{ 'enum': 'TpmType', 'data': [ 'passthrough', 'emulator' ] }
> =20
>  ##
>  # @query-tpm-types:
> @@ -5163,6 +5164,22 @@
>    'data': { '*path' : 'str', '*cancel-path' : 'str'} }
> =20
>  ##
> +# @TPMEmulatorOptions:
> +#
> +# Information about the TPM emulator
> +#
> +# @tpmstatedir: TPM emilator state dir

s/emilator/emulator/

> +# @path: TPM emulator binary path to use
> +# @logfile: file to use to place TPM emulator logs

What's the default when logfile is omitted?

> +# @loglevel: log level number

What's the default, or even the valid range of values? Is a larger
number noisier?

> +#
> +# Since: 2.6

You've missed 2.6 by a long shot. We are now working on 2.10 interfaces.

> +##
> +{ 'struct': 'TPMEmulatorOptions', 'base': 'TPMOptions',

Okay, the base class you added in 5/7 makes a bit more sense now, even
if it remains empty.  But then that means you need to update the commit
message to call it out as intentional that it is empty and a second
derived class will be added later.

> +  'data': { 'tpmstatedir' : 'str', '*path': 'str',
> +            '*logfile' : 'str', '*loglevel' : 'int' } }
> +
> +##
>  # @TpmTypeOptions:
>  #
>  # A union referencing different TPM backend types' configuration optio=
ns
> @@ -5172,7 +5189,8 @@
>  # Since: 1.5
>  ##
>  { 'union': 'TpmTypeOptions',
> -   'data': { 'passthrough' : 'TPMPassthroughOptions' } }
> +  'data': { 'passthrough' : 'TPMPassthroughOptions',
> +            'emulator' : 'TPMEmulatorOptions' } }
> =20
>  ##
>  # @TPMInfo:

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--D8HIQFnAbuPu2FW6KMWPPJaFHgvaJ9XPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY4qLSAAoJEKeha0olJ0NqcakH+wYmlUIhnlzLujPfLQlhJZJS
hD0OeweMLaedGYw+YRFWVwUJ+9tZ5597XUDoebaJ4lafo4WgR1anrGSIOU2io0yv
dVypCzYqixY3t+ZpZdBIbA4JU9exjBUYpwrGc+DQld/MSlFLrlLJXR0uOlWA76gy
xzDkrjYVLm2fBSZSjLxkKVVR3QqLQeSCmkDvKkbMVrtsGADz9UlHrsai5UJLl24N
2ZgYmL8xXEBsg8rP4i0SyVeQNjBurYczYFJf/k0bU8XlW5lDiFzSjqDJqYygB5OM
gQOnAOjAvN6KNjLs+2CniqvYPO2Z7kdGdMbzCZDziZS1kWKdnc532kqfPdDn4tE=
=hrT9
-----END PGP SIGNATURE-----

--D8HIQFnAbuPu2FW6KMWPPJaFHgvaJ9XPd--
