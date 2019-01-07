Received: from eggs.gnu.org ([209.51.188.92]:38261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggSOS-0006Am-I6
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggSOO-0003sY-Qo
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:44:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggSOM-0003qm-Rn
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:44:24 -0500
Date: Mon, 7 Jan 2019 11:44:19 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190107104419.coaistvm72hx2slz@sirius.home.kraxel.org>
References: <alpine.DEB.2.11.1812271413170.12302@REDDOT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1812271413170.12302@REDDOT>
Subject: Re: [Qemu-devel] [PATCH] Introduce new "no_guest_reset" parameter
 for usb-host device (fwd)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Kappner <agk@godking.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On Thu, Dec 27, 2018 at 02:19:09PM -0800, Alexander Kappner wrote:
> 
> Resending; forgot to CC maintainer.

Now the list mail address is wrong (.com instead of .org).

> 1) Guest recognizes new device, sends reset to emulated USB host
> 2) QEMU's USB host sends reset to host kernel
> 3) Host kernel resets device
> 4) After reset, host kernel determines that some part of the device descriptor
> has changed ("device firmware changed" in dmesg), so host kernel decides to
> re-enumerate the device.

Not sure this is actually the reason ...

> 5) Re-enumeration causes QEMU to disconnect and reconnect the device in the
> guest.
> 6) goto 1)
> 
> Here's from the host kernel (note the "device firmware changed" lines")
> 
> [3677704.473050] usb 1-1.3: new high-speed USB device number 53 using ehci-pci
> [3677704.555594] usb 1-1.3: New USB device found, idVendor=05ac, idProduct=12a8, bcdDevice=11.08
> [3677704.555599] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [3677704.555602] usb 1-1.3: Product: iPhone
> [3677704.555605] usb 1-1.3: Manufacturer: Apple Inc.
> [3677704.555607] usb 1-1.3: SerialNumber: [[removed]]
> [3677709.401040] usb 1-1.3: reset high-speed USB device number 53 using ehci-pci
> [3677709.479486] usb 1-1.3: device firmware changed

.. here it is ...

> [3677709.479842] usb 1-1.3: USB disconnect, device number 53
> [3677709.546039] usb 1-1.3: new high-speed USB device number 54 using ehci-pci
> [3677709.627471] usb 1-1.3: New USB device found, idVendor=05ac, idProduct=12a8, bcdDevice=11.08
> [3677709.627476] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [3677709.627479] usb 1-1.3: Product: iPhone
> [3677709.627481] usb 1-1.3: Manufacturer: Apple Inc.
> [3677709.627483] usb 1-1.3: SerialNumber: [[removed]]
> [3677762.320044] usb 1-1.3: reset high-speed USB device number 54 using ehci-pci
> [3677762.615630] usb 1-1.3: USB disconnect, device number 54

... but on the second cycle this is missing but there is still a disconnect.

Could be the phone actually disconnects.

> introduced for the usb-host device. I can confirm that the configuration
> described above (iPhone XS + Mojave guest) works flawlessly with
> no_guest_reset=True specified.

Can you make this "guest-reset=false"?  Otherwise the patch looks fine.

thanks,
  Gerd
