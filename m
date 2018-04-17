Received: from eggs.gnu.org ([2001:4830:134:3::10]:43437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f8TrM-0004LV-Ou
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1f8TrJ-0006WK-JZ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:53:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1f8TrJ-0006VV-BG
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:53:33 -0400
Date: Tue, 17 Apr 2018 10:53:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180417105331.30429dca@w520.home>
In-Reply-To: <8082FF9BCB2B054996454E47167FF4EC1C7FE5CA@SHSMSX104.ccr.corp.intel.com>
References: <1523424250-3835-1-git-send-email-xiong.y.zhang@intel.com>
	<20180416161559.530ee800@w520.home>
	<8082FF9BCB2B054996454E47167FF4EC1C7FE5CA@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vfio/pci-quirks.c: Make stolen memory size
 adjustable for igd VFIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>

On Tue, 17 Apr 2018 02:37:21 +0000
"Zhang, Xiong Y" <xiong.y.zhang@intel.com> wrote:

> > On Wed, 11 Apr 2018 13:24:10 +0800
> > Xiong Zhang <xiong.y.zhang@intel.com> wrote:
> >   
> > > Currenly linux guest with kernel above 3.19 couldn't boot up on igd
> > > passthrough env. The root case is i915 driver use stolen memory, but
> > > qemu vfio doesn't support it.
> > >
> > > This patch set stolen memory size to zero default, so guest i915 won't
> > > use it. But this breaks old windows igd driver which will be unloaded
> > > once it see zero stolen memory size. Then this patch also use
> > > x-igd-gms option to adjust stolen memory size. New windows igd driver
> > > fixes this and could work with zero stolen memory size.
> > >
> > > Finally with this patch, Linux guest and windows guest with igd driver
> > > above 15.45.4860 could work successfully, windows guest with igd
> > > driver below 15.45.4860 should add x-igd-gms=* option.  
> > 
> > Sorry, I can't understand the above commit log in comparison to what this
> > patch is actually doing.
> >   
> > > Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> > > ---
> > >  hw/vfio/pci-quirks.c | 95
> > > ++++++++++++++++++++++++++++------------------------
> > >  1 file changed, 52 insertions(+), 43 deletions(-)
> > >
> > > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c index
> > > 60ad5fb..6e9ed7f 100644
> > > --- a/hw/vfio/pci-quirks.c
> > > +++ b/hw/vfio/pci-quirks.c
> > > @@ -1372,14 +1372,60 @@ static void  
> > vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)  
> > >      uint16_t cmd_orig, cmd;
> > >      Error *err = NULL;
> > >
> > > +    /* This must be an Intel VGA device. */
> > > +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> > > +        !vfio_is_vga(vdev) || nr != 4) {
> > > +        return;
> > > +    }
> > > +
> > >      /*
> > > -     * This must be an Intel VGA device at address 00:02.0 for us to even
> > > -     * consider enabling legacy mode.  The vBIOS has dependencies on  
> > the  
> > > -     * PCI bus address.
> > > +     * IGD is not a standard, they like to change their specs often.  We
> > > +     * only attempt to support back to SandBridge and we hope that  
> > newer  
> > > +     * devices maintain compatibility with generation 8.
> > >       */
> > > -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> > > -        !vfio_is_vga(vdev) || nr != 4 ||
> > > -        &vdev->pdev !=  
> > pci_find_device(pci_device_root_bus(&vdev->pdev),  
> > > +    gen = igd_gen(vdev);
> > > +    if (gen != 6 && gen != 8) {
> > > +        error_report("IGD device %s is unsupported by IGD quirks, "
> > > +                     "try SandyBridge or newer",  
> > vdev->vbasedev.name);  
> > > +        return;
> > > +    }
> > > +
> > > +    /*
> > > +     * Regardless of running in UPT or legacy mode, the guest graphics
> > > +     * driver may attempt to use stolen memory, however only legacy  
> > mode  
> > > +     * has BIOS support for reserving stolen memory in the guest VM.
> > > +     * Emulate the GMCH register in all cases and zero out the stolen
> > > +     * memory size here.
> > > +     */
> > > +    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
> > > +    gmch &= ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));  
> > 
> > Aha!  You want to enable stolen memory in either UPT or legacy mode.  I
> > could not possibly have determined that from the commit log.  Please
> > rewrite the commit log to describe what is actually changing here.  
> [Zhang, Xiong Y] Here, I want to disable stolen memory in UPT and legacy mode.
> Sure, I will rewrite the commit log.
> >   
> > > +
> > > +    /*
> > > +     * Assume we have no GMS memory, but allow it to be overrided by  
> > device  
> > > +     * option (experimental). Old windows igd driver must see non-zero  
> > stolen  
> > > +     * memory size, otherwise it will be unloaded. New igd windows  
> > driver fix  
> > > +     * this issue and could load with zero stolen memory size.
> > > +     */
> > > +    if (vdev->igd_gms) {
> > > +        if (vdev->igd_gms <= 0x10) {
> > > +            gms_mb = vdev->igd_gms * 32;
> > > +            gmch |= vdev->igd_gms << (gen < 8 ? 3 : 8);
> > > +        } else {
> > > +            error_report("Unsupported IGD GMS value 0x%x",  
> > vdev->igd_gms);  
> > > +            vdev->igd_gms = 0;
> > > +        }
> > > +    }  
> > 
> > You state in the previous code block that only legacy mode has BIOS support
> > for reserving stolen memory, so why should UPT mode be allowed to specify
> > stolen memory?  Where is it allocated?  
> [Zhang, Xiong Y] As the previous code disable stolen memory and set the size of stolen memory to zero,

Only in Legacy Mode, GMCH is not virtualized in UPT Mode.

> this cause old windows igd driver couldn't be loaded as the old
> windows igd driver will be unloaded once it see zero size stolen
> memory but the old windows igd driver doesn't use stolen memory, so
> for old windows igd driver, we just need to set a none zero size
> stolen memory and don't need to allocate an emulated stolen memory .

And this is likely why UPT Mode doesn't virtualize GMCH, we cannot
allocate BDSM for UPT Mode, so our only option would have been to set
GMCH to zero, but this would break Windows, so we did nothing.

> This is old windows igd driver issue and has been fixed in new windows
> igd driver.

So now Windows can operate with GMCH set to zero, but if we set it to
zero we still break anyone using the old driver.  I also note that the
new driver isn't available for all generations of IGD we claim to
support in UPT Mode (Broadwell+), so there is no "update the guest
drivers" fix, the user is required to modify their VM configuration to
set a stolen memory value.  So now you're asking that we set UPT Mode
stolen memory to zero, which will break some users.  To allow those
users to return to their previously working setup, we need to provide
an option to set a stolen memory size, but setting the size is a lie
because we have no mechanism to allocate a range for it in the VM or
set the BDSM register for it.

> So the above code is just for old windows igd driver. if user use an old windows igd driver, he could use x-igd-gms option to workaround old windows igd driver issue. Without this code, old windows igd driver couldn't work anymore in upt mode. And I'm afraid, a lot of user are using  old windows igd driver.

What's our need to do anything here, what's the behavior of the new
Windows driver with the existing UPT Mode behavior?  If this is only an
attempt to virtualize GMCH so that it's a little more coherent in the
guest at the expense of breaking older drivers, that's not a good
trade-off.  On the other hand, if new Windows drivers are broken
because GMCH is non-zero yet BDSM is not virtualized, maybe we could
virtualize BDSM to report a reserved base address so that Windows
recognizes stolen memory is unavailable.  As I understood it, we were
supposed to be able to ignore stolen memory in UPT Mode because it was
a legacy feature, why isn't the hardware and software moving away from
it?  Thanks,

Alex
