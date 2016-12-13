Received: from eggs.gnu.org ([2001:4830:134:3::10]:54468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cGpXk-0006dJ-9A
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cGpXe-0004Uj-LF
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:03:04 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cGpXe-0004UN-8z
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:02:58 -0500
Received: by mail-lf0-f67.google.com with SMTP id 96so368425lfs.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 08:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20161213071439.32322-1-ppandit@redhat.com>
	<1481627861.27088.116.camel@redhat.com>
	<alpine.LFD.2.20.1612131703450.6298@wniryva>
	<1481630872.27088.128.camel@redhat.com>
	<alpine.LFD.2.20.1612131946260.6601@wniryva>
In-Reply-To: <alpine.LFD.2.20.1612131946260.6601@wniryva>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Dec 2016 16:01:45 +0000
Message-ID: <CAJ+F1CLUhToO9jNsx3V88h6aVmswdJE3Z8KtM2j75OVdqy6gHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: P J P <ppandit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Zhenhao Hong <zhenhaohong@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>

Hi

On Tue, Dec 13, 2016 at 5:27 PM P J P <ppandit@redhat.com> wrote:

> +-- On Tue, 13 Dec 2016, Gerd Hoffmann wrote --+
> | I guess we want throw an error (VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER)
> | in the error case then instead of leaving resp->hdr.type unset.
>
>   I see, okay. Does the patch below look okay?
>
> =3D=3D=3D
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 758d33a..6ceeba3 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -370,8 +370,12 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>
>      virgl_renderer_get_cap_set(gc.capset_id, &max_ver,
>                                 &max_size);
> -    resp =3D g_malloc(sizeof(*resp) + max_size);
> +    if (!max_size) {
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
>
> +    resp =3D g_malloc(sizeof(*resp) + max_size);
>      resp->hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;
>      virgl_renderer_fill_caps(gc.capset_id,
>                               gc.capset_version,
> =3D=3D=3D
>
>
That looks good to me, waiting for the proper patch.


> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
>
> --
Marc-Andr=C3=A9 Lureau
