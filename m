Received: from eggs.gnu.org ([209.51.188.92]:52408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggnjR-0006db-Q2
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggnjP-0008OK-Ed
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:31:33 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
Date: Tue, 08 Jan 2019 10:31:09 +0100
In-Reply-To: <20190103213320.2653-2-lbloch@janustech.com> (Leonid Bloch's
	message of "Thu, 3 Jan 2019 21:33:59 +0000")
Message-ID: <8736q3ebs2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Mat?= =?utf-8?Q?hieu-Daud=C3=A9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>

Copying our resident shell script guru Eric.

Leonid Bloch <lbloch@janustech.com> writes:

> The lookup table for power-of-two sizes is now auto-generated during the
> build, and not hard-coded into the units.h file.
>
> This partially reverts commit 540b8492618eb.
>
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

I'd leave it hard-coded.  Replacing a few trivial defines by an arguably
less trivial script doesn't feel like an improvement.  In this case, it
doesn't even save lines.  But I'm not the maintainer.  Hmm,
include/qemu/units.h lacks one.  For what it's worth, its only user
block/vdi.c is maintained by

    $ scripts/get_maintainer.pl -f block/vdi.c 
    Stefan Weil <sw@weilnetz.de> (maintainer:VDI)
    Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
    Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
    qemu-block@nongnu.org (open list:VDI)
    qemu-devel@nongnu.org (open list:All patches CC here)

> diff --git a/.gitignore b/.gitignore
> index 0430257313..721a7f4454 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -59,6 +59,7 @@
>  /qemu-version.h
>  /qemu-version.h.tmp
>  /module_block.h
> +/pow2_sizes.h
>  /scsi/qemu-pr-helper
>  /vhost-user-scsi
>  /vhost-user-blk
> diff --git a/Makefile b/Makefile
> index dd53965f77..db72786ccb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -122,6 +122,8 @@ endif
>  
>  GENERATED_FILES += module_block.h
>  
> +GENERATED_FILES += pow2_sizes.h
> +
>  TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
>  TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
>  TRACE_DTRACE =
> @@ -499,6 +501,9 @@ ifdef CONFIG_MPATH
>  scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
>  endif
>  
> +pow2_sizes.h: $(SRC_PATH)/scripts/gen-sizes.sh
> +	$(call quiet-command,sh $(SRC_PATH)/scripts/gen-sizes.sh $@,"GEN","$@")
> +
>  qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
>  
> diff --git a/block/qcow2.h b/block/qcow2.h
> index a98d24500b..f5fa419ae7 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -27,7 +27,7 @@
>  
>  #include "crypto/block.h"
>  #include "qemu/coroutine.h"
> -#include "qemu/units.h"
> +#include "pow2_sizes.h"
>  
>  //#define DEBUG_ALLOC
>  //#define DEBUG_ALLOC2
> diff --git a/block/vdi.c b/block/vdi.c
> index 2380daa583..06d7335b3e 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -51,6 +51,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "pow2_sizes.h"
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

If we decide not keep the defines hard-coded, I think we can delete the
AWK script.

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
> index 0000000000..28fe62a4c2
> --- /dev/null
> +++ b/scripts/gen-sizes.sh

I'm not sure I'd use shell for this, but since you already wrote it and
it works...

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

Terser:

       suf=('' 'K' 'M' 'G' 'T' 'P' 'E')
       printf "${suf[$1]}iB"

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

Rule of thumb: when you compute blank padding strings, you're not fully
exploiting printf :)

    local p
    for ((p=10; p < 64; p++))
    do
        local n=$((1 << (p % 10)))
	local sym=$(printf "S_%u%s" $n "$(size_suffix $((p / 10)))")
        printf "#define %-8s %20u\n" $sym $((1 << p))
    done

> +}
> +
> +print_header() {
> +    cat <<EOF
> +/* AUTOMATICALLY GENERATED, DO NOT MODIFY.
> + *
> + * The following lookup table is intended to be used when a literal string of
> + * the number of bytes is required (for example if it needs to be stringified).
> + * It can also be used for generic shortcuts of power-of-two sizes.
> + *
> + * Authors:
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
> +    printf "\n#endif  /* QEMU_SIZES_H */\n"
> +}
> +
> +print_header  > "${1}"
> +print_sizes  >> "${1}"
> +print_footer >> "${1}"

Unchecked use of command-line arguments is not nice:

    $ scripts/gen-sizes.sh 
    scripts/gen-sizes.sh: line 64: : No such file or directory
    scripts/gen-sizes.sh: line 65: : No such file or directory
    scripts/gen-sizes.sh: line 66: : No such file or directory

You should error out if $# -ne 1.  But in such a simple script, I'd
dispense with arguments and print to stdout.  Matter of taste.
Rejecting $# -ne 0 is still nice then.
