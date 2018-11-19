Received: from eggs.gnu.org ([2001:4830:134:3::10]:40093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gOoSB-0001KQ-NG
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gOoS8-0000fQ-CX
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:39:23 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:42718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gOoS6-0008Ow-Bo
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:39:18 -0500
Received: by mail-qk1-f180.google.com with SMTP id m5so50310962qka.9
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 10:38:51 -0800 (PST)
MIME-Version: 1.0
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
	<20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
In-Reply-To: <20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 19 Nov 2018 19:38:39 +0100
Message-ID: <CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
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
To: kraxel@redhat.com, stefanha@gmail.com
Cc: Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>, seabios@seabios.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Nov 19, 2018 at 3:15 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mon, Nov 19, 2018 at 01:07:13PM +0000, Stefan Hajnoczi wrote:
> > On Mon, Nov 19, 2018 at 11:42:28AM +0100, Stefano Garzarella wrote:
> > > On Mon, Nov 19, 2018 at 9:49 AM Gerd Hoffmann <kraxel@redhat.com>
> wrote:
> > >
> > > > Why at runtime?  What is bad with two images?  With a runtime option
> > > > you probably need some way to enable the "fastboot" hint for seabios,
> > > > because some optimizations (like skipping ps/2 initialization) breaks
> > > > functionality.  So it must be opt-in so you can enable it if you know
> > > > your use case is fine with that.  But "qemu -boot fast=on" isn't much
> > > > different from "qemu -bios seabios-fastboot.bin" after all ...
> > > >
> > >
> > > You are right, but maybe having a single image can be simpler to
> distribute,
> > > and we can implement something (eg. using fw_cfg) to selectively enable
> > > features needed.
> > > Anyway, as the first step, I'll try to build a separate image of
> SeaBIOS.
> >
> > Gerd, you may be right that explicit an command-line option like -boot
> > fast=on is required.  I was hoping SeaBIOS improvements could
> > automatically detect cases where no functionality is lost and would not
> > require new command-line options for users or management tools (e.g.
> > libvirt).
>
> Will probably be possible to a certain degree, but I expect you can't
> get 100% of the qboot savings without something like -boot fast=on.
>
> > For example, if SeaBIOS sees -kernel, is it necessary to follow the full
> > BIOS boot process including loading option ROMs?
>
> Well, right now -kernel loading is actually implemented by an option rom
> ...
>
> > This way we could avoid scanning PCI devices.
>
> That has consequences for the acpi tables, because qemu checks where the
> firmware mapped the pci bars when generating the tables.
>
> Also it is not a given that skipping pci initialization in seabios is a
> win in the end.  The linux kernel has to handle pci bar configuration
> then so it might be we just shift around boot times.
>
> > Admittedly I don't know the answer to how transparent we can make this,
> > but I hope Stefano will identify how far we can go.
>
> Yes, lets see.
>

Hi guys,
just an update, I enabled the debug prints and I saw two timeouts fired
with a lot
of time lost (~780ms between "init timer" and "Scan for VGA ..."),
putting other prints I discovered that a lot of time is spent in the
tpm_setup(),
during the probe of the 2 TPM devices:

00.548869 init timer
00.549677 ./src/post.c:157 platform_hardware_setup
00.550182 ./src/hw/tpm_drivers.c:579 tpmhw_probe
01.300833 WARNING - Timeout at wait_reg8:81!
01.301388 ./src/hw/tpm_drivers.c:579 tpmhw_probe
01.331843 WARNING - Timeout at wait_reg8:81!
01.332316 ./src/post.c:160 platform_hardware_setup
01.333358 Scan for VGA option rom

Indeed, in the probe of the TPM devices (TIS and CRB)  there are timeouts of
750 ms and 30 ms respectively.

Then, statically disabling TPM and TCG (CONFIG_TCGBIOS) the time spent
in SeaBIOS goes down from ~846ms to ~56ms:
# SeaBIOS disabling CONFIG_TCGBIOS
BIOS=/home/stefano/repos/seabios/out_notcgbios/bios.bin
 qemu_init_end: 40.658371
 fw_start: 40.850395 (+0.192024)
 fw_do_boot: 96.750142 (+55.899747)
 linux_start_boot: 98.880578 (+2.130436)

The tpm_setup() is called after the qemu_cfg_init(), so I think we can
disable
this call using some fw_cfg parameters, if we will decide to implement a
runtime
approach.

Cheers,
Stefano


> cheers,
>   Gerd
>
>

-- 
Stefano Garzarella
Red Hat
