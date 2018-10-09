Received: from eggs.gnu.org ([2001:4830:134:3::10]:48115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9q5b-0002sS-NO
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9q5a-0004W7-Q1
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:22:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9q5a-0004VV-4d
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:22:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id y11-v6so1462399wma.3
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 04:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-22-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-22-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 15:21:56 +0400
Message-ID: <CAJ+F1CKfBX164VOYkzSe2camprR05n05urRTJfZ-b4687O=_7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 21/31] vl: Clean up error reporting in
 mon_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Oct 8, 2018 at 9:37 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  mon_init_func() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 3adc9dbe4f..1009d708a0 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2270,8 +2270,8 @@ static int mon_init_func(void *opaque, QemuOpts *op=
ts, Error **errp)
>      } else if (strcmp(mode, "control") =3D=3D 0) {
>          flags =3D MONITOR_USE_CONTROL;
>      } else {
> -        error_report("unknown monitor mode \"%s\"", mode);
> -        exit(1);
> +        error_setg(errp, "unknown monitor mode \"%s\"", mode);
> +        return -1;
>      }
>
>      if (qemu_opt_get_bool(opts, "pretty", 0))
> @@ -2285,8 +2285,8 @@ static int mon_init_func(void *opaque, QemuOpts *op=
ts, Error **errp)
>      chardev =3D qemu_opt_get(opts, "chardev");
>      chr =3D qemu_chr_find(chardev);
>      if (chr =3D=3D NULL) {
> -        error_report("chardev \"%s\" not found", chardev);
> -        exit(1);
> +        error_setg(errp, "chardev \"%s\" not found", chardev);
> +        return -1;
>      }
>
>      monitor_init(chr, flags);
> @@ -4365,10 +4365,8 @@ int main(int argc, char **argv, char **envp)
>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>
> -    if (qemu_opts_foreach(qemu_find_opts("mon"),
> -                          mon_init_func, NULL, NULL)) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("mon"),
> +                      mon_init_func, NULL, &error_fatal);
>
>      if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
>          exit(1);
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
