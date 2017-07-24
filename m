Received: from eggs.gnu.org ([2001:4830:134:3::10]:60820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZbvL-00075N-Uk
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZbvI-0005SF-SB
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:53:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZbvI-0005S7-Iy
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:53:16 -0400
References: <1500921322-36875-1-git-send-email-peng.hao2@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2d87744-a823-977a-df1f-dc54d664e5e3@redhat.com>
Date: Mon, 24 Jul 2017 13:53:04 +0200
MIME-Version: 1.0
In-Reply-To: <1500921322-36875-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3] rtc: fix a infinite loop in windows vm
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, mst@redhat.com
Cc: qemu-devel@nongnu.org, Liu Yi <liu.yi24@zte.com.cn>

On 24/07/2017 20:35, Peng Hao wrote:
> When a windows vm starts, periodic timer of rtc will stop several times.
> windows kernel will check whether REG_A_UIP is changed. REG_C's interrupt
> flags will not be cleared when periodic timer stops and the update timer
> will switch to alarm timer. So the expiration time of alarm timer is very
> long and REG_A_UIP will not vary.At last windows kernel will repeat to 
> check REG_A_UIP all the time.

This should not happen.  REG_A_UIP is set and cleared in register A
every second, like this:

        case RTC_REG_A:
            if (update_in_progress(s)) {
                s->cmos_data[s->cmos_index] |= REG_A_UIP;
            } else {
                s->cmos_data[s->cmos_index] &= ~REG_A_UIP;
            }
            ret = s->cmos_data[s->cmos_index];
            break;

where update_in_progress does:

    guest_nsec = get_guest_rtc_ns(s);
    /* UIP bit will be set at last 244us of every second. */
    if ((guest_nsec % NANOSECONDS_PER_SECOND) >=
        (NANOSECONDS_PER_SECOND - UIP_HOLD_LENGTH)) {
        return 1;
    }
    return 0;

This is done even if the timer is not pending.

How can the bug be reproduced?

Paolo

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Liu Yi <liu.yi24@zte.com.cn>
> ---
>  hw/timer/mc146818rtc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 1b8d3d7..aa55fae 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -457,6 +457,8 @@ static void rtc_update_timer(void *opaque)
>      if ((new_irqs & s->cmos_data[RTC_REG_B]) != 0) {
>          s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
>          qemu_irq_raise(s->irq);
> +    } else if ((s->cmos_data[RTC_REG_B] & REG_B_UIE) == 0) {
> +        s->cmos_data[RTC_REG_C] &= ~REG_C_UF;
>      }
>      check_update_timer(s);
>  }
> @@ -559,7 +561,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
>                  s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
>                  qemu_irq_raise(s->irq);
>              } else {
> -                s->cmos_data[RTC_REG_C] &= ~REG_C_IRQF;
> +                s->cmos_data[RTC_REG_C] &= ~(REG_C_UF | REG_C_IRQF);
>                  qemu_irq_lower(s->irq);
>              }
>              s->cmos_data[RTC_REG_B] = data;
> 
