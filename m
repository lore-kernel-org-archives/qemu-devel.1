Received: from eggs.gnu.org ([2001:4830:134:3::10]:39657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fXLzU-0001Uk-2F
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 03:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fXLzQ-0005nR-VS
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 03:32:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45682 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fXLzQ-0005lj-Ov
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 03:32:44 -0400
References: <20180623085028.29553-1-mark.cave-ayland@ilande.co.uk>
	<20180623085028.29553-2-mark.cave-ayland@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7ac656b2-374a-8591-08a6-8303aae1eba1@redhat.com>
Date: Mon, 25 Jun 2018 09:32:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180623085028.29553-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] sysbus: always allow
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

Hi Mark,

On 06/23/18 10:50, Mark Cave-Ayland wrote:
> Some SysBusDevices either use sysbus_init_mmio() without sysbus_mmio_map() or
> the first MMIO memory region doesn't represent the bus address, causing an invalid
> firmware device path to be generated.
> 
> SysBusDeviceClass does provide a virtual explicit_ofw_unit_address() method that
> can be used to override this process, but it is only considered as a fallback
> option meaning that any existing MMIO memory regions still take priority whilst
> determining the firmware device address.
> 
> As any class defining explicit_ofw_unit_address() has explicitly requested a
> specialised behaviour then it should be used in preference to the default
> implementation rather than being used as a fallback.

I disagree about the last paragraph, when put like this. I don't
disagree with the *goal* of the patch, however the original
justification for explicit_ofw_unit_address() was different.

It was meant as a fallback for distinguishing sysbus devices when those
sysbus devices had neither MMIO nor PIO resources. The issue wasn't that
MMIO/PIO-based identification was not "right", the issue was that unique
identification was impossible in the absence of such resources. Please
see commit 0b336b3b98d8 ("hw/core: explicit OFW unit address callback
for SysBusDeviceClass", 2015-06-23).

I don't have anything against repurposing explicit_ofw_unit_address()
like this -- as long as you check that it doesn't change behavior for
existing devices -- it's just that we shouldn't justify the new purpose
with the original intent. The original intent was different.

I suggest stating, "we can have explicit_ofw_unit_address() take
priority in a backwards-compatible manner, because no sysbus device
currently has both explicit_ofw_unit_address() and MMIO/PIO resources".

(Obviously checking the validity of this statement is up to you; I'm
just suggesting what I'd see as one more precise explanation.)

Thanks,
Laszlo

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
