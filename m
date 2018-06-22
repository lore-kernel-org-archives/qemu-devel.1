Received: from eggs.gnu.org ([2001:4830:134:3::10]:38209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWTkO-0002te-DN
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWTkL-0006FM-6Y
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:37:36 -0400
Date: Fri, 22 Jun 2018 23:37:30 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <c59b2d3e-384a-f3d9-41a7-74439cd3c78e@roeck-us.net>
Message-ID: <alpine.BSF.2.21.1806222322110.86811@zero.eik.bme.hu>
References: <1529642871-14214-1-git-send-email-linux@roeck-us.net>
	<20180622050334.GG612@umbus.fritz.box>
	<alpine.BSF.2.21.1806220930470.66303@zero.eik.bme.hu>
	<c59b2d3e-384a-f3d9-41a7-74439cd3c78e@roeck-us.net>
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

On Fri, 22 Jun 2018, Guenter Roeck wrote:
> On 06/22/2018 12:52 AM, BALATON Zoltan wrote:
>> On Fri, 22 Jun 2018, David Gibson wrote:
>>> On Thu, Jun 21, 2018 at 09:47:51PM -0700, Guenter Roeck wrote:
>>>> sam4660ex (or at least this emulation) does not support the "ibm,cpm" 
>>>> power
>>>> management. As a result, Linux crashes when trying to access it. Remove
>>>> its devicetree node. Also, if/when we boot the Linux kernel directly,
>>>> u-boot will not fix up serial frequencies in the devicetree file, and
>>>> serial port initialization will fail. Add plausible frequency values to 
>>>> the
>>>> first serial port to be able to use it. Disable the second serial port
>>>> since it is not available on the board.? Also set valid values for the
>>>> other clock nodes otherwise set by u-boot.
>> 
>> Patching clock values when using -kernel instead of u-boot looks good. 
>> Although I've tested booting a Linux kernel and could see serial output 
>> while the kernel boots, it only went silent after started user space. Is 
>> this the same you see or you don't get serial output (with loglevel set to 
>> some higher value) even during kernel boot? Which kernel and image do you 
>> test with?
>> 
> I test with all stable kernel releases starting with 3.16.
>
> Correct, this is exactly what I was seeing as well. I also noticed that the
> system keeps running, only there is no serial output.
>
>> Does leaving second UART in device tree cause any problems? The fdt in 
>> kernel has these and I'm not sure u-boot would patch this out. Do we need 
>> to remove this? This did not seem to cause any problem with guests I've 
>> tried so far. Does real hardware have a different fdt than the stock kernel 
>> one (which is also what's downloadable from ACube's site).
>> 
> Only that the port fails to initialize without clock. We could leave it 
> in the tree, but it would only have value if the clocks are actually 
> set, and then it would be a qemu-only value (presumably; I read 
> somewhere that the board only has a single serial port). I don't have a 
> strong opinion either way. Also, I don't know what u-boot does.

I think you probably read the comment in qemu/hw/ppc/sam460ex.c:526 which 
mentions hardware should have 4 serial ports but board has only one and 
two are in device tree therefore only these two are emulated. Not sure 
what's the right way here so unless this causes any problems I'd leave it 
as it is now and not patch the device tree for this because that would 
make it different from what you get when using u-boot so unless u-boot 
also removes this node I think -kernel should behave the same and leave 
it there.

>> The version of the Linux kernel I've tried (which is from the Linux CD on 
>> ACube's site) did not try to access the power management register, neither 
>> any guest OSes I've tested with. Looks like it may be specific to the 
>> kernel config you're using.
>> 
> Interesting. This is with the standard upstream kernel, using 
> canyonlands_defconfig.
> The code seems to have been in the upstream kernel forever.

Maybe the Sam460ex specific image has some patches not in upstream kernel.

>> By the way, when I've tried with a more recent Linux kernel (4.15.10) I've 
>> noticed that the sm501 driver seemed like having endianness problems and 
>> thus did not find the chip, while it works with other older kernels made 
>> for sam460ex. I did not try to debug or bisect this yet. Do you know 
>> anything about that?
>> 
>
> No, I had not noticed. SM501 is disabled in the latest canyonlands_defconfig,
> and I only use the serial console for my testing. It fails as far back as 
> 3.18.y,
> so I am not sure if this is a Linux or a qemu problem, or if it is a problem 
> that
> was never fixed in the upstream kernel. What kernels did you try ?

I've tried the kernel from this iso:

http://www.acube-systems.biz/index.php?page=news&id=106

(the image does not boot with u-boot because it seems to hit a bug in the 
firmware so could only test it with directly booting kernel with -kernel 
option).

I've also tried a stock upstream 4.15.10 kernel which is where I've seen 
it reading the PCI IDs of the SM501 endian swapped and failed to find 
device because of that. There are also several other kernels and images 
here:

http://www.supertuxkart-amiga.de/amiga/sam.html#downloads

That I haven't tried. The images start to boot but I could not get to boot 
one fully.

Regards,
BALATON Zoltan
