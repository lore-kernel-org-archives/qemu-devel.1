Received: from eggs.gnu.org ([2001:4830:134:3::10]:41552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccCEY-0006RA-8a
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccCEV-0000zZ-3K
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:31:34 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-10-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7a95b49b-83af-019d-b480-f26d69f0fe7d@amsat.org>
Date: Fri, 10 Feb 2017 11:31:24 -0300
MIME-Version: 1.0
In-Reply-To: <1486065742-28639-10-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Liviu Ionescu <ilg@livius.net>, Michael Davidsaver <mdavidsaver@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, patches@linaro.org

On 02/02/2017 05:02 PM, Peter Maydell wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>
