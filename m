Received: from eggs.gnu.org ([2001:4830:134:3::10]:58039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAt2X-0002Dq-Br
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAt2O-0007N0-GM
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:43:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAt2K-0006n7-In
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:43:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B933BC0293AD
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 08:43:05 +0000 (UTC)
Date: Fri, 12 Oct 2018 10:43:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181012084302.so3aptiavcgvbbyh@sirius.home.kraxel.org>
References: <20180917061729.22407-1-kraxel@redhat.com>
	<20180917061729.22407-3-kraxel@redhat.com>
	<20181011151941.77cd8516@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011151941.77cd8516@w520.home>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

  Hi,

> >      OnOffAuto display;
> > +    bool enable_ramfb;
> >      int32_t bootindex;
> >      uint32_t igd_gms;
> >      OffAutoPCIBAR msix_relo;
> 
> Hi Gerd,
> 
> One tiny nit here, we can move this new bool down in the struct with
> the rest of the bools for better alignment.  I can change that on
> commit.

I've grouped it with the display option because it is display related
too, but if you prefer to group the bools instead this is fine with me.

> However, I'm not having luck getting ramfb to work; the
> display is only getting initialized once the guest driver loads.  This
> is a 440FX/SeaBIOS VM, it looks like you've already updated bios.bin in
> qemu.git with ramfb support,

Yes, seabios (and vgabios) bundled with 3.0 (and master branch) should work fine.

There is a standalone device you can use for testing (-vga none -device
ramfb), to see whenever the firmware side of things works correctly.

OVMF has ramfb support too btw (merged a few months back).

> -device vfio-pci-nohotplug,id=hostdev0,sysfsdev=...,display=on,bus=pci.0,addr=0x9 \

>     <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-pci' display='on'>
>       <source>
>         <address uuid='cd4fa69f-c24c-476f-a61d-abca705e2a13'/>
>       </source>
>       <address type='pci' domain='0x0000' bus='0x00' slot='0x09' function='0x0'/>
>     </hostdev>

Hmm, that actually uses vfio-pci-nohotplug?
But when ramfb=on doesn't throw an error, then yes, appearently.

>   <qemu:commandline>
>     <qemu:arg value='-set'/>
>     <qemu:arg value='device.hostdev0.x-igd-opregion=on'/>
>     <qemu:arg value='-set'/>
>     <qemu:arg value='device.hostdev0.ramfb=on'/>
>   </qemu:commandline>

I have this (additionally):

    <qemu:arg value='-set'/>
    <qemu:arg value='device.hostdev0.driver=vfio-pci-nohotplug'/>

> This is a Windows 10 VM, but as I understand this ramfb support, I
> think I'm still supposed to see SeaBIOS boot messages and perhaps even
> the Windows boot animation before the guest driver takes over, is that
> correct?

Yes, you should see both.

cheers,
  Gerd
