Received: from eggs.gnu.org ([2001:4830:134:3::10]:35167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX6zy-00054t-3b
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX6zv-0000jJ-0t
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:55:30 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX6zu-0000j6-Ra
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:55:26 -0500
Received: by mail-wm0-x236.google.com with SMTP id r126so118158792wmr.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:55:26 -0800 (PST)
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
	<1485285380-10565-9-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1485285380-10565-9-git-send-email-peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 13:55:23 +0000
Message-ID: <8737g4a9pw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/10] armv7m: Honour CCR.USERSETMPEND
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Liviu Ionescu <ilg@livius.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Michael Davidsaver <mdavidsaver@gmail.com>
>
> The CCR.USERSETMPEND bit has to be set to permit unprivileged code to
> write to the Software Triggered Interrupt register; honour this bit
> rather than letting any code write to the register.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> [PMM: Tweak commit message, comment, phrasing of condition]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  hw/intc/armv7m_nvic.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 60e72d7..fe5c303 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -409,7 +409,10 @@ static void nvic_writel(nvic_state *s, uint32_t offset, uint32_t value)
>                        "NVIC: Aux fault status registers unimplemented\n");
>          break;
>      case 0xf00: /* Software Triggered Interrupt Register */
> -        if ((value & 0x1ff) < s->num_irq) {
> +        /* user mode can only write to STIR if CCR.USERSETMPEND permits it */
> +        if ((value & 0x1ff) < s->num_irq &&
> +            (arm_current_el(&cpu->env) ||
> +             (cpu->env.v7m.ccr & R_V7M_CCR_USERSETMPEND_MASK))) {
>              gic_set_pending_private(&s->gic, 0, value & 0x1ff);
>          }
>          break;


--
Alex Bennée
