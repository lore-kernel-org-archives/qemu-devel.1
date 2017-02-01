Received: from eggs.gnu.org ([2001:4830:134:3::10]:42421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZ0iz-0001nT-F6
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 14:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZ0iw-0003J5-Bs
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 14:37:49 -0500
Received: from mail.kernel.org ([198.145.29.136]:55280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cZ0iw-0003FI-1M
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 14:37:46 -0500
Date: Wed, 1 Feb 2017 11:37:40 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170201065202.7746-1-jgross@suse.com>
Message-ID: <alpine.DEB.2.10.1702011134020.17946@sstabellini-ThinkPad-X260>
References: <20170201065202.7746-1-jgross@suse.com>
MIME-Version: 1.0
Content-ID: <alpine.DEB.2.10.1702011134140.17946@sstabellini-ThinkPad-X260>
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] xen: use qdev_unplug() instead of
 g_free() in xen_pv_find_xendev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, kraxel@redhat.com, sstabellini@kernel.org, jgross@suse.com

Hi Peter,

do you think this is acceptable?

Thanks,

Stefano

On Wed, 1 Feb 2017, Juergen Gross wrote:
> The error exits of xen_pv_find_xendev() free the new xen-device via
> g_free() which is wrong.
>=20
> As the xen-device has been initialized as qdev it must be removed
> via qdev_unplug().
>=20
> This bug has been introduced with commit 3a6c9172ac5951e6dac2b3f6
> ("xen: create qdev for each backend device").
>=20
> Reported-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> Tested-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2: set free method to avoid memory leak (Peter Maydell)
>     use DEVICE(xendev) instead of &xendev->qdev (Peter Maydell)
> ---
>  hw/xen/xen_backend.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index d119004..6c21c37 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -124,10 +124,11 @@ static struct XenDevice *xen_be_get_xendev(const =
char *type, int dom, int dev,
>      /* init new xendev */
>      xendev =3D g_malloc0(ops->size);
>      object_initialize(&xendev->qdev, ops->size, TYPE_XENBACKEND);
> -    qdev_set_parent_bus(&xendev->qdev, xen_sysbus);
> -    qdev_set_id(&xendev->qdev, g_strdup_printf("xen-%s-%d", type, dev)=
);
> -    qdev_init_nofail(&xendev->qdev);
> -    object_unref(OBJECT(&xendev->qdev));
> +    OBJECT(xendev)->free =3D g_free;
> +    qdev_set_parent_bus(DEVICE(xendev), xen_sysbus);
> +    qdev_set_id(DEVICE(xendev), g_strdup_printf("xen-%s-%d", type, dev=
));
> +    qdev_init_nofail(DEVICE(xendev));
> +    object_unref(OBJECT(xendev));
> =20
>      xendev->type  =3D type;
>      xendev->dom   =3D dom;
> @@ -145,7 +146,7 @@ static struct XenDevice *xen_be_get_xendev(const ch=
ar *type, int dom, int dev,
>      xendev->evtchndev =3D xenevtchn_open(NULL, 0);
>      if (xendev->evtchndev =3D=3D NULL) {
>          xen_pv_printf(NULL, 0, "can't open evtchn device\n");
> -        g_free(xendev);
> +        qdev_unplug(DEVICE(xendev), NULL);
>          return NULL;
>      }
>      fcntl(xenevtchn_fd(xendev->evtchndev), F_SETFD, FD_CLOEXEC);
> @@ -155,7 +156,7 @@ static struct XenDevice *xen_be_get_xendev(const ch=
ar *type, int dom, int dev,
>          if (xendev->gnttabdev =3D=3D NULL) {
>              xen_pv_printf(NULL, 0, "can't open gnttab device\n");
>              xenevtchn_close(xendev->evtchndev);
> -            g_free(xendev);
> +            qdev_unplug(DEVICE(xendev), NULL);
>              return NULL;
>          }
>      } else {
> --=20
> 2.10.2
>=20
