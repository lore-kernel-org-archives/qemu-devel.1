Received: from eggs.gnu.org ([2001:4830:134:3::10]:52228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gRcfr-0001SM-Lo
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gRcfo-0001RS-A8
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:41:07 -0500
Message-ID: <8806f4268a13af0a5fe73295a5d496c4809394d7.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 27 Nov 2018 13:40:59 +0100
In-Reply-To: <mhng-b12cc231-a10a-454f-a088-21932acd8edf@palmer-si-x1c4>
References: <mhng-b12cc231-a10a-454f-a088-21932acd8edf@palmer-si-x1c4>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 0/6] Connect a PCIe host and
 graphics support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair23@gmail.com, logang@deltatee.com, linux@roeck-us.net

On Mon, 2018-11-26 at 11:34 -0800, Palmer Dabbelt wrote:
> FWIW, I get my images from here
> 
>     https://fedorapeople.org/groups/risc-v/disk-images/
> 
> which is linked to from the Fedora wiki
> 
>     https://fedoraproject.org/wiki/Architectures/RISC-V/Disk_images
> 
> the stage4 there is quite old (April, 2018), is yours newer?  I'm having some 
> problems updating my disk image and since I'm not a Fedora user I have no idea 
> what's going on.

Yeah, we have nightly built images now - they come in several
flavors, even!

  http://185.97.32.145/koji/tasks?state=closed&view=flat&method=createAppliance&order=-id

Note that there are some issues with the server configuration and
the HSTS preload list shipped with browsers not playing nice with
each other, so you'll have to tweak URLs a bit before you can
actually download images, basically

  s,https://fedora-riscv.tranquillity.se,http://185.97.32.145,

I wonder if it even makes sense to keep the old stage4 images
around... And someone should definitely sweep through the wiki
and make sure we don't point to obsolete information and all URLs
are up to date. Maybe I should create that Fedora Account after
all O:-)

> > [2] https://fedorapeople.org/groups/risc-v/disk-images/
> >     PCI support is included in the bbl now! \o/
> 
> Great!  I've yet to figure out how to get all the PCI stuff working, but I was 
> trying to go with a virgl-based GPU which I suspect is broken for other 
> reasons.  What sort of devices did you attach?

I just tried today, and virtio-gpu doesn't work for me either:
during boot I get

  [drm] radeon kernel modesetting enabled.
  [drm] pci: virtio-gpu-pci detected at 0000:00:05.0
  [drm] virgl 3d acceleration not supported by host
  [TTM] Zone  kernel: Available graphics memory: 993416 kiB
  [TTM] Initializing pool allocator
  [TTM] Initializing DMA pool allocator
  [drm] number of scanouts: 1
  [drm] number of cap sets: 0
  ------------[ cut here ]------------
  WARNING: CPU: 3 PID: 1 at lib/scatterlist.c:275 __sg_alloc_table+0xba/0xbe
  Modules linked in:
  CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc8 #1
  Call Trace:
  [<ffffffe0000383ec>] walk_stackframe+0x0/0xa0
  [<ffffffe000038588>] show_stack+0x2a/0x34
  [<ffffffe0006b12b2>] dump_stack+0x62/0x7c
  [<ffffffe00003c498>] __warn+0xd2/0xe4
  [<ffffffe00003c544>] warn_slowpath_null+0x30/0x3e
  [<ffffffe0002a1646>] __sg_alloc_table+0xba/0xbe
  [<ffffffe0002a18c8>] sg_alloc_table+0x28/0xa6
  [<ffffffe0002a1a1a>] __sg_alloc_table_from_pages+0xd4/0x1da
  [<ffffffe0002a1b30>] sg_alloc_table_from_pages+0x10/0x18
  [<ffffffe00042c87c>] virtio_gpu_object_get_sg_table+0x90/0xa6
  [<ffffffe00042bdfc>] virtio_gpu_object_attach+0x12c/0x14c
  [<ffffffe00042a1aa>] virtio_gpufb_create+0xe4/0x1c0
  [<ffffffe0003345f2>] __drm_fb_helper_initial_config_and_unlock+0x198/0x334
  [<ffffffe000334c5a>] drm_fb_helper_initial_config+0x2e/0x3a
  [<ffffffe00042a3f6>] virtio_gpu_fbdev_init+0xa6/0xce
  [<ffffffe000429556>] virtio_gpu_driver_load+0x36e/0x3be
  [<ffffffe00033a932>] drm_dev_register+0xfe/0x162
  [<ffffffe000429968>] drm_virtio_init+0x48/0x158
  [<ffffffe000429164>] virtio_gpu_probe+0x32/0x40
  [<ffffffe0002f7e58>] virtio_dev_probe+0x10e/0x196
  [<ffffffe00043546c>] really_probe+0x17e/0x1ea
  [<ffffffe000435654>] driver_probe_device+0x7a/0x90
  [<ffffffe000435702>] __driver_attach+0x98/0x9a
  [<ffffffe000433bc2>] bus_for_each_dev+0x4a/0x72
  [<ffffffe000434f28>] driver_attach+0x1a/0x22
  [<ffffffe000434b06>] bus_add_driver+0x156/0x1b8
  [<ffffffe000435c88>] driver_register+0x3a/0xd0
  [<ffffffe0002f7f00>] register_virtio_driver+0x20/0x2e
  [<ffffffe000012d92>] virtio_gpu_driver_init+0x18/0x20
  [<ffffffe00003664a>] do_one_initcall+0x2c/0x10a
  [<ffffffe000000a90>] kernel_init_freeable+0x11e/0x1ae
  [<ffffffe0006c2304>] kernel_init+0x12/0xf0
  [<ffffffe000037472>] ret_from_exception+0x0/0xc
  ---[ end trace 161c50bff518fcd6 ]---
  [drm] Initialized virtio_gpu 0.0.1 0 for virtio5 on minor 0

and the graphical console is not initialized.

The libvirt guest XML I'm using is

  <domain type='qemu'>
    <name>riscv</name>
    <memory unit='GiB'>2</memory>
    <vcpu>4</vcpu>
    <os>
      <type arch='riscv64' machine='virt'>hvm</type>
      <kernel>/var/lib/libvirt/images/riscv.bbl</kernel>
      <cmdline>root=/dev/vda1</cmdline>
    </os>
    <devices>
      <emulator>/usr/bin/qemu-system-riscv64</emulator>
      <disk type='file' device='disk'>
        <driver name='qemu' type='raw'/>
        <source file='/var/lib/libvirt/images/riscv.raw'/>
        <target dev='vda' bus='virtio'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x0'/>
      </disk>
      <controller type='pci' model='pcie-root'/>
      <controller type='virtio-serial'>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0'/>
      </controller>
      <interface type='network'>
        <source network='default'/>
        <model type='virtio'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
      </interface>
      <serial type='pty'/>
      <channel type='unix'>
        <target type='virtio' name='org.qemu.guest_agent.0'/>
      </channel>
      <graphics type='spice'/>
      <video>
        <model type='virtio'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
      </video>
      <memballoon model='virtio'>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x05' function='0x0'/>
      </memballoon>
      <rng model='virtio'>
        <backend model='random'>/dev/urandom</backend>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x06' function='0x0'/>
      </rng>
    </devices>
  </domain>

but you're going to need a libvirt built from

  https://github.com/andreabolognani/libvirt/tree/riscv-pci

in order to actually use it.

I think the BBL I'm using doesn't have ballooning support, and I
haven't bothered trying it either, but as reported earlier everything
else (disk, networking, RNG, shutdown via qemu-guest-agent) works
just fine.

-- 
Andrea Bolognani / Red Hat / Virtualization
