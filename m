Received: from eggs.gnu.org ([2001:4830:134:3::10]:51406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUpv4-0007DX-LK
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUpv1-0006kX-Hv
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:49:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUpv1-0006iX-7p
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:49:15 -0400
Date: Tue, 11 Jul 2017 09:49:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711094908.7931eb95@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499700760-4777-2-git-send-email-thuth@redhat.com>
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
	<1499700760-4777-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/10] pc-bios/s390-ccw: Move libc
 functions to separate header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Mon, 10 Jul 2017 17:32:31 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The upcoming netboot code will use the libc from SLOF. To be able
> to still use s390-ccw.h there, the libc related functions in this
> header have to be moved to a different location.
> And while we're at it, remove the duplicate memcpy() function from
> sclp.c.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/bootmap.c     |  1 +
>  pc-bios/s390-ccw/libc.h        | 45 ++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/main.c        |  1 +
>  pc-bios/s390-ccw/s390-ccw.h    | 29 ---------------------------
>  pc-bios/s390-ccw/sclp.c        | 10 ++--------
>  pc-bios/s390-ccw/virtio-scsi.c |  1 +
>  pc-bios/s390-ccw/virtio.c      |  1 +
>  7 files changed, 51 insertions(+), 37 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/libc.h
> 

> diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
> new file mode 100644
> index 0000000..6397d67
> --- /dev/null
> +++ b/pc-bios/s390-ccw/libc.h
> @@ -0,0 +1,45 @@
> +/*
> + * libc-style definitions and functions
> + *
> + * This code is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef S390_CCW_LIBC_H
> +#define S390_CCW_LIBC_H
> +
> +typedef long               size_t;
> +typedef int                bool;
> +typedef unsigned char      uint8_t;
> +typedef unsigned short     uint16_t;
> +typedef unsigned int       uint32_t;
> +typedef unsigned long long uint64_t;
> +
> +static inline void *memset(void *s, int c, size_t n)

This one uses n...

> +{
> +    int i;
> +    unsigned char *p = s;
> +
> +    for (i = 0; i < n; i++) {
> +        p[i] = c;
> +    }
> +
> +    return s;
> +}
> +
> +static inline void *memcpy(void *s1, const void *s2, size_t len)

...and this one len. (The duplicate memcpy function used n.)

No real need to change, just to show I actually read this ;)

> +{
> +    uint8_t *dest = s1;
> +    const uint8_t *src = s2;
> +    int i;
> +
> +    for (i = 0; i < len; i++) {
> +        dest[i] = src[i];
> +    }
> +
> +    return s1;
> +}
> +
> +#endif

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
