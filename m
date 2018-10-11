Received: from eggs.gnu.org ([2001:4830:134:3::10]:53328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gAiN6-0005Je-NZ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 17:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gAiN1-0006qV-LZ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 17:19:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gAiN1-0006pm-Cm
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 17:19:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D92D62EAA
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 21:19:46 +0000 (UTC)
Date: Thu, 11 Oct 2018 15:19:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181011151941.77cd8516@w520.home>
In-Reply-To: <20180917061729.22407-3-kraxel@redhat.com>
References: <20180917061729.22407-1-kraxel@redhat.com>
	<20180917061729.22407-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 17 Sep 2018 08:17:29 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> So we have a boot display when using a vgpu as primary display.
> 
> ramfb depends on a fw_cfg file.  fw_cfg files can not be added and
> removed at runtime, therefore a ramfb-enabled vfio device can't be
> hotplugged.
> 
> Add a nohotplug variant of the vfio-pci device (as child class).  Add
> the ramfb property to the nohotplug variant only.  So to enable the vgpu
> display with boot support use this:
> 
>   -device vfio-pci-nohotplug,display=on,ramfb=on,sysfsdev=...
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/vfio/pci.h                 |  1 +
>  include/hw/vfio/vfio-common.h |  2 ++
>  hw/vfio/display.c             | 12 ++++++++++++
>  hw/vfio/pci.c                 | 25 +++++++++++++++++++++++++
>  4 files changed, 40 insertions(+)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 52b065421a..904e286586 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -149,6 +149,7 @@ typedef struct VFIOPCIDevice {
>  #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
>                                  (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
>      OnOffAuto display;
> +    bool enable_ramfb;
>      int32_t bootindex;
>      uint32_t igd_gms;
>      OffAutoPCIBAR msix_relo;

Hi Gerd,

One tiny nit here, we can move this new bool down in the struct with
the rest of the bools for better alignment.  I can change that on
commit.  However, I'm not having luck getting ramfb to work; the
display is only getting initialized once the guest driver loads.  This
is a 440FX/SeaBIOS VM, it looks like you've already updated bios.bin in
qemu.git with ramfb support, but I also see the same results with
bios.bin from your seabios.git package.  I'm using libvirt to launch
the guest with a wrapper around qemu-system-x86_64 to replace vfio-pci
with vfio-pci-nohotplug, resulting in a command line including:

-bios /usr/share/seabios.git/bios.bin \
-spice port=0,disable-ticketing,gl=on,rendernode=/dev/dri/by-path/pci-0000:00:02.0-render,seamless-migration=on \
-device vfio-pci-nohotplug,id=hostdev0,sysfsdev=...,display=on,bus=pci.0,addr=0x9 \
-set device.hostdev0.x-igd-opregion=on \
-set device.hostdev0.ramfb=on \

Relevant XML blobs:

    <graphics type='spice'>
      <listen type='none'/>
      <gl enable='yes' rendernode='/dev/dri/by-path/pci-0000:00:02.0-render'/>
    </graphics>
    <video>
      <model type='none'/>
    </video>
    <hostdev mode='subsystem' type='mdev' managed='no' model='vfio-pci' display='on'>
      <source>
        <address uuid='cd4fa69f-c24c-476f-a61d-abca705e2a13'/>
      </source>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x09' function='0x0'/>
    </hostdev>
...
  <qemu:commandline>
    <qemu:arg value='-set'/>
    <qemu:arg value='device.hostdev0.x-igd-opregion=on'/>
    <qemu:arg value='-set'/>
    <qemu:arg value='device.hostdev0.ramfb=on'/>
  </qemu:commandline>

This is a Windows 10 VM, but as I understand this ramfb support, I
think I'm still supposed to see SeaBIOS boot messages and perhaps even
the Windows boot animation before the guest driver takes over, is that
correct?  What am I missing?  Thanks,

Alex
