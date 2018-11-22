Received: from eggs.gnu.org ([2001:4830:134:3::10]:39280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPnWS-0001yE-E2
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPnWN-0005Ih-G7
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:51:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gPnWN-0005AO-Aq
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 06:51:47 -0500
Date: Thu, 22 Nov 2018 12:51:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181122115135.funmtcql3xhrixi6@sirius.home.kraxel.org>
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
	<20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
	<CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
	<20181120062109.eahirgygm4br3ov7@sirius.home.kraxel.org>
	<CAGxU2F64uK5oygQecZKOPpsyb--Pth9U00P_gghrtYDwQrSGtg@mail.gmail.com>
	<20181120112203.rzhhdl6hhsjf5twt@sirius.home.kraxel.org>
	<CAGxU2F4LNN1UtVJFADxm1V4eBDQ8eGSoAjPXC=X8+zSR4yd9Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F4LNN1UtVJFADxm1V4eBDQ8eGSoAjPXC=X8+zSR4yd9Nw@mail.gmail.com>
Subject: Re: [Qemu-devel] SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Kevin OConnor <kevin@koconnor.net>, Samuel Ortiz <sameo@linux.intel.com>, seabios@seabios.org, Stefan Hajnoczi <stefanha@gmail.com>, Rob Bradford <robert.bradford@intel.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, stephend@silicom-usa.com, stefanb@linux.ibm.com

On Thu, Nov 22, 2018 at 12:08:55PM +0100, Stefano Garzarella wrote:
> Hi,
> I continued to investigate how to reduce the boot time with SeaBIOS
> and QEMU when it used with linuxboot_dma.bin (-kernel parameter).
> I reached ~12ms with a SeaBIOS configuration (attached) where I
> disabled debug output, all Hardware support (except SMM & MTRRs) and I
> applied a small patch to disable VGA setup and console (attached).

Is there any difference to "qemu -vga none" ?

> Samuel, I put also the total time to userspace (linux_start_user)
> adding a probe in the kernel_init() and when I disabled the VGA in the
> SeaBIOS I noticed also a speed up in the kernel boot phase.

Might come from linux 16bit boot code scanning vgabios for available
video modes (for vga=<mode> cmdline arg).

> Another approach that I tried, obtaining similar results, is to
> recognize the linuxboot_dma.bin at runtime, then skip
> device_hardware_setup(), enable_vga_console(), and vgarom_setup().

Hmm, tricky.

linuxboot_dma.bin just registers a boot entry, so with "qemu -kernel
-boot menu=on" you can still get a boot menu, and the direkt kernel boot
is one menu item there.  So you can't know for sure whenever a direct
kernel boot will happen or not.

So, I think at minimum we should make this depend on both linuxboot_dma
and boot menu disabled.

cheers,
  Gerd
