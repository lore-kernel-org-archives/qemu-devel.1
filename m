Received: from eggs.gnu.org ([2001:4830:134:3::10]:59570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cMbCZ-000270-G2
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cMbCU-00041V-Ku
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:57:03 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:45297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cMbCU-00040k-CL
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:56:58 -0500
Date: Thu, 29 Dec 2016 08:56:40 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <2074312993.7518572.1483019800774.JavaMail.zimbra@redhat.com>
In-Reply-To: <1482999086-59795-1-git-send-email-liq3ea@gmail.com>
References: <1482999086-59795-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu-3d: fix memory leak in resource
 attach backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: kraxel@redhat.com, marcandre lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, liqiang6-s@360.cn

Hi

----- Original Message -----
> If the virgl_renderer_resource_attach_iov function fails the
> 'res_iovs' will be leaked. Add check of the return value to
> free the 'res_iovs' when failing.
>=20
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Interestingly, in vrend_renderer_resource_attach_iov(), if the resource has=
 already been attached, it returns 0 too, which will also leak. I guess the=
 fix is it return an error in this case.


> ---
>  hw/display/virtio-gpu-3d.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 23f39de..07b3691 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -291,8 +291,11 @@ static void virgl_resource_attach_backing(VirtIOGPU =
*g,
>          return;
>      }
> =20
> -    virgl_renderer_resource_attach_iov(att_rb.resource_id,
> -                                       res_iovs, att_rb.nr_entries);
> +    ret =3D virgl_renderer_resource_attach_iov(att_rb.resource_id,
> +                                             res_iovs, att_rb.nr_entries=
);
> +
> +    if (ret !=3D 0)
> +        virtio_gpu_cleanup_mapping_iov(res_iovs, att_rb.nr_entries);


>  }
> =20
>  static void virgl_resource_detach_backing(VirtIOGPU *g,
> --
> 1.8.3.1
>=20
>=20
