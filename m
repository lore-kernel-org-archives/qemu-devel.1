Received: from eggs.gnu.org ([2001:4830:134:3::10]:34655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7ao-0008Kq-Ot
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7ak-0001EO-IS
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:24:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cv7ak-0001E4-9L
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:24:42 -0400
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<1490965817-16913-6-git-send-email-amarnath.valluri@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f0ecef1-1e43-ffff-2060-7f0da40dc7c5@redhat.com>
Date: Mon, 3 Apr 2017 14:24:39 -0500
MIME-Version: 1.0
In-Reply-To: <1490965817-16913-6-git-send-email-amarnath.valluri@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eK5JONJnP0hPLB72XhROc5L5oemVSVquw"
Subject: Re: [Qemu-devel] [PATCH 5/7] tmp backend: Add new api to read
 backend tpm options
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
--eK5JONJnP0hPLB72XhROc5L5oemVSVquw
From: Eric Blake <eblake@redhat.com>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com
Message-ID: <5f0ecef1-1e43-ffff-2060-7f0da40dc7c5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/7] tmp backend: Add new api to read backend
 tpm options
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
 <1490965817-16913-6-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1490965817-16913-6-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 08:10 AM, Amarnath Valluri wrote:
> TPM configuration options are backend implementation details and shall =
not be
> part of base TPMBackend object, and these shall not be accessed directl=
y outside
> of the class, hence added a new tpm backend api, tpm_backend_get_tpm_op=
tions()
> to read the backend configured options.
>=20
> Added new method, get_tpm_options() to TPMDriverOps., which shall be im=
plemented
> by the derived classes to return configured tpm options.
>=20
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---

Just an interface review for now:


> +++ b/qapi-schema.json
> @@ -5140,6 +5140,14 @@
>  { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
> =20
>  ##
> +# @TPMOptions:
> +#
> +# Base type for TPM options
> +##

Missing a 'Since: 2.10' designation

> +{ 'struct': 'TPMOptions',
> +  'data': { } }

This class feels pointless (at least for now; I haven't checked if you
expand it later in the series - but if so, define it where you first
need it). It has no members, and you are only using it...

> +
> +##
>  # @TPMPassthroughOptions:
>  #
>  # Information about the TPM passthrough type
> @@ -5151,8 +5159,8 @@
>  #
>  # Since: 1.5
>  ##
> -{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : 'str',
> -                                             '*cancel-path' : 'str'} }=

> +{ 'struct': 'TPMPassthroughOptions', 'base': 'TPMOptions',

=2E..as a base class. A base class makes sense only if it is consolidatin=
g
common members, or if it is the base to at least two different
structures where having a common C type to pass around is handy.

> +  'data': { '*path' : 'str', '*cancel-path' : 'str'} }
> =20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eK5JONJnP0hPLB72XhROc5L5oemVSVquw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY4qF3AAoJEKeha0olJ0Nq4k8IAKH3tQF0n52GAglUsqT7SwVH
qsaapN96ODZhh83mIl3lSz3pS7eFrjrSa3epCQJVYtouFI2KhF+xcd51KeMlPAVR
dIYmBitNG/FRW6/gZ8TQKIYDGiEY+gp8/dxozjiR/6inZVL3beAusujssiHbg/6b
KsC0dmeIjBaJfuWamql0pOn4bvd8FygRRQKlIJTd93okiCnBzGhEK11/rrCLnIlS
twYrxeGIEg6Hs1vH8QxwqgoD3RJPy9wt3ZlF4yj9idMQYycnHa4HLQb5S1HKWg3D
dgSiFuorLamDsJrq7FLea/rUvfbPbGSDr/oM69MU0+hVuYN+yg/FGyg738iFDrk=
=BFXj
-----END PGP SIGNATURE-----

--eK5JONJnP0hPLB72XhROc5L5oemVSVquw--
