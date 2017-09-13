Received: from eggs.gnu.org ([2001:4830:134:3::10]:50833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ds84p-0004lb-FU
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ds84k-0006dz-Sf
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:51:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ds84k-0006cB-K7
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:51:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED10D5F795
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 13:51:31 +0000 (UTC)
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60e9ce8a-9473-cf55-5429-f70902bc59c2@redhat.com>
Date: Wed, 13 Sep 2017 08:51:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170911110623.24981-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CbCUru5K6j0AFFIJDsMAJJcI6XXlcN6Ec"
Subject: Re: [Qemu-devel] [PATCH v3 01/50] qlit: add qobject_from_qlit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CbCUru5K6j0AFFIJDsMAJJcI6XXlcN6Ec
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <60e9ce8a-9473-cf55-5429-f70902bc59c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/50] qlit: add qobject_from_qlit()
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
 <20170911110623.24981-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/11/2017 06:05 AM, Marc-Andr=C3=A9 Lureau wrote:
> Instanciate a QObject* form a literal QLitObject.

s/Instanciate/Instantiate/
s/form/from/

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h |  2 ++
>  qobject/qlit.c          | 36 ++++++++++++++++++++++++++++++++++++
>  tests/check-qlit.c      | 26 ++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+)

> +QObject *qobject_from_qlit(const QLitObject *qlit)
> +{
> +    switch (qlit->type) {
> +    case QTYPE_QNULL:
> +        return QOBJECT(qnull());
> +    case QTYPE_QNUM:
> +        return QOBJECT(qnum_from_int(qlit->value.qnum));

Is this going to work for all QNum values?

> +++ b/tests/check-qlit.c
> @@ -64,11 +64,37 @@ static void qlit_equal_qobject_test(void)
>      qobject_decref(qobj);
>  }
> =20
> +static void qobject_from_qlit_test(void)
> +{
> +    QObject *obj, *qobj =3D qobject_from_qlit(&qlit);
> +    QDict *qdict;
> +    QList *bee;
> +
> +    qdict =3D qobject_to_qdict(qobj);
> +    g_assert_cmpint(qdict_get_int(qdict, "foo"), =3D=3D, 42);
> +    g_assert_cmpstr(qdict_get_str(qdict, "bar"), =3D=3D, "hello world"=
);
> +    g_assert(qobject_type(qdict_get(qdict, "baz")) =3D=3D QTYPE_QNULL)=
;

Related to my question above - you pass because there are no floating
point values in qlit.  Is that something we want supported?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CbCUru5K6j0AFFIJDsMAJJcI6XXlcN6Ec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm5N+AACgkQp6FrSiUn
Q2oHhQf/XWwr3HUizLnvWP/pFuFOB5aUgnci9FN0IhfAUp5d5+ElUhXCu0WLUOTV
WzEOP8jSXubpvgQB9uZmpuJL+JgCbXIsD3kZKtdSMdpopI19xx9etoghEa4Sk57v
fmDRiw5q6vDiZBw6ajXqQLWHUWcrm6DmUFZ/GIEpeCT+6P/cCXBcz45JOToyOK8Z
hiYMKS9N2CgG7kM5t3vWV74WbbFKgnD7mZ5EwlHNQkjEBNQNsof7Kx7lMwt3oof2
y0uxU8Dfj6n9e43LoZPcvbCqTgFvv6ViWWjXvxzcAZ+ym4UzE8UnF1KvMw1D9YqF
Icd7m710rjpgowX73FwzkDN3unvFnA==
=GEKf
-----END PGP SIGNATURE-----

--CbCUru5K6j0AFFIJDsMAJJcI6XXlcN6Ec--
