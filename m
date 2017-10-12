Received: from eggs.gnu.org ([2001:4830:134:3::10]:34981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=451d893c3=Paul.Durrant@citrix.com>)
	id 1e2gu1-0002tJ-Tl
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 13:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=451d893c3=Paul.Durrant@citrix.com>)
	id 1e2gtx-0005gl-IV
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 13:04:09 -0400
Received: from smtp.citrix.com.au ([103.14.252.240]:9797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=451d893c3=Paul.Durrant@citrix.com>)
	id 1e2gtw-0005fG-UX
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 13:04:05 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 12 Oct 2017 17:03:57 +0000
Message-ID: <33b709757fd34ac9ba964aeccf8016b9@AMSPEX02CL03.citrite.net>
References: <20171011155203.16502-1-ross.lagerwall@citrix.com>
	<f494c584bf4244beb2419095e057ca2b@AMSPEX02CL03.citrite.net>
In-Reply-To: <f494c584bf4244beb2419095e057ca2b@AMSPEX02CL03.citrite.net>
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
To: Paul Durrant <Paul.Durrant@citrix.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-
> bounces+paul.durrant=3Dcitrix.com@nongnu.org] On Behalf Of Paul Durrant
> Sent: 12 October 2017 10:47
> To: Ross Lagerwall <ross.lagerwall@citrix.com>; qemu-devel@nongnu.org
> Cc: Anthony Perard <anthony.perard@citrix.com>; Ross Lagerwall
> <ross.lagerwall@citrix.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [Qemu-devel] [PATCH] xen: Log errno rather than return value
>=20
> > -----Original Message-----
> > From: Qemu-devel [mailto:qemu-devel-
> > bounces+paul.durrant=3Dcitrix.com@nongnu.org] On Behalf Of Ross
> Lagerwall
> > Sent: 11 October 2017 16:52
> > To: qemu-devel@nongnu.org
> > Cc: Anthony Perard <anthony.perard@citrix.com>; Ross Lagerwall
> > <ross.lagerwall@citrix.com>; Stefano Stabellini <sstabellini@kernel.org=
>
> > Subject: [Qemu-devel] [PATCH] xen: Log errno rather than return value
> >
> > xen_modified_memory() sets errno to communicate what went wrong so
> > log
> > this rather than the return value which is not interesting.
> >
> > Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> > ---
> >  hw/i386/xen/xen-hvm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> > index d9ccd5d..8028bed 100644
> > --- a/hw/i386/xen/xen-hvm.c
> > +++ b/hw/i386/xen/xen-hvm.c
> > @@ -1446,7 +1446,7 @@ void xen_hvm_modified_memory(ram_addr_t
> > start, ram_addr_t length)
> >          if (rc) {
> >              fprintf(stderr,
> >                      "%s failed for "RAM_ADDR_FMT" ("RAM_ADDR_FMT"): %i=
,
> %s\n",
> > -                    __func__, start, nb_pages, rc, strerror(-rc));
> > +                    __func__, start, nb_pages, errno, strerror(errno))=
;
>=20
> I think this is actually a deeper problem. If QEMU is using compat code, =
which
> one way or another will go via xencall, then xen_modified_memory() will
> return a hypercall errno.

Having waded through the code now it turns out that (for linux at least) xe=
ncall returns the value returned from the underlying ioctl() call so it wil=
l actually return -1 with errno set correctly, so the above statement is in=
correct. Thus there is no inconsistency and the patch DTRT.

Sorry for the noise.

  Paul

> However, if it goes via libxendevicemodel and an
> up-to-date privcmd, then it will return -1 and errno will be set. Thus I =
think
> the correct fix is not this patch, but a fix in xen_modified_memory() to =
return
> -errno and a fix in libxendevicemodel and the compat code in libxencntrl =
to
> behave consistently. It's all rather horrible.
>=20
>   Paul
>=20
> >          }
> >      }
> >  }
> > --
> > 2.9.5
> >
>=20
