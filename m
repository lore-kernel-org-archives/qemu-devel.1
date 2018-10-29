Received: from eggs.gnu.org ([2001:4830:134:3::10]:55137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH7Nf-00081Y-UQ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH7Ne-0001Se-1P
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:14:55 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH7Na-0001Ft-Eu
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:14:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id e9so5960737oti.1
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 06:14:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181026073034.16648-1-ppandit@redhat.com>
References: <20181026073034.16648-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 13:14:20 +0000
Message-ID: <CAFEAcA_WduaLJZG-gu9oywCaUb2mR9DeBJ9WKqsTkKu4uGT7Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] strongarm: mask off high[32:28] bits
 from dir and state registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Moguofang <moguofang@huawei.com>, liqsub1 <liqsub1@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 26 October 2018 at 08:30, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> The high[32:28] bits of 'direction' and 'state' registers of
> SA-1100/SA-1110 device are reserved. Setting them may lead to
> OOB 's->handler[]' array access issue. Mask off [32:28] bits to
> avoid it.

There is no bit 32 in a 32-bit value; you mean 31.

>
> Reported-by: Moguofang <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/arm/strongarm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Update v2: mask off high[32:28] bits
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05746.html
>
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index ec2627374d..dd8c4b1f2e 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -587,12 +587,12 @@ static void strongarm_gpio_write(void *opaque, hwaddr offset,
>
>      switch (offset) {
>      case GPDR:        /* GPIO Pin-Direction registers */
> -        s->dir = value;
> +        s->dir = value & 0x3fffff;

The commit message says it's masking [31:28], but the
code is masking [31:22]. The SA1110 spec suggests the
commit message is correct and the code is not.

thanks
-- PMM
