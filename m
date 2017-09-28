Received: from eggs.gnu.org ([2001:4830:134:3::10]:49238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxZbQ-0008Oe-FD
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxZbM-00011A-Fl
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:15:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dxZbM-00010p-76
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:15:44 -0400
Date: Thu, 28 Sep 2017 16:15:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170928161528.31a623a5.cohuck@redhat.com>
In-Reply-To: <20170928131831.81393-1-borntraeger@de.ibm.com>
References: <20170928131831.81393-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Revert "s390x/ccw: create s390 phb
 conditionally"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 28 Sep 2017 15:18:31 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> This reverts commit d32bd032d8fde41281aae34c16a4aa97e9acfeac.
> 
> Turns out that old QEMUs always created a pci host bridge
> and for many CPU models the migration from old QEMUs to new
> QEMUs will fail with
> qemu-system-s390x: Unknown savevm section or instance 'PCIBUS' 0
> qemu-system-s390x: load of migration failed: Invalid argument
> 
> As a quick fix we will revert the commit and always create the
> pci host bridge.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [fixed revert to keep the comment fixup, added a comment in the code]
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index b6aa2da..a77336f 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -275,6 +275,7 @@ static void ccw_init(MachineState *machine)
>  {
>      int ret;
>      VirtualCssBus *css_bus;
> +    DeviceState *dev;
>  
>      s390_sclp_init();
>      s390_memory_init(machine->ram_size);
> @@ -290,13 +291,14 @@ static void ccw_init(MachineState *machine)
>                        machine->initrd_filename, "s390-ccw.img",
>                        "s390-netboot.img", true);
>  
> -    if (s390_has_feat(S390_FEAT_ZPCI)) {
> -        DeviceState *dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
> -        object_property_add_child(qdev_get_machine(),
> -                                  TYPE_S390_PCI_HOST_BRIDGE,
> -                                  OBJECT(dev), NULL);
> -        qdev_init_nofail(dev);
> -    }
> +    /*
> +     * We cannot easily make the pci host bridge conditional as older QEMUs
> +     * always created it. Doing so would break migration across QEMU versions

Added the missing trailing period.

> +     */
> +    dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
> +    object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
> +                              OBJECT(dev), NULL);
> +    qdev_init_nofail(dev);
>  
>      /* register hypercalls */
>      virtio_ccw_register_hcalls();

Thanks, applied.
