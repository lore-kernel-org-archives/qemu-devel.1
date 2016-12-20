Received: from eggs.gnu.org ([2001:4830:134:3::10]:53592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cJII9-0003wG-45
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cJII4-0005TC-Uk
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:09:09 -0500
Received: from mail-yw0-x230.google.com ([2607:f8b0:4002:c05::230]:34959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cJII4-0005Sg-PV
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 06:09:04 -0500
Received: by mail-yw0-x230.google.com with SMTP id i145so80449599ywg.2
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 03:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20161214070156.23368-1-ppandit@redhat.com>
In-Reply-To: <20161214070156.23368-1-ppandit@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 20 Dec 2016 11:08:52 +0000
Message-ID: <CAJ+F1CJq2tp+-sDjX6EqZ7mFx63uUkc3=i8yaQyVmmG1c1RTNw@mail.gmail.com>
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
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Zhenhao Hong <zhenhaohong@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

Hi

On Wed, Dec 14, 2016 at 8:02 AM P J P <ppandit@redhat.com> wrote:

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Virtio GPU device while processing 'VIRTIO_GPU_CMD_GET_CAPSET'
> command, retrieves the maximum capabilities size to fill in the
> response object. It continues to fill in capabilities even if
> retrieved 'max_size' is zero(0), thus resulting in OOB access.
> Add check to avoid it.
>
> Reported-by: Zhenhao Hong <zhenhaohong@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/display/virtio-gpu-3d.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 758d33a..6ceeba3 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -370,8 +370,12 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>
>      virgl_renderer_get_cap_set(gc.capset_id, &max_ver,
>                                 &max_size);
> +    if (!max_size) {
>

Shouldn't it check for >=3D sizeof(union virgl_caps) ? (since that's what
virglrenderer vrend_renderer_fill_caps() expects)


+        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
>      resp =3D g_malloc(sizeof(*resp) + max_size);
> -
>      resp->hdr.type =3D VIRTIO_GPU_RESP_OK_CAPSET;
>      virgl_renderer_fill_caps(gc.capset_id,
>                               gc.capset_version,
> --
> 2.9.3
>
> --
Marc-Andr=C3=A9 Lureau
