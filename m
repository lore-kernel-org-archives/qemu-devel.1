Received: from eggs.gnu.org ([209.51.188.92]:48778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjM5Z-0003wa-Sl
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjM5Z-0001es-3A
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:36:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjM5Y-0001dE-U2
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:36:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so2346026wrw.5
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 02:36:55 -0800 (PST)
References: <1547546927-18006-1-git-send-email-dimastep@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fe074b97-8af7-ebbf-4f03-7519cc007a87@redhat.com>
Date: Tue, 15 Jan 2019 11:36:52 +0100
MIME-Version: 1.0
In-Reply-To: <1547546927-18006-1-git-send-email-dimastep@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] virtio: add checks for the size of the
 indirect table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dima Stepanov <dimastep@yandex-team.ru>, mst@redhat.com, qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru

On 1/15/19 11:08 AM, Dima Stepanov wrote:
> The virtqueue_pop() and virtqueue_get_avail_bytes() routines can use the
> INDIRECT table to get the data. It is possible to create a packet which
> will lead to the assert message like:
>   include/exec/memory.h:1995: void
>   address_space_read_cached(MemoryRegionCache *, hwaddr, void *, int):
>   Assertion `addr < cache->len && len <= cache->len - addr' failed.
>   Aborted
> To do it the first descriptor should have a link to the INDIRECT table
> and set the size of it to 0. It doesn't look good that the guest should
> be able to trigger the assert in qemu. Add additional check for the size
> of the INDIRECT table, which should not be 0.
> 
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/virtio/virtio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 22bd1ac..a1ff647 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -646,7 +646,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
>          vring_desc_read(vdev, &desc, desc_cache, i);
>  
>          if (desc.flags & VRING_DESC_F_INDIRECT) {
> -            if (desc.len % sizeof(VRingDesc)) {
> +            if (!desc.len || (desc.len % sizeof(VRingDesc))) {
>                  virtio_error(vdev, "Invalid size for indirect buffer table");
>                  goto err;
>              }
> @@ -902,7 +902,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>      desc_cache = &caches->desc;
>      vring_desc_read(vdev, &desc, desc_cache, i);
>      if (desc.flags & VRING_DESC_F_INDIRECT) {
> -        if (desc.len % sizeof(VRingDesc)) {
> +        if (!desc.len || (desc.len % sizeof(VRingDesc))) {
>              virtio_error(vdev, "Invalid size for indirect buffer table");
>              goto done;
>          }
> 
