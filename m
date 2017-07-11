Received: from eggs.gnu.org ([2001:4830:134:3::10]:48381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dUrjq-0004Ex-2K
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dUrjm-0004TO-VZ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:45:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dUrjm-0004T2-Ly
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:45:46 -0400
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
	<1499700760-4777-4-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c86565a0-bc02-50a4-123e-ea75afc9cf8e@redhat.com>
Date: Tue, 11 Jul 2017 11:45:42 +0200
MIME-Version: 1.0
In-Reply-To: <1499700760-4777-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] pc-bios/s390-ccw: Move
 virtio-block related functions into a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 10.07.2017 17:32, Thomas Huth wrote:
> The netboot code is going to link against the code from virtio.c, too, so
> we've got to move the virtio-block and -scsi related code out of the way.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/Makefile        |   2 +-
>  pc-bios/s390-ccw/main.c          |   2 +-
>  pc-bios/s390-ccw/s390-ccw.h      |   2 +-
>  pc-bios/s390-ccw/virtio-blkdev.c | 296 +++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio.c        | 273 +-----------------------------------
>  pc-bios/s390-ccw/virtio.h        |   4 +
>  6 files changed, 307 insertions(+), 272 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/virtio-blkdev.c
> 
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index fb88c13..82b41ef 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -9,7 +9,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
>  
>  .PHONY : all clean build-all
>  
> -OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o
> +OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o
>  QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
>  QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
>  QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 0580eac..401e9db 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -144,7 +144,7 @@ static void virtio_setup(void)
>          sclp_print("Network boot device detected\n");
>          vdev->netboot_start_addr = iplb.ccw.netboot_start_addr;
>      } else {
> -        virtio_setup_device(blk_schid);
> +        virtio_blk_setup_device(blk_schid);
>  
>          IPL_assert(virtio_ipl_disk_is_valid(), "No valid IPL device detected");
>      }
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 43e2d42..6fdc858 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -74,7 +74,7 @@ void sclp_get_loadparm_ascii(char *loadparm);
>  unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
>                                   ulong subchan_id, void *load_addr);
>  bool virtio_is_supported(SubChannelId schid);
> -void virtio_setup_device(SubChannelId schid);
> +void virtio_blk_setup_device(SubChannelId schid);
>  int virtio_read(ulong sector, void *load_addr);
>  int enable_mss_facility(void);
>  ulong get_second(void);
> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
> new file mode 100644
> index 0000000..6cb77bc
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -0,0 +1,296 @@
> +/*
> + * Virtio driver bits
> + *
> + * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include "libc.h"
> +#include "s390-ccw.h"
> +#include "virtio.h"
> +#include "virtio-scsi.h"
> +
> +static int virtio_blk_read_many(VDev *vdev,
> +                                ulong sector, void *load_addr, int sec_num)
> +{

I would change this on the fly into something nicer. But I assume you
really just want a straight copy in this patch.


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
