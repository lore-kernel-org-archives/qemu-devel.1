Received: from eggs.gnu.org ([2001:4830:134:3::10]:36553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOouO-0001hY-Fg
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOouN-0000jD-7z
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:04:00 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOouN-0000ix-2l
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:03:59 -0500
Received: by mail-oi0-x241.google.com with SMTP id y75so14594671oie.4
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 10:03:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171212041539.25700-1-ppandit@redhat.com>
References: <20171212041539.25700-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 18:03:37 +0000
Message-ID: <CAFEAcA8Vh=5mUi-0x0kdeKPed8so2GX+vCUm_hZoCDY5257DGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1] display: limit irq handler index to
 TC6393XB_GPIOS
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

On 12 December 2017 at 04:15, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> The ctz32() routine could return value greater than
> TC6393XB_GPIOS=16. This could lead to an OOB array access.
> Mask 'level' to avoid it.
>
> Reported-by: Moguofang <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/display/tc6393xb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> Update: mask 'level' value to TC6393XB_GPIOS=16
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg01685.html
>
> diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
> index 74d10af3d4..0ae63605f0 100644
> --- a/hw/display/tc6393xb.c
> +++ b/hw/display/tc6393xb.c
> @@ -172,6 +172,7 @@ static void tc6393xb_gpio_handler_update(TC6393xbState *s)
>      int bit;
>
>      level = s->gpio_level & s->gpio_dir;
> +    level &= MAKE_64BIT_MASK(0, TC6393XB_GPIOS);
>
>      for (diff = s->prev_level ^ level; diff; diff ^= 1 << bit) {
>          bit = ctz32(diff);

Thanks; applied to target-arm.next for 2.12.

-- PMM
