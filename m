Received: from eggs.gnu.org ([2001:4830:134:3::10]:54269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gNGdc-0002CN-Sr
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gNGdb-0006Am-BK
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:20:48 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:39222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gNGdb-0006Ac-63
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:20:47 -0500
Received: by mail-it1-x144.google.com with SMTP id m15so28916372itl.4
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 04:20:47 -0800 (PST)
MIME-Version: 1.0
References: <1541051971-28584-1-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1541051971-28584-1-git-send-email-liq3ea@gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 15 Nov 2018 20:20:09 +0800
Message-ID: <CAKXe6S+tdUiWdWLut6Wx9tGvnFVYhC0oDZjLYtcGZuBjExeOyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: Improve error message when we can't
 load fw_cfg from file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, philmd@redhat.com
Cc: Qemu Developers <qemu-devel@nongnu.org>

Ping....


Li Qiang <liq3ea@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=881=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=881:59=E5=86=99=E9=81=93=EF=BC=9A

> parse_fw_cfg() reports "can't load" without further details.  Get
> the details from g_file_get_contents(), and include them in the
> error message.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  vl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 1fcacc5..f0bd899 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2244,8 +2244,10 @@ static int parse_fw_cfg(void *opaque, QemuOpts
> *opts, Error **errp)
>          size =3D strlen(str); /* NUL terminator NOT included in fw_cfg b=
lob
> */
>          buf =3D g_memdup(str, size);
>      } else {
> -        if (!g_file_get_contents(file, &buf, &size, NULL)) {
> -            error_setg(errp, "can't load %s", file);
> +        GError *err =3D NULL;
> +        if (!g_file_get_contents(file, &buf, &size, &err)) {
> +            error_setg(errp, "can't load %s: %s", file, err->message);
> +            g_error_free(err);
>              return -1;
>          }
>      }
> --
> 1.8.3.1
>
>
