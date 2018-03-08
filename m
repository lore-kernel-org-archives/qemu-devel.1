Received: from eggs.gnu.org ([2001:4830:134:3::10]:38815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1etwpl-0003Ee-8S
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1etwpg-0007tc-8u
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:47:53 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:45430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1etwpg-0007sD-2C
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:47:48 -0500
Received: by mail-pg0-x243.google.com with SMTP id i133so2285169pgc.12
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 06:47:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
References: <1520444223-8389-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA8iFYGhzmLm6pyZi6tg=Di1P=vi_Enyw_ia1M34B3t8aw@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1cb9cc42-c7c9-5124-a615-27914d23b05c@roeck-us.net>
Date: Thu, 8 Mar 2018 06:47:45 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8iFYGhzmLm6pyZi6tg=Di1P=vi_Enyw_ia1M34B3t8aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fsl-imx6: Swap Ethernet interrupt defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Jason Wang <jasowang@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Bill Paul <wpaul@windriver.com>

On 03/08/2018 02:50 AM, Peter Maydell wrote:
> On 7 March 2018 at 17:37, Guenter Roeck <linux@roeck-us.net> wrote:
>> The sabrelite machine model used by qemu-system-arm is based on the
>> Freescale/NXP i.MX6Q processor. This SoC has an on-board ethernet
>> controller which is supported in QEMU using the imx_fec.c module
>> (actually called imx.enet for this model.)
>>
>> The include/hw/arm/fsm-imx6.h file defines the interrupt vectors for the
>> imx.enet device like this:
>>
>>   #define FSL_IMX6_ENET_MAC_1588_IRQ 118
>>   #define FSL_IMX6_ENET_MAC_IRQ 119
>>
>> According to https://www.nxp.com/docs/en/reference-manual/IMX6DQRM.pdf,
>> page 225, in Table 3-1. ARM Cortex A9 domain interrupt summary,
>> interrupts are as follows.
>>
>> 150 ENET MAC 0 IRQ
>> 151 ENET MAC 0 1588 Timer interrupt
>>
>> where
>>
>> 150 - 32 == 118
>> 151 - 32 == 119
>>
>> In other words, the vector definitions in the fsl-imx6.h file are reversed.
>>
>> This results in lost interrupt warnings when running recent (v4.15+) Linux
>> kernels, and the Ethernet interface will fail to probe.
>>
>> Note that applying this patch will cause problems with older Linux kernels:
>> The Ethernet interface will fail to probe with Linux v4.9 and earlier.
>> Linux v4.1 and earlier will crash. This is a Linux kernel problem, not a
>> qemu problem: the Linux kernel only worked by accident since it requested
>> both interrupts.
> 
> So do the works-by-accident kernels fail on QEMU because
> we don't emulate some bit of the ethernet device ?
> Ideally we could fix that so we could boot newer kernels
> without breaking the old ones...
> 

As mentioned, older versions of Linux assign both interrupt lines instead of one
to the Ethernet interrupt handler. After applying this patch, this causes the probe
function to fail. This in turn results in 4.1 and earlier to crash, This is fixed
by applying upstream commit 32cba57ba7 to those kernels. I asked upstream maintainers
to apply this patch to 3.18.y and 4.1.y.

The wrong interrupt problem is solved in Linux with upstream commit 4c8777892e80b,
as I pointed out in bugzilla. With this patch applied, older versions of Linux (4.9
and older) work with qemu, both with and without this patch. What I don't know is if
older versions of Linux still work on real hardware with 4c8777892e80b applied.

I don't know if a fix working for all versions of Linux is even possible. Creating both
interrupts might be an option, but would likely cause other problems since some versions
of Linux would handle the same interrupt twice, while others expect the second interrupt
to be associated with the timer.

Guenter
