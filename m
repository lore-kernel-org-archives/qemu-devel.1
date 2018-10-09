Received: from eggs.gnu.org ([2001:4830:134:3::10]:58325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9ozK-000120-Di
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9ozJ-0007jn-JD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:11:38 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9ozJ-0007ix-9D
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 06:11:37 -0400
Received: by mail-wm1-x342.google.com with SMTP id y11-v6so1245158wma.3
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 03:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-18-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-18-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 14:11:22 +0400
Message-ID: <CAJ+F1CLdgo=qwex-2wQUc5+Ov7dmunj7gCwrsCOWOuPBiVJDjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/31] vl: Clean up error reporting in
 parse_add_fd()
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

On Mon, Oct 8, 2018 at 9:44 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  parse_add_fd() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
>
> Also change call of cleanup_add_fd(), which can't fail, for symmetry.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 485c3fc008..7ce8299d9d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1059,12 +1059,12 @@ static int parse_add_fd(void *opaque, QemuOpts *o=
pts, Error **errp)
>      fd_opaque =3D qemu_opt_get(opts, "opaque");
>
>      if (fd < 0) {
> -        error_report("fd option is required and must be non-negative");
> +        error_setg(errp, "fd option is required and must be non-negative=
");
>          return -1;
>      }
>
>      if (fd <=3D STDERR_FILENO) {
> -        error_report("fd cannot be a standard I/O stream");
> +        error_setg(errp, "fd cannot be a standard I/O stream");
>          return -1;
>      }
>
> @@ -1074,12 +1074,12 @@ static int parse_add_fd(void *opaque, QemuOpts *o=
pts, Error **errp)
>       */
>      flags =3D fcntl(fd, F_GETFD);
>      if (flags =3D=3D -1 || (flags & FD_CLOEXEC)) {
> -        error_report("fd is not valid or already in use");
> +        error_setg(errp, "fd is not valid or already in use");
>          return -1;
>      }
>
>      if (fdset_id < 0) {
> -        error_report("set option is required and must be non-negative");
> +        error_setg(errp, "set option is required and must be non-negativ=
e");
>          return -1;
>      }
>
> @@ -1092,7 +1092,7 @@ static int parse_add_fd(void *opaque, QemuOpts *opt=
s, Error **errp)
>      }
>  #endif
>      if (dupfd =3D=3D -1) {
> -        error_report("error duplicating fd: %s", strerror(errno));
> +        error_setg(errp, "error duplicating fd: %s", strerror(errno));
>          return -1;
>      }
>
> @@ -3936,15 +3936,11 @@ int main(int argc, char **argv, char **envp)
>      }
>
>  #ifndef _WIN32
> -    if (qemu_opts_foreach(qemu_find_opts("add-fd"),
> -                          parse_add_fd, NULL, NULL)) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("add-fd"),
> +                      parse_add_fd, NULL, &error_fatal);
>
> -    if (qemu_opts_foreach(qemu_find_opts("add-fd"),
> -                          cleanup_add_fd, NULL, NULL)) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("add-fd"),
> +                      cleanup_add_fd, NULL, &error_fatal);
>  #endif
>
>      current_machine =3D MACHINE(object_new(object_class_get_name(
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
