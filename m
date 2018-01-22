Received: from eggs.gnu.org ([2001:4830:134:3::10]:47394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eddUQ-0007RA-3j
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eddUP-0004Tc-1y
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:54:26 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_epX=BOj5sxNVB2z-k3wQ+RRAry=OQi2b=i0d9pJaSeA@mail.gmail.com>
References: <20180113113445.2705-1-jcd@tribudubois.net>
	<CAFEAcA_epX=BOj5sxNVB2z-k3wQ+RRAry=OQi2b=i0d9pJaSeA@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 22 Jan 2018 06:54:23 -0800
Message-ID: <CAHQ1cqHXHxSH4LxSu0Jjug5hy1FhMYF-O2FtYbjpnm68VjTDpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] i.MX: Fix FEC/ENET receive funtions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, fyleo45@gmail.com, qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>

On Mon, Jan 22, 2018 at 3:48 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 13 January 2018 at 11:34, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>> The actual imx_eth_enable_rx() function is buggy.
>>
>> It updates s->regs[ENET_RDAR] after calling qemu_flush_queued_packets().
>>
>> qemu_flush_queued_packets() is going to call imx_XXX_receive() which itself
>> is going to call imx_eth_enable_rx().
>>
>> By updating s->regs[ENET_RDAR] after calling qemu_flush_queued_packets()
>> we end up updating the register with an outdated value which might
>> lead to disabling the receive function in the i.MX FEC/ENET device.
>>
>> This patch change the place where the register update is done so that the
>> register value stays up to date and the receive function can keep
>> running.
>>
>> Reported-by: Fyleo <fyleo45@gmail.com>
>> Tested-by: Fyleo  <fyleo45@gmail.com>
>> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
>> ---
>
> Andrey, do you have an opinion on this patch, since you've been
> looking at i.MX code recently?
>

The rationale makes sense to me and patch looks like a good cleanup in
general, so FWIW:

Reviewed-by: Andrey Smirnov <andrew.smirnov@gmail.com>

I also gave it a spin against my i.MX7 changes with doing basic things
like ping and scp of 1GB file, so I can give my:

Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>

for that.

Thanks,
Andrey Smirnov


>> Change since v1:
>> 1. Rebase the patch on the updated master branch
>>
>>  hw/net/imx_fec.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
>> index 4fb48f62ba..9506f9b69f 100644
>> --- a/hw/net/imx_fec.c
>> +++ b/hw/net/imx_fec.c
>> @@ -595,19 +595,16 @@ static void imx_eth_do_tx(IMXFECState *s, uint32_t index)
>>  static void imx_eth_enable_rx(IMXFECState *s, bool flush)
>>  {
>>      IMXFECBufDesc bd;
>> -    bool rx_ring_full;
>>
>>      imx_fec_read_bd(&bd, s->rx_descriptor);
>>
>> -    rx_ring_full = !(bd.flags & ENET_BD_E);
>> +    s->regs[ENET_RDAR] = (bd.flags & ENET_BD_E) ? ENET_RDAR_RDAR : 0;
>>
>> -    if (rx_ring_full) {
>> +    if (!s->regs[ENET_RDAR]) {
>>          FEC_PRINTF("RX buffer full\n");
>>      } else if (flush) {
>>          qemu_flush_queued_packets(qemu_get_queue(s->nic));
>>      }
>> -
>> -    s->regs[ENET_RDAR] = rx_ring_full ? 0 : ENET_RDAR_RDAR;
>>  }
>>
>>  static void imx_eth_reset(DeviceState *d)
>> @@ -866,7 +863,6 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
>>      case ENET_RDAR:
>>          if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
>>              if (!s->regs[index]) {
>> -                s->regs[index] = ENET_RDAR_RDAR;
>>                  imx_eth_enable_rx(s, true);
>>              }
>>          } else {
>> --
>> 2.14.1
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM
