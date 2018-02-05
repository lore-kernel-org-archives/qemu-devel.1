Received: from eggs.gnu.org ([2001:4830:134:3::10]:41197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eigMA-0007zl-Sh
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eigM6-0006JY-1a
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:58:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15717)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eigM5-0006Hk-SR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:58:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3A6B7E42C
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 12:58:40 +0000 (UTC)
References: <20180205114938.15784-1-berrange@redhat.com>
	<20180205114938.15784-3-berrange@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <90f9d802-89ed-cc18-6541-9a7f81c54b07@redhat.com>
Date: Mon, 5 Feb 2018 13:58:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180205114938.15784-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] ui: avoid 'local_err' variable
 shadowing in VNC SASL auth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 02/05/18 12:49, Daniel P. Berrang=C3=A9 wrote:
> The start_auth_sasl() method declares a 'Error *local_err' variable in
> an inner if () {...} scope, which shadows a variable of the same name
> declared at the start of the method. This is confusing for reviewers an=
d
> may trigger compiler warnings.
>=20
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  ui/vnc-auth-sasl.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
> index fbccca8c8a..8ebd0d3d00 100644
> --- a/ui/vnc-auth-sasl.c
> +++ b/ui/vnc-auth-sasl.c
> @@ -556,7 +556,6 @@ void start_auth_sasl(VncState *vs)
>      /* Inform SASL that we've got an external SSF layer from TLS/x509 =
*/
>      if (vs->auth =3D=3D VNC_AUTH_VENCRYPT &&
>          vs->subauth =3D=3D VNC_AUTH_VENCRYPT_X509SASL) {
> -        Error *local_err =3D NULL;
>          int keysize;
>          sasl_ssf_t ssf;
> =20
> @@ -565,7 +564,6 @@ void start_auth_sasl(VncState *vs)
>          if (keysize < 0) {
>              trace_vnc_auth_fail(vs, vs->auth, "cannot TLS get cipher s=
ize",
>                                  error_get_pretty(local_err));
> -            error_free(local_err);
>              sasl_dispose(&vs->sasl.conn);
>              vs->sasl.conn =3D NULL;
>              goto authabort;
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
