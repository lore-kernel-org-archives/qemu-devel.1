Received: from eggs.gnu.org ([209.51.188.92]:33441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0rOJ-0001P5-Dd
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0rOI-00033J-Ir
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:28:39 -0500
Date: Mon, 4 Mar 2019 18:28:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190304182832.1f619a03.cohuck@redhat.com>
In-Reply-To: <1551466776-29123-8-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-8-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/16] s390-bios: Decouple channel i/o
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

On Fri,  1 Mar 2019 13:59:27 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Create a separate library for channel i/o related code. This decouples
> channel i/o operations from virtio and allows us to make use of them for
> the real dasd boot path.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile    |  2 +-
>  pc-bios/s390-ccw/cio.c       | 43 +++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/cio.h       |  3 +++
>  pc-bios/s390-ccw/main.c      |  1 +
>  pc-bios/s390-ccw/netboot.mak |  2 +-
>  pc-bios/s390-ccw/netmain.c   |  1 +
>  pc-bios/s390-ccw/s390-ccw.h  |  1 -
>  pc-bios/s390-ccw/virtio.c    | 27 ++-------------------------
>  8 files changed, 52 insertions(+), 28 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/cio.c
(...)
> diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
> new file mode 100644
> index 0000000..605f6f0
> --- /dev/null
> +++ b/pc-bios/s390-ccw/cio.c
> @@ -0,0 +1,43 @@
> +/*
> + * S390 Channel I/O
> + *
> + * Copyright 2017 Alexander Graf & IBM Corp.

This looks a bit odd. Should probably be two copyright lines (one for
agraf, one for IBM) and one author line for you? (Especially as
virtio.c has a 2013 copyright, not 2017.)

> + * Author(s): Alexander Graf <agraf@suse.de>
> + *            Jason J. Herne <jjherne@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
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

The code movement looks reasonable.
