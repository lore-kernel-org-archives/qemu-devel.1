Received: from eggs.gnu.org ([209.51.188.92]:45388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1nG-0007pp-OM
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1l7-0004Yb-45
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:30:54 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1l3-0004Rz-6m
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:30:52 -0500
Received: by mail-ot1-x343.google.com with SMTP id e12so24738916otl.5
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20190120143452.21683-1-stefanha@redhat.com>
	<20190120143452.21683-2-stefanha@redhat.com>
In-Reply-To: <20190120143452.21683-2-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 16:36:36 +0000
Message-ID: <CAFEAcA9KkYC7MHquASjoghuDrvkkE_brnM6teLknj1H-waM_0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/4] memory: add
 memory_region_flush_rom_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>

On Sun, 20 Jan 2019 at 14:35, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> ROM devices go via MemoryRegionOps->write() callbacks for write
> operations and do not dirty/invalidate that memory.  Device emulation
> must be able to mark memory ranges that have been modified internally
> (e.g. using memory_region_get_ram_ptr()).
>
> Introduce the memory_region_flush_rom_device() API for this purpose.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/exec/memory.h | 18 ++++++++++++++++++
>  exec.c                | 12 ++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index cd2f209b64..abe9cc79c0 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1344,6 +1344,24 @@ bool memory_region_snapshot_get_dirty(MemoryRegion *mr,
>  void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
>                                 hwaddr size, unsigned client);
>
> +/**
> + * memory_region_flush_rom_device: Mark a range of pages dirty and invalidate
> + *                                 TBs (for self-modifying code).
> + *
> + * The MemoryRegionOps->write() callback of a ROM device must use this function
> + * to mark byte ranges that have been modified internally, such as by directly
> + * accessing the memory returned by memory_region_get_ram_ptr().
> + *
> + * This function marks the range dirty and invalidates TBs so that TCG can
> + * detect self-modifying code.
> + *
> + * @mr: the region being flushed.
> + * @addr: the start, relative to the start of the region, of the range being
> + *        flushed.
> + * @size: the size, in bytes, of the range being flushed.
> + */
> +void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size);
> +
>  /**
>   * memory_region_set_readonly: Turn a memory region read-only (or read-write)
>   *
> diff --git a/exec.c b/exec.c
> index 895449f926..105ff21e74 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3162,6 +3162,18 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
>      cpu_physical_memory_set_dirty_range(addr, length, dirty_log_mask);
>  }
>
> +void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
> +{
> +    /* In principle this function would work on other memory region types too,
> +     * but the ROM device use case is the only one where this operation is
> +     * necessary.  Other memory regions should use the
> +     * address_space_read/write() APIs.
> +     */
> +    assert(memory_region_is_romd(mr));
> +
> +    invalidate_and_set_dirty(mr, addr, size);
> +}
> +
>  static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
>  {
>      unsigned access_size_max = mr->ops->valid.max_access_size;

API and implementation make sense to me, but better that Paolo reviews
this I think. I guess we should add calls to this to the pflash device
models too...

thanks
-- PMM
