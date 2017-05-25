Received: from eggs.gnu.org ([2001:4830:134:3::10]:46328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDtnQ-00057c-UY
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDtnP-0007oe-UT
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:31:24 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dDtnP-0007oS-IZ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:31:23 -0400
Received: by mail-lf0-x244.google.com with SMTP id h4so13547508lfj.3
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 07:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <1495198042-124203-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495198042-124203-6-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495198042-124203-6-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 25 May 2017 14:31:11 +0000
Message-ID: <CAJ+F1C+D4yF60uydo1Mv1cj7m+Q_oJEu6pWrdhXO3+ORf_CP6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/9] char: forbid direct chardevice
 access for hotswap devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com

On Fri, May 19, 2017 at 4:49 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
wrote:

> qemu_chr_fe_get_driver() is unsafe, frontends with hotswap support
> should not access CharDriver ptr directly as CharDriver might change.
>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>

I would move this patch up in the series, otherwise looks good


> ---
>  chardev/char.c        |  7 +++++++
>  include/sysemu/char.h | 10 ++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 0483f19..36d6f36 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -484,9 +484,16 @@ static Notifier muxes_realize_notify =3D {
>
>  Chardev *qemu_chr_fe_get_driver(CharBackend *be)
>  {
> +    /* this is unsafe for the users that support chardev hotswap */
> +    assert(be->chr_be_change =3D=3D NULL);
>      return be->chr;
>  }
>
> +bool qemu_chr_fe_backend_connected(CharBackend *be)
> +{
> +    return !!be->chr;
> +}
> +
>  static bool fe_connect(CharBackend *b, Chardev *s, Error **errp)
>  {
>      int tag =3D 0;
> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> index 92ae57e..fa21535 100644
> --- a/include/sysemu/char.h
> +++ b/include/sysemu/char.h
> @@ -404,10 +404,20 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s,
> Error **errp);
>   *
>   * Returns the driver associated with a CharBackend or NULL if no
>   * associated Chardev.
> + * Note: avoid this function as the driver should never be accessed
> directly,
> + *       especially by the frontends that support chardevice hotswap.
> + *       Consider qemu_chr_fe_backend_connected() to check for driver
> existence
>   */
>  Chardev *qemu_chr_fe_get_driver(CharBackend *be);
>
>  /**
> + * @qemu_chr_fe_backend_connected:
> + *
> + * Returns true if there is a chardevice associated with @be.
> + */
> +bool qemu_chr_fe_backend_connected(CharBackend *be);
> +
> +/**
>   * @qemu_chr_fe_deinit:
>   *
>   * Dissociate the CharBackend from the Chardev.
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
