Received: from eggs.gnu.org ([2001:4830:134:3::10]:43044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cu0Kk-0003dw-Fw
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cu0Kg-00030O-3O
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:27:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cu0Kf-0002us-RL
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:27:30 -0400
Date: Fri, 31 Mar 2017 11:27:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170331112726.69625d03@t450s.home>
In-Reply-To: <20170331190349.493158f3@Igors-MacBook-Pro.local>
References: <1490869641-29873-1-git-send-email-xiong.y.zhang@intel.com>
	<20170330090148.16048141@t450s.home>
	<8082FF9BCB2B054996454E47167FF4EC1C4930B3@SHSMSX104.ccr.corp.intel.com>
	<20170330205511.28be6306@t450s.home>
	<20170331190349.493158f3@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Revert "vfio/pci-quirks.c: Disable stolen
 memory for igd VFIO"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, 31 Mar 2017 19:03:49 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 30 Mar 2017 20:55:11 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > On Fri, 31 Mar 2017 02:27:11 +0000
> > "Zhang, Xiong Y" <xiong.y.zhang@intel.com> wrote:
> >   
> > > > On Thu, 30 Mar 2017 18:27:21 +0800
> > > > Xiong Zhang <xiong.y.zhang@intel.com> wrote:
> > > >     
> > > > > This reverts commit c2b2e158cc7b1cb431bd6039824ec13c3184a775.
> > > > >
> > > > > The original patch intend to prevent linux i915 driver from using
> > > > > stolen meory. But this patch breaks windows IGD driver loading on
> > > > > Gen9+, as IGD HW will use stolen memory on Gen9+, once windows IGD
> > > > > driver see zero size stolen memory, it will unload.
> > > > > Meanwhile stolen memory will be disabled in 915 when i915 run as
> > > > > a guest.    
> > > > 
> > > > Does this mean that legacy mode IGD assignment is not going to work
> > > > on Gen9+ with Windows?  Will it continue to work with Gen8-?    
> > > [Zhang, Xiong Y] I try to use the following qemu command to enable legacy mode on SKyLake, but It seems the entry point of wins IGD driver isn't called(I couldn't confirm this as I don't have the source code, but I didn't see any IGD driver info from windbg while I could see many info in upt mode), so driver doesn't bind to IGD after win 8.1 boot up.
> > >   #qemu-system-x86_64 -M pc -enable-kvm -smp 2 -m 2G  -vga none -nographic -cpu host -hda "$IMAGE" -device vfio-pci,host=00:02.0,x-vga=true,id=hostdev0,bus=pci.0,addr=0x2
> > > Is this the right method to enable legacy mode ?  
> > 
> > Yeah, that should do it.  x-vga should not be necessary, but shouldn't
> > hurt IIRC.  Any dmesg errors regarding the ROM?  I think we have
> > trouble with the ROM if the host is booted in UEFI mode.  
> 
> 1.
> here is dmesg messages when host is booted with CSM mode enabled
> and host's bios load option rom on boot:
> 
> [165041.359929] vfio-pci 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [165073.898940] vfio-pci 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [165074.687515] vfio-pci 0000:00:02.0: enabling device (0400 -> 0403)
> [165074.791598] vfio_ecap_init: 0000:00:02.0 hiding ecap 0x1b@0x100
> 
> have output on monitor connected via HDMI
> 
> 2.
> and here is dmesg in pure UEFI mode (where host's bios doesn't load option rom):
> 
> [   21.034983] vfio-pci 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [   22.025361] vfio_ecap_init: 0000:00:02.0 hiding ecap 0x1b@0x100
> [   22.030970] vfio-pci 0000:00:02.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
> [   22.031036] vfio-pci 0000:00:02.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
> [   24.738793] vfio-pci 0000:00:02.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0xffff
> [   27.776904] vfio-pci 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> 
> no output on monitor connected via HDMI when using Kabylake CPU (HD630)
> but pure UEFI mode used to work (external output) with Skylake CPU (HD510)

In my limited experience, I've never been able to use IGD assignment on
a pure UEFI host unless I provide the ROM via file.  For instance on my
laptop I switched to CSM and booted a live CD to dump the ROM, which I
can then use regardless of the host BIOS mode.

I just updated my rom-parser to include a version to fixup ROMs for
vendor/device ID and checksum which should help with this:

https://github.com/awilliam/rom-parser

Update the device ID to match your ROM and let it fix the checksum.
Maybe Xiong has some insight into why the VGA ROM often doesn't seem to
exist on native pure UEFI hosts.

> > ---
> my test config is Win10 guest + IGD drivers 4534 build (installed by win update)
> i3-7100T on C236 chipset with following libvirt config
> 
>   <devices>
>     ...
>     <hostdev mode='subsystem' type='pci' managed='yes'>
>       <driver name='vfio'/>
>       <source>
>         <address domain='0x0000' bus='0x00' slot='0x02' function='0x0'/>
>       </source>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0'/>
>     </hostdev>
>     <hostdev mode='subsystem' type='pci' managed='yes'>
>       <driver name='vfio'/>
>       <source>
>         <address domain='0x0000' bus='0x00' slot='0x1f' function='0x3'/>
>       </source>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x0a' function='0x0'/>
>     </hostdev>
>   </devices>
>   <qemu:commandline>
>     <qemu:arg value='-set'/>
>     <qemu:arg value='device.hostdev0.x-igd-opregion=on'/>
>     <qemu:arg value='-set'/>
>     <qemu:arg value='device.hostdev0.x-vga=on'/>

Hmm, neither of these should be necessary, legacy mode IGD support
should active both automatically.  Thanks,

Alex
