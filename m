Received: from eggs.gnu.org ([2001:4830:134:3::10]:59490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dz6YW-0008U8-8r
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dz6YS-0006lb-7z
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:39:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dz6YR-0006ky-UX
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:39:04 -0400
Date: Mon, 2 Oct 2017 13:39:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171002133901.4f886cec@t450s.home>
In-Reply-To: <0D4B427206E615459C4FEB71FC00EF8CFE74E5@dggemi509-mbx.china.huawei.com>
References: <0D4B427206E615459C4FEB71FC00EF8CFE74E5@dggemi509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] vfio/pci: don't reset bar address when pci
 device no_soft_reset bit is set to "1"
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Lifei (Louis)" <louis.lifei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Ido Yariv <ido@wizery.com>
List-ID: <qemu-devel.nongnu.org>

On Tue, 12 Sep 2017 02:49:33 +0000
"Lifei (Louis)" <louis.lifei@huawei.com> wrote:

> Hi all
> 
> In commit a52a4c471703e995ceb06f6157d70747823e8a0d said:
> 
> The VFIO configuration space stays untouched, so the guest OS may choose
>     to skip restoring the BAR addresses as they would seem intact. The PCI
>     device may be left non-operational.
> 
> While the guest OS choose to restore the BAR addresses only when pci device no_soft_reset
> is not set. So we may not reset the BAR address when no_soft_reset is set.

Please see:

https://git.qemu.org/?p=qemu.git;a=blob;f=README#l68
https://wiki.qemu.org/Contribute/SubmitAPatch#Do_not_send_as_an_attachment

(manually copied from attachment)
> From 845914cf5bcd48872224df7f08e53ca2a19a577e Mon Sep 17 00:00:00 2001
> From: Louis Lifei <louis.lifei@huawei.com>
> Date: Tue, 12 Sep 2017 10:17:59 +0800
> Subject: [PATCH] vfio/pci: don't reset bar address when no_soft_rst set

The description above belongs here.  The proper way to reference the commit is:

a52a4c471703 ("vfio/pci: fix out-of-sync BAR information on reset")

> Signed-off-by: Louis Lifei <louis.lifei@huawei.com>
> ---
>  hw/vfio/pci.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 31e1edf..6766f6b 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2029,14 +2029,19 @@ static void vfio_pci_post_reset(VFIOPCIDevice *vdev)
>          error_reportf_err(err, ERR_PREFIX, vdev->vbasedev.name);
>      }
> 
> -    for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
> -        off_t addr = vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr);
> -        uint32_t val = 0;
> -        uint32_t len = sizeof(val);
> -
> -        if (pwrite(vdev->vbasedev.fd, &val, len, addr) != len) {
> -            error_report("%s(%s) reset bar %d failed: %m", __func__,
> -                         vdev->vbasedev.name, nr);
> +    /* When No_Soft_Reset bit is set to "1", no additional operating
> +     * system intervention is required beyond writing the PowerState bits.
> +     */

Follow the existing comment style please, multi-line comments:

/*
 * First line
 * Nth line
 */

> +    if (vdev->has_pm_reset) {
> +        for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
> +            off_t addr = vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr);
> +            uint32_t val = 0;
> +            uint32_t len = sizeof(val);
> +
> +            if (pwrite(vdev->vbasedev.fd, &val, len, addr) != len) {
> +                error_report("%s(%s) reset bar %d failed: %m", __func__,
> +                             vdev->vbasedev.name, nr);
> +            }
>          }
>      }
>  }

I don't understand the premise of the patch, if a device reports
no_soft_reset, then vfio will not use a PM reset to reset the device.
Conversely, simply because a device sets has_pm_reset, does not mean
that every reset is a PM reset.  The device might also support FLR or
we might have performed a secondary bus reset.  Therefore whether a
device supports has_pm_reset at this point seems fairly irrelevant.
Can you clarify exactly what path is getting to this point, having only
done a PM reset on a device which advertises no_soft_reset?  Thanks,

Alex
