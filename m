Received: from eggs.gnu.org ([2001:4830:134:3::10]:38640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fZ98e-0006VU-Qi
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fZ98Z-00070M-RZ
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:13:40 -0400
Received: from mout.web.de ([212.227.17.11]:38509)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1fZ98Z-0006yL-H4
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:13:35 -0400
From: Jan Kiszka <jan.kiszka@web.de>
References: <bfb309be-3ef4-bd01-b4f8-3ebdeaa64374@web.de>
Message-ID: <6b6e45bf-362f-1305-6991-69749d5f02f9@web.de>
Date: Sat, 30 Jun 2018 08:13:29 +0200
MIME-Version: 1.0
In-Reply-To: <bfb309be-3ef4-bd01-b4f8-3ebdeaa64374@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] e1000e: Prevent MSI/MSI-X storms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>

On 2018-04-05 19:41, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Only signal MSI/MSI-X events on rising edges. So far we re-triggered the
> interrupt sources even if the guest did no consumed the pending one,
> easily causing interrupt storms.
> 
> Issue was observable with Linux 4.16 e1000e driver when MSI-X was used.
> Vector 2 was causing interrupt storms after the driver activated the
> device.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>  - also update msi_causes_pending after EIAC changes (required because
>    there is no e1000e_update_interrupt_state after that
> 
>  hw/net/e1000e_core.c | 11 +++++++++++
>  hw/net/e1000e_core.h |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index c93c4661ed..d6ddd59986 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2027,6 +2027,7 @@ e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
>      }
>  
>      core->mac[ICR] &= ~effective_eiac;
> +    core->msi_causes_pending &= ~effective_eiac;
>  
>      if (!(core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
>          core->mac[IMS] &= ~effective_eiac;
> @@ -2123,6 +2124,13 @@ e1000e_send_msi(E1000ECore *core, bool msix)
>  {
>      uint32_t causes = core->mac[ICR] & core->mac[IMS] & ~E1000_ICR_ASSERTED;
>  
> +    core->msi_causes_pending &= causes;
> +    causes ^= core->msi_causes_pending;
> +    if (causes == 0) {
> +        return;
> +    }
> +    core->msi_causes_pending |= causes;
> +
>      if (msix) {
>          e1000e_msix_notify(core, causes);
>      } else {
> @@ -2160,6 +2168,9 @@ e1000e_update_interrupt_state(E1000ECore *core)
>      core->mac[ICS] = core->mac[ICR];
>  
>      interrupts_pending = (core->mac[IMS] & core->mac[ICR]) ? true : false;
> +    if (!interrupts_pending) {
> +        core->msi_causes_pending = 0;
> +    }
>  
>      trace_e1000e_irq_pending_interrupts(core->mac[ICR] & core->mac[IMS],
>                                          core->mac[ICR], core->mac[IMS]);
> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
> index 7d8ff41890..63a15510cc 100644
> --- a/hw/net/e1000e_core.h
> +++ b/hw/net/e1000e_core.h
> @@ -109,6 +109,8 @@ struct E1000Core {
>      NICState *owner_nic;
>      PCIDevice *owner;
>      void (*owner_start_recv)(PCIDevice *d);
> +
> +    uint32_t msi_causes_pending;
>  };
>  
>  void
> 

Ping again, this one is still open.

Jan
