Received: from eggs.gnu.org ([2001:4830:134:3::10]:35577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fHj-0004sZ-65
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fHg-00047U-2D
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:13:11 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fHf-00046n-Ug
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:13:08 -0400
Received: by mail-qk0-x244.google.com with SMTP id k74so12419300qke.2
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 15:13:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510083259.3900-1-xiaoguangrong@tencent.com>
	<20170510083259.3900-4-xiaoguangrong@tencent.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7644bdee-2e57-958e-ecd1-abbac0009a18@amsat.org>
Date: Sat, 13 May 2017 19:13:03 -0300
MIME-Version: 1.0
In-Reply-To: <20170510083259.3900-4-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] mc146818rtc: ensure
 LOST_TICK_POLICY_SLEW is only enabled on TARGET_I386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: Xiao Guangrong <xiaoguangrong@tencent.com>, yunfangtai@tencent.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

On 05/10/2017 05:32 AM, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> Any tick policy specified on other platforms rather on TARGET_I386
> will fall back to LOST_TICK_POLICY_DISCARD silently, this patch makes
> sure only TARGET_I386 can enable LOST_TICK_POLICY_SLEW
>
> After that, we can enable LOST_TICK_POLICY_SLEW in the common code
> which need not use '#ifdef TARGET_I386' to make these code be x86
> specific anymore
>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/timer/mc146818rtc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index dac6744..9810bd5 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -980,19 +980,19 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
>
>      rtc_set_date_from_host(isadev);
>
> -#ifdef TARGET_I386
>      switch (s->lost_tick_policy) {
> +#ifdef TARGET_I386
>      case LOST_TICK_POLICY_SLEW:
>          s->coalesced_timer =
>              timer_new_ns(rtc_clock, rtc_coalesced_timer, s);
>          break;
> +#endif
>      case LOST_TICK_POLICY_DISCARD:
>          break;
>      default:
>          error_setg(errp, "Invalid lost tick policy.");
>          return;
>      }
> -#endif
>
>      s->periodic_timer = timer_new_ns(rtc_clock, rtc_periodic_timer, s);
>      s->update_timer = timer_new_ns(rtc_clock, rtc_update_timer, s);
>
