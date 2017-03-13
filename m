Received: from eggs.gnu.org ([2001:4830:134:3::10]:51130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cnWSJ-0002Ya-Br
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cnWSG-0004l7-7p
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cnWSF-0004kC-V6
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 16:20:32 -0400
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
	<1488777954-4578-13-git-send-email-jasowang@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <b3d2249e-9eb9-8621-e4c7-c77ac0962615@redhat.com>
Date: Mon, 13 Mar 2017 21:20:27 +0100
MIME-Version: 1.0
In-Reply-To: <1488777954-4578-13-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL RESEND 12/19] vmxnet3: Convert ring values
 to uint32_t's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org

On 06/03/2017 06:25, Jason Wang wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The index's in the Vmxnet3Ring were migrated as 32bit ints
> yet are declared as size_t's.  They appear to be derived
> from 32bit values loaded from guest memory, so actually
> store them as that.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Acked-by: Dmitry Fleytman <dmitry@daynix.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/vmxnet3.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index e13a798..224c109 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -141,17 +141,17 @@ typedef struct VMXNET3Class {
>  /* Cyclic ring abstraction */
>  typedef struct {
>      hwaddr pa;
> -    size_t size;
> -    size_t cell_size;
> -    size_t next;
> +    uint32_t size;
> +    uint32_t cell_size;
> +    uint32_t next;
>      uint8_t gen;
>  } Vmxnet3Ring;
>  
>  static inline void vmxnet3_ring_init(PCIDevice *d,
>  				     Vmxnet3Ring *ring,
>                                       hwaddr pa,
> -                                     size_t size,
> -                                     size_t cell_size,
> +                                     uint32_t size,
> +                                     uint32_t cell_size,
>                                       bool zero_region)
>  {
>      ring->pa = pa;
> @@ -166,7 +166,7 @@ static inline void vmxnet3_ring_init(PCIDevice *d,
>  }
>  
>  #define VMXNET3_RING_DUMP(macro, ring_name, ridx, r)                         \
> -    macro("%s#%d: base %" PRIx64 " size %zu cell_size %zu gen %d next %zu",  \
> +    macro("%s#%d: base %" PRIx64 " size %u cell_size %u gen %d next %u",  \
>            (ring_name), (ridx),                                               \
>            (r)->pa, (r)->size, (r)->cell_size, (r)->gen, (r)->next)
>  
> 


David, with '-dump-vmstate' with 2.8 machine type and with v2.8 and
master I can see the size of "txq_descr" and "rxq_descr" changes because
of "sizeof(Vmxnet3TxqDescr)" and "sizeof(Vmxnet3RxqDescr)". This changes
because the size of Vmxnet3Ring has changed with the s/size_t/uint32_t/":

        {
          "field": "txq_descr",
          "version_id": 0,
          "field_exists": false,
          "size": 176
        },
        {
          "field": "rxq_descr",
          "version_id": 0,
          "field_exists": false,
          "size": 216
        },

becomes:

        {
          "field": "txq_descr",
          "version_id": 0,
          "field_exists": false,
          "size": 144
        },
        {
          "field": "rxq_descr",
          "version_id": 0,
          "field_exists": false,
          "size": 168
        },

And if I try a migration, I have:

qemu/migration/vmstate.c:112: vmstate_load_state: Assertion `first_elem
|| !n_elems' failed.

Laurent
