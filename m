Received: from eggs.gnu.org ([2001:4830:134:3::10]:57970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <somlo@cmu.edu>) id 1cUknr-00030O-2l
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 20:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <somlo@cmu.edu>) id 1cUknn-0008Lb-Vs
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 20:49:15 -0500
Received: from smtp.andrew.cmu.edu ([128.2.105.202]:38479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <somlo@cmu.edu>) id 1cUknn-0008Kj-QT
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 20:49:11 -0500
Date: Fri, 20 Jan 2017 20:49:01 -0500
From: "Gabriel L. Somlo" <somlo@cmu.edu>
Message-ID: <20170121014901.GA21645@foober.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484915417-10499-1-git-send-email-phil@philjordan.eu>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] hw/usb/dev-hid: Make usb-tablet
 work with OS X/macOS guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: phil@philjordan.eu, kraxel@redhat.com

On Fri, Jan 20, 2017 at 13:30:15 +0100, phil@philjordan.eu wrote:
> This series makes the Qemu usb-tablet work correctly with OS X/macOS guests without the need for a special guest driver.
> 
>  * The usb-tablet should not have a boot protocol of 2. Other OSes seem to ignore this, but the IOHIDFamily driver stack chokes on it for anything but conventional (relative motion) mice.
>  * A "mac_compat" boolean option is added to the usb-tablet, which changes its report descriptor to specify a usage of 0x02 (mouse) instead of 0x01 (pointer). This is required for correct operation in the Mac HID driver stack.

works like a charm on Sierra (10.12.1). Also tried it with
Fedora-Workstation-Live-x86_64-25-1.3.iso, where it behaves
identically with or without the mac_compat option. All tests
used qemu in SDL/X11-client mode.

Tested-by: Gabriel Somlo <somlo@cmu.edu>

Thanks,
--Gabriel

> 
> Changelog
> =========
> 
> v1 -> v2:
>  * v1 Thread was "[PATCH] hw/usb/dev-hid: add a Mac guest compatibility option to usb-tablet"
>  * Always apply the boot protocol (bInterfaceProtocol) change to usb-tablet, not just when the Mac compatibility option is active. The original value of 0x02 was determined to be incorrect according to the spec anyway.
>  * As the boot protocol change is permanent, separate interface and device descriptor constants for the Mac/non-Mac variants of the tablet are no longer required, and have been removed.
> 
> Phil Dennis-Jordan (2):
>   hw/usb/dev-hid: set bInterfaceProtocol to 0x00 for usb-tablet
>   hw/usb/dev-hid: add a usb-tablet Mac guest compatibility option
> 
>  hw/usb/dev-hid.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
