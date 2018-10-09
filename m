Received: from eggs.gnu.org ([2001:4830:134:3::10]:54206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9qT4-0001uN-7u
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9qT2-0006UL-8U
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:46:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9qT0-0006SM-8s
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:46:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id a8-v6so1612409wmf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 04:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-28-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-28-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 15:46:07 +0400
Message-ID: <CAJ+F1C+0vmgrF5wMhmU_b1KzGm9P4zkCsbMqePAFNWL+WPOVPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 27/31] spice: Clean up error reporting in
 add_channel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Mon, Oct 8, 2018 at 9:43 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  add_channel() does that, and then exit()s.  Its caller
> main(), via qemu_opts_foreach(), is fine with it, but clean it up
> anyway.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/spice-core.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index a4fbbc3898..ebaae24643 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -597,9 +597,9 @@ static int add_channel(void *opaque, const char *name=
, const char *value,
>      if (strcmp(name, "tls-channel") =3D=3D 0) {
>          int *tls_port =3D opaque;
>          if (!*tls_port) {
> -            error_report("spice: tried to setup tls-channel"
> -                         " without specifying a TLS port");
> -            exit(1);
> +            error_setg(errp, "spice: tried to setup tls-channel"
> +                       " without specifying a TLS port");
> +            return -1;
>          }
>          security =3D SPICE_CHANNEL_SECURITY_SSL;
>      }
> @@ -615,8 +615,9 @@ static int add_channel(void *opaque, const char *name=
, const char *value,
>          rc =3D spice_server_set_channel_security(spice_server, value, se=
curity);
>      }
>      if (rc !=3D 0) {
> -        error_report("spice: failed to set channel security for %s", val=
ue);
> -        exit(1);
> +        error_setg(errp, "spice: failed to set channel security for %s",
> +                   value);
> +        return -1;
>      }
>      return 0;
>  }
> @@ -787,7 +788,7 @@ void qemu_spice_init(void)
>      spice_server_set_playback_compression
>          (spice_server, qemu_opt_get_bool(opts, "playback-compression", 1=
));
>
> -    qemu_opt_foreach(opts, add_channel, &tls_port, NULL);
> +    qemu_opt_foreach(opts, add_channel, &tls_port, &error_fatal);
>
>      spice_server_set_name(spice_server, qemu_name);
>      spice_server_set_uuid(spice_server, (unsigned char *)&qemu_uuid);
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
