Received: from eggs.gnu.org ([2001:4830:134:3::10]:38159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chVgJ-0006Qc-B2
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chVgE-0002dd-Cl
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:18:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1chVgE-0002dY-3b
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:18:06 -0500
References: <20170223122025.10420-1-cornelia.huck@de.ibm.com>
	<20170223122025.10420-3-cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c1bfea11-c4ae-389f-dde1-e893a3019a05@redhat.com>
Date: Sat, 25 Feb 2017 07:18:02 +0100
MIME-Version: 1.0
In-Reply-To: <20170223122025.10420-3-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] s390x/ipl: Extend S390IPLState to
 support network boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com, Farhan Ali <alifm@linux.vnet.ibm.com>, agraf@suse.de

On 23.02.2017 13:20, Cornelia Huck wrote:
> From: Farhan Ali <alifm@linux.vnet.ibm.com>
> 
> Add new field to S390IPLState to store the name of the network boot
> loader.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/ipl.c             | 1 +
>  hw/s390x/ipl.h             | 1 +
>  hw/s390x/s390-virtio-ccw.c | 3 ++-
>  hw/s390x/s390-virtio.c     | 2 ++
>  hw/s390x/s390-virtio.h     | 1 +
>  5 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 2e2664f22e..fd656718a7 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -209,6 +209,7 @@ static Property s390_ipl_properties[] = {
>      DEFINE_PROP_STRING("initrd", S390IPLState, initrd),
>      DEFINE_PROP_STRING("cmdline", S390IPLState, cmdline),
>      DEFINE_PROP_STRING("firmware", S390IPLState, firmware),
> +    DEFINE_PROP_STRING("netboot_fw", S390IPLState, netboot_fw),
>      DEFINE_PROP_BOOL("enforce_bios", S390IPLState, enforce_bios, false),
>      DEFINE_PROP_BOOL("iplbext_migration", S390IPLState, iplbext_migration,
>                       true),
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index c89109585a..4ad9a7c05e 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -106,6 +106,7 @@ struct S390IPLState {
>      char *initrd;
>      char *cmdline;
>      char *firmware;
> +    char *netboot_fw;
>      uint8_t cssid;
>      uint8_t ssid;
>      uint16_t devno;
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 4f0d62b2d8..40914fde6f 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -116,7 +116,8 @@ static void ccw_init(MachineState *machine)
>      /* get a BUS */
>      css_bus = virtual_css_bus_init();
>      s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdline,
> -                      machine->initrd_filename, "s390-ccw.img", true);
> +                      machine->initrd_filename, "s390-ccw.img",
> +                      "s390-netboot.img", true);
>      s390_flic_init();
>  
>      dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
> diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
> index 9cfb09057e..afa4148e6b 100644
> --- a/hw/s390x/s390-virtio.c
> +++ b/hw/s390x/s390-virtio.c
> @@ -65,6 +65,7 @@ void s390_init_ipl_dev(const char *kernel_filename,
>                         const char *kernel_cmdline,
>                         const char *initrd_filename,
>                         const char *firmware,
> +                       const char *netboot_fw,
>                         bool enforce_bios)
>  {
>      Object *new = object_new(TYPE_S390_IPL);
> @@ -78,6 +79,7 @@ void s390_init_ipl_dev(const char *kernel_filename,
>      }
>      qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
>      qdev_prop_set_string(dev, "firmware", firmware);
> +    qdev_prop_set_string(dev, "netboot_fw", netboot_fw);
>      qdev_prop_set_bit(dev, "enforce_bios", enforce_bios);
>      object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
>                                new, NULL);
> diff --git a/hw/s390x/s390-virtio.h b/hw/s390x/s390-virtio.h
> index f588b80a6e..f2377a3e0e 100644
> --- a/hw/s390x/s390-virtio.h
> +++ b/hw/s390x/s390-virtio.h
> @@ -24,6 +24,7 @@ void s390_init_ipl_dev(const char *kernel_filename,
>                         const char *kernel_cmdline,
>                         const char *initrd_filename,
>                         const char *firmware,
> +                       const char *netboot_fw,
>                         bool enforce_bios);
>  void s390_create_virtio_net(BusState *bus, const char *name);
>  void s390_nmi(NMIState *n, int cpu_index, Error **errp);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
