Received: from eggs.gnu.org ([2001:4830:134:3::10]:59429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHUQ0-0007TT-BU
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHUPv-0003Nv-J6
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:50:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHUPv-0003NY-6A
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:50:47 -0400
Received: by mail-ot1-x343.google.com with SMTP id e9so9622148oti.1
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:50:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030114635.31232-1-ppandit@redhat.com>
References: <20181030114635.31232-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 13:50:26 +0000
Message-ID: <CAFEAcA8bRXAbTX3e398rRYuiBQymGGVmv5S4TjN5Zgw1Jnqhpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] strongarm: mask off high[31:28] bits
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

On 30 October 2018 at 11:46, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> The high[31:28] bits of 'direction' and 'state' registers of
> SA-1100/SA-1110 device are reserved. Setting them may lead to
> OOB 's->handler[]' array access issue. Mask off [31:28] bits to
> avoid it.
>
> Reported-by: Moguofang <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/arm/strongarm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Update v3: fix the mask value to 0x0fffffff
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06088.html
>
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index ec2627374d..644a9c45b4 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -587,12 +587,12 @@ static void strongarm_gpio_write(void *opaque, hwaddr offset,
>
>      switch (offset) {
>      case GPDR:        /* GPIO Pin-Direction registers */
> -        s->dir = value;
> +        s->dir = value & 0x0fffffff;
>          strongarm_gpio_handler_update(s);
>          break;
>
>      case GPSR:        /* GPIO Pin-Output Set registers */
> -        s->olevel |= value;
> +        s->olevel |= value & 0x0fffffff;
>          strongarm_gpio_handler_update(s);
>          break;




Applied to target-arm.next, thanks.

-- PMM
