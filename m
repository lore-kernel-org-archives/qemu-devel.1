Received: from eggs.gnu.org ([2001:4830:134:3::10]:52026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dZcxW-0006uZ-Bv
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dZcxT-0000ey-7O
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:59:38 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:36113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dZcxT-0000cC-0T
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:59:35 -0400
Received: by mail-io0-x243.google.com with SMTP id j32so1682248iod.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 05:59:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724120729.24350-1-dmitry@daynix.com>
References: <20170724120729.24350-1-dmitry@daynix.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 24 Jul 2017 15:59:32 +0300
Message-ID: <CAKPgXcErTuAR-pXhZMu6mKdyYdT1bb0U88Qb0dMfxsnjak-STw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>

Just noticed a small typo, other than LGTM +1 :)
On Mon, Jul 24, 2017 at 3:07 PM, Dmitry Fleytman <dmitry@daynix.com> wrote:

> There is a claim that GMS memory is unused however
> Intel Windows 10 drivers starting from V.4534 (10/7/2016)
> allocate extra ~4G memory when GMS size set to 0.
>
> This patch fixes this issue by seting IGD GMS memory
>
* setting

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
> @@ -1527,10 +1527,15 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice
> *vdev, int nr)
>      }
>
>      /*
> -     * Assume we have no GMS memory, but allow it to be overrided by
> device
> -     * option (experimental).  The spec doesn't actually allow zero GMS
> when
> -     * when IVD (IGD VGA Disable) is clear, but the claim is that it's
> unused,
> -     * so let's not waste VM memory for it.
> +     * There is a claim that GMS memory is unused and we want to waste
> for it
> +     * as less VM memory as possible, however Intel Windows 10 drivers
> starting
> +     * from V.4534 (10/7/2016) allocate extra ~4G memory when GMS size
> set to 0.
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
> --
> 2.9.4
>
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
