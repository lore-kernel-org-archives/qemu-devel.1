Received: from eggs.gnu.org ([2001:4830:134:3::10]:52293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gQ4rQ-00031W-IR
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gQ4qW-0001Mu-4l
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:21:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gQ4qV-0001KA-Vr
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 01:21:44 -0500
Date: Fri, 23 Nov 2018 07:21:38 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181123062138.rdfaeaqq5uw43ey2@sirius.home.kraxel.org>
References: <CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
	<20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
	<CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
	<20181120062109.eahirgygm4br3ov7@sirius.home.kraxel.org>
	<CAGxU2F64uK5oygQecZKOPpsyb--Pth9U00P_gghrtYDwQrSGtg@mail.gmail.com>
	<20181120112203.rzhhdl6hhsjf5twt@sirius.home.kraxel.org>
	<CAGxU2F4LNN1UtVJFADxm1V4eBDQ8eGSoAjPXC=X8+zSR4yd9Nw@mail.gmail.com>
	<20181122115135.funmtcql3xhrixi6@sirius.home.kraxel.org>
	<CAGxU2F6462MF00_0dh_6HiFPgVyEpaRTEPJ_0-sUdg8YnhgLcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F6462MF00_0dh_6HiFPgVyEpaRTEPJ_0-sUdg8YnhgLcw@mail.gmail.com>
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

On Thu, Nov 22, 2018 at 04:13:38PM +0100, Stefano Garzarella wrote:
> On Thu, Nov 22, 2018 at 12:51 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Thu, Nov 22, 2018 at 12:08:55PM +0100, Stefano Garzarella wrote:
> > > Hi,
> > > I continued to investigate how to reduce the boot time with SeaBIOS
> > > and QEMU when it used with linuxboot_dma.bin (-kernel parameter).
> > > I reached ~12ms with a SeaBIOS configuration (attached) where I
> > > disabled debug output, all Hardware support (except SMM & MTRRs) and I
> > > applied a small patch to disable VGA setup and console (attached).
> >
> > Is there any difference to "qemu -vga none" ?
> 
> Using both (qemu -vga none, and my patch) we are around 10.8 ms.
> Note: using only the patch, Linux is still able to initialize and use the VGA.

But do you want linux use the vga console if you care about boot times?
I'd expect virtio-console would be fastest in that case.

> - QEMU -vga none + SeaBIOS config (CONFIG_DEBUG_LEVEL=0, disable all
> HW support except
> SMM & MTRRs) + Stephen's TPM patch
>  qemu_init_end: 43.675803
>  fw_start: 43.865178 (+0.189375)
>  fw_do_boot: 58.093161 (+14.227983)
>  linux_start_boot: 59.490308 (+1.397147)
>  linux_start_user: 556.782354 (+497.292046)
> 
> - QEMU -vga none + SeaBIOS config (CONFIG_DEBUG_LEVEL=0, disable all
> HW support except
> SMM & MTRRs, CONFIG_DISABLE_VGA=y) + Stephen's TPM patch
>  qemu_init_end: 42.387412
>  fw_start: 42.579257 (+0.191845)
>  fw_do_boot: 53.381517 (+10.802260)
>  linux_start_boot: 54.848643 (+1.467126)
>  linux_start_user: 498.517050 (+443.668407)

Interesting that CONFIG_DISABLE_VGA=y makes a noticable difference even
without vga hardware being preset.  And not only in seabios but also for
the linux kernel.

Do you know why?

cheers,
  Gerd
