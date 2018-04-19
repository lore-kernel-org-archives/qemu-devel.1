Received: from eggs.gnu.org ([2001:4830:134:3::10]:42079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9BYQ-0000wE-LN
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9BYL-0006nI-2r
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:32:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48658 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9BYK-0006mz-St
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:32:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 542C27B4A7
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:32:49 +0000 (UTC)
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-5-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9254b6df-8840-183c-8854-0dfd892f11ad@redhat.com>
Date: Thu, 19 Apr 2018 10:32:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180419150145.24795-5-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xnrm8XZutaRelsRUC6cLu4Z671NVATlh2"
Subject: Re: [Qemu-devel] [PATCH v6 4/5] qobject: modify qobject_ref() to
 return obj
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xnrm8XZutaRelsRUC6cLu4Z671NVATlh2
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com
Message-ID: <9254b6df-8840-183c-8854-0dfd892f11ad@redhat.com>
Subject: Re: [PATCH v6 4/5] qobject: modify qobject_ref() to return obj
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
 <20180419150145.24795-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180419150145.24795-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
> For convenience and clarity, make it possible to call qobject_ref() at
> the time when the reference is associated with a variable, or
> argument, by making qobject_ref() return the same pointer as given.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

You've made some substantial changes to the macro, I would have dropped
R-b to ensure those changes get reviewed.  In particular,

> ---

> +++ b/include/qapi/qmp/qobject.h
> @@ -72,11 +72,12 @@ static inline void qobject_init(QObject *obj, QType=
 type)
>      obj->base.type =3D type;
>  }
> =20
> -static inline void qobject_ref_impl(QObject *obj)
> +static inline void *qobject_ref_impl(QObject *obj)
>  {
>      if (obj) {
>          obj->base.refcnt++;
>      }
> +    return obj;

This hunk is now useless,

> @@ -103,8 +104,15 @@ static inline void qobject_unref_impl(QObject *obj=
)
> =20
>  /**
>   * qobject_ref(): Increment QObject's reference count
> + *
> + * Returns: the same @obj. The type of @obj will be propagated to the
> + * return type.
>   */
> -#define qobject_ref(obj) qobject_ref_impl(QOBJECT(obj))
> +#define qobject_ref(obj) ({                     \
> +    typeof(obj) _o =3D (obj);                     \
> +    qobject_ref_impl(QOBJECT(_o));              \
> +    _o;                                         \

since nothing ever uses the return value.

But that said, I'm still okay with R-b with or without the useless hunk.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Xnrm8XZutaRelsRUC6cLu4Z671NVATlh2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrYtpkACgkQp6FrSiUn
Q2r//Af9G0p/BeV9y5F9qz2OTVc3baIywodhPEKhiS/SH0Vm41b26X4mhglEzV2Q
kZ22Ur/D+j+NNkvqM7AdKf4nZL0DqQVTrwj8SMG0vLrPXjOhuORB8PzFd/I1ZtPc
VDeTND1Vil6OLy9rWyHifPlvF4AvAaVQng4WLNbcF6JBR2sP1gK1wPEn+NKYINN7
wv3VHMHRK6GfCMn+hVHYw4gC8/dHG/olx3fQjUk7PYAPypFF+k1L5ZF6PgcVWEVf
FdGzcsK9NeFcwSgVvI9hxduEKnuWemsn25TF+ydlKheUIxDPcXJcGK8DJAxDWRhr
d1FQ3t5BjHhq4DSK2KQ1x91M/hljQg==
=m3Fu
-----END PGP SIGNATURE-----

--Xnrm8XZutaRelsRUC6cLu4Z671NVATlh2--
