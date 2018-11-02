Received: from eggs.gnu.org ([2001:4830:134:3::10]:55304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gIZTI-0005H5-56
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gIZTH-0006qn-4X
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:26:44 -0400
Sender: Guenter Roeck <groeck7@gmail.com>
References: <20181102001303.32640-1-f4bug@amsat.org>
	<b32bf2a0-08ac-6b16-6372-455f9a239f9f@roeck-us.net>
	<CAAdtpL6VCf+hyK7GGtoiC8KLAL2DJtaYomwhcY7Mz2OxMg2AiA@mail.gmail.com>
	<CAAdtpL776SX0rbO1-dsBmx_7D3gn8e5ukt5Z0STejYRt+oXcEg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0515e472-b65e-9b68-7792-75c000d4824a@roeck-us.net>
Date: Fri, 2 Nov 2018 06:26:28 -0700
MIME-Version: 1.0
In-Reply-To: <CAAdtpL776SX0rbO1-dsBmx_7D3gn8e5ukt5Z0STejYRt+oXcEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 3.2 v2 0/7] hw/arm/bcm2835: Add basic
 support for cprman (clock subsystem)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 11/2/18 12:48 AM, Philippe Mathieu-Daudé wrote:
> On Fri, Nov 2, 2018 at 8:32 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Hi Guenter,
>>
>> On Fri, Nov 2, 2018 at 3:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On 11/1/18 5:12 PM, Philippe Mathieu-Daudé wrote:
>>>> Hi,
>>>>
>>>> This series is a mix of a previous work I had for the raspi, and a patch from
>>>> Guenter: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03153.html
>>>>
>>>> The final patch keep Guenter ideas and comments, but is mostly a rewrite.
>>>> I dropped the A2W code from this work, it doesn't seems unuseful to me.
>>>>
>>>> Guenter can you test this series?
>>>>
>>>
>>> arm/raspi2 works, but aarch64/raspi3 stalls.
>>
>> Thanks for testing it!
>>
>> So I suppose the A2W is required. And I'm probably using a too old kernel,
>> I'm using the Buster preview following Peter's post [1]:
>>
>> [    0.000000] Linux version 4.14.0-3-arm64
>> (debian-kernel@lists.debian.org) (gcc version 7.2.0 (Debian 7.2.0-18))
>> #1 SMP Debian 4.14.12-2 (2018-01-06)
>> [    0.000000] Machine model: Raspberry Pi 3 Model B
>> [...]
>> [    8.044215] systemd[1]: Detected architecture arm64.
>> Welcome to Debian GNU/Linux buster/sid!
>>
>> Debian GNU/Linux buster/sid rpi3 ttyAMA0
>>
>> rpi3 login: root
>> Password:
>> Linux rpi3 4.14.0-3-arm64 #1 SMP Debian 4.14.12-2 (2018-01-06) aarch64
>> root@rpi3:~#
>>
>> I'll look for a newer kernel.
> 
> I'm a bit confuse since I can boot a 4.19 kernel:
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> [    0.000000] Linux version 4.19.0 (gokrazy@docker) (gcc version
> 6.3.0 20170516 (Debian 6.3.0-18)) #1 SMP PREEMPT Wed Mar 1 20:57:29
> UTC 2017
> [    0.000000] Machine model: Raspberry Pi 3 Model B
> [    0.000000] earlycon: pl11 at MMIO 0x000000003f201000 (options '')
> [    0.000000] bootconsole [pl11] enabled
> ...
> [    2.722577] Freeing unused kernel memory: 5696K
> [    2.723256] Run /init as init process
> Loading, please wait...
> starting version 236
> ...
> root@rpi3:~# uname -a
> Linux rpi3 4.19.0 #1 SMP PREEMPT Wed Mar 1 20:57:29 UTC 2017 aarch64 GNU/Linux
> 
>>
>> BTW I use these QEMU command line options while testing:
>>
>> qemu-system-aarch64 \
>>    -d unimp,guest_errors \
>>    -trace bcm2835_cprman_rd_\* -trace bcm2835_cprman_wr_\* \
>>    ...
>>
>> And the cmdline suggested by Peter:
>>
>>    -append "rw earlycon=pl011,0x3f201000 console=ttyAMA0 loglevel=8
>> root=/dev/mmcblk0p2 fsck.repair=yes net.ifnames=0 rootwait memtest=1"
>>
>> [1] https://translatedcode.wordpress.com/2018/04/25/debian-on-qemus-raspberry-pi-3-model/
>>
>>>
>>> [   45.683302] Run /sbin/init as init process
> 
> init is ran way after A2W register accesses, so I doubt they are the
> problem here.
> 
> Can you provide me your testing setup?
> 

-append 'earlycon=uart8250,mmio32,0x3f215040 rdinit=/sbin/init panic=-1 console=ttyS1,115200'

On raspi3, ttyAMA0 can not be used as console because it is connected to something else.
I can boot if I use ttyAMA0 as console. Comparing the log output with the output when
using my original patch, tt looks like ttyS1 doesn't come up.

Hope this helps,
Guenter
