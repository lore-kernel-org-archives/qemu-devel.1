Received: from eggs.gnu.org ([2001:4830:134:3::10]:45462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fBgk9-0006uC-3U
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fBgk4-0008WB-4o
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:15:25 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:51229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fBgk3-0008Vm-Np
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:15:20 -0400
Received: by mail-wm0-x242.google.com with SMTP id j4so12901461wme.1
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 06:15:19 -0700 (PDT)
Date: Thu, 26 Apr 2018 14:15:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180426131517.GB30991@stefanha-x1.localdomain>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20180425112415.12327-3-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 2/2] pmem: device flush over VIRTIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org, jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, marcel@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com, imammedo@redhat.com, lcapitulino@redhat.com


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 04:54:14PM +0530, Pankaj Gupta wrote:
> This patch adds functionality to perform=20
> flush from guest to hosy over VIRTIO=20
> when 'ND_REGION_VIRTIO'flag is set on=20
> nd_negion. Flag is set by 'virtio-pmem'
> driver.
>=20
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/nvdimm/region_devs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index a612be6..6c6454e 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -20,6 +20,7 @@
>  #include <linux/nd.h>
>  #include "nd-core.h"
>  #include "nd.h"
> +#include <linux/virtio_pmem.h>
> =20
>  /*
>   * For readq() and writeq() on 32-bit builds, the hi-lo, lo-hi order is
> @@ -1074,6 +1075,12 @@ void nvdimm_flush(struct nd_region *nd_region)
>  	struct nd_region_data *ndrd =3D dev_get_drvdata(&nd_region->dev);
>  	int i, idx;
> =20
> +       /* call PV device flush */
> +	if (test_bit(ND_REGION_VIRTIO, &nd_region->flags)) {
> +		virtio_pmem_flush(&nd_region->dev);
> +		return;
> +	}

How does libnvdimm know when flush has completed?

Callers expect the flush to be finished when nvdimm_flush() returns but
the virtio driver has only queued the request, it hasn't waited for
completion!

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4dDlAAoJEJykq7OBq3PI980IAJY41FLfXhqcQzxR13OvtKqj
cM7mQMJIee6fETlh9HYqEh7dOvOHhpqojY9PEKA+Bu1f/KC3Y03liilCCKdLiHc+
WpCVSyT3nOTjPlY4tS+e4WEEzaCwqNYu8rbz7sfJxd1c+4Hl9VuLfBQLieSnTsmE
GUawKQak2e+c7EdOdKxmxtaeZfX1qJcm6ZMhbqSrvIrzR+E+fz4WKmntxrdgeDwY
4IzZHK5h2u4z0jSeLf0tfdWf/77y1IWPqKGvuK6MTZHFxvMn6AiI4VZ116LfXgNC
l7SS25ehqJ5WGgBrUYsL40QAimQDSCQL2ouNwyx/Q1+Ub/xi6TWKN17u3UV5Bpc=
=i3H2
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
