Received: from eggs.gnu.org ([2001:4830:134:3::10]:56471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZfbV-0007Nt-Su
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZfbS-0002Mu-JD
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:16:49 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:32861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cZfbS-0002ML-Cj
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:16:46 -0500
Received: by mail-wj0-x243.google.com with SMTP id le4so1163491wjb.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 07:16:46 -0800 (PST)
Date: Fri, 3 Feb 2017 15:16:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170203151643.GG642@stefanha-x1.localdomain>
References: <20170202171625.28502-1-rjones@redhat.com>
	<20170202171625.28502-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Content-Disposition: inline
In-Reply-To: <20170202171625.28502-2-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, den@openvz.org, rkagan@virtuozzo.com, dplotnikov@virtuozzo.com, berrange@redhat.com


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 05:16:25PM +0000, Richard W.M. Jones wrote:
> Socket activation (sometimes known as systemd socket activation)
> allows an Internet superserver to pass a pre-opened listening socket
> to the process, instead of having qemu-nbd open a socket itself.  This
> is done via the LISTEN_FDS and LISTEN_PID environment variables, and a
> standard file descriptor range.
>=20
> This change partially implements socket activation for qemu-nbd.  If
> the environment variables are set correctly, then socket activation
> will happen automatically, otherwise everything works as before.  The
> limitation is that LISTEN_FDS must be 1.
>=20
> Signed-off-by: Richard W.M. Jones.
> ---
>  qemu-nbd.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 163 insertions(+), 9 deletions(-)
>=20
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index c734f62..b3088d0 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -463,6 +463,135 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const cha=
r *id, Error **errp)
>      return creds;
>  }
> =20
> +static void setup_address_and_port(const char **address, const char **po=
rt)
> +{
> +    if (*address =3D=3D NULL) {
> +        *address =3D "0.0.0.0";
> +    }
> +
> +    if (*port =3D=3D NULL) {
> +        *port =3D g_strdup_printf("%d", NBD_DEFAULT_PORT);;

Please stringify NBD_DEFAULT_PORT instead of using g_strdup_printf().
That avoids the memory leak.

> @@ -751,6 +881,19 @@ int main(int argc, char **argv)
>      trace_init_file(trace_file);
>      qemu_set_log(LOG_TRACE);
> =20
> +    socket_activation =3D check_socket_activation();
> +    if (socket_activation =3D=3D 0) {
> +        setup_address_and_port(&bindto, &port);
> +    } else {
> +        /* Using socket activation - check user didn't use -p etc. */
> +        const char *err_msg =3D socket_activation_validate_opts(device, =
sockpath,
> +                                                              bindto, po=
rt);

Daemonizing is also incompatible with socket activation.  We've marked
the fds O_CLOEXEC so the child won't have access to them.  Please add an
error in case a user tries this.

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYlJ7bAAoJEJykq7OBq3PINWEIAK2ym1R0cKR2HafWBprjV4bj
y/RUYKbOvOqYzTBIiC1jR8gW9dqRS49ZDC416IKQnp8fiL4r2pc2X+RWRljQys3g
+q32vsqfq8alAItjm+39AdSn8teIGJ48sHLG83mayPlZc3EvODMPmr5f9U74Io9V
w8qu/X0Pfh6zB38dlDuoj+g25lOMPzzuUNqRwnUc8ljYiAfzlFKTfG3RxMF0m+eK
yExM0e06F9PqQqsfl56jokyNCZlDaumzn5zrGSaWIUB1DjTE9Xzy1o2O12kqY8eM
+8A4n1Q/odV3lwFrCjSJnAt17Ive5QQA2odwydMNNJJxwZaOn02ehNS1twpiZk4=
=RcBZ
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--
