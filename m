Received: from eggs.gnu.org ([2001:4830:134:3::10]:40160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1xkK-00017Z-4X
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1xkH-0004uG-1n
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:51:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e1xkG-0004t8-Ob
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:51:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E544E3B9
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:51:02 +0000 (UTC)
References: <20171010154328.8419-1-berrange@redhat.com>
	<20171010154328.8419-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <931753df-dfb4-906f-0991-b075da984469@redhat.com>
Date: Tue, 10 Oct 2017 11:51:00 -0500
MIME-Version: 1.0
In-Reply-To: <20171010154328.8419-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UTPxo1411xFAlKFE78KgiwOhRUdlOJSkJ"
Subject: Re: [Qemu-devel] [PATCH v1 1/7] io: monitor encoutput buffer size
 from websocket GSource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UTPxo1411xFAlKFE78KgiwOhRUdlOJSkJ
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <931753df-dfb4-906f-0991-b075da984469@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/7] io: monitor encoutput buffer size
 from websocket GSource
References: <20171010154328.8419-1-berrange@redhat.com>
 <20171010154328.8419-2-berrange@redhat.com>
In-Reply-To: <20171010154328.8419-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 10:43 AM, Daniel P. Berrange wrote:
> The websocket GSource is monitoring the size of the rawoutput
> buffer to determine if the channel can accepts more writes.
> The rawoutput buffer, however, is merely a temporary staging
> buffer before data is copied into the encoutput buffer. This

s/This/Thus/

> its size will always be zero when the GSource runs.
>=20
> This flaw causes the encoutput buffer to grow without bound
> if the other end of the underlying data channel doesn't
> read data being sent. This can be seen with VNC if a client
> is on a slow WAN link and the guest OS is sending many screen
> updates. A malicious VNC client can act like it is on a slow
> link by playing a video in the guest and then reading data
> very slowly, causing QEMU host memory to expand arbitrarily.
>=20
> This issue is assigned CVE-2017-????, publically reported in

If we get the assignment in time, I'm sure you'll update this before the
PULL request.

>=20
>   https://bugs.launchpad.net/qemu/+bug/1718964
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index d1d471f86e..04bcc059cd 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -28,7 +28,7 @@
>  #include <time.h>
> =20
> =20
> -/* Max amount to allow in rawinput/rawoutput buffers */
> +/* Max amount to allow in rawinput/encoutput buffers */
>  #define QIO_CHANNEL_WEBSOCK_MAX_BUFFER 8192
> =20
>  #define QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN 24
> @@ -1208,7 +1208,7 @@ qio_channel_websock_source_check(GSource *source)=

>      if (wsource->wioc->rawinput.offset || wsource->wioc->io_eof) {
>          cond |=3D G_IO_IN;
>      }
> -    if (wsource->wioc->rawoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFF=
ER) {
> +    if (wsource->wioc->encoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFF=
ER) {
>          cond |=3D G_IO_OUT;
>      }
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UTPxo1411xFAlKFE78KgiwOhRUdlOJSkJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnc+nQACgkQp6FrSiUn
Q2rOMgf8CXWF6mSJlL3Sjfvxd/NBu+uwqgE5iejPsD+nmePbXY2NaPj1m7hROrub
1yzBDlx2b1dV6Y2l5o3H9Cp8j92S104HsB9KYNsew3UXULh8ng+VJWGyNl0Bk7YS
BlmXzkDMF1SAnoPthNPifCll32DddGqs9CrbtaInREY1FhLZs0lZ4FwLqmsPAaKD
mWZEFVRZ7d9daYz0+6uoBvREzOawoj7oYnNLM8JRUrU2mM11d5gc5gVOXXNYEhI5
NNZfZwdLDRRQB6GhM5mQ0nxaKmFOrJBgIgevrZRianLIFSuXOAw6lyAkMjpHlJ3Z
R63I9y4anL2XEJ781KCw2w9imVldGw==
=ppsI
-----END PGP SIGNATURE-----

--UTPxo1411xFAlKFE78KgiwOhRUdlOJSkJ--
