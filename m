Received: from eggs.gnu.org ([209.51.188.92]:49275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyAMv-0007h7-4t
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 02:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyAMu-0005cQ-7u
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 02:08:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gyAMt-0005ZZ-ER
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 02:08:04 -0500
Date: Mon, 25 Feb 2019 08:07:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190225070755.isoufp7cua3muci6@sirius.home.kraxel.org>
References: <20190221150353.93DE87465DE@zero.eik.bme.hu>
	<20190222115146.e4e5jlbwlysx433f@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1902221629100.73795@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1902221629100.73795@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, philmd@redhat.com

> > Attached patch creates two separate devices.  It's just some QOM
> > boilerplate, they still share 95% of the code.
> 
> Thanks. Do you want me to merge this and submit a new version or you want to
> fix up after merging my patch or what should we do with this? (I'm not a fan
> of adding a new function for every new model of these devices so I'd
> probably get rid of the is_ati_* functions and still compare to device id
> internally maybe via a single is_ati_device(id) function though. I also find
> ati-rage128pro a bit too long, I liked the ati-vga better with selecting
> variants via a property but if you think it's better with more QOM
> boilerplate and adding every variant to the default_list[] one by one then I
> can live with that. How about ati-r128pro at least instead?

Just apply the patch to your branch and tidy up as you want.  Shorten
the rage name is fine with me.

I don't expect we'll add too many variants, getting the two work
properly will be difficult enough, so the QOM boilerplate shouldn't be
much of a problem.  I think it'll be more user-friendly to just have two
or three ati devices instead of expecting them to dig out the correct
id.

> >  With that in place
> > vgabios works just fine for both devices.
> 
> But I don't get why is the above needed for this. By the time the client
> runs (after device realize) both should look the same: your QOM subclasses
> and my ati-vga class that sets device_id based on property. Where's the
> difference that makes one work and other doesn't?

See pci_patch_ids() in hw/pci/pci.c

That gets vgabios-stdvga going with the ati cards (as long as the bochs
interface is available), by setting the vendor and device IDs so seabios
accepts and loads the rom.

That requires the device ID being set at that point though.
Specifically setting it in reset handler is too late, and I think doing
it in realize() is too late too.  With two QOM types it is already set,
thats why this gets the vgabios work with the rv100.

> > Neither radeonfb.ko nor radeon.ko (drm driver) can handle the rv100.
> > Loading radeonfb results in a kernel panic.  radeon.ko prints an
> > initialization error.  Seems at least radeonfb tries to pull some info
> > out of the bios image ...
> 
> Is there a live cd iso or something simple to test this with?

No.  Problem is modern distros tend to not build these drivers any more.

I have a script which creates a big initrd with a small distro install
plus a self-compiled kernel, for testing my kernel patches.  This is
what I have used here too.

> I think the ATI option ROMs have some mode timings that are needed to
> program PLLs for setting modes and drivers extract this from the BIOS which
> has some predefined structure so if a driver relies on this it may have a
> problem when we don't have a BIOS with the data it expects. But if it does
> not check BIOS format and just pulls junk out of unexpected BIOS image and
> puts that in clock registers that should not matter as those are ignored
> anyway. I think rv100 will probably need a separate vgabios that looks more
> like what drivers expect but I don't have plans yet to implement that.

For radeonfb this might work.
The radeon drm driver error messaga was quite unspecific.

cheers,
  Gerd
