Received: from eggs.gnu.org ([2001:4830:134:3::10]:45574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDSQ-0006RE-JX
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDSN-0005xz-AE
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:11:26 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:37149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDSN-0005xm-5y
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 08:11:23 -0400
Received: by mail-qt0-x243.google.com with SMTP id g13so1801913qta.4
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 05:11:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-5-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bc715b25-2a2c-d692-6bed-1f8364634e1b@amsat.org>
Date: Fri, 25 Aug 2017 09:11:17 -0300
MIME-Version: 1.0
In-Reply-To: <20170824192730.8440-5-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 04/32] qemu_ram_block_host_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com, peterx@redhat.com, quintela@redhat.com

Hi David,

On 08/24/2017 04:27 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Utility to give the offset of a host pointer within a RAMBlock
> (assuming we already know it's in that RAMBlock)
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   exec.c                    | 10 ++++++++++
>   include/exec/cpu-common.h |  1 +
>   2 files changed, 11 insertions(+)
> 
> diff --git a/exec.c b/exec.c
> index 67df2909ce..35b4cea2ed 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2231,6 +2231,16 @@ static void *qemu_ram_ptr_length(RAMBlock *ram_block, ram_addr_t addr,
>       return ramblock_ptr(block, addr);
>   }
>   
> +/* Return the offset of a hostpointer within a ramblock */
> +ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
> +{
> +    ram_addr_t res = (uint8_t *)host - (uint8_t *)rb->host;

What about using ptrdiff_t here,

> +    assert((uint8_t *)host >= (uint8_t *)rb->host);

and uintptr_t here?

> +    assert(res < rb->max_length);
> +
> +    return res;
> +}
> +
>   /*
>    * Translates a host ptr back to a RAMBlock, a ram_addr and an offset
>    * in that RAMBlock.
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 74341b19d2..0d861a6289 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -68,6 +68,7 @@ ram_addr_t qemu_ram_addr_from_host(void *ptr);
>   RAMBlock *qemu_ram_block_by_name(const char *name);
>   RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>                                      ram_addr_t *offset);
> +ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
>   void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
>   void qemu_ram_unset_idstr(RAMBlock *block);
>   const char *qemu_ram_get_idstr(RAMBlock *rb);
> 
