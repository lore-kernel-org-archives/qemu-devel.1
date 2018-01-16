Received: from eggs.gnu.org ([2001:4830:134:3::10]:40518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebWSL-0004lq-BH
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebWSK-0000A4-67
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:59:33 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b4df0a9-a77e-32a9-457d-eacab0127cd5@redhat.com>
Date: Tue, 16 Jan 2018 12:59:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GsiHseEaLWHbS5X5tGBjpTPBd6CDirVA9"
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
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GsiHseEaLWHbS5X5tGBjpTPBd6CDirVA9
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org
Message-ID: <9b4df0a9-a77e-32a9-457d-eacab0127cd5@redhat.com>
Subject: Re: [RFC PATCH 02/10] block/qapi: Add qcow2 create options to schema
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-3-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 01:52 PM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1749376c61..9341f6708d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3320,6 +3320,37 @@
>  { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
> =20
>  ##
> +# @BlockdevQcow2CompatLevel:
> +# @0_10:    The original QCOW2 format as introduced in qemu 0.10 (vers=
ion 2)
> +# @1_1:     The extended QCOW2 format as introduced in qemu 1.1 (versi=
on 3)
> +#
> +# Since: 2.10
> +##
> +{ 'enum': 'BlockdevQcow2CompatLevel',
> +  'data': [ '0_10', '1_1' ] }

Enums are allowed to start with digits while struct members are not; so
you can get away with this naming.  Do we really want the names 0_10 and
1_1, or are there better names we could come up with (it already
undergoes translation such that qemu-img reports 0.10 rather than 0_10).

> +
> +
> +##
> +# @BlockdevCreateOptionsQcow2:
> +#
> +# Driver specific image creation options for qcow2.
> +#
> +# TODO Describe fields

Hence this being RFC :)

> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateOptionsQcow2',
> +  'data': { 'size':             'size',

Is size mandatory even when we have a backing file specification?  It is
not mandatory for qemu-img create; but on the other hand, I think I can
live with requiring the QMP caller to supply a size.

> +            '*compat':          'BlockdevQcow2CompatLevel',
> +            '*backing-file':    'str',

Given Dan's comments, perhaps name this one 'backing-str' to make it
obvious that it is the string written into the qcow2 header, rather than
the node we open as backing?  Or, maybe we support an optional
'*backing-node' that can be used for allowing a default size and backing
string if not explicitly overridden?

> +            '*backing-fmt':     'BlockdevDriver',
> +            '*encrypt':         'QCryptoBlockCreateOptions',
> +            '*cluster-size':    'size',
> +            '*preallocation':   'PreallocMode',
> +            '*lazy-refcounts':  'bool',
> +            '*refcount-bits':   'int' } }
> +
> +##
>  # @BlockdevCreateDummy:
>  #
>  # FIXME To be removed. Only there to make the QAPI generator happy whi=
le we're
> @@ -3365,7 +3396,7 @@
>        'null-aio':       'BlockdevCreateDummy',
>        'null-co':        'BlockdevCreateDummy',
>        'parallels':      'BlockdevCreateDummy',
> -      'qcow2':          'BlockdevCreateDummy',
> +      'qcow2':          'BlockdevCreateOptionsQcow2',
>        'qcow':           'BlockdevCreateDummy',
>        'qed':            'BlockdevCreateDummy',
>        'quorum':         'BlockdevCreateDummy',
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GsiHseEaLWHbS5X5tGBjpTPBd6CDirVA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeS4wACgkQp6FrSiUn
Q2oCjAf/bgcQAi+ssoDjJwLXr/JPUo+vSrbhwodx4BK3f3NT10q1xip7+934PUiy
HSrJcGMe6KMNEBZW0vP/7f2fCwVxBPHHeLeqa5mruqk2skA5YgD6Ba/dYxaO25wB
IoQBpwnzscw86LPLJqLy5RmsGOhtGGcKz7b8fr/QxqtSAuXUq88ofMj28QV5/tK8
OCWc0Z/U6FFyEPseZKhp4rPuKBCb+ocjpnEu7XAOtCG81O1K02tye8bgTDbuohWw
HHhKTlWQ6CLJ5MJuRtsq5ieWfg4+e77ypnOwDZM8qNHzeZs4mABgvG0zNon5K94u
sFpZIvSoTxPkXMkrTdnJKWPkx+zyuQ==
=nfLd
-----END PGP SIGNATURE-----

--GsiHseEaLWHbS5X5tGBjpTPBd6CDirVA9--
