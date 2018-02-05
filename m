Received: from eggs.gnu.org ([2001:4830:134:3::10]:45911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimVb-0007hZ-0L
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimVX-0006nB-37
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:32:55 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimVW-0006mz-Tw
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:32:51 -0500
Received: by mail-qk0-x242.google.com with SMTP id c82so6107247qka.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:32:50 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180205114938.15784-1-berrange@redhat.com>
	<20180205114938.15784-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <68b85f53-5bc0-454d-239a-af4ea1c9c9c9@amsat.org>
Date: Mon, 5 Feb 2018 16:32:46 -0300
MIME-Version: 1.0
In-Reply-To: <20180205114938.15784-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="HUn4rE6x4pB7HRHpOm1YWmeENtAa137SB"
Subject: Re: [Qemu-devel] [PATCH 1/4] ui: avoid risk of 32-bit int overflow
 in VNC buffer check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HUn4rE6x4pB7HRHpOm1YWmeENtAa137SB
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <68b85f53-5bc0-454d-239a-af4ea1c9c9c9@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 1/4] ui: avoid risk of 32-bit int overflow in
 VNC buffer check
References: <20180205114938.15784-1-berrange@redhat.com>
 <20180205114938.15784-2-berrange@redhat.com>
In-Reply-To: <20180205114938.15784-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2018 08:49 AM, Daniel P. Berrang=C3=A9 wrote:
> For very large framebuffers, it is theoretically possible for the resul=
t
> of 'vs->throttle_output_offset * VNC_THROTTLE_OUTPUT_LIMIT_SCALE' to
> exceed the size of a 32-bit int. For this to happen in practice, the
> video RAM would have to be set to a large enough value, which is not
> likely today. None the less we can be paranoid against future growth by=

> using division instead of multiplication when checking the limits.
>=20
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  ui/vnc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 93731accb6..e14e524764 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1572,8 +1572,8 @@ void vnc_write(VncState *vs, const void *data, si=
ze_t len)
>       * handshake, or from the job thread's VncState clone
>       */
>      if (vs->throttle_output_offset !=3D 0 &&
> -        vs->output.offset > (vs->throttle_output_offset *
> -                             VNC_THROTTLE_OUTPUT_LIMIT_SCALE)) {
> +        (vs->output.offset / VNC_THROTTLE_OUTPUT_LIMIT_SCALE) >
> +        vs->throttle_output_offset) {
>          trace_vnc_client_output_limit(vs, vs->ioc, vs->output.offset,
>                                        vs->throttle_output_offset);
>          vnc_disconnect_start(vs);
>=20


--HUn4rE6x4pB7HRHpOm1YWmeENtAa137SB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp4sV8ACgkQ4+MsLN6t
wN5+Cg/6Al2C1k7BcC+jDvaAyTHWkwskTUPPL+KA8LwxntpCUqJ5MgExIn5+yNFC
tplBlIGU40d/3unRJrrbqWw+YxtdrFSSD0s2cZncGuq4rAtRvC9UEq8xJLJDydPk
20mQwd1Hviw/lEAmG/gWIb8VJZQn4I3zVkMqmQYu2LVZEXnIS03icFvhhVC62mHc
2ikT0fs8mUAi0BQLbharvYjjMJlALiReDPKokqcESvEJPhrHoYtA8WsuGQhfP/62
5pPjwR9w03m/wFOW42nUolLsyf7NC9n1ta54zeD+/T/p53CKytMPHRZhtbWsahhE
+f5sdZYpyuqYmgEydLdSguesN+pVxlfZcHw7dsPD8oNN33RKJYQMkdCws7y3hZtY
saE0gaRjeCh7TlwbuG/inmnRV5RtCutqLZLDC+zazyig/c86nR7I4vCeNGf8+R1M
+irkbN4SaCAt5CNlYdbM81A8HOLq3rq0Zn9NDc/+ItGDNoslYqnvy4rKYd6n8XWi
wO6TvY5iH/MoaO43FY3x68I82yNY/AK0TZMJEWZFF7tPd11dr4XvkOyg7PDtnrHV
uGQ4xopbJJ5fdZ+c8qNpUulhQ6BwP5RIj7nqAfw+FrsMEzlHffgWipPONMkZftKn
w7jbtNuU/PID2FTPVMteYLBQlzLqVXzAPQTfNP8sXVsnZlc0uzE=
=A84Y
-----END PGP SIGNATURE-----

--HUn4rE6x4pB7HRHpOm1YWmeENtAa137SB--
