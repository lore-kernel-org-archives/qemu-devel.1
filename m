Received: from eggs.gnu.org ([2001:4830:134:3::10]:41120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZAU-0007kh-3B
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxZAO-0002nb-GU
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxZAO-0002nN-7C
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:47:52 -0400
References: <20170928131831.81393-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3445a7f0-65cc-7420-c494-87f1c600b474@redhat.com>
Date: Thu, 28 Sep 2017 15:47:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170928131831.81393-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 28.09.2017 15:18, Christian Borntraeger wrote:
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
> +     */
> +    dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
> +    object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
> +                              OBJECT(dev), NULL);
> +    qdev_init_nofail(dev);
>  
>      /* register hypercalls */
>      virtio_ccw_register_hcalls();
> 

This zPCI stuff is just nasty.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
