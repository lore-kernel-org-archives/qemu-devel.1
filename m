Received: from eggs.gnu.org ([2001:4830:134:3::10]:46539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cg5ru-0006XN-KN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cg5rr-00049p-DN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:32:18 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:40969)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cg5rr-00048d-50
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:32:15 -0500
Date: Tue, 21 Feb 2017 03:32:04 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <910332417.8403823.1487665924940.JavaMail.zimbra@redhat.com>
In-Reply-To: <1487665107-88004-1-git-send-email-liqiang6-s@360.cn>
References: <1487665107-88004-1-git-send-email-liqiang6-s@360.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] spice-char: fix segfault in
 char_spice_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, marcandre lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>

Hi

----- Original Message -----
> In 'qemu_chr_open_spice_vmc' if the 'psubtype' is NULL, it will
> call 'char_spice_finalize'. But as the SpiceChardev is not inserted
> in the 'spice_chars' list, the 'QLIST_REMOVE' will cause a segfault.
> Add a detect to avoid it.
>=20
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  spice-qemu-char.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/spice-qemu-char.c b/spice-qemu-char.c
> index 6f46f46..4d1c76e 100644
> --- a/spice-qemu-char.c
> +++ b/spice-qemu-char.c
> @@ -215,7 +215,10 @@ static void char_spice_finalize(Object *obj)
>      SpiceChardev *s =3D SPICE_CHARDEV(obj);
> =20
>      vmc_unregister_interface(s);
> -    QLIST_REMOVE(s, next);
> +
> +    if (s->next.le_prev) {
> +        QLIST_REMOVE(s, next);
> +    }
> =20
>      g_free((char *)s->sin.subtype);
>  #if SPICE_SERVER_VERSION >=3D 0x000c02
> --
> 1.8.3.1
>=20
>=20
