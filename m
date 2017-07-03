Received: from eggs.gnu.org ([2001:4830:134:3::10]:39801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS5P4-0003UQ-NM
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS5P0-00020s-PO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:44:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS5P0-00020V-JU
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:44:50 -0400
Date: Mon, 3 Jul 2017 20:44:41 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170703204425-mutt-send-email-mst@kernel.org>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170628190047.26159-4-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC 03/29] qemu_ram_block_host_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

On Wed, Jun 28, 2017 at 08:00:21PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Utility to give the offset of a host pointer within a RAMBlock
> (assuming we already know it's in that RAMBlock)
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  exec.c                    | 6 ++++++
>  include/exec/cpu-common.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/exec.c b/exec.c
> index 4e61226a16..a1499b9bee 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2218,6 +2218,12 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
>      return ramblock_ptr(block, addr);
>  }
>  
> +/* Return the offset of a hostpointer within a ramblock */
> +ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
> +{
> +    return (uint8_t *)host - (uint8_t *)rb->host;
> +}
> +

I'd also assert that it's within that block.

>  /*
>   * Translates a host ptr back to a RAMBlock, a ram_addr and an offset
>   * in that RAMBlock.
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 4af179b543..fa1ec22d66 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -66,6 +66,7 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr);
>  RAMBlock *qemu_ram_block_by_name(const char *name);
>  RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>                                     ram_addr_t *offset);
> +ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
>  void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
>  void qemu_ram_unset_idstr(RAMBlock *block);
>  const char *qemu_ram_get_idstr(RAMBlock *rb);
> -- 
> 2.13.0
