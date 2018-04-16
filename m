Received: from eggs.gnu.org ([2001:4830:134:3::10]:40102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f83uj-0000Yn-6U
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f83ui-0005R1-1W
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:11:21 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f83uh-0005Qg-RZ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:11:19 -0400
Received: by mail-ot0-x244.google.com with SMTP id m22-v6so17251537otf.8
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 06:11:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523518688-26674-6-git-send-email-eric.auger@redhat.com>
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-6-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 14:10:58 +0100
Message-ID: <CAFEAcA-8xH7Tmr7mz9Gjk6jX=RgjVWX9cqVnpNr2kCAs0pb5xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 05/17] hw/arm/smmuv3: Wired IRQ and
 GERROR helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On 12 April 2018 at 08:37, Eric Auger <eric.auger@redhat.com> wrote:
> We introduce some helpers to handle wired IRQs and especially
> GERROR interrupt. SMMU writes GERROR register on GERROR event
> and SW acks GERROR interrupts by setting GERRORn.
>
> The Wired interrupts are edge sensitive hence the pulse usage.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
>
> ---
> v9 - v10:
> - s/hwaddr/uint64_t in trace-events
> - use qemu_log_mask LOG_UNIMP on PRI IRQ
> - add a comment saying smmuv3_trigger_irq and smmuv3_write_gerrorn
>   will become static later on
> - write gerrorn without filtering (ie. even if the guest toggles non
>   active IRQs)
> - pulse if at least one new IRQ type
> - smmuv3_eventq_irq_enabled and smmuv3_gerror_irq_enabled become
>   static inline
>
> v7 -> v8:
> - remove SMMU_PENDING_GERRORS macro
> - properly toggle gerror
> - properly sanitize gerrorn write
> ---
>  hw/arm/smmuv3-internal.h | 36 +++++++++++----------------
>  hw/arm/smmuv3.c          | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events      |  3 +++
>  3 files changed, 81 insertions(+), 22 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index a6461fe..32f81d4 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -129,28 +129,6 @@ typedef struct Evt  {
>      uint32_t word[8];
>  } Evt;
>
> -/**
> - * smmu_read64 - 64-bit register read utility function supporting
> - * aligned 32-bit word access to both 32-bit halves and aligned 64-bit
> - * access.
> - *
> - * @r: register address
> - * @offset: byte offset if 32-bit access
> - * @size: read byte size
> - */
> -static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
> -                                   unsigned size)
> -{
> -    if (size == 8) {
> -        return r;
> -    }
> -
> -    /* 32 bit access */
> -    assert(!offset || offset == 4);
> -
> -    return extract64(r, offset << 3, 32);
> -}
> -

Ah, this change should be squashed into the previous patch,
which addresses one of my review comments there.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
