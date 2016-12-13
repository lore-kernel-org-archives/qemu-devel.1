Received: from eggs.gnu.org ([2001:4830:134:3::10]:55176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGkNy-0002ap-94
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGkNt-0006Sp-Dk
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:32:38 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cGkNt-0006SO-9d
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:32:33 -0500
Received: by mail-io0-f193.google.com with SMTP id y124so27723408iof.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 02:32:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480386565-10077-1-git-send-email-liq3ea@gmail.com>
References: <1480386565-10077-1-git-send-email-liq3ea@gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 13 Dec 2016 18:31:32 +0800
Message-ID: <CAKXe6SJeJc-FasLK=SEs+sjCXmcevrdcwPsgie8Zi-5-nuWPog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: call cleanup mapping function
 in resource destroy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>, Li Qiang <liq3ea@gmail.com>

Ping!

2016-11-29 10:29 GMT+08:00 Li Qiang <liq3ea@gmail.com>:

> If the guest destroy the resource before detach banking, the 'iov'
> and 'addrs' field in resource is not freed thus leading memory
> leak issue. This patch avoid this.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/display/virtio-gpu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 60bce94..98dadf2 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -28,6 +28,8 @@
>  static struct virtio_gpu_simple_resource*
>  virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id);
>
> +static void virtio_gpu_cleanup_mapping(struct virtio_gpu_simple_resource
> *res);
> +
>  #ifdef CONFIG_VIRGL
>  #include <virglrenderer.h>
>  #define VIRGL(_g, _virgl, _simple, ...)                     \
> @@ -358,6 +360,7 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
>                                          struct virtio_gpu_simple_resource
> *res)
>  {
>      pixman_image_unref(res->image);
> +    virtio_gpu_cleanup_mapping(res);
>      QTAILQ_REMOVE(&g->reslist, res, next);
>      g_free(res);
>  }
> --
> 1.8.3.1
>
>
