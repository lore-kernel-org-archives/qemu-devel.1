Received: from eggs.gnu.org ([209.51.188.92]:44831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqbx2-0005dm-BY
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqbx0-0001vL-H3
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:58:08 -0500
Date: Mon, 4 Feb 2019 11:57:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204115758.765941f1.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-8-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-8-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/15] s390-bios: Decouple channel i/o
 logic from virtio
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

On Tue, 29 Jan 2019 08:29:14 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Create a separate library for channel i/o related code. This decouples
> channel i/o operations from virtio and allows us to make use of them for
> the real dasd boot path.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile        |  2 +-
>  pc-bios/s390-ccw/cio.c           | 41 ++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/cio.h           |  3 +++
>  pc-bios/s390-ccw/main.c          |  1 +
>  pc-bios/s390-ccw/netboot.mak     |  2 +-
>  pc-bios/s390-ccw/netmain.c       |  1 +
>  pc-bios/s390-ccw/s390-ccw.h      |  1 -
>  pc-bios/s390-ccw/virtio-blkdev.c |  1 +
>  pc-bios/s390-ccw/virtio.c        | 27 ++------------------------
>  9 files changed, 51 insertions(+), 28 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/cio.c
> 

> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
> new file mode 100644
> index 0000000..095f79b
> --- /dev/null
> +++ b/pc-bios/s390-ccw/cio.c
> @@ -0,0 +1,41 @@
> +/*
> + * S390 Channel I/O
> + *
> + * Copyright (c) 2018 Jason J. Herne <jjherne@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */

Not sure that copyright header is correct. You moved some code that
probably should be copyright IBM (although that was never added to the
header in the first place...) Also not sure if Alex has some copyrights
on the code you moved, or if that is only trivial stuff. (Don't want to
be difficult, but we should try to get this right.)

> +
> +#include "libc.h"
> +#include "s390-ccw.h"
> +#include "cio.h"
> +
> +static char chsc_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
> +
> +int enable_mss_facility(void)
> +{
> +    int ret;
> +    ChscAreaSda *sda_area = (ChscAreaSda *) chsc_page;
> +
> +    memset(sda_area, 0, PAGE_SIZE);
> +    sda_area->request.length = 0x0400;
> +    sda_area->request.code = 0x0031;
> +    sda_area->operation_code = 0x2;
> +
> +    ret = chsc(sda_area);
> +    if ((ret == 0) && (sda_area->response.code == 0x0001)) {
> +        return 0;
> +    }
> +    return -EIO;
> +}
> +
> +void enable_subchannel(SubChannelId schid)
> +{
> +    Schib schib;
> +
> +    stsch_err(schid, &schib);
> +    schib.pmcw.ena = 1;
> +    msch(schid, &schib);
> +}

(...)

> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
> index 11c5626..d2e7fcd 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -10,6 +10,7 @@
>  
>  #include "libc.h"
>  #include "s390-ccw.h"
> +#include "cio.h"

Not sure why you need to add this here?

>  #include "virtio.h"
>  #include "virtio-scsi.h"
>  

Otherwise, looks good.
