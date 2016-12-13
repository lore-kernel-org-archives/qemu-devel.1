Received: from eggs.gnu.org ([2001:4830:134:3::10]:37515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cGl5g-0004tr-N0
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cGl5b-0005yf-Mg
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:17:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cGl5b-0005xn-HA
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:17:43 -0500
Message-ID: <1481627861.27088.116.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Dec 2016 12:17:41 +0100
In-Reply-To: <20161213071439.32322-1-ppandit@redhat.com>
References: <20161213071439.32322-1-ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] display: virtio-gpu-3d: check virgl
 capabilities max_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Zhenhao Hong <zhenhaohong@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Di, 2016-12-13 at 12:44 +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> Virtio GPU device while processing 'VIRTIO_GPU_CMD_GET_CAPSET'
> command, retrieves the maximum capabilities size to fill in the
> response object. It continues to fill in capabilities even if
> retrieved 'max_size' is zero(0), thus resulting in OOB access.
> Add check to avoid it.

Hmm?  Did you see this happing in practice?

> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 758d33a..fbfb39f 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -371,11 +371,12 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>      virgl_renderer_get_cap_set(gc.capset_id, &max_ver,
>                                 &max_size);

This is not the guest returning the size, it is the host renderer
library saying how much space it needs ...

>      resp =3D g_malloc(sizeof(*resp) + max_size);
> -
> -    resp->hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;
> -    virgl_renderer_fill_caps(gc.capset_id,
> -                             gc.capset_version,
> -                             (void *)resp->capset_data);

... and here the renderer fills the qemu-allocated space with the actual
data.

Can't see anything wrong here.  It's not that we process untrusted data
without checking.  If a buffer overflow happens here this would clearly
be a bug in the virglrenderer library, because the size advertised and
the size actually needed mismatch.

cheers,
  Gerd
