Received: from eggs.gnu.org ([2001:4830:134:3::10]:53053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gP2bM-0000H4-0k
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gP2bI-0003BX-T3
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:45:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gP2bI-0003BJ-PD
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:45:44 -0500
Received: by mail-qk1-f196.google.com with SMTP id a132so1860289qkg.1
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 01:45:44 -0800 (PST)
MIME-Version: 1.0
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
	<20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
	<CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
	<20181120062109.eahirgygm4br3ov7@sirius.home.kraxel.org>
In-Reply-To: <20181120062109.eahirgygm4br3ov7@sirius.home.kraxel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 20 Nov 2018 10:45:31 +0100
Message-ID: <CAGxU2F64uK5oygQecZKOPpsyb--Pth9U00P_gghrtYDwQrSGtg@mail.gmail.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>, seabios@seabios.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi Gerd,

On Tue, Nov 20, 2018 at 7:21 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > just an update, I enabled the debug prints and I saw two timeouts fired
> > with a lot
> > of time lost (~780ms between "init timer" and "Scan for VGA ..."),
> > putting other prints I discovered that a lot of time is spent in the
> > tpm_setup(),
> > during the probe of the 2 TPM devices:
> >
> > 00.548869 init timer
> > 00.549677 ./src/post.c:157 platform_hardware_setup
> > 00.550182 ./src/hw/tpm_drivers.c:579 tpmhw_probe
> > 01.300833 WARNING - Timeout at wait_reg8:81!
> > 01.301388 ./src/hw/tpm_drivers.c:579 tpmhw_probe
> > 01.331843 WARNING - Timeout at wait_reg8:81!
> > 01.332316 ./src/post.c:160 platform_hardware_setup
> > 01.333358 Scan for VGA option rom
> >
> > Indeed, in the probe of the TPM devices (TIS and CRB)  there are timeouts of
> > 750 ms and 30 ms respectively.
> >
> > Then, statically disabling TPM and TCG (CONFIG_TCGBIOS) the time spent
> > in SeaBIOS goes down from ~846ms to ~56ms:
> > # SeaBIOS disabling CONFIG_TCGBIOS
> > BIOS=/home/stefano/repos/seabios/out_notcgbios/bios.bin
> >  qemu_init_end: 40.658371
> >  fw_start: 40.850395 (+0.192024)
> >  fw_do_boot: 96.750142 (+55.899747)
> >  linux_start_boot: 98.880578 (+2.130436)
> >
> > The tpm_setup() is called after the qemu_cfg_init(), so I think we can
> > disable
> > this call using some fw_cfg parameters, if we will decide to implement a
> > runtime
> > approach.
>
> Another possible option is to simply use shorter timeouts on qemu (using
> runningOnQEMU()), I'd suggest to check with the TPM maintainers whenever
> that is ok.

Yes, it is a good idea!

>
> Background:  The drivers in seabios work on both virtual and physical
> hardware (you can run seabios as coreboot payload on physical hardware).
> There are quite a few places where are delays and timeouts which are
> required to work properly on physical hardware.  But typically virtual
> hardware is alot faster.  There is -- for example -- no time needed to
> establish a sata link.  Link detection in ahci is instant on qemu.

I'll investigate also other timeouts.

Thanks,
Stefano

>
> cheers,
>   Gerd
>


--
Stefano Garzarella
Red Hat
