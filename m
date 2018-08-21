Received: from eggs.gnu.org ([2001:4830:134:3::10]:54732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fs6R0-0004rO-5M
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fs6Qv-0001oD-Lk
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:10:58 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:33392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1fs6Qv-0001nn-H2
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:10:53 -0400
Received: by mail-yw1-xc44.google.com with SMTP id x67-v6so3006543ywg.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:10:53 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
References: <CAOrZHTTgNLY6UjvgMm_98R9A0-GvCz-1owxOYz-1dN9-kVNmhA@mail.gmail.com>
In-Reply-To: <CAOrZHTTgNLY6UjvgMm_98R9A0-GvCz-1owxOYz-1dN9-kVNmhA@mail.gmail.com>
Message-ID: <153485704527.13636.5674938620198385149@sif>
Date: Tue, 21 Aug 2018 08:10:45 -0500
Subject: Re: [Qemu-devel] [PATCH] qga: Support Unicode paths in
 guest-file-open on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathon Reinhart <jreinhart@cc-sw.com>, qemu-devel@nongnu.org

Quoting Jonathon Reinhart (2018-08-01 18:10:59)
> Currently, the win32 port of QEMU Guest Agent does not properly handle Un=
icode
> paths. The JSON decoder produces a valid UTF-8 path string, but this is p=
assed
> directly to CreateFileA, which is expecting an ANSI string and not UTF-8.=
 This
> leads to mangled filenames.
> =

> This patch follows the example of qmp_guest_set_user_password() and uses
> g_utf8_to_utf16() to convert the string to UTF-16 and calls CreateFileW()
> explicitly.
> =

> Signed-off-by: Jonathon Reinhart <jreinhart@cc-sw.com>
> ---
>  qga/commands-win32.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 98d9735389..416343b97b 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -160,13 +160,15 @@ static void handle_set_nonblocking(HANDLE fh)
>  int64_t qmp_guest_file_open(const char *path, bool has_mode,
>                              const char *mode, Error **errp)
>  {
> -    int64_t fd;
> +    int64_t fd =3D -1;
>      HANDLE fh;
>      HANDLE templ_file =3D NULL;
>      DWORD share_mode =3D FILE_SHARE_READ;
>      DWORD flags_and_attr =3D FILE_ATTRIBUTE_NORMAL;
>      LPSECURITY_ATTRIBUTES sa_attr =3D NULL;
>      OpenFlags *guest_flags;
> +    GError *gerr =3D NULL;
> +    wchar_t *w_path =3D NULL;
> =

>      if (!has_mode) {
>          mode =3D "r";
> @@ -175,16 +177,21 @@ int64_t qmp_guest_file_open(const char *path,
> bool has_mode,

It looks like your mail client might be wrapping patches at 80 char,
which makes them not apply on my end. I've fixed this one up and
applied it though:

  https://github.com/mdroth/qemu/commits/qga

>      guest_flags =3D find_open_flag(mode);
>      if (guest_flags =3D=3D NULL) {
>          error_setg(errp, "invalid file open mode");
> -        return -1;
> +        goto done;
> +    }
> +
> +    w_path =3D g_utf8_to_utf16(path, -1, NULL, NULL, &gerr);
> +    if (!w_path) {
> +        goto done;
>      }
> =

> -    fh =3D CreateFile(path, guest_flags->desired_access, share_mode, sa_=
attr,
> +    fh =3D CreateFileW(w_path, guest_flags->desired_access, share_mode, =
sa_attr,
>                      guest_flags->creation_disposition, flags_and_attr,
>                      templ_file);
>      if (fh =3D=3D INVALID_HANDLE_VALUE) {
>          error_setg_win32(errp, GetLastError(), "failed to open file '%s'=
",
>                           path);
> -        return -1;
> +        goto done;
>      }
> =

>      /* set fd non-blocking to avoid common use cases (like reading from a
> @@ -196,10 +203,17 @@ int64_t qmp_guest_file_open(const char *path,
> bool has_mode,
>      if (fd < 0) {
>          CloseHandle(fh);
>          error_setg(errp, "failed to add handle to qmp handle table");
> -        return -1;
> +        goto done;
>      }
> =

>      slog("guest-file-open, handle: % " PRId64, fd);
> +
> +done:
> +    if (gerr) {
> +        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
> +        g_error_free(gerr);
> +    }
> +    g_free(w_path);
>      return fd;
>  }
> =

> -- =

> 2.11.0
>=20
