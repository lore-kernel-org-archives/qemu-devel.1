Received: from eggs.gnu.org ([2001:4830:134:3::10]:40286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccCBA-0004jK-CP
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccCB6-0008DO-DQ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:28:04 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-3-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fbe34e44-5a42-e615-04f8-885d4d512e1b@amsat.org>
Date: Fri, 10 Feb 2017 11:27:56 -0300
MIME-Version: 1.0
In-Reply-To: <1486065742-28639-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/9] armv7m: Implement reading and writing
 of PRIGROUP
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
> Add a state field for the v7M PRIGROUP register and implent
> reading and writing it. The current NVIC doesn't honour
> the values written, but the new version will.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/armv7m_nvic.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 09975f3..ce22001 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -24,6 +24,9 @@
>  typedef struct NVICState {
>      GICState gic;
>      ARMCPU *cpu;
> +
> +    uint32_t prigroup;
> +
>      struct {
>          uint32_t control;
>          uint32_t reload;
> @@ -223,7 +226,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset)
>      case 0xd08: /* Vector Table Offset.  */
>          return cpu->env.v7m.vecbase;
>      case 0xd0c: /* Application Interrupt/Reset Control.  */
> -        return 0xfa050000;
> +        return 0xfa050000 | (s->prigroup << 8);
>      case 0xd10: /* System Control.  */
>          /* TODO: Implement SLEEPONEXIT.  */
>          return 0;
> @@ -362,9 +365,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
>              if (value & 1) {
>                  qemu_log_mask(LOG_UNIMP, "AIRCR system reset unimplemented\n");
>              }
> -            if (value & 0x700) {
> -                qemu_log_mask(LOG_UNIMP, "PRIGROUP unimplemented\n");
> -            }
> +            s->prigroup = extract32(value, 8, 3);
>          }
>          break;
>      case 0xd10: /* System Control.  */
> @@ -483,13 +484,14 @@ static const MemoryRegionOps nvic_sysreg_ops = {
>
>  static const VMStateDescription vmstate_nvic = {
>      .name = "armv7m_nvic",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(systick.control, NVICState),
>          VMSTATE_UINT32(systick.reload, NVICState),
>          VMSTATE_INT64(systick.tick, NVICState),
>          VMSTATE_TIMER_PTR(systick.timer, NVICState),
> +        VMSTATE_UINT32(prigroup, NVICState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
>
