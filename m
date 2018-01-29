Received: from eggs.gnu.org ([2001:4830:134:3::10]:43438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <o.rempel@pengutronix.de>) id 1eg464-00088L-Kz
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:43:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <o.rempel@pengutronix.de>) id 1eg463-00063r-96
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:43:20 -0500
Received: from metis.ext.pengutronix.de
	([2001:67c:670:201:290:27ff:fe1d:cc33]:34721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <o.rempel@pengutronix.de>)
	id 1eg463-000618-1G
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:43:19 -0500
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801252233.45477.pisa@cmp.felk.cvut.cz>
	<8f7d0063-6290-bdd5-7383-5bf3ae10e6dd@redhat.com>
	<201801281002.40862.pisa@cmp.felk.cvut.cz>
From: Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <c1278269-6103-0aab-d365-f1047adf92fe@pengutronix.de>
Date: Mon, 29 Jan 2018 08:43:08 +0100
MIME-Version: 1.0
In-Reply-To: <201801281002.40862.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 0/7] CAN bus support for QEMU (SJA1000
 PCI so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Marek Vasut <marex@denx.de>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, qemu-devel@nongnu.org, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>, Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Hi,

On 28.01.2018 10:02, Pavel Pisa wrote:
> Hello Paolo,
> 
> On Friday 26 of January 2018 12:12:32 Paolo Bonzini wrote:
>> Coincidentially, I have some time on a flight next Monday. :)  I
>> obviously cannot really _test_ anything, but I can at least do the
>> changes below and set up all the QOM boilerplate.
> 
> thanks much for offer to help.
> 
> Deniz Eren or Oleksij Rempel can test your changes as well.

just tell me wen and what should i test :)

> I have prepared branch "can-pci-qom" in GitLab repository
> 
>   https://gitlab.fel.cvut.cz/canbus/qemu-canbus
> 
>   https://gitlab.fel.cvut.cz/canbus/qemu-canbus/tree/can-pci-qom
> 
> and I have updated all PCI devices to use realize() instead of init(),
> eliminated all uses of exit() and changed error reporting to use
> error_setg() and error_setg_errno(). So I think that there is
> no fatal blocker in these files. Problematic is setup
> of connect_to_host variant
> 
>  can_bus_set_connect_to_host(can_bus_connect_to_host_socketcan);
> 
> in "hw/can/can_socketcan.c" and location of this file
> in HW. I keep it there to have all CAN support *.c
> files in single place for now.
> 
> I have studied "tests/check-qom-proplist.c" for while
> but I expect that you will be much more successfull
> and efficient to define mainline acceptable object model.
> 
> Thanks again,
> 
> Pavel
> 
>>>> The best way would be a QOM object.  That is, you would do
>>>>
>>>>    -object can-bus,id=canbus0
>>>>    -object can-host-socketcan,id=can0-host,canbus=canbus0,if=can0
>>>>    -device kvaser_pci,canbus=canbus0
>>>
>>> I would prefer to allow CAN emulation to be used without
>>> explicit can-bus object creation specified on the command line.
>>> The bus object could be created when requested by
>>> can-host-socketcan or device (kvaser_pci) automatically.
>>
>> It could be fine to allow "-device kvaser_pci" to automatically create a
>> private bus.  However, IMO it's better to be explicit in the case where
>> multiple objects (e.g. can-host-socketcan and the kvaser_pci device, or
>> two controllers) want to connect to the same object.
>>
>>>> Separating the QOM objects is a bit more work, but it makes the
>>>> semantics clearer.  The classes would be:
>>>>
>>>> - can-bus and an abstract class can-host, which would inherit directly
>>>> from TYPE_OBJECT and implement TYPE_USER_CREATABLE
>>>>
>>>> - can-host-socketcan, which would inherit from can-host (and take the
>>>> TYPE_USER_CREATABLE implementation from there)
>>>>
>>>> while CanBusClientState and CanBusClientInfo need not be QOMified.
>>>
>>> May it be, can-host-socketcan can be based directly on TYPE_OBJECT,
>>> because only QEMU CAN bus specific part is CanBusClientState which
>>> allows it to connect to the CAN bus same way as other CAN controllers
>>> connect to the bus.
>>
>> The abstract class "can-host" is useful to keep can-host-socketcan free
>> of things that are not specific to SocketCAN, but it's just a small detail.
> 
> 
