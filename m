Received: from eggs.gnu.org ([209.51.188.92]:35677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gxD9N-0007sy-6n
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gxD9L-0007ZR-FD
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:54:09 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:56863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gxD9L-0007OO-1k
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:54:07 -0500
Date: Fri, 22 Feb 2019 16:54:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190222115146.e4e5jlbwlysx433f@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1902221629100.73795@zero.eik.bme.hu>
References: <20190221150353.93DE87465DE@zero.eik.bme.hu>
	<20190222115146.e4e5jlbwlysx433f@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v3] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, philmd@redhat.com

On Fri, 22 Feb 2019, Gerd Hoffmann wrote:
> On Thu, Feb 21, 2019 at 03:55:14PM +0100, BALATON Zoltan wrote:
>> At least two machines, the PPC mac99 and MIPS fulong2e, have an ATI
>> gfx chip by default (Rage 128 Pro and M6/RV100 respectively) and
>> guests running on these and the PMON2000 firmware of the fulong2e
>> expect this to be available. Fortunately these are very similar chips
>> so they can be mostly emulated in the same device model. This patch
>> adds basic emulation of these ATI VGA chips.
>>
>> While this is incomplete and currently only enough to run the MIPS
>> firmware and get framebuffer output with Linux, it allows the fulong2e
>> board to work more like the real hardware and having it in QEMU in
>> this state provides a way to experiment with it and allows others to
>> contribute to improve it. It is compiled for all archs but only the
>> fulong2e (which currently has no display output at all) is set to use
>> it by default (in a patch sent separately).
>
> Attached patch creates two separate devices.  It's just some QOM
> boilerplate, they still share 95% of the code.

Thanks. Do you want me to merge this and submit a new version or you want 
to fix up after merging my patch or what should we do with this? (I'm not 
a fan of adding a new function for every new model of these devices so I'd 
probably get rid of the is_ati_* functions and still compare to device id 
internally maybe via a single is_ati_device(id) function though. I also 
find ati-rage128pro a bit too long, I liked the ati-vga better with 
selecting variants via a property but if you think it's better with more 
QOM boilerplate and adding every variant to the default_list[] one by one 
then I can live with that. How about ati-r128pro at least instead?

>  With that in place
> vgabios works just fine for both devices.

But I don't get why is the above needed for this. By the time the client 
runs (after device realize) both should look the same: your QOM subclasses 
and my ati-vga class that sets device_id based on property. Where's the 
difference that makes one work and other doesn't?

> On x86 linux:  Fedora live iso happily boots X on both devices, they both
> are running with the vesa xorg driver though so that doesn't say much.
>
> With a self-compiled kernel:
> aty128fb.ko seems to be able to handle the rage128pro.

Good, that's all that's expected to work at the moment anyway.

> Neither radeonfb.ko nor radeon.ko (drm driver) can handle the rv100.
> Loading radeonfb results in a kernel panic.  radeon.ko prints an
> initialization error.  Seems at least radeonfb tries to pull some info
> out of the bios image ...

Is there a live cd iso or something simple to test this with?

I think the ATI option ROMs have some mode timings that are needed to 
program PLLs for setting modes and drivers extract this from the BIOS 
which has some predefined structure so if a driver relies on this it may 
have a problem when we don't have a BIOS with the data it expects. But if 
it does not check BIOS format and just pulls junk out of unexpected BIOS 
image and puts that in clock registers that should not matter as those are 
ignored anyway. I think rv100 will probably need a separate vgabios that 
looks more like what drivers expect but I don't have plans yet to 
implement that. It may also be interesting to try a BIOS from a real card 
if you can get one to see what it does.

I think I've seen some logs in dmesg from aty128fb driver saying that BIOS 
is unexpected, guessing PLL values or similar. Maybe the radoeon driver 
does not do that and exits if BIOS is not found?

Regards,
BALATON Zoltan
