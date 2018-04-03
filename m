Received: from eggs.gnu.org ([2001:4830:134:3::10]:50409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f3KGz-0005f5-8Q
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 07:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f3KGy-0005el-Cz
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 07:38:45 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f3KGy-0005cy-4S
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 07:38:44 -0400
Received: by mail-wm0-x244.google.com with SMTP id i3so10753430wmf.3
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 04:38:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3c36db1dc0702763ebb7966cc27428ed67d43804.1522751624.git.mprivozn@redhat.com>
References: <3c36db1dc0702763ebb7966cc27428ed67d43804.1522751624.git.mprivozn@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Apr 2018 13:38:41 +0200
Message-ID: <CAJ+F1CKzkhdXHyZ0wRQ7Hjx8cVLVhDCgoGP9pVgte26+NMQmbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] ccid-card: include libcacard.h only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Tue, Apr 3, 2018 at 12:34 PM, Michal Privoznik <mprivozn@redhat.com> wro=
te:
> When trying to build with latest libcacard-2.5.1, I hit the
> following error:
>
> In file included from hw/usb/ccid-card-passthru.c:12:0:
> /usr/include/cacard/vscard_common.h:26:2: error: #warning "Only <libcacar=
d.h> can be included directly" [-Werror=3Dcpp]
>  #warning "Only <libcacard.h> can be included directly"
>
> While it was fixed in libcacard upstream (so that individual
> files can be included directly), it doesn't make much sense.
> Let's switch to including the main libcacard.h and also require
> at least libcacard-2.5.1 which introduced it. It's available
> since late 2015.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>
> diff to v1:
> - Introduce configure change to require newer libcacard version
>
>  configure                   | 2 +-
>  hw/usb/ccid-card-emulated.c | 5 +----
>  hw/usb/ccid-card-passthru.c | 2 +-
>  3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/configure b/configure
> index 4d0e92c96c..0edec24fff 100755
> --- a/configure
> +++ b/configure
> @@ -4440,7 +4440,7 @@ fi
>
>  # check for smartcard support
>  if test "$smartcard" !=3D "no"; then
> -    if $pkg_config libcacard; then
> +    if $pkg_config --atleast-version=3D2.5.1 libcacard; then
>          libcacard_cflags=3D$($pkg_config --cflags libcacard)
>          libcacard_libs=3D$($pkg_config --libs libcacard)
>          smartcard=3D"yes"
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index ea42e4681d..7b538ae6da 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -27,10 +27,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include <eventt.h>
> -#include <vevent.h>
> -#include <vreader.h>
> -#include <vcard_emul.h>
> +#include <cacard/libcacard.h>

You should be able to #include <libcacard.h> only

>
>  #include "qemu/thread.h"
>  #include "qemu/main-loop.h"
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index b7dd3602dc..982d575edd 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -9,7 +9,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include <cacard/vscard_common.h>
> +#include <cacard/libcacard.h>
>  #include "chardev/char-fe.h"
>  #include "qemu/error-report.h"
>  #include "qemu/sockets.h"
> --
> 2.16.1
>



--=20
Marc-Andr=C3=A9 Lureau
