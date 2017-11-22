Received: from eggs.gnu.org ([2001:4830:134:3::10]:52192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbXh-0001Im-09
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbXf-0005eo-P1
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:22:44 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_+9fz4zzWg6najN0pn6-=jRMzz2zbHneZxca=SYyxDKA@mail.gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-4-andrew.smirnov@gmail.com>
	<CAFEAcA_+9fz4zzWg6najN0pn6-=jRMzz2zbHneZxca=SYyxDKA@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 22 Nov 2017 12:22:40 -0800
Message-ID: <CAHQ1cqFGr9YMeXPHyueKVpRQp8ugvF7+gnwSZRk=rBY20UYV7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/30] imx_fec: Change queue flushing
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Nov 21, 2017 at 9:27 AM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wr=
ote:
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
>>               -net nic,model=3Dimx.fec,netdev=3Dlan0 \
>>               netdev tap,id=3Dlan0,ifname=3Dtap0,script=3Dno,downscript=
=3Dno \
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
>>                  s->regs[index] =3D ENET_RDAR_RDAR;
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
>> To prevent the problem, change the code to always flush packet queue
>> when ENET_RDAR transitions 0 -> ENET_RDAR_RDAR.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org
>> Cc: yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
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
> This field isn't needed any more in this version of the patch, I think?
>

Yeah, my bad, forgot to remove this part. Will do in v4.

Thanks,
Andrey Smirnov
