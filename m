Received: from eggs.gnu.org ([2001:4830:134:3::10]:56867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eekxp-0005Sy-D1
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eekxl-00070e-4p
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:05:25 -0500
Date: Thu, 25 Jan 2018 17:05:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180125170501.GA19513@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20171208133416.28978-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20171208133416.28978-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: fix EOF Ctrl-D handling in
 qemu-io readline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

ping, does any block maintainer want to queue this one ?

On Fri, Dec 08, 2017 at 01:34:16PM +0000, Daniel P. Berrange wrote:
> qemu-io puts the TTY into non-canonical mode, which means no EOF processi=
ng is
> done and thus getchar() will never return the EOF constant. Instead we ha=
ve to
> query the TTY attributes to determine the configured EOF character (usual=
ly
> Ctrl-D / 0x4), and then explicitly check for that value. This fixes the
> regression that prevented Ctrl-D from triggering an exit of qemu-io that =
has
> existed since readline was first added in
>=20
>   commit 0cf17e181798063c3824c8200ba46f25f54faa1a
>   Author: Stefan Hajnoczi <stefanha@redhat.com>
>   Date:   Thu Nov 14 11:54:17 2013 +0100
>=20
>     qemu-io: use readline.c
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> Changed in v2:
>=20
>   - Query termios settings for EOF character
>=20
>  qemu-io.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-io.c b/qemu-io.c
> index c70bde3eb1..fa4972d734 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -10,6 +10,9 @@
>  #include "qemu/osdep.h"
>  #include <getopt.h>
>  #include <libgen.h>
> +#ifndef _WIN32
> +#include <termios.h>
> +#endif
> =20
>  #include "qapi/error.h"
>  #include "qemu-io.h"
> @@ -41,6 +44,26 @@ static bool imageOpts;
> =20
>  static ReadLineState *readline_state;
> =20
> +static int ttyEOF;
> +
> +static int get_eof_char(void)
> +{
> +#ifdef _WIN32
> +    return 0x4; /* Ctrl-D */
> +#else
> +    struct termios tty;
> +    if (tcgetattr(STDIN_FILENO, &tty) !=3D 0) {
> +        if (errno =3D=3D ENOTTY) {
> +            return 0x0; /* just expect read() =3D=3D 0 */
> +        } else {
> +            return 0x4; /* Ctrl-D */
> +        }
> +    }
> +
> +    return tty.c_cc[VEOF];
> +#endif
> +}
> +
>  static int close_f(BlockBackend *blk, int argc, char **argv)
>  {
>      blk_unref(qemuio_blk);
> @@ -322,7 +345,7 @@ static char *fetchline_readline(void)
>      readline_start(readline_state, get_prompt(), 0, readline_func, &line=
);
>      while (!line) {
>          int ch =3D getchar();
> -        if (ch =3D=3D EOF) {
> +        if (ttyEOF !=3D 0x0 && ch =3D=3D ttyEOF) {
>              break;
>          }
>          readline_handle_byte(readline_state, ch);
> @@ -592,6 +615,7 @@ int main(int argc, char **argv)
>      qemuio_add_command(&close_cmd);
> =20
>      if (isatty(STDIN_FILENO)) {
> +        ttyEOF =3D get_eof_char();
>          readline_state =3D readline_init(readline_printf_func,
>                                         readline_flush_func,
>                                         NULL,
> --=20
> 2.14.3
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|
