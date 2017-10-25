Received: from eggs.gnu.org ([2001:4830:134:3::10]:60537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e7FYy-0004rJ-BP
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1e7FYt-0003RX-H0
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:53:16 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:47314
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1e7FYt-0003QW-Ad
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:53:11 -0400
References: <7df70170550e3a10152a3571012f507dd035ba7c.1508885974.git.pisa@cmp.felk.cvut.cz>
	<cbfe4b03919c677d132971ed0c352b0d90de5015.1508885974.git.pisa@cmp.felk.cvut.cz>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <083391ca-0827-fa22-92e3-7522e8722b0c@adacore.com>
Date: Wed, 25 Oct 2017 08:53:07 +0200
MIME-Version: 1.0
In-Reply-To: <cbfe4b03919c677d132971ed0c352b0d90de5015.1508885974.git.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] Fixed IRQ problem for CAN device
 can_pcm3680_pci.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pisa@cmp.felk.cvut.cz
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Jan Kiszka <jan.kiszka@siemens.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Konrad Frederic <fred.konrad@greensocs.com>

Can't this be merged in the previous patch?

Fred

On 10/25/2017 01:29 AM, pisa@cmp.felk.cvut.cz wrote:
> From: Deniz Eren <deniz.eren@icloud.com>
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>   hw/can/can_pcm3680_pci.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/hw/can/can_pcm3680_pci.c b/hw/can/can_pcm3680_pci.c
> index 77523f2ddb..bc6b164ea7 100644
> --- a/hw/can/can_pcm3680_pci.c
> +++ b/hw/can/can_pcm3680_pci.c
> @@ -61,6 +61,7 @@ typedef struct Pcm3680iPCIState {
>       MemoryRegion    sja_io[2];
>   
>       CanSJA1000State sja_state[2];
> +    qemu_irq        irq;
>   
>       char            *model; /* The model that support, only SJA1000 now. */
>       char            *canbus[2];
> @@ -69,10 +70,16 @@ typedef struct Pcm3680iPCIState {
>   
>   static void pcm3680i_pci_irq_raise(void *opaque)
>   {
> +    Pcm3680iPCIState *d = (Pcm3680iPCIState *)opaque;
> +
> +    qemu_irq_raise(d->irq);
>   }
>   
>   static void pcm3680i_pci_irq_lower(void *opaque)
>   {
> +    Pcm3680iPCIState *d = (Pcm3680iPCIState *)opaque;
> +
> +    qemu_irq_lower(d->irq);
>   }
>   
>   static void
> @@ -206,6 +213,8 @@ static int pcm3680i_pci_init(PCIDevice *pci_dev)
>       pci_conf = pci_dev->config;
>       pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
>   
> +    d->irq = pci_allocate_irq(&d->dev);
> +
>       can_sja_init(s1, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower, d);
>       can_sja_init(s2, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower, d);
>   
> @@ -254,6 +263,8 @@ static void pcm3680i_pci_exit(PCIDevice *pci_dev)
>   
>       can_sja_exit(s1);
>       can_sja_exit(s2);
> +
> +    qemu_free_irq(d->irq);
>   }
>   
>   static const VMStateDescription vmstate_pcm3680i_pci = {
> 
