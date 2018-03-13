Received: from eggs.gnu.org ([2001:4830:134:3::10]:39683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evoOk-0008Dk-7T
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evoOh-0006bZ-5i
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:11:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evoOh-0006bH-0n
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:11:39 -0400
Date: Tue, 13 Mar 2018 18:11:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180313181134.GD3784@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180312201305.16972-1-berrange@redhat.com>
	<20180312201305.16972-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312201305.16972-3-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 2/9] cutils: add qemu_strtoi & qemu_strtoui
 parsers for int/unsigned int types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Mar 12, 2018 at 08:12:58PM +0000, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> There are qemu_strtoNN functions for various sized integers. This adds =
two
> more for plain int & unsigned int types, with suitable range checking.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> diff --git a/util/cutils.c b/util/cutils.c
> index b33ede83d1..774d5f7362 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> +int qemu_strtoui(const char *nptr, const char **endptr, int base,
> +                 unsigned int *result)
> +{
> +    char *ep;
> +    long lresult;
> +
> +    if (!nptr) {
> +        if (endptr) {
> +            *endptr =3D nptr;
> +        }
> +        return -EINVAL;
> +    }
> +
> +    errno =3D 0;
> +    lresult =3D strtoul(nptr, &ep, base);

The test failure on 32-bit is caused by use of strtoul instead
of strtoull here, so I'll just switch them, so the logic that
follows below actually works on 32-bit.

> +    /* Windows returns 1 for negative out-of-range values.  */
> +    if (errno =3D=3D ERANGE) {
> +        *result =3D -1;
> +    } else {
> +        if (lresult > UINT_MAX) {
> +            *result =3D UINT_MAX;
> +            errno =3D ERANGE;
> +        } else if (lresult < INT_MIN) {
> +            *result =3D UINT_MAX;
> +            errno =3D ERANGE;
> +        } else {
> +            *result =3D lresult;
> +        }
> +    }
> +    return check_strtox_error(nptr, ep, endptr, errno);
> +}
> +
>  /**
>   * Convert string @nptr to a long integer, and store it in @result.
>   *
> --=20
> 2.14.3
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
