Received: from eggs.gnu.org ([2001:4830:134:3::10]:58448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e5TlF-0005cJ-TS
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e5TlE-0005bb-SE
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:38:37 -0400
Date: Fri, 20 Oct 2017 11:38:26 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171020093826.GB21393@stefanha-x1.localdomain>
References: <20171020015005.2311-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171020015005.2311-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] implement strnlen for systems that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Thu, Oct 19, 2017 at 09:50:05PM -0400, John Arbuckle wrote:

Which repo does this patch apply to?  Please add a tag in the email
subject like "[libfdt]" to distinguish it from qemu.git patches.

> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  Makefile.dtc           |  3 ++-
>  libfdt/Makefile.libfdt |  2 +-
>  libfdt/libfdt_env.h    | 12 ++++++++++++
>  libfdt/strnlen.h       | 14 ++++++++++++++
>  strnlen.c              | 25 +++++++++++++++++++++++++
>  5 files changed, 54 insertions(+), 2 deletions(-)
>  create mode 100644 libfdt/strnlen.h
>  create mode 100644 strnlen.c
> 
> diff --git a/Makefile.dtc b/Makefile.dtc
> index bece49b..14eaa4e 100644
> --- a/Makefile.dtc
> +++ b/Makefile.dtc
> @@ -12,7 +12,8 @@ DTC_SRCS = \
>  	livetree.c \
>  	srcpos.c \
>  	treesource.c \
> -	util.c
> +	util.c \
> +    strnlen.c
>  
>  DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.c
>  DTC_OBJS = $(DTC_SRCS:%.c=%.o) $(DTC_GEN_SRCS:%.c=%.o)
> diff --git a/libfdt/Makefile.libfdt b/libfdt/Makefile.libfdt
> index 098b3f3..b20a85b 100644
> --- a/libfdt/Makefile.libfdt
> +++ b/libfdt/Makefile.libfdt
> @@ -7,5 +7,5 @@ LIBFDT_soname = libfdt.$(SHAREDLIB_EXT).1
>  LIBFDT_INCLUDES = fdt.h libfdt.h libfdt_env.h
>  LIBFDT_VERSION = version.lds
>  LIBFDT_SRCS = fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c fdt_empty_tree.c \
> -	fdt_addresses.c fdt_overlay.c
> +	fdt_addresses.c fdt_overlay.c strnlen.c
>  LIBFDT_OBJS = $(LIBFDT_SRCS:%.c=%.o)
> diff --git a/libfdt/libfdt_env.h b/libfdt/libfdt_env.h
> index 952056c..a25a615 100644
> --- a/libfdt/libfdt_env.h
> +++ b/libfdt/libfdt_env.h
> @@ -109,4 +109,16 @@ static inline fdt64_t cpu_to_fdt64(uint64_t x)
>  #undef CPU_TO_FDT16
>  #undef EXTRACT_BYTE
>  
> +#ifdef __APPLE__
> +#include <AvailabilityMacros.h>
> +
> +#define MAC_OS_X_VERSION_10_7 1070
> +
> +/* strnlen() is not available on Mac OS < 10.7 */
> +# if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7)
> +#include "strnlen.h"
> +#endif /* (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7) */
> +
> +#endif /* __APPLE__ */
> +
>  #endif /* _LIBFDT_ENV_H */
> diff --git a/libfdt/strnlen.h b/libfdt/strnlen.h
> new file mode 100644
> index 0000000..62a45c0
> --- /dev/null
> +++ b/libfdt/strnlen.h
> @@ -0,0 +1,14 @@
> +/*
> + * File: strnlen.h
> + * Date: 10-19-2017
> + * Description: Implements functions that may be missing on the host system
> + */
> +
> +#ifndef STRNLEN
> +#define STRNLEN
> +
> +#include <stddef.h>
> +
> +size_t strnlen(const char *string, size_t max_count);
> +
> +#endif /* STRNLEN */
> diff --git a/strnlen.c b/strnlen.c
> new file mode 100644
> index 0000000..3559c6f
> --- /dev/null
> +++ b/strnlen.c
> @@ -0,0 +1,25 @@
> +/*
> + * File: strnlen.c
> + * Date: 10-19-2017
> + * Description: Implement the strnlen() function for platforms that need it
> + */
> +
> +#include <stddef.h>
> +#include "strnlen.h"
> +
> +/* 
> + * strnlen: returns the length of a string or max_count - which ever is smallest
> + * Input 1 string: the string whose size is to be determined
> + * Input 2 max_count: the maximum value returned by this function
> + * Output: length of the string or max_count (the smallest of the two)
> + */
> +size_t strnlen(const char *string, size_t max_count)
> +{
> +    int count;
> +    for(count = 0; count < max_count; count++) {
> +        if (string[count] == '\0') {
> +            break;
> +        }
> +    }
> +    return count;
> +}
> -- 
> 2.10.2
> 
> 
