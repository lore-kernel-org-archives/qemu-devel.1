Received: from eggs.gnu.org ([209.51.188.92]:47796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtEbX-000751-Ic
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtEbW-0006qd-Jt
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:38:47 -0500
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-5-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cc6dcf27-e1cf-14de-e729-486e1995f6eb@redhat.com>
Date: Mon, 11 Feb 2019 17:38:22 +0100
MIME-Version: 1.0
In-Reply-To: <1548768562-20007-5-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 04/15] s390-bios: Extend
 find_dev() for non-virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 2019-01-29 14:29, Jason J. Herne wrote:
> We need a method for finding the subchannel of a dasd device. Let's
> modify find_dev to handle this since it mostly does what we need. Up to
> this point find_dev has been specific to only virtio devices.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 67df421..7e3f65e 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -49,6 +49,12 @@ unsigned int get_loadparm_index(void)
>      return atoui(loadparm_str);
>  }
>  
> +/*
> + * Find the subchannel connected to the given device (dev_no) and fill in the
> + * subchannel information block (schib) with the connected subchannel's info.
> + * NOTE: The global variable blk_schid is updated to contain the subchannel
> + * information.
> + */
>  static bool find_dev(Schib *schib, int dev_no)
>  {
>      int i, r;
> @@ -62,15 +68,15 @@ static bool find_dev(Schib *schib, int dev_no)
>          if (!schib->pmcw.dnv) {
>              continue;
>          }
> -        if (!virtio_is_supported(blk_schid)) {
> -            continue;
> -        }
> +
>          /* Skip net devices since no IPLB is created and therefore no
> -         * no network bootloader has been loaded
> +         * network bootloader has been loaded
>           */
> -        if (virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
> +        if (virtio_is_supported(blk_schid) &&
> +            virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
>              continue;
>          }
> +
>          if ((dev_no < 0) || (schib->pmcw.dev == dev_no)) {
>              return true;
>          }
> 

Not sure whether this really works as expected? If dev_no is -1, this
used to return the first supported virtio device. Now it returns the
first device that could be found - but how are we sure that we can boot
from that device?

 Thomas
