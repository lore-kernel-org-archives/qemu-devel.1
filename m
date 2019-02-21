Received: from eggs.gnu.org ([209.51.188.92]:35833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwsIa-0006Nq-Lm
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwsIZ-0004EX-RY
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:38:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwsIX-0004DM-PJ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:38:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so16933024wrt.11
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:38:13 -0800 (PST)
References: <20190221114330.17968-1-marcandre.lureau@redhat.com>
	<20190221114330.17968-5-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0513055b-88f4-296e-e89e-f5e06ff99cea@redhat.com>
Date: Thu, 21 Feb 2019 18:38:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190221114330.17968-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] virtio-gpu: remove useless 'waiting'
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 2/21/19 12:43 PM, Marc-André Lureau wrote:
> Let's check renderer_blocked instead directly.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/virtio/virtio-gpu.h | 1 -
>  hw/display/virtio-gpu.c        | 4 +---
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index f8cd8ee96f..26a6698266 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -81,7 +81,6 @@ struct virtio_gpu_ctrl_command {
>      VirtQueue *vq;
>      struct virtio_gpu_ctrl_hdr cmd_hdr;
>      uint32_t error;
> -    bool waiting;
>      bool finished;
>      QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
>  };
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 7ada4b83ac..0baa9ac0ad 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -889,8 +889,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
>      while (!QTAILQ_EMPTY(&g->cmdq)) {
>          cmd = QTAILQ_FIRST(&g->cmdq);
>  
> -        cmd->waiting = g->renderer_blocked;
> -        if (cmd->waiting) {
> +        if (g->renderer_blocked) {
>              break;
>          }
>  
> @@ -939,7 +938,6 @@ static void virtio_gpu_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>          cmd->vq = vq;
>          cmd->error = 0;
>          cmd->finished = false;
> -        cmd->waiting = false;
>          QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
>          cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
>      }
> 
