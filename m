Received: from eggs.gnu.org ([2001:4830:134:3::10]:51262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dID7t-0002mW-Ko
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dID7s-0005Jl-9R
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:58:21 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:34404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dID7r-0005ID-UG
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:58:20 -0400
Received: by mail-lf0-x22e.google.com with SMTP id v20so53074027lfa.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 04:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <2b2311b1b070a0b03973e39deccf4682de4a6cd4.1496686997.git.alistair.francis@xilinx.com>
In-Reply-To: <2b2311b1b070a0b03973e39deccf4682de4a6cd4.1496686997.git.alistair.francis@xilinx.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 06 Jun 2017 11:58:07 +0000
Message-ID: <CAJ+F1CLuPkWjG3Hn8hfaxTApn6+ouqh5nJZNWSQYX1C3_HRFqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] char-socket: Don't report TCP
 socket waiting as an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com
Cc: alistair23@gmail.com

Hi

On Mon, Jun 5, 2017 at 10:37 PM Alistair Francis <
alistair.francis@xilinx.com> wrote:

> When QEMU is waiting for a TCP socket connection it reports that message =
as
> an error. This isn't an error though, so let's change the report to just
> use qemu_log().
>
>
I don't think this is a good idea, since stdout output my be mixed with
console or other expected output.

In fact, it used to be on stdout, and got moved to stderr:

commit fdca2124adc293f84f2b7aaf0df43faa6b6bf420
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Mon Jun 24 08:39:49 2013 +0200

    qemu-char: print notification to stderr

    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
    Reviewed-by: Laszlo Ersek <lersek@redhat.com>
    Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-char.c b/qemu-char.c
index e3b3224886..371f6308c5 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -2666,8 +2666,8 @@ static CharDriverState *qemu_chr_open_socket_fd(int
fd, bool do_nodelay,
     }

     if (is_listen && is_waitconnect) {
-        printf("QEMU waiting for connection on: %s\n",
-               chr->filename);
+        fprintf(stderr, "QEMU waiting for connection on: %s\n",
+                chr->filename);


Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>
>  chardev/char-socket.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index ccc499cfa1..a9884fa85b 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -27,6 +27,7 @@
>  #include "io/channel-tls.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qemu/log.h"
>  #include "qapi/clone-visitor.h"
>
>  #include "chardev/char-io.h"
> @@ -765,7 +766,7 @@ static int tcp_chr_wait_connected(Chardev *chr, Error
> **errp)
>       * in TLS and telnet cases, only wait for an accepted socket */
>      while (!s->ioc) {
>          if (s->is_listen) {
> -            error_report("QEMU waiting for connection on: %s",
> +            qemu_log("QEMU waiting for connection on: %s",
>                           chr->filename);
>              qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true,
> NULL);
>              tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
> --
> 2.11.0
>
>
> --
Marc-Andr=C3=A9 Lureau
