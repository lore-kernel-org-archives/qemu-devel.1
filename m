Received: from eggs.gnu.org ([2001:4830:134:3::10]:48782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ef3zG-0000PT-NG
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ef3zC-0006PJ-IT
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:24:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ef3zC-0006P0-Ab
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:24:06 -0500
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801232242.31243.pisa@cmp.felk.cvut.cz>
	<ca52867f-08bf-e79f-db63-0698ccd1a106@redhat.com>
	<201801252233.45477.pisa@cmp.felk.cvut.cz>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f7d0063-6290-bdd5-7383-5bf3ae10e6dd@redhat.com>
Date: Fri, 26 Jan 2018 12:12:32 +0100
MIME-Version: 1.0
In-Reply-To: <201801252233.45477.pisa@cmp.felk.cvut.cz>
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
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Marek Vasut <marex@denx.de>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, qemu-devel@nongnu.org, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>, Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 25/01/2018 22:33, Pavel Pisa wrote:
> Hello Paolo,
> 
> thanks for suggestions. I understand and fully agree with your
> request to switch to QOM. I have succeed with that for CAN devices
> some time ago. It worth to be done for the rest of the objects
> but I fear that I do not find time to complete QOMification
> in reasonable future. Contributions/suggestions from other
> are welcomed. I can look for students for GSoC at our university
> or under other funding.

Coincidentially, I have some time on a flight next Monday. :)  I
obviously cannot really _test_ anything, but I can at least do the
changes below and set up all the QOM boilerplate.

> On Thursday 25 of January 2018 14:58:41 Paolo Bonzini wrote:
>> On 23/01/2018 22:42, Pavel Pisa wrote:
>>> Do you think QOM based? I would like it to be implemented
>>> that way but I need some assistance where to look how this
>>> object kind should be implemented and from which base object
>>> inherit from. But I prefer to left that for later work.
>>>
>>> I would definitely like to use some mechanism which allows
>>> to get rid of externally visible pointer and need to assign
>>> it in the stub. It has been my initial idea and your review
>>> sumbled across this hack as well. But I need suggestion what
>>> is the preferred way for QEMU.
>>
>> The best way would be a QOM object.  That is, you would do
>>
>>    -object can-bus,id=canbus0
>>    -object can-host-socketcan,id=can0-host,canbus=canbus0,if=can0
>>    -device kvaser_pci,canbus=canbus0
> 
> I would prefer to allow CAN emulation to be used without
> explicit can-bus object creation specified on the command line.
> The bus object could be created when requested by
> can-host-socketcan or device (kvaser_pci) automatically.

It could be fine to allow "-device kvaser_pci" to automatically create a
private bus.  However, IMO it's better to be explicit in the case where
multiple objects (e.g. can-host-socketcan and the kvaser_pci device, or
two controllers) want to connect to the same object.

>> Separating the QOM objects is a bit more work, but it makes the
>> semantics clearer.  The classes would be:
>>
>> - can-bus and an abstract class can-host, which would inherit directly
>> from TYPE_OBJECT and implement TYPE_USER_CREATABLE
>>
>> - can-host-socketcan, which would inherit from can-host (and take the
>> TYPE_USER_CREATABLE implementation from there)
>>
>> while CanBusClientState and CanBusClientInfo need not be QOMified.
> 
> May it be, can-host-socketcan can be based directly on TYPE_OBJECT,
> because only QEMU CAN bus specific part is CanBusClientState which
> allows it to connect to the CAN bus same way as other CAN controllers
> connect to the bus.

The abstract class "can-host" is useful to keep can-host-socketcan free
of things that are not specific to SocketCAN, but it's just a small detail.

Paolo
