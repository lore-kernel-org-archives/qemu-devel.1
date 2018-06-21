Received: from eggs.gnu.org ([2001:4830:134:3::10]:40036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fW6vl-0001cT-HC
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linux@roeck-us.net>) id 1fW6vi-0007Cd-Cr
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 17:15:49 -0400
Date: Thu, 21 Jun 2018 14:15:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180621211542.GA11391@roeck-us.net>
References: <cover.1518730026.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1518730026.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [v2,0/3] Sam460ex emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Hi,

On Thu, Feb 15, 2018 at 10:27:06PM +0100, BALATON Zoltan wrote:
> Remaining patches for Sam460ex emulation. The original cover letter
> with more details is here:
> 
> http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00112.html
> 
> We'll need to also add binaries for firmware (customised u-boot
> version) and dtb but I'm not sure how to submit those.
> 
> Current status for OSes I've tried:
> 
> - AROS boots (after I've fixed some bugs in it which are now upstream
>   so the nightly iso should work) but keyboard doesn't work (could be
>   a bug in AROS's HID driver) and time is going slow (this can be seen
>   in time prefs). This may be a QEMU bug and possibly causes the hang
>   seen in other OSes but I don't know what causes it or how to fix it.
>   Maybe related to some internal timing registers of the SoC because
>   setting multipliers to real values causes U-Boot to become slow.
>   Anyone with more knowledge of this hardware has any idea?
> 
> - Linux: kernel boots but hangs during user space (again could be the
>   above timing problem or maybe missing emac network interface
>   emulation but I don't really know).
> 
I played with the sam460ex emulation under Linux. There are two problems:

- qemu does not emulate "ibm,cpm". If specified in the devicetree file,
  Linux tries to access the respective dcr register (0x160) and crashes.
- If the kernel is loaded with "-kernel" and there is no uboot, the serial
  port frequency is set to 0, and the serial ports fail to initialize.
  As result, there is no serial port output from userspace. Userspace runs,
  but is silent.

Both problems are easy to fix with a separate devicetree file.

Guenter
