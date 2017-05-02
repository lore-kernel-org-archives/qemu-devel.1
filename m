Received: from eggs.gnu.org ([2001:4830:134:3::10]:47442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5VH5-0004TI-Br
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5VH2-0005ik-93
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:43:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5VH2-0005gu-0L
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:43:16 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42Ag5qv011337
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 06:43:13 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a68vwjmm5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 06:43:13 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 11:43:10 +0100
Date: Tue, 2 May 2017 12:43:04 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1493692691-30801-1-git-send-email-lu.zhipeng@zte.com.cn>
References: <1493692691-30801-1-git-send-email-lu.zhipeng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170502124304.3c8f5a73.cornelia.huck@de.ibm.com>
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
Cc: dgilbert@redhat.com, mst@redhat.com, marcel@redhat.com, qemu-devel@nongnu.org

On Tue, 2 May 2017 10:38:11 +0800
ZhiPeng Lu <lu.zhipeng@zte.com.cn> wrote:

> Add command to  query a virtio pci device status.
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
> 
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

Why are you only printing verbose information for DRIVER_OK? Either
dump the status only, or decode everything.

(Or is that left over from debugging?)

> +            monitor_printf(mon, "status=%d", val);
> +        } else {
> +            monitor_printf(mon, "status=%d", val);
> +        }
> +    } else {
> +        monitor_printf(mon, "the 'info virtio_pci_status' command "
> +           "only supports virtio pci devices");
> +    }
> +}

Instead of introducing a virtio-pci only command, I think it would be
better to introduce a virtio info command that can be used for any
transport. There is already a transport callback to get the status
byte. (When you have that mechanism in place, you could also easily use
it to get information like feature bits.)
