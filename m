Received: from eggs.gnu.org ([2001:4830:134:3::10]:42728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ctmib-00047c-HC
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 22:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ctmiY-0000DG-EX
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 22:55:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ctmiY-0000CZ-8k
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 22:55:14 -0400
Date: Thu, 30 Mar 2017 20:55:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170330205511.28be6306@t450s.home>
In-Reply-To: <8082FF9BCB2B054996454E47167FF4EC1C4930B3@SHSMSX104.ccr.corp.intel.com>
References: <1490869641-29873-1-git-send-email-xiong.y.zhang@intel.com>
	<20170330090148.16048141@t450s.home>
	<8082FF9BCB2B054996454E47167FF4EC1C4930B3@SHSMSX104.ccr.corp.intel.com>
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
To: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, 31 Mar 2017 02:27:11 +0000
"Zhang, Xiong Y" <xiong.y.zhang@intel.com> wrote:

> > On Thu, 30 Mar 2017 18:27:21 +0800
> > Xiong Zhang <xiong.y.zhang@intel.com> wrote:
> >   
> > > This reverts commit c2b2e158cc7b1cb431bd6039824ec13c3184a775.
> > >
> > > The original patch intend to prevent linux i915 driver from using
> > > stolen meory. But this patch breaks windows IGD driver loading on
> > > Gen9+, as IGD HW will use stolen memory on Gen9+, once windows IGD
> > > driver see zero size stolen memory, it will unload.
> > > Meanwhile stolen memory will be disabled in 915 when i915 run as
> > > a guest.  
> > 
> > Does this mean that legacy mode IGD assignment is not going to work
> > on Gen9+ with Windows?  Will it continue to work with Gen8-?  
> [Zhang, Xiong Y] I try to use the following qemu command to enable legacy mode on SKyLake, but It seems the entry point of wins IGD driver isn't called(I couldn't confirm this as I don't have the source code, but I didn't see any IGD driver info from windbg while I could see many info in upt mode), so driver doesn't bind to IGD after win 8.1 boot up.
>   #qemu-system-x86_64 -M pc -enable-kvm -smp 2 -m 2G  -vga none -nographic -cpu host -hda "$IMAGE" -device vfio-pci,host=00:02.0,x-vga=true,id=hostdev0,bus=pci.0,addr=0x2
> Is this the right method to enable legacy mode ?

Yeah, that should do it.  x-vga should not be necessary, but shouldn't
hurt IIRC.  Any dmesg errors regarding the ROM?  I think we have
trouble with the ROM if the host is booted in UEFI mode.

> 
> > Please clarify Gen9+, is this Kaby Lake?  
> [Zhang, Xiong Y] Gen 9+ is SkyLake and later.

Ok, then I cannot test since I only have access to BDW.  We do have
users that might start complaining if this is a new change in the
Windows driver for SKL+.
 
> > I assume this patch is intended for QEMU 2.9, it's helpful to make that
> > explicit during the rc freeze.  Thanks,  
> [Zhang, Xiong Y] Yes, as the original patch has entered into Qemu 2.9 rc1. So this reverted patch should be entered into the later 2.9 rc.
> Sorry for the troubles.

Ok, no problem.  Thanks,

Alex 
