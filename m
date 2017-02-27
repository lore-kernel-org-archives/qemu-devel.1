Received: from eggs.gnu.org ([2001:4830:134:3::10]:41451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciTyG-00072a-8h
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciTyF-0006X8-6x
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:40:44 -0500
References: <cover.1488220970.git.jcody@redhat.com>
	<3d09a265f288145ddd8a0159c72ce343d32c30ff.1488220970.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <33e252c2-4025-db70-5a59-7cdc6445a97f@redhat.com>
Date: Mon, 27 Feb 2017 16:40:34 -0600
MIME-Version: 1.0
In-Reply-To: <3d09a265f288145ddd8a0159c72ce343d32c30ff.1488220970.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MRX9t5bKJqrDIT6QqQegsPDnGJ84j2qI3"
Subject: Re: [Qemu-devel] [PATCH v2 4/5] block/rbd: add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MRX9t5bKJqrDIT6QqQegsPDnGJ84j2qI3
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com
Message-ID: <33e252c2-4025-db70-5a59-7cdc6445a97f@redhat.com>
Subject: Re: [PATCH v2 4/5] block/rbd: add blockdev-add support
References: <cover.1488220970.git.jcody@redhat.com>
 <3d09a265f288145ddd8a0159c72ce343d32c30ff.1488220970.git.jcody@redhat.com>
In-Reply-To: <3d09a265f288145ddd8a0159c72ce343d32c30ff.1488220970.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 12:58 PM, Jeff Cody wrote:
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  qapi/block-core.json | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5f82d35..5b311ff 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2111,6 +2111,7 @@
>  # @replication: Since 2.8
>  # @ssh: Since 2.8
>  # @iscsi: Since 2.9
> +# @rbd: Since 2.9
>  #
>  # Since: 2.0
>  ##
> @@ -2120,7 +2121,7 @@
>              'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'n=
fs',
>              'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed'=
,
>              'quorum', 'raw', 'replication', 'ssh', 'vdi', 'vhdx', 'vmd=
k',
> -            'vpc', 'vvfat' ] }
> +            'vpc', 'vvfat', 'rbd' ] }

Please keep the list alphabetical.

> =20
>  ##
>  # @BlockdevOptionsFile:
> @@ -2376,7 +2377,6 @@
>              'path': 'str',
>              '*user': 'str' } }
> =20
> -
>  ##
>  # @BlkdebugEvent:
>  #

Spurious hunk?

> @@ -2666,6 +2666,34 @@
>              '*timeout': 'int' } }
> =20
>  ##
> +# @BlockdevOptionsRbd:
> +#
> +# @pool:               Ceph pool name.
> +#
> +# @image:              Image name in the Ceph pool.
> +#
> +# @conf:               # optional path to Ceph configuration file.  Va=
lues

No space between # and optional

> +#                      in the configuration file will be overridden by=

> +#                      options specified via QAPI.
> +#
> +# @snapshot:           #optional Ceph snapshot name.
> +#
> +# @user:               #optional Ceph id name.
> +#
> +# @password-secret:    #optional The ID of a QCryptoSecret object prov=
iding
> +#                       the password for the login.


Indentation off?

> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'BlockdevOptionsRbd',
> +  'data': { 'pool': 'str',
> +            'image': 'str',
> +            '*conf': 'str',
> +            '*snapshot': 'str',
> +            '*user': 'str',
> +            '*password-secret': 'str' } }
> +
> +##
>  # @ReplicationMode:
>  #
>  # An enumeration of replication modes.
> @@ -2863,7 +2891,7 @@
>        'qed':        'BlockdevOptionsGenericCOWFormat',
>        'quorum':     'BlockdevOptionsQuorum',
>        'raw':        'BlockdevOptionsRaw',
> -# TODO rbd: Wait for structured options
> +      'rbd':        'BlockdevOptionsRbd',
>        'replication':'BlockdevOptionsReplication',
>  # TODO sheepdog: Wait for structured options
>        'ssh':        'BlockdevOptionsSsh',
>=20

Omits the problematic keyvalue-pairs, and otherwise matches the previous
patches.  With the nits fixed,

Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MRX9t5bKJqrDIT6QqQegsPDnGJ84j2qI3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtKriAAoJEKeha0olJ0NqfmUH/joGtqiWRAudee1hj4KBjaUp
huMdLRy1g4h7PtE9smwgvLGbGaFFrnJqG8RhrzDn4egln3aUI4XxiXkS295Mg+Sb
OxIYa+VNgTT5T0WNurq4kk9A6TT6RojmFVFU7PnLZZ+hGFN+K+15amVtIqfzAXKo
Lx3IrdRP0QZJFt7SRKTsl6JLcESAOjttoP2pOK9493cx7EubHzdZkPXnnJjHa1Td
kM182xW2zMm4IXBTZlmyxzpjoUDcecOjiwCwyror7Dhn80uk5SaCnkl8YV5NpssM
vvEK+Ug8u1uwISt/4IYF8IdpY5ZryHf9bAkEstUqllPhAKfCZXhpTMGVRvMVYfA=
=EASx
-----END PGP SIGNATURE-----

--MRX9t5bKJqrDIT6QqQegsPDnGJ84j2qI3--
