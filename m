Received: from eggs.gnu.org ([209.51.188.92]:40311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gpDUW-0005rq-QG
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gpDUW-0007Yk-1x
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:38:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gpDUV-0007Y6-MS
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:38:56 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0VEU1Se147410
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 09:38:53 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qc1rcc3ym-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 09:38:53 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 31 Jan 2019 14:38:52 -0000
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-8-git-send-email-jjherne@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 31 Jan 2019 09:38:46 -0500
MIME-Version: 1.0
In-Reply-To: <1548768562-20007-8-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7714c56e-b856-4b00-0bbc-dd328d660779@linux.ibm.com>
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
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com



On 01/29/2019 08:29 AM, Jason J. Herne wrote:
> Create a separate library for channel i/o related code. This decouples
> channel i/o operations from virtio and allows us to make use of them for
> the real dasd boot path.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/Makefile        |  2 +-
>   pc-bios/s390-ccw/cio.c           | 41 ++++++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/cio.h           |  3 +++
>   pc-bios/s390-ccw/main.c          |  1 +
>   pc-bios/s390-ccw/netboot.mak     |  2 +-
>   pc-bios/s390-ccw/netmain.c       |  1 +
>   pc-bios/s390-ccw/s390-ccw.h      |  1 -
>   pc-bios/s390-ccw/virtio-blkdev.c |  1 +
>   pc-bios/s390-ccw/virtio.c        | 27 ++------------------------
>   9 files changed, 51 insertions(+), 28 deletions(-)
>   create mode 100644 pc-bios/s390-ccw/cio.c
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 1eb316b..12ad9c1 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -10,7 +10,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
>   .PHONY : all clean build-all
>   
>   OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
> -	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o
> +	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o
>   
>   QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
>   QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
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
> +

shouldn't the year be 2019 now? :)
