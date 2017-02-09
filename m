Received: from eggs.gnu.org ([2001:4830:134:3::10]:52877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbxgD-0004XV-2f
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbxgC-00078e-E8
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:59:09 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbxgC-00078S-AB
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:59:08 -0500
Received: by mail-qt0-x243.google.com with SMTP id h53so2495391qth.3
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 14:59:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
	<1485531620-121182-9-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19067a0f-01e3-4f00-e9f2-5f78fe6dde4e@amsat.org>
Date: Thu, 9 Feb 2017 19:59:04 -0300
MIME-Version: 1.0
In-Reply-To: <1485531620-121182-9-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 8/9] virtio: check for vring setup in
 virtio_queue_update_used_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com

On 01/27/2017 12:40 PM, Paolo Bonzini wrote:
> If the vring has not been set up, it is not necessary for vring_used_idx
> to do anything (as is already the case when the caller is virtio_load).
> This is harmless for now, but it will be a problem when the
> MemoryRegionCache has not been set up.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/virtio/virtio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 32bf364..23fac1e 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2154,7 +2154,9 @@ void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
>
>  void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
>  {
> -    vdev->vq[n].used_idx = vring_used_idx(&vdev->vq[n]);
> +    if (vdev->vq[n].vring.desc) {
> +        vdev->vq[n].used_idx = vring_used_idx(&vdev->vq[n]);
> +    }
>  }
>
>  void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n)
>
