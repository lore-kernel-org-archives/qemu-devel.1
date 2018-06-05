Received: from eggs.gnu.org ([2001:4830:134:3::10]:58385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQANu-0005uA-Qv
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQANr-0008KT-Pj
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:18 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:52054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQANr-0008KC-IB
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:15 -0400
Received: by mail-wm0-x230.google.com with SMTP id r15-v6so4318896wmc.1
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 04:44:15 -0700 (PDT)
Date: Tue, 5 Jun 2018 12:44:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180605114412.GE11888@stefanha-x1.localdomain>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<1527840629-18648-8-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline
In-Reply-To: <1527840629-18648-8-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH V6 7/7] migration/ram: ensure write
 persistence on loading all data to PMEM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2018 at 04:10:29PM +0800, junyan.he@gmx.com wrote:
> diff --git a/migration/ram.c b/migration/ram.c
> index aa0c6f0..09525b2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -33,6 +33,7 @@
>  #include "qemu/bitops.h"
>  #include "qemu/bitmap.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/pmem.h"
>  #include "xbzrle.h"
>  #include "ram.h"
>  #include "migration.h"
> @@ -3046,6 +3047,13 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
>  static int ram_load_cleanup(void *opaque)
>  {
>      RAMBlock *rb;
> +
> +    RAMBLOCK_FOREACH(rb) {
> +        if (ramblock_is_pmem(rb)) {
> +            pmem_persist(rb->host, rb->used_length);
> +         }

Indentation is off.  This can be fixed by the maintainer who merges
these patches.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFneMAAoJEJykq7OBq3PIqf4H/iVuZJ6VDk7b8xQ6fatM9gfF
4r3TcKi++BeIVeeTqzTHe8JsE+yOonNlY8wSviRBxtGieB6XFZ1Cs/6uOwKlAQri
+DLghDs+RuOgAvfC6EwkJ36AKw81ygLuAHLhl1A/JVAp2P69jqZL25YZMzfLV4Uk
g+Y0x/izCzg1DxbJUNStVrbtUZ8dSTWI6vOlsii5hDTX3HUKhqV0JFOSRaTtRtmo
flkoVJBjGrUtSSrt6CVY2LURd6ZjMauNY5UofaRh5zwb7GJbM1Zioz9IXNHaPvza
bbm+cOulDsjge69kzjbF31d18elaFaCqAshZAQBq5XU0OkocQ660DLjPnXdLjgw=
=3tkp
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
