Received: from eggs.gnu.org ([2001:4830:134:3::10]:48413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1dwXpf-0007dZ-WA
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1dwXpf-0005Wm-1q
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:10:15 -0400
MIME-Version: 1.0
In-Reply-To: <dbc5a135-10d5-e332-94b3-4e59596f1d76@redhat.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-5-andrew.smirnov@gmail.com>
	<dbc5a135-10d5-e332-94b3-4e59596f1d76@redhat.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 25 Sep 2017 11:10:04 -0700
Message-ID: <CAHQ1cqHVuKdSfViMVMSCGB=RUJH3XbSzUL0ad3z0LGpj=VJ6OQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Jason Wang <jasowang@redhat.com>
Cc: "open list:ARM" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Fri, Sep 22, 2017 at 12:27 AM, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2017=E5=B9=B409=E6=9C=8819=E6=97=A5 03:50, Andrey Smirnov wrote:
>>
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
>>                   imx_eth_enable_rx(s);
>>
>>            which, combined with:
>>
>>                   if (!s->regs[ENET_RDAR]) {
>>                      qemu_flush_queued_packets(qemu_get_queue(s->nic));
>>                   }
>
>
> Not familiar with FEC, but if you are tracking 0->1 transition, why not
> simply introduce a parameter of imx_eth_enable_rx() to force the flushing=
?
>

Not sure I fully understand you, are you proposing I get rid of
"needs_flush" parameter in the device state, converting it to be a
parameter to imx_eth_enable_rx(), and then force flushing every time
imx_eth_enable_rx() is called in imx_eth_write()?

That should work, but it'll end up making the emulator code to flush
corresponding NIC queue every time the driver is done processing RX
ring. If that is not a big problem I am more than happy to make that
change.

Thanks,
Andrey Smirnov
