Received: from eggs.gnu.org ([2001:4830:134:3::10]:47677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEjXQ-0000il-9G
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEjXN-0007NU-1B
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:23:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEjXM-0007NK-Qv
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:23:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so11881368wmf.1
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 16:23:04 -0700 (PDT)
References: <20181022181035.20104-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <31102692-e821-9fb2-c5fa-a6fd021e4c23@redhat.com>
Date: Tue, 23 Oct 2018 01:23:02 +0200
MIME-Version: 1.0
In-Reply-To: <20181022181035.20104-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] arm: check bit index before usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, liqsub1 <liqsub1@163.com>, Moguofang <moguofang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

Hi Prasad,

On 22/10/18 20:10, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While performing gpio write via strongarm_gpio_handler_update
> routine, the 'bit' index could access beyond s->handler[28] array.
> Add check to avoid OOB access.
> 
> Reported-by: Moguofang <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   hw/arm/strongarm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Update v1: use ARRAY_SIZE macro
>    -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04826.html
> 
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index ec2627374d..9225b1ba6e 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -532,7 +532,9 @@ static void strongarm_gpio_handler_update(StrongARMGPIOInfo *s)
>   
>       for (diff = s->prev_level ^ level; diff; diff ^= 1 << bit) {
>           bit = ctz32(diff);
> -        qemu_set_irq(s->handler[bit], (level >> bit) & 1);
> +        if (bit < ARRAY_SIZE(s->handler)) {
> +            qemu_set_irq(s->handler[bit], (level >> bit) & 1);

            } else {
                	qemu_log_mask(LOG_GUEST_ERROR, ...

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        }
>       }
>   
>       s->prev_level = level;
> 
