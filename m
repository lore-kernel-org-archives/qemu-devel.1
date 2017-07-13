Received: from eggs.gnu.org ([2001:4830:134:3::10]:48712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVcQI-00085q-5d
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVcQF-0006ia-Lx
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:36:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVcQF-0006iP-FK
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:36:43 -0400
References: <1499874119-67558-1-git-send-email-peng.hao2@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50fcbf5f-5f3d-9407-40ac-83f2c3106bf9@redhat.com>
Date: Thu, 13 Jul 2017 13:36:33 +0200
MIME-Version: 1.0
In-Reply-To: <1499874119-67558-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3] chardev: fix parallel device can't be
 reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, wang.yechao255@zte.com.cn, jiang.biao2@zte.com.cn

On 12/07/2017 17:41, Peng Hao wrote:
> Parallel device don't register be->chr_can_read function, but remote
> disconnect event is handled in chr_read.So connected parallel device
> can not detect remote disconnect event. The chardevs with chr_can_read=NULL
> has the same problem.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>  hw/char/parallel.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index 75a1a2f..b33bbb8 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -503,6 +503,10 @@ static const VMStateDescription vmstate_parallel_isa = {
>      }
>  };
>  
> +static int parallel_can_receive(void *opaque)
> +{
> +     return 1;
> +}
>  
>  static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
>  {
> @@ -535,6 +539,8 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
>      isa_init_irq(isadev, &s->irq, isa->isairq);
>      qemu_register_reset(parallel_reset, s);
>  
> +    qemu_chr_fe_set_handlers(&s->chr, parallel_can_receive, NULL,
> +                             NULL, s, NULL, true);
>      if (qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_PP_READ_STATUS, &dummy) == 0) {
>          s->hw_driver = 1;
>          s->status = dummy;
> 


Sounds good for a simple fix.

Thanks,

Paolo
