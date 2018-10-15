Received: from eggs.gnu.org ([2001:4830:134:3::10]:37702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBtAw-0001LR-L4
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 23:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBtAr-0008QY-MR
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 23:04:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gBtAr-0008Pf-H1
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 23:04:05 -0400
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-3-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9c90bc11-2f65-2604-47bc-52b82fbea6fd@redhat.com>
Date: Mon, 15 Oct 2018 11:03:52 +0800
MIME-Version: 1.0
In-Reply-To: <1539266915-15216-3-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [[RFC v3 02/12] virtio: redefine structure &
 memory cache for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org
Cc: tiwei.bie@intel.com, jfreimann@redhat.com, maxime.coquelin@redhat.com



On 2018=E5=B9=B410=E6=9C=8811=E6=97=A5 22:08, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> Redefine packed ring structure according to qemu nomenclature,
> also supported data(event index, wrap counter, etc) are introduced.
>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 94f5c8e..500eecf 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -39,6 +39,13 @@ typedef struct VRingDesc
>       uint16_t next;
>   } VRingDesc;
>  =20
> +typedef struct VRingPackedDesc {
> +    uint64_t addr;
> +    uint32_t len;
> +    uint16_t id;
> +    uint16_t flags;
> +} VRingPackedDesc;
> +
>   typedef struct VRingAvail
>   {
>       uint16_t flags;
> @@ -62,8 +69,14 @@ typedef struct VRingUsed
>   typedef struct VRingMemoryRegionCaches {
>       struct rcu_head rcu;
>       MemoryRegionCache desc;
> -    MemoryRegionCache avail;
> -    MemoryRegionCache used;
> +    union {
> +        MemoryRegionCache avail;
> +        MemoryRegionCache driver;
> +    };

Can we reuse avail and used?

> +    union {
> +        MemoryRegionCache used;
> +        MemoryRegionCache device;
> +    };
>   } VRingMemoryRegionCaches;
>  =20
>   typedef struct VRing
> @@ -77,6 +90,11 @@ typedef struct VRing
>       VRingMemoryRegionCaches *caches;
>   } VRing;
>  =20
> +typedef struct VRingPackedDescEvent {
> +    uint16_t off_wrap;
> +    uint16_t flags;
> +} VRingPackedDescEvent ;
> +
>   struct VirtQueue
>   {
>       VRing vring;
> @@ -87,6 +105,10 @@ struct VirtQueue
>       /* Last avail_idx read from VQ. */
>       uint16_t shadow_avail_idx;
>  =20
> +    uint16_t event_idx;

Need a comment to explain this field.

Thanks

> +    bool event_wrap_counter;
> +    bool avail_wrap_counter;
> +
>       uint16_t used_idx;
>  =20
>       /* Last used index value we have signalled on */
