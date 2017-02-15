Received: from eggs.gnu.org ([2001:4830:134:3::10]:58567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ce0Qm-0003Xw-N5
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ce0Qj-00078V-Iz
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:19:40 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ce0Qj-00077n-A0
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 09:19:37 -0500
Received: by mail-wr0-x22e.google.com with SMTP id z61so4094868wrc.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 06:19:37 -0800 (PST)
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-10-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1486065742-28639-10-git-send-email-peter.maydell@linaro.org>
Date: Wed, 15 Feb 2017 14:19:34 +0000
Message-ID: <87d1ejv8nd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 9/9] armv7m: VECTCLRACTIVE and VECTRESET
 are UNPREDICTABLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Michael Davidsaver <mdavidsaver@gmail.com>
>
> The VECTCLRACTIVE and VECTRESET bits in the AIRCR are both
> documented as UNPREDICTABLE if you write a 1 to them when
> the processor is not halted in Debug state (ie stopped
> and under the control of an external JTAG debugger).
> Since we don't implement Debug state or emulated JTAG
> these bits are always UNPREDICTABLE for us. Instead of
> logging them as unimplemented we can simply log writes
> as guest errors and ignore them.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> [PMM: change extracted from another patch; commit message
>  constructed from scratch]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  hw/intc/armv7m_nvic.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 7b61fe6..18c0e60 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -698,10 +698,14 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
>                  qemu_irq_pulse(s->sysresetreq);
>              }
>              if (value & 2) {
> -                qemu_log_mask(LOG_UNIMP, "VECTCLRACTIVE unimplemented\n");
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Setting VECTCLRACTIVE when not in DEBUG mode "
> +                              "is UNPREDICTABLE\n");
>              }
>              if (value & 1) {
> -                qemu_log_mask(LOG_UNIMP, "AIRCR system reset unimplemented\n");
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Setting VECTRESET when not in DEBUG mode "
> +                              "is UNPREDICTABLE\n");
>              }
>              s->prigroup = extract32(value, 8, 3);
>              nvic_irq_update(s);


--
Alex Bennée
