Received: from eggs.gnu.org ([2001:4830:134:3::10]:51556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg6Bf-0004Zv-He
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg6Be-0001VB-HF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:52:43 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cg6Be-0001Uq-6M
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:52:42 -0500
Received: by mail-lf0-x244.google.com with SMTP id 90so3013989lfr.3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 00:52:41 -0800 (PST)
MIME-Version: 1.0
References: <1487663858-11731-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487663858-11731-1-git-send-email-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Feb 2017 08:52:29 +0000
Message-ID: <CAJ+F1CLK3aPi+aDgHGUjCCF2Xbi1V=g5UjM_BAko_PSfau33KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spice: add display & head options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Hi

On Tue, Feb 21, 2017 at 11:58 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> This allows to specify display and head to use, simliar to vnc.
>
>
Does "head" in qemu always match the head for multi-monitor spice? (with a
single qxl/virtio). I don't clearly understand the relation, I would need
to do some research.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/spice-core.c    |  6 ++++++
>  ui/spice-display.c | 22 +++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index d613f1a..e18ad77 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -498,6 +498,12 @@ static QemuOptsList qemu_spice_opts =3D {
>          },{
>              .name =3D "seamless-migration",
>              .type =3D QEMU_OPT_BOOL,
> +        },{
> +            .name =3D "display",
> +            .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "head",
> +            .type =3D QEMU_OPT_NUMBER,
>  #ifdef HAVE_SPICE_GL
>          },{
>              .name =3D "gl",
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 64e472e..9c58e5a 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -1029,9 +1029,26 @@ static void qemu_spice_display_init_one(QemuConsol=
e
> *con)
>
>  void qemu_spice_display_init(void)
>  {
> -    QemuConsole *con;
> +    QemuOptsList *olist =3D qemu_find_opts("spice");
> +    QemuOpts *opts =3D QTAILQ_FIRST(&olist->head);
> +    QemuConsole *spice_con, *con;
> +    const char *str;
>      int i;
>
> +    str =3D qemu_opt_get(opts, "display");
> +    if (str) {
> +        int head =3D qemu_opt_get_number(opts, "head", 0);
> +        Error *err =3D NULL;
> +
> +        spice_con =3D qemu_console_lookup_by_device_name(str, head, &err=
);
> +        if (err) {
> +            error_report("Failed to lookup display/head");
> +            exit(1);
> +        }
> +    } else {
> +        spice_con =3D NULL;
> +    }
> +
>      for (i =3D 0;; i++) {
>          con =3D qemu_console_lookup_by_index(i);
>          if (!con || !qemu_console_is_graphic(con)) {
> @@ -1040,6 +1057,9 @@ void qemu_spice_display_init(void)
>          if (qemu_spice_have_display_interface(con)) {
>              continue;
>          }
> +        if (spice_con !=3D NULL && spice_con !=3D con) {
> +            continue;
> +        }
>          qemu_spice_display_init_one(con);
>      }
>  }
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
