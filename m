Received: from eggs.gnu.org ([2001:4830:134:3::10]:45546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaLi-000440-S9
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaKh-00007O-Gt
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:09:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egaKg-00005e-QK
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:08:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D8024F1AC
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 18:08:34 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-19-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d21a61a0-686c-6356-b223-231789378025@redhat.com>
Date: Tue, 30 Jan 2018 12:08:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-19-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9W8mAjVmKP8UWZ14z2UKkC7M5NLrqYfwK"
Subject: Re: [Qemu-devel] [PATCH 18/18] Move include qemu/option.h from
 qemu-common.h to actual users
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
--9W8mAjVmKP8UWZ14z2UKkC7M5NLrqYfwK
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <d21a61a0-686c-6356-b223-231789378025@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/18] Move include qemu/option.h from
 qemu-common.h to actual users
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-19-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-19-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:22 AM, Markus Armbruster wrote:
> qemu-common.h includes qemu/option.h, but most places that include the
> former don't actually need the latter.  Drop the include, and add it
> to the places that actually need it.
>=20
> While there, drop superfluous includes of both headers.
>=20
> This cleanup makes the number of objects depending on qemu/option.h
> drop from 4542 (out of 4739) to 284 in my "build everything" tree.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  103 files changed, 98 insertions(+), 54 deletions(-)

Bigger effort, but still a nice cleanup.  And especially nice if we're
trying to reduce users of QemuOpts.

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/block/file-posix.c
> @@ -21,12 +21,14 @@
>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
>   * THE SOFTWARE.
>   */
> +
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "block/block_int.h"
>  #include "qemu/module.h"
> +#include "qemu/option.h"
>  #include "trace.h"

More of the blank line before osdep.h cleanup comment.

> +++ b/hw/9pfs/9p-handle.c
> @@ -22,6 +22,7 @@
>  #include "qemu/xattr.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> +#include "qemu/option.h"
>  #include <linux/fs.h>
>  #ifdef CONFIG_LINUX_MAGIC_H
>  #include <linux/magic.h>

Shouldn't we be fixing this one to include system headers (like
<linux/fs.h> prior to internal headers?  Separate cleanup, though.

> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index c6d8af4fb8..d85494bd31 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -26,6 +26,7 @@
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
> +#include "qemu/option.h"
>  #include <libgen.h>
>  #include <linux/fs.h>

More of that separate cleanup.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9W8mAjVmKP8UWZ14z2UKkC7M5NLrqYfwK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwtKAACgkQp6FrSiUn
Q2oPLwf8DyaIJbBOkCCXRYAMuU0VoJIiNhct0p2vjBQDano4M9T4cq0dw7ByEjdW
udt/AbO8Vxoo7KP+12YN82FTijGy2qUYKaxP5/en637YVQJfZpC88+jhHeqiUrj3
1k1ddINnU0gR5C+7orODbFAUlK67pB1+h5i3aHOfCpCeHJOfXIT4tPQfw06hqPvN
VRbdpqtjGNOcgV2obBZcKphjSqESGLUPzCoOU4RHWtrCR0xLkHpNs2211x2WkrZe
9kMAq+E01m1RtY8ZE0REiX1GTdnjvb1zFge03tirZokABEhdLHh7Tc8X7QFB/cUp
Rysjlc69dEIu8ix/HxGd3hGnjAmu2Q==
=NANw
-----END PGP SIGNATURE-----

--9W8mAjVmKP8UWZ14z2UKkC7M5NLrqYfwK--
