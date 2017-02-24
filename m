Received: from eggs.gnu.org ([2001:4830:134:3::10]:58987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chJUd-0001PE-5Z
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chJUZ-0000qh-Q7
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:17:19 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1chJUZ-0000qI-Js
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:17:15 -0500
Received: by mail-wr0-x235.google.com with SMTP id g10so15503109wrg.2
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:17:15 -0800 (PST)
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
	<1487262963-11519-14-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1487262963-11519-14-git-send-email-peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:17:13 +0000
Message-ID: <87lgsvld9i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/13] armv7m: Allow SHCSR writes to
 change pending and active bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Implement the NVIC SHCSR write behaviour which allows pending and
> active status of some exceptions to be changed.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  hw/intc/armv7m_nvic.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index a8c5a9e..1d34e0d 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -755,8 +755,17 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
>          cpu->env.v7m.ccr = value;
>          break;
>      case 0xd24: /* System Handler Control.  */
> -        /* TODO: Real hardware allows you to set/clear the active bits
> -           under some circumstances.  We don't implement this.  */
> +        s->vectors[ARMV7M_EXCP_MEM].active = (value & (1 << 0)) != 0;
> +        s->vectors[ARMV7M_EXCP_BUS].active = (value & (1 << 1)) != 0;
> +        s->vectors[ARMV7M_EXCP_USAGE].active = (value & (1 << 3)) != 0;
> +        s->vectors[ARMV7M_EXCP_SVC].active = (value & (1 << 7)) != 0;
> +        s->vectors[ARMV7M_EXCP_DEBUG].active = (value & (1 << 8)) != 0;
> +        s->vectors[ARMV7M_EXCP_PENDSV].active = (value & (1 << 10)) != 0;
> +        s->vectors[ARMV7M_EXCP_SYSTICK].active = (value & (1 << 11)) != 0;
> +        s->vectors[ARMV7M_EXCP_USAGE].pending = (value & (1 << 12)) != 0;
> +        s->vectors[ARMV7M_EXCP_MEM].pending = (value & (1 << 13)) != 0;
> +        s->vectors[ARMV7M_EXCP_BUS].pending = (value & (1 << 14)) != 0;
> +        s->vectors[ARMV7M_EXCP_SVC].pending = (value & (1 << 15)) != 0;
>          s->vectors[ARMV7M_EXCP_MEM].enabled = (value & (1 << 16)) != 0;
>          s->vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
>          s->vectors[ARMV7M_EXCP_USAGE].enabled = (value & (1 << 18)) != 0;


--
Alex Bennée
