Received: from eggs.gnu.org ([2001:4830:134:3::10]:38920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebWNW-0001zp-GL
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebWNV-0003vR-Ft
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:54:34 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f55f84bb-2f05-1ef8-8198-42208a927764@redhat.com>
Date: Tue, 16 Jan 2018 12:54:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TzhWWyHuhbJfTV5RDe4OL26iJDbkVuvTS"
Subject: Re: [Qemu-devel] [RFC PATCH 01/10] block/qapi: Introduce
 BlockdevCreateOptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TzhWWyHuhbJfTV5RDe4OL26iJDbkVuvTS
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <f55f84bb-2f05-1ef8-8198-42208a927764@redhat.com>
Subject: Re: [RFC PATCH 01/10] block/qapi: Introduce BlockdevCreateOptions
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-2-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> This creates a BlockdevCreateOptions union type that will contain all o=
f
> the options for image creation. We'll start out with an empty struct
> type BlockdevCreateDummy for all drivers.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 64 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index e94a6881b2..1749376c61 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3320,6 +3320,70 @@
>  { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
> =20
>  ##
> +# @BlockdevCreateDummy:
> +#
> +# FIXME To be removed. Only there to make the QAPI generator happy whi=
le we're
> +# adding driver by driver. Leaving out union branches is not allowed.
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateDummy', 'data': {}}

At one point, I had a patch that let you do:

'data': { 'branch': {},
          ... }

for the branches that didn't need to add any additional types to the
flat union.  Hmm, looks like it is still sitting in my tree, unapplied;
would it help if I revived that one?

> +
> +##
> +# @BlockdevCreateOptions:
> +#
> +# Options for creating an image format on a given node.
> +#
> +# @driver           block driver to create the image format
> +# @node             node to create the image format on

Any restrictions we want to document about the node (for example, it
must not be in use by any backend device at the moment, particularly
since creation may change the node's format)?

> +#
> +# Since: 2.12
> +##
> +{ 'union': 'BlockdevCreateOptions',
> +  'base': {
> +      'driver':         'BlockdevDriver',
> +      'node':           'BlockdevRef' },
> +  'discriminator': 'driver',
> +  'data': {
> +      'blkdebug':       'BlockdevCreateDummy',

The QAPI itself looks sane for the future patches.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TzhWWyHuhbJfTV5RDe4OL26iJDbkVuvTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeSlUACgkQp6FrSiUn
Q2rbcAgAmqxoGiHdjPsxK4UhYkv0fpdedN9N7giMpeEtO0I8hZiWGfwPUQsA8zic
hf0TsmAJx6PixihlfyJrlsy6nahA6ZcuE2867vIdCy65NwoYI7H6AcyrkUNpeZ/Q
WQqHMBBIQiK2W2kZ/oeqULAp2WXHMV8+ZgsWT0u6OQzkBNa9qnma5EP3Dy8G+jLf
tHcclH3qEQ7mU3siXoSy2v5nm5PfWxi8N8Bw5kV2Ag47MzTvBl6iXR+oKrluWi2R
em2CwvuBIFxWGnhUJzuULwmrXeh/oK8QMQ3acsQNbDhoT6dpA3Ut5xcu8DjKvQOF
y7vAZfPKCt3MP0MbXFAy1sAOuaY9iQ==
=VnDy
-----END PGP SIGNATURE-----

--TzhWWyHuhbJfTV5RDe4OL26iJDbkVuvTS--
