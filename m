Received: from eggs.gnu.org ([2001:4830:134:3::10]:32807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQ4eS-00059b-Q5
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 23:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQ4eP-00063t-Mx
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 23:00:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQ4eP-000626-HW
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 23:00:09 -0500
Date: Sun, 8 Jan 2017 06:00:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170108055940-mutt-send-email-mst@kernel.org>
References: <CALoWxX_-+dBexpVzy2MKVN10b94vaZC50y+vxbZtqXi+S_Urmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoWxX_-+dBexpVzy2MKVN10b94vaZC50y+vxbZtqXi+S_Urmg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/pci: use-after-free in
 pci_nic_init_nofail when nic device fails to initialize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Kompel <barbos@gmail.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Jason Wang <jasowang@redhat.com>

On Fri, Jan 06, 2017 at 03:48:27PM -0800, Alex Kompel wrote:
> object_property_set_bool(OBJECT(dev), true, "realized", &err) in
> pci_nic_init_nofail may release the object if device fails to
> initialize which leads to use-after-free in error handling block.
> qdev_init_nofail does the same thing while holding the reference.
> 
> (gdb) run -net nic
> qemu-system-x86_64: failed to find romfile "efi-e1000.rom"
> 
> Program received signal SIGSEGV, Segmentation fault.
> object_unparent (obj=0x7fffe96a0010) at qom/object.c:440
> 440     in qom/object.c
> (gdb) bt
> #0  object_unparent (obj=0x7fffe96a0010) at qom/object.c:440
> #1  0x000055555598c30d in pci_nic_init_nofail (nd=0x55555616b460
> <nd_table>, rootbus=0x5555567ed990, default_model=<optimized out>,
> default_devaddr=<optimized out>) at hw/pci/pci.c:1812
> #2  0x00005555557ff52c in pc_nic_init (isa_bus=0x55555733c610,
> pci_bus=0x5555567ed990) at hw/i386/pc.c:1634
> #3  0x00005555558021ad in pc_init1 (machine=0x55555661ee10,
> pci_type=0x555555c1a523 "i440FX", host_type=0x555555ba564e
> "i440FX-pcihost") at hw/i386/pc_piix.c:241
> #4  0x00005555557519cb in main (argc=<optimized out>, argv=<optimized
> out>, envp=<optimized out>) at vl.c:4481
> 
> Signed-off-by: Alex Kompel <barbos@gmail.com>

More a nic thing than pci really ...

Jason, could you pls merge this?

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  hw/pci/pci.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 24fae16..2fd1b9e 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1805,13 +1805,7 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd,
> PCIBus *rootbus,
>      pci_dev = pci_create(bus, devfn, pci_nic_names[i]);
>      dev = &pci_dev->qdev;
>      qdev_set_nic_properties(dev, nd);
> -
> -    object_property_set_bool(OBJECT(dev), true, "realized", &err);
> -    if (err) {
> -        error_report_err(err);
> -        object_unparent(OBJECT(dev));
> -        exit(1);
> -    }
> +    qdev_init_nofail(dev);
> 
>      return pci_dev;
>  }
> --
> 2.8.3
