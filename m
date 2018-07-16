Received: from eggs.gnu.org ([2001:4830:134:3::10]:59347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ff3uC-0004z5-Ti
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1ff3u8-0002Z9-1Y
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:51:13 -0400
Sender: Guenter Roeck <groeck7@gmail.com>
References: <1531692369-1511-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA9W88G8rd4iMq7qsNd2C2fRiYJ32dVooZLyzY10__5piw@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e893ae38-9294-4b54-e950-6632b6b73532@roeck-us.net>
Date: Mon, 16 Jul 2018 06:51:04 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9W88G8rd4iMq7qsNd2C2fRiYJ32dVooZLyzY10__5piw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] hw: arm: Add basic support for cprman
 (clock subsystem)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Pekka Enberg <penberg@iki.fi>

On 07/16/2018 02:08 AM, Peter Maydell wrote:
> On 15 July 2018 at 23:06, Guenter Roeck <linux@roeck-us.net> wrote:
>> Add basic support for BCM283x CPRMAN. Provide support for reading and
>> writing CPRMAN registers and initialize registers with sensible default
>> values. During runtime retain any written values.
>>
>> Basic CPRMAN support is necessary and sufficient to boot Linux on raspi2
>> and raspi3 systems.
> 
> I can boot Linux on raspi3 with current upstream's level
> of cprman support:
> https://translatedcode.wordpress.com/2018/04/25/debian-on-qemus-raspberry-pi-3-model/

Yes, as long as you use ttyAMA0 as console. Using ttyS1, which is the real console
on raspi3, doesn't work. It doesn't give tracebacks, but it reports

[    8.894257] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.973121] bcm2835-aux-uart 3f215040.serial: unable to register 8250 port - -22
[    8.981971] bcm2835-aux-uart: probe of 3f215040.serial failed with error -22

and then there is no console. I have to hack the bcm8250 driver to provide
a dummy clock to get it to work.

> 
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> I don't seriously expect this patch to get accepted, but I thought
>> it might be valuable enough for others to use it when playing with
>> raspi2 and raspi3 emulations.
> 
> I'm not necessarily going to rule it out entirely, but I'm
> definitely not very happy about having a model of hardware
> that's very clearly "do something that Linux likes". I'd
> really rather see hardware documentation here -- presumably
> whoever is writing the Linux drivers has that?
> 

Maybe, but I don't, and I was unable to find it. The published documentation
only lists information for some of the registers (for the general purpose
clocks).

In this context, I can't get mmc to work with ToT Linux on raspi3.

/ # mount /dev/mmcblk0 /mnt
[   47.099074] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware interrupt.
[   57.339803] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware interrupt.
[   57.390449] mmc0: Problem switching card into high-speed mode!
[   67.581559] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware interrupt.
[   67.587832] print_req_error: I/O error, dev mmcblk0, sector 2
[   67.588908] Buffer I/O error on dev mmcblk0, logical block 1, lost sync page write
[   67.610307] EXT4-fs (mmcblk0): I/O error while writing superblock
[   67.620842] EXT4-fs (mmcblk0): mount failed
[   77.819114] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware interrupt.
[   88.058917] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware interrupt.
[   98.298937] sdhost-bcm2835 3f202000.mmc: timeout waiting for hardware interrupt.
[   98.303554] print_req_error: I/O error, dev mmcblk0, sector 2
[   98.306044] Buffer I/O error on dev mmcblk0, logical block 1, lost sync page write

Any idea what the problem might be ?

Thanks,
Guenter
