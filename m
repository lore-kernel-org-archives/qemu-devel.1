Received: from eggs.gnu.org ([209.51.188.92]:52671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghQJm-0000NE-3p
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghQJl-0004uH-0Y
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:43:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ghQJj-0004q1-1I
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:43:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11105A9707
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 02:43:25 +0000 (UTC)
References: <20190110020259.8492-1-ehabkost@redhat.com>
	<20190110020259.8492-2-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <139331a6-f588-81eb-0104-83c814d74c7f@redhat.com>
Date: Wed, 9 Jan 2019 20:43:13 -0600
MIME-Version: 1.0
In-Reply-To: <20190110020259.8492-2-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tYSXmMnAtSaDBADBG9SByt6ATqCE22aLe"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qom: Don't keep error value between
 object_property_parse() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tYSXmMnAtSaDBADBG9SByt6ATqCE22aLe
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <139331a6-f588-81eb-0104-83c814d74c7f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qom: Don't keep error value between
 object_property_parse() calls
References: <20190110020259.8492-1-ehabkost@redhat.com>
 <20190110020259.8492-2-ehabkost@redhat.com>
In-Reply-To: <20190110020259.8492-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/9/19 8:02 PM, Eduardo Habkost wrote:
> When handling errp=3D=3DNULL at object_apply_global_props(), we are
> leaving the old error value in `err` after printing a warning.
> This makes QEMU crash if two global properties generate warnings:
>=20
>   $ echo device_add rtl8139 | qemu-system-x86_64 -monitor stdio -global=
 rtl8139.xxx=3Dyyy -global rtl8139.xxx=3Dzzz
>   warning: can't apply global rtl8139.xxx=3Dyyy: Property '.xxx' not fo=
und
>   qemu-system-x86_64: util/error.c:57: error_setv: Assertion `*errp =3D=
=3D NULL' failed.
>   Aborted (core dumped)
>=20
> Fix that by making `err` go out of scope immediately after the
> warn_report_err() call.
>=20
> Fixes: 50545b2cc029 "qdev-props: call object_apply_global_props()"
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qom/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qom/object.c b/qom/object.c
> index aa6f3a2a71..4e5226ca12 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -372,7 +372,6 @@ static void object_post_init_with_type(Object *obj,=
 TypeImpl *ti)
> =20
>  void object_apply_global_props(Object *obj, const GPtrArray *props, Er=
ror **errp)
>  {
> -    Error *err =3D NULL;

Could also have been fixed by leaving this line at this scope,...

>      int i;
> =20
>      if (!props) {
> @@ -381,6 +380,7 @@ void object_apply_global_props(Object *obj, const G=
PtrArray *props, Error **errp
> =20
>      for (i =3D 0; i < props->len; i++) {
>          GlobalProperty *p =3D g_ptr_array_index(props, i);
> +        Error *err =3D NULL;
> =20
>          if (object_dynamic_cast(obj, p->driver) =3D=3D NULL) {
>              continue;
>=20

=2E..and doing 'err =3D NULL;' after warn_report_err().  That is, it's no=
t
the going out of scope that fixes it per se, but the fact that you
changed to resetting it to NULL on each loop invocation rather than
leaving it pointing at freed memory.  Whether you set to NULL by a
tighter scope initializer or by an assignment doesn't matter, so no need
to respin since your way works.

Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--tYSXmMnAtSaDBADBG9SByt6ATqCE22aLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2sUEACgkQ3g5py3or
ov2eYQgAkkNy2W345HnNARDMaF+Cpc/rv0U0a/AmSwiEn3nP1f2AZ839Y490a52X
3NDaLKQQkvwB4CsVPWrHBLe3Bow6Cihsjpx/jrJMa9qH5Gp919crv0r5DCqRpHm5
CcUuLARL4TS6eThWwDDhS7EtFlqY2kv/mgAb2fRcKOi2h7AvhpWMULJ5QB0CSk0/
+3zXWCUGvVaNri83aUUbYdpGCu2EbyuAPPTTzHfRFQ/sb3Zez4qS6YpP5A+WAU6m
86A0WezMmXbTKsLD2PuWZHHAZL6nhVFUhC6pvWSvIKH13l1S3qK6UiaThR9qje3W
JpAOoU+wtCWmDL1SVJ0MWJq55C9g7w==
=t4Ub
-----END PGP SIGNATURE-----

--tYSXmMnAtSaDBADBG9SByt6ATqCE22aLe--
