Received: from eggs.gnu.org ([209.51.188.92]:40942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glX5b-0002IG-7i
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1glX5T-0004Mg-Jy
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:45:53 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1glX5Q-0004Jh-Fu
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:45:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so22773080wrr.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 02:45:47 -0800 (PST)
Date: Mon, 21 Jan 2019 10:45:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190121104545.GE30536@stefanha-x1.localdomain>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <20190118173103.4903-2-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] display: ensure qxl log_buf is a
 nul terminated string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 05:31:00PM +0000, Daniel P. Berrang=E9 wrote:
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 8e9a65e75b..eefdf4baac 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -1763,7 +1763,8 @@ async_common:
>          qxl_set_mode(d, val, 0);
>          break;
>      case QXL_IO_LOG:
> -        trace_qxl_io_log(d->id, d->ram->log_buf);
> +        d->ram->log_buf[sizeof(d->ram->log_buf) - 1] =3D '\0';
> +        trace_qxl_io_log(d->id, (const char *)d->ram->log_buf);

This is a PCI BAR shared with the guest?  Then NUL termination is
subject to races with vcpu threads that modify log_buf[] while we access
it.

The safe way to do this is to copy in log_buf[] and then NUL-terminate
the local copy.

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcRaLZAAoJEJykq7OBq3PI9iYH/14hpWg2CFNxtv31923hwkEm
AzRvupFD9lEe21xziqsvFnOB0RNfM8fJYE4+r4h6K0nOG9cNE+rQNO9bl0YNi9d+
O1AMaRlIHqJybFpwD/1SGVeW9mjwc5vxFD6Zi2XZyd57cfOIiZfMJunptJM2QT3o
aukl2DRB+GhjVquDsinrGCU0mUm910XzLssxikAyZV3PKbYUW9GJ9hpj1j/eXIx2
I90iKn+7OwxKQwLQhT3pwZhbXu1dH3V91FcAML3zla6X7bIwLCl3QUnRtNOHuwOI
tYoeH1E6QNZGxQl939I85Yc3hIX3WCFdtv2Wmq9C1gmt8+qzEpHaHgziw3guwvA=
=eK+9
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
