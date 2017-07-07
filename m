Received: from eggs.gnu.org ([2001:4830:134:3::10]:41000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dTTkC-00030w-4Y
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dTTk9-0007vl-1c
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:56:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dTTk8-0007v9-NQ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:56:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v67DrjJe043402
	for <qemu-devel@nongnu.org>; Fri, 7 Jul 2017 09:56:22 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bj0wq6jun-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 09:56:22 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 7 Jul 2017 09:56:21 -0400
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
	<1499423224-23060-2-git-send-email-thuth@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 7 Jul 2017 09:56:17 -0400
MIME-Version: 1.0
In-Reply-To: <1499423224-23060-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <ff20f9da-8ed5-381d-affd-c064eb61ed53@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/8] pc-bios/s390-ccw: Move libc
 functions to separate header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>



On 07/07/2017 06:26 AM, Thomas Huth wrote:
> The upcoming netboot code will use the libc from SLOF. To be able
> to still use s390-ccw.h there, the libc related functions in this
> header have to be moved to a different location.
> And while we're at it, remove the duplicate memcpy() function from
> sclp.c.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/bootmap.c     |  1 +
>  pc-bios/s390-ccw/libc.h        | 43 ++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/main.c        |  1 +
>  pc-bios/s390-ccw/s390-ccw.h    | 29 ----------------------------
>  pc-bios/s390-ccw/sclp.c        | 10 ++--------
>  pc-bios/s390-ccw/virtio-scsi.c |  1 +
>  pc-bios/s390-ccw/virtio.c      |  1 +
>  7 files changed, 49 insertions(+), 37 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/libc.h
>
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 523fa78..458d3da 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -8,6 +8,7 @@
>   * directory.
>   */
>
> +#include "libc.h"
>  #include "s390-ccw.h"
>  #include "bootmap.h"
>  #include "virtio.h"
> diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
> new file mode 100644
> index 0000000..9076bb7
> --- /dev/null
> +++ b/pc-bios/s390-ccw/libc.h
> @@ -0,0 +1,43 @@
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
> +static inline void *memcpy(void *s1, const void *s2, size_t n)
> +{
> +    uint8_t *p1 = s1;
> +    const uint8_t *p2 = s2;
> +
> +    while (n--) {
> +        p1[n] = p2[n];
> +    }
> +    return s1;
> +}
> +
> +#endif
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 1cacc1b..40cba8d 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -8,6 +8,7 @@
>   * directory.
>   */
>
> +#include "libc.h"
>  #include "s390-ccw.h"
>  #include "virtio.h"
>
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 2089274..43e2d42 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -18,12 +18,6 @@ typedef unsigned short     u16;
>  typedef unsigned int       u32;
>  typedef unsigned long long u64;
>  typedef unsigned long      ulong;
> -typedef long               size_t;
> -typedef int                bool;
> -typedef unsigned char      uint8_t;
> -typedef unsigned short     uint16_t;
> -typedef unsigned int       uint32_t;
> -typedef unsigned long long uint64_t;
>  typedef unsigned char      __u8;
>  typedef unsigned short     __u16;
>  typedef unsigned int       __u32;
> @@ -88,18 +82,6 @@ ulong get_second(void);
>  /* bootmap.c */
>  void zipl_load(void);
>
> -static inline void *memset(void *s, int c, size_t n)
> -{
> -    int i;
> -    unsigned char *p = s;
> -
> -    for (i = 0; i < n; i++) {
> -        p[i] = c;
> -    }
> -
> -    return s;
> -}
> -
>  static inline void fill_hex(char *out, unsigned char val)
>  {
>      const char hex[] = "0123456789abcdef";
> @@ -169,17 +151,6 @@ static inline void sleep(unsigned int seconds)
>      }
>  }
>
> -static inline void *memcpy(void *s1, const void *s2, size_t n)
> -{
> -    uint8_t *p1 = s1;
> -    const uint8_t *p2 = s2;
> -
> -    while (n--) {
> -        p1[n] = p2[n];
> -    }
> -    return s1;
> -}
> -
>  static inline void IPL_assert(bool term, const char *message)
>  {
>      if (!term) {
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index a1639ba..aa1c862 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -8,6 +8,7 @@
>   * directory.
>   */
>
> +#include "libc.h"
>  #include "s390-ccw.h"
>  #include "sclp.h"
>
> @@ -59,13 +60,6 @@ static int _strlen(const char *str)
>      return i;
>  }
>
> -static void _memcpy(char *dest, const char *src, int len)
> -{
> -    int i;
> -    for (i = 0; i < len; i++)
> -        dest[i] = src[i];
> -}
> -
>  void sclp_print(const char *str)
>  {
>      int len = _strlen(str);
> @@ -76,7 +70,7 @@ void sclp_print(const char *str)
>      sccb->ebh.length = sizeof(EventBufferHeader) + len;
>      sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
>      sccb->ebh.flags = 0;
> -    _memcpy(sccb->data, str, len);
> +    memcpy(sccb->data, str, len);
>
>      sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
>  }
> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
> index f61ecf0..c92f5d3 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.c
> +++ b/pc-bios/s390-ccw/virtio-scsi.c
> @@ -9,6 +9,7 @@
>   * directory.
>   */
>
> +#include "libc.h"
>  #include "s390-ccw.h"
>  #include "virtio.h"
>  #include "scsi.h"
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 6ee93d5..8768331 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -8,6 +8,7 @@
>   * directory.
>   */
>
> +#include "libc.h"
>  #include "s390-ccw.h"
>  #include "virtio.h"
>  #include "virtio-scsi.h"
>
Reviewed-by: Farhan Ali <alifm@linux.vnet.ibm.com>
