Received: from eggs.gnu.org ([2001:4830:134:3::10]:51562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOM0O-0005Bp-It
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOM0I-0005gA-OB
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:12:16 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:36308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOM0I-0005fh-J3
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:12:10 -0500
Received: by mail-ot0-x233.google.com with SMTP id d5so14369635oti.3
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 03:12:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171211105546.16466-1-ppandit@redhat.com>
References: <20171211105546.16466-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2017 11:11:49 +0000
Message-ID: <CAFEAcA9=AzBE7CCGwHZtueyXzEGXXXSAb0ynhc-+6tzQfk5jrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] display: check irq handler index before
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Moguofang <moguofang@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>

On 11 December 2017 at 10:55, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> The ctz32() routine could return value greater than
> TC6393XB_GPIOS=16. This could lead to an OOB array access.
> Add check to avoid it.
>
> Reported-by: Moguofang <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/display/tc6393xb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
> index 74d10af3d4..78292cb847 100644
> --- a/hw/display/tc6393xb.c
> +++ b/hw/display/tc6393xb.c
> @@ -175,6 +175,10 @@ static void tc6393xb_gpio_handler_update(TC6393xbState *s)
>
>      for (diff = s->prev_level ^ level; diff; diff ^= 1 << bit) {
>          bit = ctz32(diff);
> +        if (bit >= TC6393XB_GPIOS) {
> +            fprintf(stderr, "TC6393xb: no GPIO pin %d\n", bit);
> +            return;
> +        }
>          qemu_set_irq(s->handler[bit], (level >> bit) & 1);
>      }

It would be more sensible to just mask off the top bits of
'level' before starting the loop, rather than checking every
time around the loop:
   level &= MAKE_64BIT_MASK(0, TC6493XB_GPIOS);

Also, if we want to warn about the guest having set a GPIO
bit we don't implement this isn't the best place to do it --
it would make more sense to do that only if the guest writes
something non-zero to SCR_GPO_DSR(2), and as an LOG_UNIMP warning.
But I don't think it's worth the effort since this is only used
on the ancient 'tosa' board.

thanks
-- PMM
