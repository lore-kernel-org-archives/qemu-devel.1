Received: from eggs.gnu.org ([209.51.188.92]:41736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqbl9-0001ak-T3
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqbl8-0001pD-Ld
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:45:51 -0500
Date: Mon, 4 Feb 2019 11:45:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204114537.0ddb236a.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-6-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-6-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/15] s390-bios: Factor finding boot
 device out of virtio code path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 29 Jan 2019 08:29:12 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Make a new routine find_boot_device to locate the boot device for all
> cases. not just virtio.

s/cases./cases,/

> 
> In one case no boot device is specified and a suitable boot device can not
> be auto detected. The error message for this case was specific to virtio
> devices. We update this message to remove virtio specific wording.

"The error message for the case where no boot device has been specified
and a suitable boot device cannot be auto detected was specific to
virtio devices. We update..."

> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c  | 87 ++++++++++++++++++++++++++----------------------
>  tests/boot-serial-test.c |  2 +-
>  2 files changed, 49 insertions(+), 40 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 7e3f65e..2457752 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -55,17 +55,18 @@ unsigned int get_loadparm_index(void)
>   * NOTE: The global variable blk_schid is updated to contain the subchannel
>   * information.
>   */
> -static bool find_dev(Schib *schib, int dev_no)
> +static bool find_subch(int dev_no)

I'm wondering why you drop passing in the schib here? But OTOH, the
usage of global variables or not is a bit confused in the bios anyway...

>  {
> +    Schib schib;
>      int i, r;
>  
>      for (i = 0; i < 0x10000; i++) {
>          blk_schid.sch_no = i;
> -        r = stsch_err(blk_schid, schib);
> +        r = stsch_err(blk_schid, &schib);
>          if ((r == 3) || (r == -EIO)) {
>              break;
>          }
> -        if (!schib->pmcw.dnv) {
> +        if (!schib.pmcw.dnv) {
>              continue;
>          }
>  
> @@ -77,7 +78,7 @@ static bool find_dev(Schib *schib, int dev_no)
>              continue;
>          }
>  
> -        if ((dev_no < 0) || (schib->pmcw.dev == dev_no)) {
> +        if ((dev_no < 0) || (schib.pmcw.dev == dev_no)) {
>              return true;
>          }
>      }
> @@ -133,56 +134,63 @@ static void boot_setup(void)
>      have_iplb = store_iplb(&iplb);
>  }
>  
> -static void virtio_setup(void)
> +static void find_boot_device(void)
>  {
> -    Schib schib;
> -    int ssid;
> -    bool found = false;
> -    uint16_t dev_no;
>      VDev *vdev = virtio_get_device();
> -    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
> -
> -    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
> +    int ssid;
> +    bool found;
>  
> -    if (have_iplb) {
> -        switch (iplb.pbt) {
> -        case S390_IPL_TYPE_CCW:
> -            dev_no = iplb.ccw.devno;
> -            debug_print_int("device no. ", dev_no);
> -            blk_schid.ssid = iplb.ccw.ssid & 0x3;
> -            debug_print_int("ssid ", blk_schid.ssid);
> -            found = find_dev(&schib, dev_no);
> -            break;
> -        case S390_IPL_TYPE_QEMU_SCSI:
> -            vdev->scsi_device_selected = true;
> -            vdev->selected_scsi_device.channel = iplb.scsi.channel;
> -            vdev->selected_scsi_device.target = iplb.scsi.target;
> -            vdev->selected_scsi_device.lun = iplb.scsi.lun;
> -            blk_schid.ssid = iplb.scsi.ssid & 0x3;
> -            found = find_dev(&schib, iplb.scsi.devno);
> -            break;
> -        default:
> -            panic("List-directed IPL not supported yet!\n");
> -        }
> -        menu_setup();
> -    } else {
> +    if (!have_iplb) {
>          for (ssid = 0; ssid < 0x3; ssid++) {
>              blk_schid.ssid = ssid;
> -            found = find_dev(&schib, -1);
> +            found = find_subch(-1);
>              if (found) {
> -                break;
> +                return;
>              }
>          }
> +        panic("Could not find a suitable boot device (none specified)\n");
>      }
>  
> -    IPL_assert(found, "No virtio device found");
> +    switch (iplb.pbt) {
> +    case S390_IPL_TYPE_CCW:
> +        debug_print_int("device no. ", iplb.ccw.devno);
> +        blk_schid.ssid = iplb.ccw.ssid & 0x3;
> +        debug_print_int("ssid ", blk_schid.ssid);
> +        found = find_subch(iplb.ccw.devno);
> +        break;
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +        vdev->scsi_device_selected = true;
> +        vdev->selected_scsi_device.channel = iplb.scsi.channel;
> +        vdev->selected_scsi_device.target = iplb.scsi.target;
> +        vdev->selected_scsi_device.lun = iplb.scsi.lun;
> +        blk_schid.ssid = iplb.scsi.ssid & 0x3;
> +        found = find_subch(iplb.scsi.devno);
> +        break;
> +    default:
> +        panic("List-directed IPL not supported yet!\n");
> +    }
> +
> +    if (!found) {
> +        IPL_assert(found, "Boot device not found\n");

You can simply call IPL_assert(found, ...) here, as it does the check
already.

> +    }
> +}
