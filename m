Received: from eggs.gnu.org ([2001:4830:134:3::10]:42547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG6Jc-00015q-KT
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG6JZ-0003dQ-FV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:17:44 -0400
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:49942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dG6JZ-0003bu-7t
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:17:41 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C903BFEFA9
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 18:17:38 +0200 (CEST)
Date: Wed, 31 May 2017 18:17:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170531181732.13140426@bahia.lan>
In-Reply-To: <20170531150933.10156-3-alex.bennee@linaro.org>
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/mpAmL8n1AGnqR92A2x7RqaW";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com, qemu-devel@nongnu.org

--Sig_/mpAmL8n1AGnqR92A2x7RqaW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 May 2017 16:09:33 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> The thread-id of 0 means any CPU but we then ignore the fact we find
> the first_cpu in this case who can have an index of 0. Instead of

The index can never be 0 in system mode actually, but you're right that this
check doesn't make sense.

The code still looks a bit convoluted IMHO. What about something like the
following ?

            /* 0 means any thread, so we pick the first valid CPU */
            cpu =3D tmp ? find_cpu(tmp) : first_cpu;

            /* invalid CPU/thread specified */
            if (!cpu) {
                res =3D -EINVAL;
                goto out;
            }

Anyway, the fix looks ok.

Reviewed-by: Greg Kurz <groug@kaod.org>

> bailing out just test if we have managed to match up thread-id to a
> CPU.
>=20
> Otherwise you get:
>   gdb_handle_packet: command=3D'vCont;C04:0;c'
>   put_packet: reply=3D'E22'
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index a249846954..29c9ed3002 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -934,8 +934,8 @@ static int gdb_handle_vcont(GDBState *s, const char *=
p)
>               * CPU first, and only then we can use its index.
>               */
>              cpu =3D find_cpu(idx);
> -            /* invalid CPU/thread specified */
> -            if (!idx || !cpu) {
> +            /* invalid thread specified, cpu not found. */
> +            if (!cpu) {
>                  res =3D -EINVAL;
>                  goto out;
>              }


--Sig_/mpAmL8n1AGnqR92A2x7RqaW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlku7JwACgkQAvw66wEB28Jy+wCfZFJv8K60qKUz5ruD26ZXeJ59
P6oAn2iOTWqxUpdgX0pfBIrqq4r+CMJZ
=weAe
-----END PGP SIGNATURE-----

--Sig_/mpAmL8n1AGnqR92A2x7RqaW--
