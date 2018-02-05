Received: from eggs.gnu.org ([2001:4830:134:3::10]:48035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eima6-0003uy-9v
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eima3-0003Sa-4n
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:37:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eima2-0003S7-Sr
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:37:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24F7B28206
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 19:37:30 +0000 (UTC)
References: <20180205152455.12088-1-berrange@redhat.com>
	<20180205152455.12088-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ab20df7-a6fe-7dca-d6c3-f3ab33f78550@redhat.com>
Date: Mon, 5 Feb 2018 13:37:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180205152455.12088-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/9] cutils: add qemu_strtoi &
 qemu_strtoui parsers for int/unsigned int types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 02/05/2018 09:24 AM, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> There are qemu_strtoNN functions for various sized integers. This adds =
two
> more for plain int & unsigned int types, with suitable range checking.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> +++ b/util/cutils.c
> @@ -297,6 +297,110 @@ static int check_strtox_error(const char *nptr, c=
har *ep,
>       return -libc_errno;
>   }
>  =20
> +/**
> + * Convert string @nptr to a long integer, and store it in @result.

s/a long/an/

> + */
> +int qemu_strtoi(const char *nptr, const char **endptr, int base,
> +                int *result)
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
> +    lresult =3D strtol(nptr, &ep, base);
> +    if (lresult < INT_MIN) {
> +        *result =3D INT_MIN;
> +    } else if (lresult > INT_MAX) {
> +        *result =3D INT_MAX;

On 64-bit platforms, this clamps the result, but does not set errno, for=20
values beyond int but still within the range of long.  Which is=20
different than what it does on 32-bit platforms.  Gross.  The testsuite=20
is missing coverage of this, which ideally would be the same behavior=20
(setting errno=3DERANGE) on both platforms.

> +    } else {
> +        *result =3D lresult;
> +    }
> +    return check_strtox_error(nptr, ep, endptr, errno);
> +}
> +
> +/**
> + * Convert string @nptr to an unsigned int, and store it in @result.

> + * Note that a number with a leading minus sign gets converted without
> + * the minus sign, checked for overflow (see above), then negated (in
> + * @result's type).  This is exactly how strtoul() works.
> + */
> +int qemu_strtoui(const char *nptr, const char **endptr, int base,
> +                 unsigned int *result)
> +{

> +
> +    errno =3D 0;
> +    lresult =3D strtol(nptr, &ep, base);
> +    /* Windows returns 1 for negative out-of-range values.  */
> +    if (errno =3D=3D ERANGE) {
> +        *result =3D -1;
> +    } else {
> +        if (lresult > UINT_MAX) {
> +            *result =3D UINT_MAX;
> +        } else if (lresult < INT_MIN) {
> +            *result =3D UINT_MAX;

Again, an unfortunate difference between 32- and 64-bit platforms on=20
whether errno is set.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
