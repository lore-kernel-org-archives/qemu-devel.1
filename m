Received: from eggs.gnu.org ([209.51.188.92]:42795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grTZo-0002SS-JF
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grTZm-00065j-Fb
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:13:44 -0500
References: <20190206195551.28893-1-mreitz@redhat.com>
	<20190206195551.28893-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <495fa2d7-44cd-ff18-a2b7-aa40c0c37964@redhat.com>
Date: Wed, 6 Feb 2019 14:13:23 -0600
MIME-Version: 1.0
In-Reply-To: <20190206195551.28893-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4cVlaygAtyBQaFGJhTyWkOfLo1OkO7gq8"
Subject: Re: [Qemu-devel] [PATCH v3 1/8] qapi: Add default-variant for flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4cVlaygAtyBQaFGJhTyWkOfLo1OkO7gq8
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <495fa2d7-44cd-ff18-a2b7-aa40c0c37964@redhat.com>
Subject: Re: [PATCH v3 1/8] qapi: Add default-variant for flat unions
References: <20190206195551.28893-1-mreitz@redhat.com>
 <20190206195551.28893-2-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 1:55 PM, Max Reitz wrote:
> This patch allows specifying a discriminator that is an optional member=

> of the base struct.  In such a case, a default value must be provided
> that is used when no value is given.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/introspect.json           |  8 +++++
>  scripts/qapi/common.py         | 58 ++++++++++++++++++++++++++++------=

>  scripts/qapi/doc.py            | 10 ++++--
>  scripts/qapi/introspect.py     | 10 ++++--
>  scripts/qapi/visit.py          | 13 ++++++++
>  tests/qapi-schema/test-qapi.py |  2 ++
>  6 files changed, 86 insertions(+), 15 deletions(-)

Missing a change to docs/devel/qapi-code-gen.txt? [re-reads diffstat in
cover letter...] Oh, you got that later in the series. Maybe those two
patches are worth squashing?

> +++ b/scripts/qapi/visit.py
> @@ -77,6 +77,19 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_n=
ame)s *obj, Error **errp)
>          ret +=3D gen_endif(memb.ifcond)
> =20
>      if variants:
> +        if variants.default_tag_value is not None:
> +            ret +=3D mcgen('''
> +    if (!obj->has_%(c_name)s) {
> +        obj->has_%(c_name)s =3D true;
> +        obj->%(c_name)s =3D %(enum_const)s;
> +    }
> +''',
> +                         c_name=3Dc_name(variants.tag_member.name),
> +                         enum_const=3Dc_enum_const(
> +                             variants.tag_member.type.name,
> +                             variants.default_tag_value,
> +                             variants.tag_member.type.prefix))
> +

I like that you de-sugar it as early in the input parse as possible.

Markus may have comments, but it looks reasonable to me.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4cVlaygAtyBQaFGJhTyWkOfLo1OkO7gq8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbP+QACgkQp6FrSiUn
Q2r2VAf+MFl5bcJlmekJ/Iu8nhtmUhiU7GU4DKpf/xeHJdkeP4URU9YIhhBfCYmJ
hnSE5LZ6FYTFktzKHFiUasQ3LX9FJaNv3o8HOdxdkIZMSmfG+d8SarhU0+ZnESR/
xR17mvQ+/5Momzuz35o92OmHTZFRfe8xRrxgoeYpvsWSwLo1+HjfyHOagHBdPmDX
HvukVWYXFw+exT+cxn4687vopo5FiIG4+aYZyysEmMz7n03C+/SGOh+9SaBx1ccY
i2Z5E79kpn/qzxpnSWMwt7Kh+2q7C9y+OpEKgYmPldbVITHhXReuI49uH/30nAyj
EniVDZvBrR01DeDMFZxtQxmwiOO37Q==
=8eqw
-----END PGP SIGNATURE-----

--4cVlaygAtyBQaFGJhTyWkOfLo1OkO7gq8--
