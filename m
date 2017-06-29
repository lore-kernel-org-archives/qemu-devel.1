Received: from eggs.gnu.org ([2001:4830:134:3::10]:60903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQYfi-0002nh-5t
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQYff-0003jH-Ki
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:35:46 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQYff-0003j1-GM
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:35:43 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12so11051937qta.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 05:35:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
	<1498728533-23160-4-git-send-email-frederic.konrad@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <44cd89c9-bd70-874d-f2bf-f51a9b4170c3@amsat.org>
Date: Thu, 29 Jun 2017 09:35:39 -0300
MIME-Version: 1.0
In-Reply-To: <1498728533-23160-4-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] armv7m_systick: abort instead of
 locking on a bad rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alistair@alistair23.me, alex.bennee@linaro.org, pbonzini@redhat.com

Hi Frederic,

On 06/29/2017 06:28 AM, KONRAD Frederic wrote:
> This helps the board developer by asserting that system_clock_rate is not
> null. Using systick with a zero rate will lead to a deadlock so better showing
> the error.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>   hw/timer/armv7m_systick.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
> index df8d280..745efb7 100644
> --- a/hw/timer/armv7m_systick.c
> +++ b/hw/timer/armv7m_systick.c
> @@ -54,6 +54,9 @@ static void systick_reload(SysTickState *s, int reset)
>           s->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       }
>       s->tick += (s->reload + 1) * systick_scale(s);
> +
> +    /* system_clock_scale = 0 leads to a nasty deadlock, better aborting */
> +    assert(systick_scale(s));
>       timer_mod(s->timer, s->tick);
>   }

This is true it is better to abort here than risking a deadlock.

However it seems to me they are 3 issues here:
- the deadlock pattern is caused by using a global variable,
- stellaris:ssys_calculate_system_clock() no checking RCC.SYSDIV and 
RCC2.SYSDIV2 values <= 2 are reserved (GUEST_ERROR)
- stellaris:ssys_write(RCC2) not overrides correctly RCC

I'd rather take this opportunity to fix the deadlock pattern using a 
getter/setter on system_clock_scale, doing the zero check in the setter 
and eventually aborting in the getter, what do you think?

Regards,

Phil.
