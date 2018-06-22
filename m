Received: from eggs.gnu.org ([2001:4830:134:3::10]:42226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWGrd-0004k1-7V
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWGra-0005Pp-5Z
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 03:52:13 -0400
Date: Fri, 22 Jun 2018 09:52:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180622050334.GG612@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806220930470.66303@zero.eik.bme.hu>
References: <1529642871-14214-1-git-send-email-linux@roeck-us.net>
	<20180622050334.GG612@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Hello,

Thanks for the feedback, really appreciated.

On Fri, 22 Jun 2018, David Gibson wrote:
> On Thu, Jun 21, 2018 at 09:47:51PM -0700, Guenter Roeck wrote:
>> sam4660ex (or at least this emulation) does not support the "ibm,cpm" power
>> management. As a result, Linux crashes when trying to access it. Remove
>> its devicetree node. Also, if/when we boot the Linux kernel directly,
>> u-boot will not fix up serial frequencies in the devicetree file, and
>> serial port initialization will fail. Add plausible frequency values to the
>> first serial port to be able to use it. Disable the second serial port
>> since it is not available on the board.  Also set valid values for the
>> other clock nodes otherwise set by u-boot.

Patching clock values when using -kernel instead of u-boot looks good. 
Although I've tested booting a Linux kernel and could see serial output 
while the kernel boots, it only went silent after started user space. Is 
this the same you see or you don't get serial output (with loglevel set to 
some higher value) even during kernel boot? Which kernel and image do you 
test with?

Does leaving second UART in device tree cause any problems? The fdt in 
kernel has these and I'm not sure u-boot would patch this out. Do we need 
to remove this? This did not seem to cause any problem with guests I've 
tried so far. Does real hardware have a different fdt than the stock 
kernel one (which is also what's downloadable from ACube's site).

The version of the Linux kernel I've tried (which is from the Linux CD on 
ACube's site) did not try to access the power management register, neither 
any guest OSes I've tested with. Looks like it may be specific to the 
kernel config you're using.

By the way, when I've tried with a more recent Linux kernel (4.15.10) I've 
noticed that the sm501 driver seemed like having endianness problems and 
thus did not find the chip, while it works with other older kernels made 
for sam460ex. I did not try to debug or bisect this yet. Do you know 
anything about that?

Regards,
BALATON Zoltan

>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  hw/ppc/sam460ex.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>> index bdc53d2..045a255 100644
>> --- a/hw/ppc/sam460ex.c
>> +++ b/hw/ppc/sam460ex.c
>> @@ -308,6 +308,24 @@ static int sam460ex_load_device_tree(hwaddr addr,
>>      qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "timebase-frequency",
>>                                tb_freq);
>>
>> +    /* Remove cpm node (not emulated) */
>> +    qemu_fdt_nop_node(fdt, "/cpm");
>> +    /* set serial port clock and speed */
>> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/serial@ef600300", "clock-frequency",
>> +                              50000000);
>> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/serial@ef600300", "current-speed",
>> +                              38400);
>> +    /* disable second serial port */
>> +    qemu_fdt_setprop_string(fdt, "/plb/opb/serial@ef600400", "status",
>> +                              "disabled");
>> +    /* some more clocks */
>> +    qemu_fdt_setprop_cell(fdt, "/plb", "clock-frequency",
>> +                              50000000);
>> +    qemu_fdt_setprop_cell(fdt, "/plb/opb", "clock-frequency",
>> +                              50000000);
>> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/ebc", "clock-frequency",
>> +                              50000000);
>> +
>>      rom_add_blob_fixed(BINARY_DEVICE_TREE_FILE, fdt, fdt_size, addr);
>>      g_free(fdt);
>>      ret = fdt_size;
>
>
