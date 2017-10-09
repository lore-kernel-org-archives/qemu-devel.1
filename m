Received: from eggs.gnu.org ([2001:4830:134:3::10]:35512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1e1ZVK-0003ZP-US
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1e1ZVJ-0002sd-Rz
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:58:03 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-_E2aV78AnODfAvjObYpHdWXwxBxJLHDR9qS8yR9YM3g@mail.gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-5-andrew.smirnov@gmail.com>
	<CAFEAcA-_E2aV78AnODfAvjObYpHdWXwxBxJLHDR9qS8yR9YM3g@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 9 Oct 2017 07:57:57 -0700
Message-ID: <CAHQ1cqGnxnMLezakUt6ZhZemW9BTe43bZ2a2O8Mf9b9YNQis8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/17] imx_fec: Change queue flushing
 heuristics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Fri, Oct 6, 2017 at 6:56 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 18 September 2017 at 20:50, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> In current implementation, packet queue flushing logic seem to suffer
>> from a deadlock like scenario if a packet is received by the interface
>> before before Rx ring is initialized by Guest's driver. Consider the
>> following sequence of events:
>>
>>         1. A QEMU instance is started against a TAP device on Linux
>>            host, running Linux guest, e. g., something to the effect
>>            of:
>>
>>            qemu-system-arm \
>>               -net nic,model=imx.fec,netdev=lan0 \
>>               netdev tap,id=lan0,ifname=tap0,script=no,downscript=no \
>>               ... rest of the arguments ...
>>
>>         2. Once QEMU starts, but before guest reaches the point where
>>            FEC deriver is done initializing the HW, Guest, via TAP
>>            interface, receives a number of multicast MDNS packets from
>>            Host (not necessarily true for every OS, but it happens at
>>            least on Fedora 25)
>>
>>         3. Recieving a packet in such a state results in
>>            imx_eth_can_receive() returning '0', which in turn causes
>>            tap_send() to disable corresponding event (tap.c:203)
>>
>>         4. Once Guest's driver reaches the point where it is ready to
>>            recieve packets it prepares Rx ring descriptors and writes
>>            ENET_RDAR_RDAR to ENET_RDAR register to indicate to HW that
>>            more descriptors are ready. And at this points emulation
>>            layer does this:
>>
>>                  s->regs[index] = ENET_RDAR_RDAR;
>>                  imx_eth_enable_rx(s);
>>
>>            which, combined with:
>>
>>                   if (!s->regs[ENET_RDAR]) {
>>                      qemu_flush_queued_packets(qemu_get_queue(s->nic));
>>                   }
>>
>>            results in Rx queue never being flushed and corresponding
>>            I/O event beign disabled.
>>
>> Change the code to remember the fact that can_receive callback was
>> called before Rx ring was ready and use it to make a decision if
>> receive queue needs to be flushed.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  hw/net/imx_fec.c         | 6 ++++--
>>  include/hw/net/imx_fec.h | 1 +
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
>> index 84085afe09..767402909d 100644
>> --- a/hw/net/imx_fec.c
>> +++ b/hw/net/imx_fec.c
>> @@ -544,8 +544,9 @@ static void imx_eth_enable_rx(IMXFECState *s)
>>
>>      if (rx_ring_full) {
>>          FEC_PRINTF("RX buffer full\n");
>> -    } else if (!s->regs[ENET_RDAR]) {
>> +    } else if (s->needs_flush) {
>>          qemu_flush_queued_packets(qemu_get_queue(s->nic));
>> +        s->needs_flush = false;
>>      }
>>
>>      s->regs[ENET_RDAR] = rx_ring_full ? 0 : ENET_RDAR_RDAR;
>> @@ -930,7 +931,8 @@ static int imx_eth_can_receive(NetClientState *nc)
>>
>>      FEC_PRINTF("\n");
>>
>> -    return s->regs[ENET_RDAR] ? 1 : 0;
>> +    s->needs_flush = !s->regs[ENET_RDAR];
>> +    return !!s->regs[ENET_RDAR];
>>  }
>>
>>  static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
>> diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
>> index 62ad473b05..4bc8f03ec2 100644
>> --- a/include/hw/net/imx_fec.h
>> +++ b/include/hw/net/imx_fec.h
>> @@ -252,6 +252,7 @@ typedef struct IMXFECState {
>>      uint32_t phy_int_mask;
>>
>>      bool is_fec;
>> +    bool needs_flush;
>>  } IMXFECState;
>
> This looks odd -- I don't think you should need extra
> state here. Conceptually what you want is:
>
>  * in the can_receive callback, test some function of
> various bits of device state to decide whether you can
> take data
>  * in the rest of the device, whenever the device state
> changes such that you were previously not able to take
> data but now you can, call qemu_flush_queued_packets().
>
> You shouldn't need any extra state to do this, you just
> need to fix the bug where you have a code path that
> flips ENET_RDAR from 0 to 1 without calling flush
> (you might for instance have a helper function for
> "set ENET_RDAR" that encapsulates setting the state
> and arranging that flush is called).
>

I don't know if you've seen my response to Jason Wang, but I think he
was proposing something similar, and, as I said, that should work fine
and the only reason I didn't do it that way was to avoid doing a flush
every time that host driver drains full RX-ring and gives it back to
the IP block.

I'll give this a try in v2.

Thanks,
Andrey Smirnov
