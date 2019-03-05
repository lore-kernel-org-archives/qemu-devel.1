Received: from eggs.gnu.org ([209.51.188.92]:59135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h19jt-0005SP-00
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:04:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h19jn-00024T-7U
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 08:04:08 -0500
Date: Tue, 5 Mar 2019 14:03:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190305140356.7c0ac1bd.cohuck@redhat.com>
In-Reply-To: <1551466776-29123-16-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-16-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 15/16] s390-bios: Support booting from
 real dasd device
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

On Fri,  1 Mar 2019 13:59:35 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Allows guest to boot from a vfio configured real dasd device.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  MAINTAINERS                  |   1 +
>  docs/devel/s390-dasd-ipl.txt | 133 +++++++++++++++++++++++
>  pc-bios/s390-ccw/Makefile    |   2 +-
>  pc-bios/s390-ccw/dasd-ipl.c  | 249 +++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/dasd-ipl.h  |  16 +++
>  pc-bios/s390-ccw/main.c      |   4 +
>  pc-bios/s390-ccw/s390-arch.h |  13 +++
>  7 files changed, 417 insertions(+), 1 deletion(-)
>  create mode 100644 docs/devel/s390-dasd-ipl.txt
>  create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
>  create mode 100644 pc-bios/s390-ccw/dasd-ipl.h
> 

> diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
> new file mode 100644
> index 0000000..5a863f0
> --- /dev/null
> +++ b/pc-bios/s390-ccw/dasd-ipl.c
> @@ -0,0 +1,249 @@
> +/*
> + * S390 IPL (boot) from a real DASD device via vfio framework.
> + *
> + * Copyright (c) 2018 Jason J. Herne <jjherne@us.ibm.com>

2019?

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
(...)
> +/*
> + * Limitations in QEMU's CCW support complicate the IPL process. Details can

s/QEMU's CCW support/vfio-ccw/ ?

> + * be found in docs/devel/s390-dasd-ipl.txt
> + */
> +void dasd_ipl(SubChannelId schid)
> +{
> +    uint32_t ipl2_addr;
> +
> +    /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
> +    make_readipl();
> +    run_readipl(schid);
> +    ipl2_addr = read_ipl2_addr();
> +    check_ipl1();
> +
> +    /*
> +     * Fixup IPL1 channel program to account for QEMU limitations, then run it
> +     * to read IPL2 channel program from boot disk.
> +     */
> +    ipl1_fixup();
> +    run_ipl1(schid);
> +    check_ipl2(ipl2_addr);
> +
> +    /*
> +     * Run IPL2 channel program to read operating system code from boot disk
> +     * then transfer control to the guest operating system
> +     */
> +    run_ipl2(schid, ipl2_addr);
> +    lpsw(0);
> +}
> diff --git a/pc-bios/s390-ccw/dasd-ipl.h b/pc-bios/s390-ccw/dasd-ipl.h
> new file mode 100644
> index 0000000..56bba82
> --- /dev/null
> +++ b/pc-bios/s390-ccw/dasd-ipl.h
> @@ -0,0 +1,16 @@
> +/*
> + * S390 IPL (boot) from a real DASD device via vfio framework.
> + *
> + * Copyright (c) 2018 Jason J. Herne <jjherne@us.ibm.com>

2019?

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef DASD_IPL_H
> +#define DASD_IPL_H
> +
> +void dasd_ipl(SubChannelId schid);
> +
> +#endif /* DASD_IPL_H */

Otherwise, looks good to me.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
