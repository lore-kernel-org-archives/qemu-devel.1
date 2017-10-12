Received: from eggs.gnu.org ([2001:4830:134:3::10]:60763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=451d893c3=Paul.Durrant@citrix.com>)
	id 1e2a4w-0007vz-Io
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=451d893c3=Paul.Durrant@citrix.com>)
	id 1e2a4t-0003DF-B9
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:46:58 -0400
Received: from smtp.citrix.com.au ([103.14.252.240]:31366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=451d893c3=Paul.Durrant@citrix.com>)
	id 1e2a4s-0003Bk-Lf
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:46:55 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 12 Oct 2017 09:46:46 +0000
Message-ID: <f494c584bf4244beb2419095e057ca2b@AMSPEX02CL03.citrite.net>
References: <20171011155203.16502-1-ross.lagerwall@citrix.com>
In-Reply-To: <20171011155203.16502-1-ross.lagerwall@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xen: Log errno rather than return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-
> bounces+paul.durrant=3Dcitrix.com@nongnu.org] On Behalf Of Ross Lagerwall
> Sent: 11 October 2017 16:52
> To: qemu-devel@nongnu.org
> Cc: Anthony Perard <anthony.perard@citrix.com>; Ross Lagerwall
> <ross.lagerwall@citrix.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: [Qemu-devel] [PATCH] xen: Log errno rather than return value
>=20
> xen_modified_memory() sets errno to communicate what went wrong so
> log
> this rather than the return value which is not interesting.
>=20
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  hw/i386/xen/xen-hvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index d9ccd5d..8028bed 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -1446,7 +1446,7 @@ void xen_hvm_modified_memory(ram_addr_t
> start, ram_addr_t length)
>          if (rc) {
>              fprintf(stderr,
>                      "%s failed for "RAM_ADDR_FMT" ("RAM_ADDR_FMT"): %i, =
%s\n",
> -                    __func__, start, nb_pages, rc, strerror(-rc));
> +                    __func__, start, nb_pages, errno, strerror(errno));

I think this is actually a deeper problem. If QEMU is using compat code, wh=
ich one way or another will go via xencall, then xen_modified_memory() will=
 return a hypercall errno. However, if it goes via libxendevicemodel and an=
 up-to-date privcmd, then it will return -1 and errno will be set. Thus I t=
hink the correct fix is not this patch, but a fix in xen_modified_memory() =
to return -errno and a fix in libxendevicemodel and the compat code in libx=
encntrl to behave consistently. It's all rather horrible.

  Paul

>          }
>      }
>  }
> --
> 2.9.5
>=20
