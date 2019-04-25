Received: from eggs.gnu.org ([209.51.188.92]:53131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZhu-0003wy-Fp
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZht-000193-4g
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:26:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hJZhs-00018H-U2
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:26:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id h11so2422367wmb.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 01:26:12 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:26:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190425082609.GB30231@stefanha-x1.localdomain>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
	<20190422004849.26463-2-richardw.yang@linux.intel.com>
	<20190423092518.GD32465@stefanha-x1.localdomain>
	<20190424010105.GA12824@richard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20190424010105.GA12824@richard>
Subject: Re: [Qemu-devel] [PATCH v14 1/2] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, pagupta@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com, Haozhong Zhang <haozhong.zhang@intel.com>, imammedo@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, ehabkost@redhat.com


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 09:01:05AM +0800, Wei Yang wrote:
> On Tue, Apr 23, 2019 at 10:25:18AM +0100, Stefan Hajnoczi wrote:
> [...]
> >> +#ifdef CONFIG_LINUX
> >> +#include <linux/mman.h>
> >> +#else  /* !CONFIG_LINUX */
> >> +#define MAP_SYNC              0x0
> >> +#define MAP_SHARED_VALIDATE   0x0
> >> +#endif /* CONFIG_LINUX */
> >
> >MAP_SHARED_VALIDATE is is from 2017:
> >
> >  commit 1c9725974074a047f6080eecc62c50a8e840d050
> >  Author: Dan Williams <dan.j.williams@intel.com>
> >  Date:   Wed Nov 1 16:36:30 2017 +0100
> >
> >    mm: introduce MAP_SHARED_VALIDATE, a mechanism to safely define new =
mmap flags
> >
> >This code fails to compile on Linux hosts with pre-4.15 headers.
> >
>=20
> Ok, qemu build will fail on pre-4.15 linux.
>=20
> >Instead you could use the following (even on Linux!):
> >
> >  #ifndef MAP_SYNC
> >  #define MAP_SYNC 0
> >  #endif
> >  #ifndef MAP_SHARED_VALIDATE
> >  #define MAP_SHARED_VALIDATE 0
> >  #endif
> >
> >Either way:
>=20
> You mean replace the above code to:
>=20
> #ifdef CONFIG_LINUX
> #include <linux/mman.h>
> #endif /* CONFIG_LINUX */
>=20
> #ifndef MAP_SYNC
> #define MAP_SYNC 0
> #endif
> #ifndef MAP_SHARED_VALIDATE
> #define MAP_SHARED_VALIDATE 0
> #endif

Yes, please.

This is not critical but I bet someone will hit this issue when
compiling a new QEMU on an old host.  This small tweak will save them
time.

Stefan

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwW8hAAoJEJykq7OBq3PI9/0IAKCQ520Vn7UaLDGx2fhGHq48
omsvcpTNdimVOCIrB6rb1ZJ81gQ8R7VQX4lqoMADYAcSt+EBI7hSIKMWlgbZBr0r
cz5Gco4wSXgl+74GnuuNYxjsPK8Zp8a7gyWllas8ls71P9rxjQfkS46bEJFaX2BB
Hg8a2M5cUsIk0/uT/62puyD9xHSJWS7tT28qoi+R0WKKPKzw2HwaocK44Gddt6ae
czbQQY4QmzP0+TtgPnObipxJBFF/+jwdSb3meYtujGHotyduYfNyvduQsaxOggiX
O7riI1xhJVWk4oOglFtjmMD6YwFWA2YvZ0/lXkq5t3/9TDkjCZMnQmNVk7Gp71A=
=Mev/
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
