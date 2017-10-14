Received: from eggs.gnu.org ([2001:4830:134:3::10]:43445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e3Q4E-0001Ba-Dn
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 13:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e3Q4B-0001WJ-6S
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 13:17:42 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e3Q4B-0001W3-1y
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 13:17:39 -0400
Received: by mail-qt0-x241.google.com with SMTP id 8so24835501qtv.1
	for <qemu-devel@nongnu.org>; Sat, 14 Oct 2017 10:17:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1507816448-86665-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8e86ddc8-5b4a-339e-04f0-2523eb310acc@amsat.org>
Date: Sat, 14 Oct 2017 14:17:34 -0300
MIME-Version: 1.0
In-Reply-To: <1507816448-86665-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tco: add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Hi Paolo,

On 10/12/2017 10:54 AM, Paolo Bonzini wrote:
> Add trace events to the PCH watchdog timer, it can be useful to see how
> the guest is using it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/acpi/tco.c        | 11 +++++++++--
>  hw/acpi/trace-events |  4 ++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
> index 05b9d7b..0032db4 100644
> --- a/hw/acpi/tco.c
> +++ b/hw/acpi/tco.c
> @@ -12,6 +12,7 @@
>  #include "hw/i386/ich9.h"
>  
>  #include "hw/acpi/tco.h"
> +#include "trace.h"
>  
>  //#define DEBUG
>  
> @@ -41,8 +42,11 @@ enum {
>  
>  static inline void tco_timer_reload(TCOIORegs *tr)
>  {
> -    tr->expire_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -        ((int64_t)(tr->tco.tmr & TCO_TMR_MASK) * TCO_TICK_NSEC);
> +    int ticks = tr->tco.tmr & TCO_TMR_MASK;
> +    int64_t nsec = (int64_t)ticks * TCO_TICK_NSEC;
> +
> +    trace_tco_timer_reload(ticks, nsec / 1000000);

I'd use SCALE_MS here.

> +    tr->expire_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + nsec;
>      timer_mod(tr->tco_timer, tr->expire_time);
>  }
>  
> @@ -59,6 +63,9 @@ static void tco_timer_expired(void *opaque)
>      ICH9LPCState *lpc = container_of(pm, ICH9LPCState, pm);
>      uint32_t gcs = pci_get_long(lpc->chip_config + ICH9_CC_GCS);
>  
> +    trace_tco_timer_expired(tr->timeouts_no,
> +			    lpc->pin_strap.spkr_hi,
> +			    !!(gcs & ICH9_CC_GCS_NO_REBOOT));
>      tr->tco.rld = 0;
>      tr->tco.sts1 |= TCO_TIMEOUT;
>      if (++tr->timeouts_no == 2) {
> diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
> index e3b41e9..df0024f 100644
> --- a/hw/acpi/trace-events
> +++ b/hw/acpi/trace-events
> @@ -30,3 +30,7 @@ cpuhp_acpi_ejecting_invalid_cpu(uint32_t idx) "0x%"PRIx32
>  cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
>  cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
>  cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
> +
> +# hw/acpi/tco.c
> +tco_timer_reload(int ticks, int msec) "ticks=%d (%d ms)"
> +tco_timer_expired(int timeouts_no, bool strap, bool no_reboot) "timeouts_no=%d no_reboot=%d/%d"

Changing tabs by spaces to satisfy checkpatch:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
