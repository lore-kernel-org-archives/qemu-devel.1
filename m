Received: from eggs.gnu.org ([2001:4830:134:3::10]:55367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1da1xj-0006S9-06
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1da1xi-0003b3-2c
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:41:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1da1xh-0003aG-SY
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:41:30 -0400
Date: Tue, 25 Jul 2017 09:31:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170725093148.3898b2da@w520.home>
In-Reply-To: <20170724120729.24350-1-dmitry@daynix.com>
References: <20170724120729.24350-1-dmitry@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vfio/pci-quirks: Set non-zero GMS memory
 size for IGD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>
Cc: qemu-devel@nongnu.org, Xiong Zhang <xiong.y.zhang@intel.com>

[cc +Zhang, Xiong Y]


Intel, any comments?


On Mon, 24 Jul 2017 15:07:29 +0300
Dmitry Fleytman <dmitry@daynix.com> wrote:

> There is a claim that GMS memory is unused however
> Intel Windows 10 drivers starting from V.4534 (10/7/2016)
> allocate extra ~4G memory when GMS size set to 0.
> 
> This patch fixes this issue by seting IGD GMS memory
> size to minimum by changing default value of x-igd-gms
> device parameter.
> 
> Signed-off-by: Dmitry Fleytman <dmitry@daynix.com>
> ---
>  hw/vfio/pci-quirks.c | 13 +++++++++----
>  hw/vfio/pci.c        |  2 +-
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 349085e..197cb90 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1527,10 +1527,15 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>      }
>  
>      /*
> -     * Assume we have no GMS memory, but allow it to be overrided by device
> -     * option (experimental).  The spec doesn't actually allow zero GMS when
> -     * when IVD (IGD VGA Disable) is clear, but the claim is that it's unused,
> -     * so let's not waste VM memory for it.
> +     * There is a claim that GMS memory is unused and we want to waste for it
> +     * as less VM memory as possible, however Intel Windows 10 drivers starting
> +     * from V.4534 (10/7/2016) allocate extra ~4G memory when GMS size set to 0.
> +     * The spec as well doesn't actually allow zero GMS when IVD
> +     * (IGD VGA Disable) is clear.
> +     *
> +     * Therefore we set GMS memory size to minimal by default via device
> +     * option x-igd-gms (experimental) and allow further tweaking of this
> +     * parameter.
>       */
>      gmch &= ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
>  
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d4051cb..bda07b7 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2982,7 +2982,7 @@ static Property vfio_pci_dev_properties[] = {
>                         sub_vendor_id, PCI_ANY_ID),
>      DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>                         sub_device_id, PCI_ANY_ID),
> -    DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
> +    DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 1),
>      /*
>       * TODO - support passed fds... is this necessary?
>       * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
