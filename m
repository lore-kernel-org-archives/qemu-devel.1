Received: from eggs.gnu.org ([2001:4830:134:3::10]:32969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePALA-0006it-Qq
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePAL7-0007eX-Jq
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:57:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePAL7-0007e0-BB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:57:01 -0500
Date: Wed, 13 Dec 2017 16:56:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213165651.GB8317@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-12-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-12-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 11/26] qmp: introduce QMPCapability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:45PM +0800, Peter Xu wrote:
> There was no QMP capabilities defined.  Define the first "oob" as
> capability to allow out-of-band messages.
>=20
> Also, touch up qmp-test.c to test the new bits.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c        | 15 +++++++++++++--
>  qapi-schema.json | 13 +++++++++++++
>  tests/qmp-test.c | 10 +++++++++-
>  3 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index e8f5a586e4..bad6ee8dd1 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3944,12 +3944,23 @@ void monitor_resume(Monitor *mon)
> =20
>  static QObject *get_qmp_greeting(void)
>  {
> +    QDict *result =3D qdict_new(), *qmp =3D qdict_new();
> +    QList *cap_list =3D qlist_new();
>      QObject *ver =3D NULL;
> +    QMPCapability cap;
> +
> +    qdict_put(result, "QMP", qmp);
> =20
>      qmp_marshal_query_version(NULL, &ver, NULL);
> +    qdict_put_obj(qmp, "version", ver);
> +
> +    for (cap =3D 0; cap < QMP_CAPABILITY__MAX; cap++) {
> +        qlist_append(cap_list, qstring_from_str(
> +                         QMPCapability_str(cap)));
> +    }
> +    qdict_put(qmp, "capabilities", cap_list);
> =20
> -    return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': [=
]}}",
> -                              ver);
> +    return QOBJECT(result);
>  }

Why did you replace qobject_from_jsonf() with manual qdict_*() calls?

I was expecting this (it's shorter and easier to read):

  static QObject *get_qmp_greeting(void)
  {
      QList *cap_list =3D qlist_new();
      QObject *ver =3D NULL;
      QMPCapability cap;

      qmp_marshal_query_version(NULL, &ver, NULL);

      for (cap =3D 0; cap < QMP_CAPABILITY__MAX; cap++) {
          qlist_append(cap_list, qstring_from_str(
                           QMPCapability_str(cap)));
      }

      return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': %p=
}}",
                                ver, cap);
  }

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMVvTAAoJEJykq7OBq3PIE7YH/3YxsAdRpPcBlKU4GPDXnujR
7lI57qEjK2Sirj9HQq4lKYZ6+cJ3Y3eepb9YQY3LjTWyEx1y1jUlBVlNfMKXbNQz
f7M2PBvBrl/pkpntxe/JXiWQGnMPdbME/qhTOV2lz6vrVXf+4dCThwlJIBrHsvKs
u8+OnjirrAzvcx48rUKff4Ny8Yp+gDgT+C9CFOAgW4qTdyG+z61VWvJM3Eefm9ch
aOrgi3pH7SdC8a4IgYXYinAHDkMuin96MLCOmgbKt43pzFLwCtnjPQRu8U+xnVG6
L6nN9tiLZLzKMW68qpJNg46Ji7/Ks8N+WWYZFIn0DJajQY00QrzJc2STC5bKNT8=
=nf87
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
