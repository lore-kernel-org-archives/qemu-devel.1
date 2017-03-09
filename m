Received: from eggs.gnu.org ([2001:4830:134:3::10]:33023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cm2FN-0003oW-Q7
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cm2FK-0004MR-Na
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:53:05 -0500
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:56142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cm2FK-0004M2-G8
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:53:02 -0500
Received: from player693.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 8E854B4019
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 18:52:58 +0100 (CET)
Date: Thu, 9 Mar 2017 18:52:48 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170309185248.61f7def6@bahia>
In-Reply-To: <1488852768-8935-8-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1703061807431.17906@sstabellini-ThinkPad-X260>
	<1488852768-8935-1-git-send-email-sstabellini@kernel.org>
	<1488852768-8935-8-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/nII1/bgheguI8gMk5htIQhD";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 8/8] xen/9pfs: build and register Xen 9pfs
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, jgross@suse.com, Stefano Stabellini <stefano@aporeto.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

--Sig_/nII1/bgheguI8gMk5htIQhD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  6 Mar 2017 18:12:48 -0800
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: anthony.perard@citrix.com
> CC: jgross@suse.com
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> CC: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/Makefile.objs        | 1 +
>  hw/xen/xen_backend.c         | 1 +
>  include/hw/xen/xen_backend.h | 1 +
>  3 files changed, 3 insertions(+)
>=20
> diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
> index da0ae0c..76a81c3 100644
> --- a/hw/9pfs/Makefile.objs
> +++ b/hw/9pfs/Makefile.objs
> @@ -7,3 +7,4 @@ common-obj-$(CONFIG_OPEN_BY_HANDLE) +=3D  9p-handle.o
>  common-obj-y +=3D 9p-proxy.o
> =20
>  obj-y +=3D virtio-9p-device.o
> +obj-y +=3D xen-9p-backend.o

The xen-9p-backend.c file seems to be target agnostic: it can be built
only once. Also, it should only be built if QEMU was configured with
Xen support. Hence:

obj-common-$(CONFIG_XEN_BACKEND) +=3D xen-9p-backend.o

> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index 6c21c37..7aa347d 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -585,6 +585,7 @@ void xen_be_register_common(void)
>      xen_be_register("console", &xen_console_ops);
>      xen_be_register("vkbd", &xen_kbdmouse_ops);
>      xen_be_register("qdisk", &xen_blkdev_ops);

#ifdef CONFIG_VIRTFS

> +    xen_be_register("9pfs", &xen_9pfs_ops);

#endif

>  #ifdef CONFIG_USB_LIBUSB
>      xen_be_register("qusb", &xen_usb_ops);
>  #endif
> diff --git a/include/hw/xen/xen_backend.h b/include/hw/xen/xen_backend.h
> index 4f4799a..84e686c 100644
> --- a/include/hw/xen/xen_backend.h
> +++ b/include/hw/xen/xen_backend.h
> @@ -49,6 +49,7 @@ extern struct XenDevOps xen_console_ops;      /* xen_co=
nsole.c     */
>  extern struct XenDevOps xen_kbdmouse_ops;     /* xen_framebuffer.c */
>  extern struct XenDevOps xen_framebuffer_ops;  /* xen_framebuffer.c */
>  extern struct XenDevOps xen_blkdev_ops;       /* xen_disk.c        */
> +extern struct XenDevOps xen_9pfs_ops;       /* xen-9p-backend.c        */

ditto

>  extern struct XenDevOps xen_netdev_ops;       /* xen_nic.c         */
>  #ifdef CONFIG_USB_LIBUSB
>  extern struct XenDevOps xen_usb_ops;          /* xen-usb.c         */

With the above fixes.

Reviewed-by: Greg Kurz <groug@kaod.org>

--Sig_/nII1/bgheguI8gMk5htIQhD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljBlnAACgkQAvw66wEB28KYDgCglNdCsRZvYQ68g3FG8uE6523Q
MyUAnR0yRZkN74VX/JHDSb1Ew3Z9YApR
=bsW4
-----END PGP SIGNATURE-----

--Sig_/nII1/bgheguI8gMk5htIQhD--
