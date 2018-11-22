Received: from eggs.gnu.org ([2001:4830:134:3::10]:33265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gPqg4-0005DW-TA
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gPqfz-0002eH-U8
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:14:00 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gPqfx-0002Zj-Uz
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:13:54 -0500
Received: by mail-io1-f66.google.com with SMTP id u19so6853067ioc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 07:13:52 -0800 (PST)
MIME-Version: 1.0
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
	<20181122115135.funmtcql3xhrixi6@sirius.home.kraxel.org>
In-Reply-To: <20181122115135.funmtcql3xhrixi6@sirius.home.kraxel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 22 Nov 2018 16:13:38 +0100
Message-ID: <CAGxU2F6462MF00_0dh_6HiFPgVyEpaRTEPJ_0-sUdg8YnhgLcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kevin OConnor <kevin@koconnor.net>, Samuel Ortiz <sameo@linux.intel.com>, seabios@seabios.org, Stefan Hajnoczi <stefanha@gmail.com>, Rob Bradford <robert.bradford@intel.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, stephend@silicom-usa.com, stefanb@linux.ibm.com

On Thu, Nov 22, 2018 at 12:51 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Nov 22, 2018 at 12:08:55PM +0100, Stefano Garzarella wrote:
> > Hi,
> > I continued to investigate how to reduce the boot time with SeaBIOS
> > and QEMU when it used with linuxboot_dma.bin (-kernel parameter).
> > I reached ~12ms with a SeaBIOS configuration (attached) where I
> > disabled debug output, all Hardware support (except SMM & MTRRs) and I
> > applied a small patch to disable VGA setup and console (attached).
>
> Is there any difference to "qemu -vga none" ?

Using both (qemu -vga none, and my patch) we are around 10.8 ms.
Note: using only the patch, Linux is still able to initialize and use the VGA.

- QEMU -vga none + SeaBIOS config (CONFIG_DEBUG_LEVEL=0, disable all
HW support except
SMM & MTRRs) + Stephen's TPM patch
 qemu_init_end: 43.675803
 fw_start: 43.865178 (+0.189375)
 fw_do_boot: 58.093161 (+14.227983)
 linux_start_boot: 59.490308 (+1.397147)
 linux_start_user: 556.782354 (+497.292046)

- QEMU -vga none + SeaBIOS config (CONFIG_DEBUG_LEVEL=0, disable all
HW support except
SMM & MTRRs, CONFIG_DISABLE_VGA=y) + Stephen's TPM patch
 qemu_init_end: 42.387412
 fw_start: 42.579257 (+0.191845)
 fw_do_boot: 53.381517 (+10.802260)
 linux_start_boot: 54.848643 (+1.467126)
 linux_start_user: 498.517050 (+443.668407)

>
> > Samuel, I put also the total time to userspace (linux_start_user)
> > adding a probe in the kernel_init() and when I disabled the VGA in the
> > SeaBIOS I noticed also a speed up in the kernel boot phase.
>
> Might come from linux 16bit boot code scanning vgabios for available
> video modes (for vga=<mode> cmdline arg).
>
> > Another approach that I tried, obtaining similar results, is to
> > recognize the linuxboot_dma.bin at runtime, then skip
> > device_hardware_setup(), enable_vga_console(), and vgarom_setup().
>
> Hmm, tricky.
>"
> linuxboot_dma.bin just registers a boot entry, so with "qemu -kernel
> -boot menu=on" you can still get a boot menu, and the direkt kernel boot
> is one menu item there.  So you can't know for sure whenever a direct
> kernel boot will happen or not.
>
> So, I think at minimum we should make this depend on both linuxboot_dma
> and boot menu disabled.

You are right! I'll prepare a patch adding the check of boot menu.

Thanks,
Stefano

>
> cheers,
>   Gerd
>


--
Stefano Garzarella
Red Hat
