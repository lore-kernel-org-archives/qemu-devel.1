Received: from eggs.gnu.org ([209.51.188.92]:51932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpCKZ-0003Du-OM
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpCKX-00077g-NJ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:24:35 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:34094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpCKV-0006wM-Is
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:24:31 -0500
Received: by mail-ot1-x32e.google.com with SMTP id t5so2802372otk.1
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 05:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20190130072131.13247-1-stefanha@redhat.com>
	<20190130072131.13247-2-stefanha@redhat.com>
In-Reply-To: <20190130072131.13247-2-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 13:24:02 +0000
Message-ID: <CAFEAcA_L3OxUCnNsWy_-CRuuQ9MtWct2S82MEdm2jTBWO+vxKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>

On Wed, 30 Jan 2019 at 07:21, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> +static void flash_write(void *opaque, hwaddr offset, uint64_t value,
> +        unsigned int size)
> +{
> +    NRF51NVMState *s = NRF51_NVM(opaque);
> +
> +    if (s->config & NRF51_NVMC_CONFIG_WEN) {
> +        uint32_t oldval;
> +
> +        assert(offset < s->flash_size);

This would be better as "offset + 4 < s->flash_size", since we're
going to be reading 4 bytes, not just 1. (Or "offset + size",
though our MemoryRegionOps fields guarantee that size == 4.)

> +
> +        /* NOR Flash only allows bits to be flipped from 1's to 0's on write */
> +        oldval = ldl_le_p(s->storage + offset);
> +        oldval &= value;
> +        stl_le_p(s->storage + offset, oldval);
> +
> +        memory_region_flush_rom_device(&s->flash, offset, size);
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: Flash write 0x%" HWADDR_PRIx" while flash not writable.\n",
> +                __func__, offset);
> +    }
> +}

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
