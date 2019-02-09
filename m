Received: from eggs.gnu.org ([209.51.188.92]:42676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMKl-0005Gh-T4
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gsMKk-0005Cc-N5
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:41:51 -0500
References: <20190209063152.9490-1-richard.henderson@linaro.org>
	<20190209063152.9490-2-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ea20fa68-2480-e532-1e0d-6e3f6856913d@redhat.com>
Date: Sat, 9 Feb 2019 07:41:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190209063152.9490-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] target/s390x: Split out s390-tod.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>, Giovanni Mascellani <gio@debian.org>

On 2019-02-09 07:31, Richard Henderson wrote:
> We will need these from CONFIG_USER_ONLY as well,
> which cannot access include/hw/.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/hw/s390x/tod.h  | 16 +---------------
>  target/s390x/s390-tod.h | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 15 deletions(-)
>  create mode 100644 target/s390x/s390-tod.h
> 
> diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
> index 47ef9de869..9c4a6000c3 100644
> --- a/include/hw/s390x/tod.h
> +++ b/include/hw/s390x/tod.h
> @@ -12,6 +12,7 @@
>  #define HW_S390_TOD_H
>  
>  #include "hw/qdev.h"
> +#include "s390-tod.h"
>  
>  typedef struct S390TOD {
>      uint8_t high;
> @@ -50,21 +51,6 @@ typedef struct S390TODClass {
>      void (*set)(S390TODState *td, const S390TOD *tod, Error **errp);
>  } S390TODClass;
>  
> -/* The value of the TOD clock for 1.1.1970. */
> -#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
> -
> -/* Converts ns to s390's clock format */
> -static inline uint64_t time2tod(uint64_t ns)
> -{
> -    return (ns << 9) / 125 + (((ns & 0xff80000000000000ull) / 125) << 9);
> -}
> -
> -/* Converts s390's clock format to ns */
> -static inline uint64_t tod2time(uint64_t t)
> -{
> -    return ((t >> 9) * 125) + (((t & 0x1ff) * 125) >> 9);
> -}
> -
>  void s390_init_tod(void);
>  S390TODState *s390_get_todstate(void);
>  
> diff --git a/target/s390x/s390-tod.h b/target/s390x/s390-tod.h
> new file mode 100644
> index 0000000000..8b74d6a6d8
> --- /dev/null
> +++ b/target/s390x/s390-tod.h
> @@ -0,0 +1,29 @@
> +/*
> + * TOD (Time Of Day) clock
> + *
> + * Copyright 2018 Red Hat, Inc.
> + * Author(s): David Hildenbrand <david@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef TARGET_S390_TOD_H
> +#define TARGET_S390_TOD_H
> +
> +/* The value of the TOD clock for 1.1.1970. */
> +#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
> +
> +/* Converts ns to s390's clock format */
> +static inline uint64_t time2tod(uint64_t ns)
> +{
> +    return (ns << 9) / 125 + (((ns & 0xff80000000000000ull) / 125) << 9);
> +}
> +
> +/* Converts s390's clock format to ns */
> +static inline uint64_t tod2time(uint64_t t)
> +{
> +    return ((t >> 9) * 125) + (((t & 0x1ff) * 125) >> 9);
> +}
> +
> +#endif
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
