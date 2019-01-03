Received: from eggs.gnu.org ([208.118.235.92]:58484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gezOH-0003OG-Ad
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gezO8-00037T-UK
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:34:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gezO8-00035V-Ki
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:34:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so32929318wrw.5
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 01:34:02 -0800 (PST)
References: <20190102110804.18155-1-lbloch@janustech.com>
	<20190102110804.18155-2-lbloch@janustech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2e8c1c1c-6456-dcbe-8aa6-1fa09d153330@redhat.com>
Date: Thu, 3 Jan 2019 10:33:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190102110804.18155-2-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>

Hi Leonid,

On 1/2/19 12:09 PM, Leonid Bloch wrote:
> The lookup table for power-of-two sizes is now auto-generated during the
> build, and not hard-coded into the units.h file.
> 

This partially reverts commit 540b8492618eb.

> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>  .gitignore           |  1 +
>  Makefile             |  5 +++
>  block/qcow2.h        |  2 +-
>  block/vdi.c          |  1 +
>  include/qemu/units.h | 73 --------------------------------------------
>  scripts/gen-sizes.sh | 66 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 74 insertions(+), 74 deletions(-)
>  create mode 100755 scripts/gen-sizes.sh
> 
> diff --git a/.gitignore b/.gitignore
> index 0430257313..5945220303 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -59,6 +59,7 @@
>  /qemu-version.h
>  /qemu-version.h.tmp
>  /module_block.h
> +/include/qemu/sizes.h
>  /scsi/qemu-pr-helper
>  /vhost-user-scsi
>  /vhost-user-blk
> diff --git a/Makefile b/Makefile
> index dd53965f77..435d92821b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -122,6 +122,8 @@ endif
>  
>  GENERATED_FILES += module_block.h
>  
> +GENERATED_FILES += $(SRC_PATH)/include/qemu/sizes.h

You shouldn't write to SRC_PATH (think of read-only filesystem).

Using the current directory is OK (the build system assumes it is
writeable).

So as 'module_block.h', why not simply name it 'lookup_table_sizes.h'?

Actually, we could move those in a generated/ subdirectory, this
would make the source file more explicit:

#include "generated/module_block.h"

Kevin, what do you think?

> +
>  TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
>  TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
>  TRACE_DTRACE =
> @@ -499,6 +501,9 @@ ifdef CONFIG_MPATH
>  scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
>  endif
>  
> +$(SRC_PATH)/include/qemu/sizes.h: $(SRC_PATH)/scripts/gen-sizes.sh

lookup_table_sizes.h: $(SRC_PATH)/scripts/gen-sizes.sh

> +	$(call quiet-command,sh $(SRC_PATH)/scripts/gen-sizes.sh $@,"GEN","$@")
> +
>  qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
>  
> diff --git a/block/qcow2.h b/block/qcow2.h
> index a98d24500b..41d14baa17 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -27,7 +27,7 @@
>  
>  #include "crypto/block.h"
>  #include "qemu/coroutine.h"
> -#include "qemu/units.h"
> +#include "qemu/sizes.h"

#include "lookup_table_sizes.h"

>  
>  //#define DEBUG_ALLOC
>  //#define DEBUG_ALLOC2
> diff --git a/block/vdi.c b/block/vdi.c
> index 2380daa583..62dafe0cc6 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -51,6 +51,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "qemu/sizes.h"

#include "lookup_table_sizes.h"

>  #include "qapi/error.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/qapi-visit-block-core.h"
> diff --git a/include/qemu/units.h b/include/qemu/units.h
> index 1c959d182e..692db3fbb2 100644
> --- a/include/qemu/units.h
> +++ b/include/qemu/units.h
> @@ -17,77 +17,4 @@
>  #define PiB     (INT64_C(1) << 50)
>  #define EiB     (INT64_C(1) << 60)
>  
> -/*
> - * The following lookup table is intended to be used when a literal string of
> - * the number of bytes is required (for example if it needs to be stringified).
> - * It can also be used for generic shortcuts of power-of-two sizes.
> - * This table is generated using the AWK script below:
> - *
> - *  BEGIN {
> - *      suffix="KMGTPE";
> - *      for(i=10; i<64; i++) {
> - *          val=2**i;
> - *          s=substr(suffix, int(i/10), 1);
> - *          n=2**(i%10);
> - *          pad=21-int(log(n)/log(10));
> - *          printf("#define S_%d%siB %*d\n", n, s, pad, val);
> - *      }
> - *  }
> - */
> -
> -#define S_1KiB                  1024
> -#define S_2KiB                  2048
> -#define S_4KiB                  4096
> -#define S_8KiB                  8192
> -#define S_16KiB                16384
> -#define S_32KiB                32768
> -#define S_64KiB                65536
> -#define S_128KiB              131072
> -#define S_256KiB              262144
> -#define S_512KiB              524288
> -#define S_1MiB               1048576
> -#define S_2MiB               2097152
> -#define S_4MiB               4194304
> -#define S_8MiB               8388608
> -#define S_16MiB             16777216
> -#define S_32MiB             33554432
> -#define S_64MiB             67108864
> -#define S_128MiB           134217728
> -#define S_256MiB           268435456
> -#define S_512MiB           536870912
> -#define S_1GiB            1073741824
> -#define S_2GiB            2147483648
> -#define S_4GiB            4294967296
> -#define S_8GiB            8589934592
> -#define S_16GiB          17179869184
> -#define S_32GiB          34359738368
> -#define S_64GiB          68719476736
> -#define S_128GiB        137438953472
> -#define S_256GiB        274877906944
> -#define S_512GiB        549755813888
> -#define S_1TiB         1099511627776
> -#define S_2TiB         2199023255552
> -#define S_4TiB         4398046511104
> -#define S_8TiB         8796093022208
> -#define S_16TiB       17592186044416
> -#define S_32TiB       35184372088832
> -#define S_64TiB       70368744177664
> -#define S_128TiB     140737488355328
> -#define S_256TiB     281474976710656
> -#define S_512TiB     562949953421312
> -#define S_1PiB      1125899906842624
> -#define S_2PiB      2251799813685248
> -#define S_4PiB      4503599627370496
> -#define S_8PiB      9007199254740992
> -#define S_16PiB    18014398509481984
> -#define S_32PiB    36028797018963968
> -#define S_64PiB    72057594037927936
> -#define S_128PiB  144115188075855872
> -#define S_256PiB  288230376151711744
> -#define S_512PiB  576460752303423488
> -#define S_1EiB   1152921504606846976
> -#define S_2EiB   2305843009213693952
> -#define S_4EiB   4611686018427387904
> -#define S_8EiB   9223372036854775808
> -
>  #endif
> diff --git a/scripts/gen-sizes.sh b/scripts/gen-sizes.sh
> new file mode 100755
> index 0000000000..e388164c32
> --- /dev/null
> +++ b/scripts/gen-sizes.sh
> @@ -0,0 +1,66 @@
> +#!/bin/sh
> +
> +size_suffix() {
> +    case ${1} in
> +        1)
> +            printf "KiB"
> +            ;;
> +        2)
> +            printf "MiB"
> +            ;;
> +        3)
> +            printf "GiB"
> +            ;;
> +        4)
> +            printf "TiB"
> +            ;;
> +        5)
> +            printf "PiB"
> +            ;;
> +        6)
> +            printf "EiB"
> +            ;;
> +    esac
> +}
> +
> +print_sizes() {
> +    local p=10
> +    while [ ${p} -lt 64 ]
> +    do
> +        local pad=' '
> +        local n=$((p % 10))
> +        n=$((1 << n))
> +        [ $((n / 100)) -eq 0 ] && pad='  '
> +        [ $((n / 10)) -eq 0 ] && pad='   '
> +        local suff=$((p / 10))
> +        printf "#define S_%u%s%s%20u\n" ${n} "$(size_suffix ${suff})" \
> +            "${pad}" $((1 << p))
> +        p=$((p + 1))
> +    done
> +}
> +
> +print_header() {
> +    cat <<EOF
> +/*
> + * The following lookup table is intended to be used when a literal string of
> + * the number of bytes is required (for example if it needs to be stringified).
> + * It can also be used for generic shortcuts of power-of-two sizes.
> + * This table is generated automatically during the build.
> + *
> + * Author:
> + *   Leonid Bloch  <lbloch@janustech.com>
> + */
> +
> +#ifndef QEMU_SIZES_H
> +#define QEMU_SIZES_H
> +
> +EOF
> +}
> +
> +print_footer() {
> +    printf "\n#endif\n"

       printf "\n#endif /* QEMU_SIZES_H */\n"

> +}
> +
> +print_header  > "${1}"
> +print_sizes  >> "${1}"
> +print_footer >> "${1}"
> 

Regards,

Phil.
