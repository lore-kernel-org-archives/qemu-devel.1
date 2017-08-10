Received: from eggs.gnu.org ([2001:4830:134:3::10]:36033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfn1S-0001y4-Sb
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfn1R-0000UY-O2
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:57:10 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dfn1R-0000Tz-Fc
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:57:09 -0400
Received: by mail-wr0-x22d.google.com with SMTP id c24so2829458wra.1
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 05:57:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498577836-25883-7-git-send-email-edgar.iglesias@gmail.com>
References: <1498577836-25883-1-git-send-email-edgar.iglesias@gmail.com>
	<1498577836-25883-7-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2017 13:56:47 +0100
Message-ID: <CAFEAcA_7_EwgxfnEmr+moHc5u4uprKjyL+ZA1VzspYwqONjfCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 6/7] exec: allow to get a pointer for
 some mmio memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 27 June 2017 at 16:37, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
>
> This introduces a special callback which allows to run code from some MMIO
> devices.
>
> SysBusDevice with a MemoryRegion which implements the request_ptr callback will
> be notified when the guest try to execute code from their offset. Then it will
> be able to eg: pre-load some code from an SPI device or ask a pointer from an
> external simulator, etc..
>
> When the pointer or the data in it are no longer valid the device has to
> invalidate it.

> +static void memory_region_do_invalidate_mmio_ptr(CPUState *cpu,
> +                                                 run_on_cpu_data data)
> +{
> +    MMIOPtrInvalidate *invalidate_data = (MMIOPtrInvalidate *)data.host_ptr;
> +    MemoryRegion *mr = invalidate_data->mr;
> +    hwaddr offset = invalidate_data->offset;
> +    unsigned size = invalidate_data->size;
> +    MemoryRegionSection section = memory_region_find(mr, offset, size);
> +
> +    qemu_mutex_lock_iothread();
> +
> +    /* Reset dirty so this doesn't happen later. */
> +    cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
> +
> +    if (section.mr != mr) {
> +        /* memory_region_find add a ref on section.mr */
> +        memory_region_unref(section.mr);
> +        if (MMIO_INTERFACE(section.mr->owner)) {

Could somebody explain why it's OK to unref section.mr here before
we go on to do things with it, rather than only unrefing it after
we've finished using it?

Also, by my reading memory_region_find() will always ref
ret.mr (if it's not NULL), whereas this code only unrefs it
if section.mr == mr. Does this leak a reference in the case
where section.mr != mr, or am I missing something ?

> +            /* We found the interface just drop it. */
> +            object_property_set_bool(section.mr->owner, false, "realized",
> +                                     NULL);
> +            object_unref(section.mr->owner);
> +            object_unparent(section.mr->owner);
> +        }
> +    }
> +
> +    qemu_mutex_unlock_iothread();
> +
> +    if (invalidate_data->allocated) {
> +        g_free(invalidate_data);
> +    } else {
> +        invalidate_data->busy = 0;
> +    }
> +}

thanks
-- PMM
