Received: from eggs.gnu.org ([2001:4830:134:3::10]:58279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fWMDF-0000Qi-GE
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1fWMDA-0000dg-Jp
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:34:53 -0400
Sender: Guenter Roeck <groeck7@gmail.com>
References: <1529642871-14214-1-git-send-email-linux@roeck-us.net>
	<20180622050334.GG612@umbus.fritz.box>
	<alpine.BSF.2.21.1806220930470.66303@zero.eik.bme.hu>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c59b2d3e-384a-f3d9-41a7-74439cd3c78e@roeck-us.net>
Date: Fri, 22 Jun 2018 06:34:44 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806220930470.66303@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ppc: Fix sam460ex devicetree when booting
 the Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/22/2018 12:52 AM, BALATON Zoltan wrote:
> Hello,
> 
> Thanks for the feedback, really appreciated.
> 
> On Fri, 22 Jun 2018, David Gibson wrote:
>> On Thu, Jun 21, 2018 at 09:47:51PM -0700, Guenter Roeck wrote:
>>> sam4660ex (or at least this emulation) does not support the "ibm,cpm" power
>>> management. As a result, Linux crashes when trying to access it. Remove
>>> its devicetree node. Also, if/when we boot the Linux kernel directly,
>>> u-boot will not fix up serial frequencies in the devicetree file, and
>>> serial port initialization will fail. Add plausible frequency values to the
>>> first serial port to be able to use it. Disable the second serial port
>>> since it is not available on the board.  Also set valid values for the
>>> other clock nodes otherwise set by u-boot.
> 
> Patching clock values when using -kernel instead of u-boot looks good. Although I've tested booting a Linux kernel and could see serial output while the kernel boots, it only went silent after started user space. Is this the same you see or you don't get serial output (with loglevel set to some higher value) even during kernel boot? Which kernel and image do you test with?
> 
I test with all stable kernel releases starting with 3.16.

Correct, this is exactly what I was seeing as well. I also noticed that the
system keeps running, only there is no serial output.

> Does leaving second UART in device tree cause any problems? The fdt in kernel has these and I'm not sure u-boot would patch this out. Do we need to remove this? This did not seem to cause any problem with guests I've tried so far. Does real hardware have a different fdt than the stock kernel one (which is also what's downloadable from ACube's site).
> 
Only that the port fails to initialize without clock. We could leave it in the tree,
but it would only have value if the clocks are actually set, and then it would
be a qemu-only value (presumably; I read somewhere that the board only has a single
serial port). I don't have a strong opinion either way. Also, I don't know what
u-boot does.

> The version of the Linux kernel I've tried (which is from the Linux CD on ACube's site) did not try to access the power management register, neither any guest OSes I've tested with. Looks like it may be specific to the kernel config you're using.
> 
Interesting. This is with the standard upstream kernel, using canyonlands_defconfig.
The code seems to have been in the upstream kernel forever.

> By the way, when I've tried with a more recent Linux kernel (4.15.10) I've noticed that the sm501 driver seemed like having endianness problems and thus did not find the chip, while it works with other older kernels made for sam460ex. I did not try to debug or bisect this yet. Do you know anything about that?
> 

No, I had not noticed. SM501 is disabled in the latest canyonlands_defconfig,
and I only use the serial console for my testing. It fails as far back as 3.18.y,
so I am not sure if this is a Linux or a qemu problem, or if it is a problem that
was never fixed in the upstream kernel. What kernels did you try ?

Thanks,
Guenter

> Regards,
> BALATON Zoltan
> 
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>  hw/ppc/sam460ex.c | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>>> index bdc53d2..045a255 100644
>>> --- a/hw/ppc/sam460ex.c
>>> +++ b/hw/ppc/sam460ex.c
>>> @@ -308,6 +308,24 @@ static int sam460ex_load_device_tree(hwaddr addr,
>>>      qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "timebase-frequency",
>>>                                tb_freq);
>>>
>>> +    /* Remove cpm node (not emulated) */
>>> +    qemu_fdt_nop_node(fdt, "/cpm");
>>> +    /* set serial port clock and speed */
>>> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/serial@ef600300", "clock-frequency",
>>> +                              50000000);
>>> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/serial@ef600300", "current-speed",
>>> +                              38400);
>>> +    /* disable second serial port */
>>> +    qemu_fdt_setprop_string(fdt, "/plb/opb/serial@ef600400", "status",
>>> +                              "disabled");
>>> +    /* some more clocks */
>>> +    qemu_fdt_setprop_cell(fdt, "/plb", "clock-frequency",
>>> +                              50000000);
>>> +    qemu_fdt_setprop_cell(fdt, "/plb/opb", "clock-frequency",
>>> +                              50000000);
>>> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/ebc", "clock-frequency",
>>> +                              50000000);
>>> +
>>>      rom_add_blob_fixed(BINARY_DEVICE_TREE_FILE, fdt, fdt_size, addr);
>>>      g_free(fdt);
>>>      ret = fdt_size;
>>
>>
> 
