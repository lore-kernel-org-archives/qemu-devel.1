Received: from eggs.gnu.org ([2001:4830:134:3::10]:40727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egYYY-0006wc-9O
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egYYT-0003pp-8l
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:14:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egYYT-0003pK-0d
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:14:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4525C7853C
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 16:14:40 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8bb9095a-93f8-ba14-3296-5a2d03cbf5e4@redhat.com>
Date: Tue, 30 Jan 2018 10:14:37 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-4-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TVvmJmhjgckEOxwhtspON0GuX3clji3py"
Subject: Re: [Qemu-devel] [PATCH 03/18] Include qapi/error.h exactly where
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TVvmJmhjgckEOxwhtspON0GuX3clji3py
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8bb9095a-93f8-ba14-3296-5a2d03cbf5e4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/18] Include qapi/error.h exactly where
 needed
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-4-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> This cleanup makes the number of objects depending on qapi/error.h
> drop from 1910 (out of 4739) to 1612 in my "build everything" tree.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  arch_init.c                             | 1 +
>  audio/wavcapture.c                      | 1 +
>  balloon.c                               | 1 +
>  block.c                                 | 2 ++
>  block/block-backend.c                   | 1 +
>  block/iscsi.c                           | 1 +
>  block/qapi.c                            | 1 +

So several .c files have to use it explicitly,

>  fsdev/qemu-fsdev-throttle.h             | 1 -

>  include/crypto/random.h                 | 1 -
>  include/crypto/xts.h                    | 1 -
>  include/hw/ide/internal.h               | 1 -
>  include/ui/console.h                    | 1 -

because they were previously getting it from .h files that don't
directly emit an error.  Makes sense.

Patches like this are easy to test - if it still compiles, you did it
right ;)  Out of curiousity, how are you counting how many files got
compiled per run?  Touch the .h, then pass 'make' output to 'grep -c "^
CC "'?

But just to make sure nothing weird is happening, I also read through
it, and found:

>=20
> diff --git a/arch_init.c b/arch_init.c
> index a0b8ed6167..0fb8093f92 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -21,6 +21,7 @@
>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
>   * THE SOFTWARE.
>   */
> +
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "cpu.h"

Spurious whitespace change.  Should this belong in 1/18, even though
arch_init.c didn't need cleanup there?  Or...

> +++ b/block.c
> @@ -21,6 +21,7 @@
>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
>   * THE SOFTWARE.
>   */
> +
>  #include "qemu/osdep.h"
>  #include "block/trace.h"
>  #include "block/block_int.h"

=2E..since you did it again, do you need a separate patch for ALL of thes=
e
types of whitespace cleanups near osdep.h?

> +++ b/block/qcow2.c
> @@ -21,6 +21,7 @@
>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
>   * THE SOFTWARE.
>   */
> +
>  #include "qemu/osdep.h"
>  #include "block/block_int.h"
>  #include "sysemu/block-backend.h"

and again

> +++ b/chardev/char-ringbuf.c
> @@ -21,9 +21,11 @@
>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
>   * THE SOFTWARE.
>   */
> +
>  #include "qemu/osdep.h"
>  #include "chardev/char.h"
>  #include "qmp-commands.h"
> +#include "qapi/error.h"
>  #include "qemu/base64.h"
> =20
>  /* Ring buffer chardev */

Here, it's in the same hunk, so a bit more forgivable.  But there's
definitely enough of them that a separate commit might be in order.

At any rate, whether done as one patch (with a better commit message) or
as two, I see nothing semantically wrong with the cleanups done here, so

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TVvmJmhjgckEOxwhtspON0GuX3clji3py
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwme0ACgkQp6FrSiUn
Q2qrPgf+O7CyuKSPtMrndj5/dEFnxPxvloDtepk2P3TpL2rm3VqaUSe7mzm4oxpx
S0Jpfl1Exb3jh2SLqq/+3XTv2uAldmpyIHXS+1Jc08OKHyc/5UEfyQHM+3OGRITh
+NAor6WeVfFX6oh37QuCxMoZ340jWQB+RYLqLiRJMZlMK7dT4VynrrCDLhiOjOvA
V/UzuggxIit8+hqcbZtjvDN5sMS6Z2rgm8tk4No1gnF70INdqTAQGkc7uxROnHzB
NFsi3gjZ2d7lml0wPUvPwZURSj+OYl1nAhKKGxZpfqK+vFWbb0N8TQB0T4Rp4oZa
whSl5uRgJ3f3xA0B8PFVzM79qcWVpw==
=dhhx
-----END PGP SIGNATURE-----

--TVvmJmhjgckEOxwhtspON0GuX3clji3py--
