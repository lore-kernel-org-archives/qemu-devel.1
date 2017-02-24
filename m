Received: from eggs.gnu.org ([2001:4830:134:3::10]:48279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chC3q-0000cI-6V
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chC3l-0003z6-8g
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:21:10 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chC3l-0003yr-0m
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:21:05 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so1999245wmv.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 01:21:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
	<1487715299-21102-7-git-send-email-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce5372a6-4fd7-fcff-f773-e8529727b4de@redhat.com>
Date: Fri, 24 Feb 2017 10:21:03 +0100
MIME-Version: 1.0
In-Reply-To: <1487715299-21102-7-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/9] virtio-gpu: use graphic_* variables.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>



On 21/02/2017 23:14, Gerd Hoffmann wrote:
> If graphic_* variables are set (via -g switch), pass on
> that information to the guest so the driver can use it.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/virtio-gpu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 9b530ab..04ba221 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1170,8 +1170,13 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>      virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
>                  g->config_size);
>  
> -    g->req_state[0].width = 1024;
> -    g->req_state[0].height = 768;
> +    if (graphic_width && graphic_height) {
> +        g->req_state[0].width = graphic_width;
> +        g->req_state[0].height = graphic_height;
> +    } else {
> +        g->req_state[0].width = 1024;
> +        g->req_state[0].height = 768;
> +    }

What about adding properties for this, and only using graphic_* as a
fallback?

Paolo

>      if (virtio_gpu_virgl_enabled(g->conf)) {
>          /* use larger control queue in 3d mode */
> 
