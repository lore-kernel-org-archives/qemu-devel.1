Received: from eggs.gnu.org ([2001:4830:134:3::10]:59106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIraN-0006Ag-LS
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIraI-0001Kk-3b
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:10:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIraH-0001JD-UB
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:10:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170607184921.28407-1-marcandre.lureau@redhat.com>
	<20170607184921.28407-2-marcandre.lureau@redhat.com>
Date: Thu, 08 Jun 2017 09:10:18 +0200
In-Reply-To: <20170607184921.28407-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 7 Jun 2017 22:49:19 +0400")
Message-ID: <87o9tzj6p1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] char: fix alias devices regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, anthony.perard@citrix.com, pbonzini@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Fix regression from commit 4d43a603c71, where the serial and parallel
> headers got removed from char.c, which broke the alias table.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 7aa0210765..f38fac5c6b 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -34,6 +34,8 @@
>  #include "qemu/help_option.h"
>=20=20
>  #include "chardev/char-mux.h"
> +#include "chardev/char-parallel.h" /* for HAVE_CHARDEV_PARPORT */
> +#include "chardev/char-serial.h" /* for HAVE_CHARDEV_SERIAL */
>=20=20
>  /***********************************************************/
>  /* character device */

Two drive-by observations:

* Putting HAVE_FOOs in random headers, then testing them with #ifdef is
  asking for trouble.  Anything you test with #ifdef should be there
  after #include "qemu/osdep.h" at the latest, or be defined in the same
  .c.

* Such comments after #include rot quickly.  Strong dislike.

Doesn't mean this isn't an acceptable minimally invasive regression fix.
