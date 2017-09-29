Received: from eggs.gnu.org ([2001:4830:134:3::10]:56109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy2R7-0002Lk-Mw
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy2R4-0007zs-KF
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:03:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3e678775-89b9-979c-5f5d-cde777adcc3b@amsat.org>
Date: Fri, 29 Sep 2017 18:03:00 -0300
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 01/20] nvic: Clear the vector
 arrays and prigroup on reset
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org
List-ID: <qemu-devel.nongnu.org>

On 09/22/2017 11:59 AM, Peter Maydell wrote:
> Reset for devices does not include an automatic clear of the
> device state (unlike CPU state, where most of the state
> structure is cleared to zero). Add some missing initialization
> of NVIC state that meant that the device was left in the wrong
> state if the guest did a warm reset.
> 
> (In particular, since we were resetting the computed state like
> s->exception_prio but not all the state it was computed
> from like s->vectors[x].active, the NVIC wound up in an
> inconsistent state that could later trigger assertion failures.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/intc/armv7m_nvic.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index d90d8d0..bc7b66d 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1782,6 +1782,11 @@ static void armv7m_nvic_reset(DeviceState *dev)
>       int resetprio;
>       NVICState *s = NVIC(dev);
>   
> +    memset(s->vectors, 0, sizeof(s->vectors));
> +    memset(s->sec_vectors, 0, sizeof(s->sec_vectors));
> +    s->prigroup[M_REG_NS] = 0;
> +    s->prigroup[M_REG_S] = 0;
> +
>       s->vectors[ARMV7M_EXCP_NMI].enabled = 1;
>       /* MEM, BUS, and USAGE are enabled through
>        * the System Handler Control register
> 
