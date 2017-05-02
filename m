Received: from eggs.gnu.org ([2001:4830:134:3::10]:58532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5Xxj-0000w6-Ln
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5Xxg-0001ZQ-Hl
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:35:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d5Xxg-0001Yg-8A
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:35:28 -0400
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-6-git-send-email-amarnath.valluri@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0e67268f-46a0-c0c9-4a3b-0957bc387871@redhat.com>
Date: Tue, 2 May 2017 08:35:24 -0500
MIME-Version: 1.0
In-Reply-To: <1493725969-19518-6-git-send-email-amarnath.valluri@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s7nsf2enQf7N3gNaogPxnxmaShdb0qbSc"
Subject: Re: [Qemu-devel] [PATCH v3 5/8] tmp backend: Add new api to read
 backend TpmInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com, stefanb@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s7nsf2enQf7N3gNaogPxnxmaShdb0qbSc
From: Eric Blake <eblake@redhat.com>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com,
 stefanb@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <0e67268f-46a0-c0c9-4a3b-0957bc387871@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/8] tmp backend: Add new api to read
 backend TpmInfo
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
 <1493725969-19518-6-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1493725969-19518-6-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/02/2017 06:52 AM, Amarnath Valluri wrote:
> TPM configuration options are backend implementation details and shall =
not be
> part of base TPMBackend object, and these shall not be accessed directl=
y outside
> of the class, hence added a new interface method, get_tpm_options() to
> TPMDriverOps., which shall be implemented by the derived classes to ret=
urn
> configured tpm options.
>=20
> A new tpm backend api - tpm_backend_query_tpm() which uses _get_tpm_opt=
ions() to
> prepare TpmInfo.
>=20
> Made TPMPassthroughOptions type inherited from newly defined TPMOptions=
 base type.
> The TPMOptions base type is intentionally left empty and supposed to be=

> inherited by all backend implementations to define their tpm configurat=
ion
> options.
>=20
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---

> +++ b/qapi-schema.json
> @@ -5137,6 +5137,16 @@
>  { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
> =20
>  ##
> +# @TPMOptions:
> +#
> +# Base type for TPM options
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'TPMOptions',
> +  'data': { } }
> +
> +##
>  # @TPMPassthroughOptions:
>  #
>  # Information about the TPM passthrough type
> @@ -5148,20 +5158,9 @@
>  #
>  # Since: 1.5
>  ##
> -{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : 'str',
> -                                             '*cancel-path' : 'str'} }=

> +{ 'struct': 'TPMPassthroughOptions', 'base': 'TPMOptions',
> +  'data': { '*path' : 'str', '*cancel-path' : 'str'} }
> =20
> -##
> -# @TpmTypeOptions:
> -#
> -# A union referencing different TPM backend types' configuration optio=
ns
> -#
> -# @type: 'passthrough' The configuration options for the TPM passthrou=
gh type
> -#
> -# Since: 1.5
> -##
> -{ 'union': 'TpmTypeOptions',
> -   'data': { 'passthrough' : 'TPMPassthroughOptions' } }

Getting rid of a simple union is nice.  However,

> =20
>  ##
>  # @TPMInfo:
> @@ -5170,6 +5169,8 @@
>  #
>  # @id: The Id of the TPM
>  #
> +# @type: The TPM backend type
> +#
>  # @model: The TPM frontend model
>  #
>  # @options: The TPM (backend) type configuration options
> @@ -5178,8 +5179,9 @@
>  ##
>  { 'struct': 'TPMInfo',
>    'data': {'id': 'str',
> +           'type': 'TpmType',
>             'model': 'TpmModel',
> -           'options': 'TpmTypeOptions' } }
> +           'options': 'TPMOptions' } }
> =20
>  ##
>  # @query-tpm:
> @@ -5196,13 +5198,12 @@
>  # <- { "return":
>  #      [
>  #        { "model": "tpm-tis",
> +#          "type": "passthrough",
>  #          "options":
> -#            { "type": "passthrough",
> -#              "data":
> -#                { "cancel-path": "/sys/class/misc/tpm0/device/cancel"=
,
> -#                  "path": "/dev/tpm0"
> -#                }
> -#            },
> +#          {
> +#            "cancel-path": "/sys/class/misc/tpm0/device/cancel",
> +#            "path": "/dev/tpm0"
> +#          },
>  #          "id": "tpm0"

Doing it in a manner that is NOT backwards-compatible (as evidenced by
your change to the output text) is NOT good.  It will break any existing
client that was expecting to parse information in the old layout.

I'm afraid you're going to have to fix this to not break QMP wire
compatibility.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s7nsf2enQf7N3gNaogPxnxmaShdb0qbSc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCIscAAoJEKeha0olJ0NqsF8H/ihbmCPtCK83gYJ0Z4COK8LO
vSAi7iAVh4R7y2TKtvrJDle4kKB6hHjzlqTqw2Bbz2ywwl9boARdSaC6E5nj27Kl
YDfQnBUWo4rxU4j+/MjTMlwbKx71TEku1PUihR5LBghV6MqxMiG/z0+GhX02U308
a5uzoNN9mqN1r0xolDfchbDtpYGpJbFObQAbUlttrIfpn7nZ9hvitZ8PBlCjguZg
L0wjddYsrTRJ4KLsdDmAn+6UGZobPmCOjk3qK3eLMPJRmGToJdlJoyJTDCrhc2Oj
rqpToRuw4WWYNXzch7MU82mQ4vBBfPffonRzwp2fUY/eZQrFM4WM+JauDk0isMY=
=7zFw
-----END PGP SIGNATURE-----

--s7nsf2enQf7N3gNaogPxnxmaShdb0qbSc--
