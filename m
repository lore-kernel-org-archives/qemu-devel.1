Received: from eggs.gnu.org ([2001:4830:134:3::10]:35145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFgw8-00082b-W5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFgw4-0002bc-Ew
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:11:48 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFgw4-0002bY-7J
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:11:44 -0400
Received: by mail-wm0-x241.google.com with SMTP id k15so25271575wmh.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 06:11:44 -0700 (PDT)
Date: Tue, 30 May 2017 14:11:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530131140.GA11356@stefanha-x1.localdomain>
References: <20170505101337.4650-1-pbonzini@redhat.com>
	<20170505101337.4650-22-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20170505101337.4650-22-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PULL 21/21] vhost-scsi: create a
 vhost-scsi-common abstraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Felipe Franciosi <felipe@nutanix.com>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 12:13:37PM +0200, Paolo Bonzini wrote:
> From: Felipe Franciosi <felipe@nutanix.com>
>=20
> In order to introduce a new vhost-user-scsi host device type, it makes
> sense to abstract part of vhost-scsi into a common parent class. This
> commit does exactly that.
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Message-Id: <1488479153-21203-3-git-send-email-felipe@nutanix.com>
> ---
>  hw/scsi/Makefile.objs                 |   2 +-
>  hw/scsi/vhost-scsi-common.c           | 143 +++++++++++++++++++++++++
>  hw/scsi/vhost-scsi.c                  | 194 ++++++++++------------------=
------
>  include/hw/virtio/vhost-scsi-common.h |  48 +++++++++
>  include/hw/virtio/vhost-scsi.h        |  11 +-
>  include/hw/virtio/virtio-scsi.h       |   2 +
>  6 files changed, 252 insertions(+), 148 deletions(-)
>  create mode 100644 hw/scsi/vhost-scsi-common.c
>  create mode 100644 include/hw/virtio/vhost-scsi-common.h
>=20
> diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
> index 5a2248be36..54d8754e9a 100644
> --- a/hw/scsi/Makefile.objs
> +++ b/hw/scsi/Makefile.objs
> @@ -10,5 +10,5 @@ obj-$(CONFIG_PSERIES) +=3D spapr_vscsi.o
> =20
>  ifeq ($(CONFIG_VIRTIO),y)
>  obj-y +=3D virtio-scsi.o virtio-scsi-dataplane.o
> -obj-$(CONFIG_VHOST_SCSI) +=3D vhost-scsi.o
> +obj-$(CONFIG_VHOST_SCSI) +=3D vhost-scsi-common.o vhost-scsi.o
>  endif
> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> new file mode 100644
> index 0000000000..e41c0314db
> --- /dev/null
> +++ b/hw/scsi/vhost-scsi-common.c
> @@ -0,0 +1,143 @@
> +/*
> + * vhost-scsi-common
> + *
> + * Copyright (c) 2016 Nutanix Inc. All rights reserved.
> + *
> + * Author:
> + *  Felipe Franciosi <felipe@nutanix.com>
> + *
> + * This work is largely based on the "vhost-scsi" implementation by:
> + *  Stefan Hajnoczi    <stefanha@linux.vnet.ibm.com>
> + *  Nicholas Bellinger <nab@risingtidesystems.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or l=
ater.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include <linux/vhost.h>

This breaks the mingw build:

  hw/scsi/vhost-scsi-common.c:19:25: fatal error: linux/vhost.h: No such fi=
le or directory
   #include <linux/vhost.h>
                         ^
  compilation terminated.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLW+MAAoJEJykq7OBq3PIg0gIALUhwmjNAKD+43Zky8/qfTCY
mqY5a7LGVsSQEe/QHsVmyl/PqSrGSkHez5AtOkPeP8igs6v9al6wnhZk93TLj/aI
WvsCf5aJNlV031zf62nBWTh+cd+whrE2xUlu6gqB1h+demc4atqtgMhSEs9H2wi+
YIp/B2Q47o0d4Qs3XSBEX4uM4Bz4dwWGu7Dodcl77xyuxuIjGcxBuE+1pT+pl+MP
NW4fGMQMZjA2T/2FF4GWKssbe/007hKRuTQ/y6MkjadDxEEjBzr/8dydY1mV0XAN
Y6ByzrQA0fZkeWY1+ut0Qeai28oHQQTA/0adgyftmesgaMSjpGR4G7LIJqpx4m8=
=+NJF
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
