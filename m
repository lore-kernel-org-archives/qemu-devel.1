Received: from eggs.gnu.org ([2001:4830:134:3::10]:53095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fYvsc-0005yc-2j
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fYvsY-0007Cp-U5
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:04:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37126 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fYvsY-00079W-OR
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:04:10 -0400
References: <20180629135616.16570-1-mark.cave-ayland@ilande.co.uk>
	<20180629135616.16570-2-mark.cave-ayland@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <dcf2364c-5422-e440-1713-b10e08023fbf@redhat.com>
Date: Fri, 29 Jun 2018 18:04:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180629135616.16570-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] sysbus: always allow
 explicit_ofw_unit_address() to override address generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, marcel@redhat.com, armbru@redhat.com, mst@redhat.com

On 06/29/18 15:56, Mark Cave-Ayland wrote:
> Some SysBusDevices either use sysbus_init_mmio() without
> sysbus_mmio_map() or the first MMIO memory region doesn't represent the
> bus address, causing a firmware device path with an invalid address to
> be generated.
> 
> SysBusDeviceClass does provide a virtual explicit_ofw_unit_address()
> method that can be used to override this process, but it was originally intended
> only as as a fallback option meaning that any existing MMIO memory regions still
> take priority whilst determining the firmware device address.
> 
> There is currently only one user of explicit_ofw_unit_address() and that
> is the PCI expander bridge (PXB) device which has no MMIO/PIO resources
> defined. This enables us to allow explicit_ofw_unit_address() to take
> priority without affecting backwards compatibility, allowing the address
> to be customised as required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/core/sysbus.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index ecfb0cfc0e..1ee0c162f4 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -293,16 +293,8 @@ static char *sysbus_get_fw_dev_path(DeviceState *dev)
>  {
>      SysBusDevice *s = SYS_BUS_DEVICE(dev);
>      SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(s);
> -    /* for the explicit unit address fallback case: */
>      char *addr, *fw_dev_path;
>  
> -    if (s->num_mmio) {
> -        return g_strdup_printf("%s@" TARGET_FMT_plx, qdev_fw_name(dev),
> -                               s->mmio[0].addr);
> -    }
> -    if (s->num_pio) {
> -        return g_strdup_printf("%s@i%04x", qdev_fw_name(dev), s->pio[0]);
> -    }
>      if (sbc->explicit_ofw_unit_address) {
>          addr = sbc->explicit_ofw_unit_address(s);
>          if (addr) {
> @@ -311,6 +303,13 @@ static char *sysbus_get_fw_dev_path(DeviceState *dev)
>              return fw_dev_path;
>          }
>      }
> +    if (s->num_mmio) {
> +        return g_strdup_printf("%s@" TARGET_FMT_plx, qdev_fw_name(dev),
> +                               s->mmio[0].addr);
> +    }
> +    if (s->num_pio) {
> +        return g_strdup_printf("%s@i%04x", qdev_fw_name(dev), s->pio[0]);
> +    }
>      return g_strdup(qdev_fw_name(dev));
>  }
>  
> 


Reviewed-by: Laszlo Ersek <lersek@redhat.com>
