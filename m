Received: from eggs.gnu.org ([2001:4830:134:3::10]:38963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5Twf-0005tO-KE
	for qemu-devel@nongnu.org; Tue, 02 May 2017 05:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5Twa-0003xb-Qm
	for qemu-devel@nongnu.org; Tue, 02 May 2017 05:18:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d5Twa-0003wu-I1
	for qemu-devel@nongnu.org; Tue, 02 May 2017 05:18:04 -0400
Date: Tue, 2 May 2017 10:17:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170502091755.GB2072@work-vm>
References: <1493692691-30801-1-git-send-email-lu.zhipeng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493692691-30801-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH] hmp: add 'info virtio-pci-status id'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Cc: mst@redhat.com, marcel@redhat.com, qemu-devel@nongnu.org

* ZhiPeng Lu (lu.zhipeng@zte.com.cn) wrote:

Hi,

> Add command to  query a virtio pci device status.

Is this purely for debug? If it's not for debug then you'll need
to structure it around a matching QMP command.

> we can get id of the virtio pci device by 'info pci' command.
> HMP Test case:
>     ==============
>     virsh # qemu-monitor-command --hmp 3 info pci
>       Bus  0, device   3, function 0:
>         Ethernet controller: PCI device 1af4:1000
>           IRQ 11.
>           BAR0: I/O at 0xc000 [0xc03f].
>           BAR1: 32 bit memory at 0xfebd1000 [0xfebd1fff].
>           BAR4: 64 bit prefetchable memory at 0xfe000000 [0xfe003fff].
>           BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
>           id "net0"
>       Bus  0, device   4, function 0:
>         USB controller: PCI device 8086:24cd
>           IRQ 11.
>           BAR0: 32 bit memory at 0xfebd2000 [0xfebd2fff].
>           id "usb"
>     virsh # qemu-monitor-command 3  --hmp "info virtio-pci-status net0"
>     status=15

Would it be better to make this 'info virtio-pci' and perhaps then you
might dump some more info in the future?

>     virsh # qemu-monitor-command 3  --hmp "info virtio-pci-status usb"
>     the 'info virtio_pci_status' command only supports virtio pci devices
> 
> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> ---
>  hmp-commands-info.hx    | 14 ++++++++++++++
>  hw/pci/pci-stub.c       |  6 ++++++
>  hw/virtio/virtio-pci.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/sysemu.h |  1 +
>  4 files changed, 68 insertions(+)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index a53f105..7b9c4db 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -815,6 +815,20 @@ ETEXI
>          .cmd = hmp_info_vm_generation_id,
>      },
>  
> +    {
> +        .name       = "virtio-pci-status",
> +        .args_type  = "id:s",
> +        .params     = "id",
> +        .help       = "show virtio pci device  status",
> +        .cmd        = hmp_info_virtio_pci_status,
> +    },
> +
> +STEXI
> +@item info virtio-pci-status  @var{id}
> +@findex virtio-pci-status
> +Show status about virtio pci device
> +ETEXI
> +
>  STEXI
>  @end table
>  ETEXI
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index 36d2c43..3609a52 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -35,3 +35,9 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
>  {
>      monitor_printf(mon, "PCI devices not supported\n");
>  }
> +
> +void hmp_info_virtio_pci_status(Monitor *mon, const QDict *qdict)
> +{
> +    monitor_printf(mon, "PCI devices not supported\n");
> +}
> +
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index f9b7244..5fa862b 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -37,6 +37,7 @@
>  #include "qemu/range.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "qapi/visitor.h"
> +#include "monitor/monitor.h"
>  
>  #define VIRTIO_PCI_REGION_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_present(dev))
>  
> @@ -50,6 +51,7 @@ static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
>                                 VirtIOPCIProxy *dev);
>  static void virtio_pci_reset(DeviceState *qdev);
>  
> +static void query_virtio_pci_status(Monitor *mon, const char *id);
>  /* virtio device */
>  /* DeviceState to VirtIOPCIProxy. For use off data-path. TODO: use QOM. */
>  static inline VirtIOPCIProxy *to_virtio_pci_proxy(DeviceState *d)
> @@ -2556,6 +2558,51 @@ static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
>                          virtio_bus_name);
>  }
>  
> +static void query_virtio_pci_status(Monitor *mon, const char *id)
> +{
> +    int ret = 0, i = 0;
> +    PCIDevice *dev = NULL;
> +    hwaddr addr = 0;
> +    uint8_t val = 0;
> +    const char *devtype = NULL;
> +
> +    ret = pci_qdev_find_device(id, &dev);
> +    if (ret) {
> +        monitor_printf(mon, "Can not find device %s\n", id);
> +        return;
> +    }
> +    devtype = object_get_typename(OBJECT(dev));
> +    if (strncmp("virtio-", devtype, 7) == 0) {

I wonder if there's a better way to do that - something like 
  if (object_dynamic_cast(OBJECT(dev), "virtio-pci-device")) 

although my knowledge of qom isn't that great.

> +        for (i = 0; i < PCI_NUM_REGIONS; i++) {
> +            if (dev->io_regions[i].type == PCI_BASE_ADDRESS_SPACE_IO) {
> +                addr = dev->io_regions[i].addr;
> +                break;
> +            }
> +        }
> +        if (addr != -1 && addr != 0) {
> +            address_space_rw(&address_space_io, addr + VIRTIO_PCI_STATUS,
> +            MEMTXATTRS_UNSPECIFIED, &val, 1, 0);
> +            if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
> +                fprintf(stderr, "driver is ok\n");
> +            } else {
> +                fprintf(stderr, "driver is not ok\n");
> +            }

Decode the value into flags that you add to the monitor_printf, not a separate fprintf.

Dave

> +            monitor_printf(mon, "status=%d", val);
> +        } else {
> +            monitor_printf(mon, "status=%d", val);
> +        }
> +    } else {
> +        monitor_printf(mon, "the 'info virtio_pci_status' command "
> +           "only supports virtio pci devices");
> +    }
> +}
> +
> +void hmp_info_virtio_pci_status(Monitor *mon, const QDict *qdict)
> +{
> +    const char *id = qdict_get_try_str(qdict, "id");
> +    query_virtio_pci_status(mon, id);
> +}
> +
>  static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
>  {
>      BusClass *bus_class = BUS_CLASS(klass);
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 576c7ce..de66cc0 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -238,4 +238,5 @@ extern QemuOptsList qemu_net_opts;
>  extern QemuOptsList qemu_global_opts;
>  extern QemuOptsList qemu_mon_opts;
>  
> +extern void hmp_info_virtio_pci_status(Monitor *mon, const QDict *qdict);
>  #endif
> -- 
> 1.8.3.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
