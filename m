Received: from eggs.gnu.org ([209.51.188.92]:54758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gon18-0000SP-CG
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gon17-0001zr-Hg
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:22:50 -0500
References: <20190104181208.7809-1-philmd@redhat.com>
	<20190104181208.7809-2-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <56ccdced-739b-49f9-7251-ec75aba01f92@vivier.eu>
Date: Wed, 30 Jan 2019 11:22:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190104181208.7809-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 1/3] util/cutils: Move
 size_to_str() from "qemu-common.h" to "cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>

On 04/01/2019 19:12, Philippe Mathieu-Daudé wrote:
> The size_to_str() function doesn't need to be in a generic header.
> 
> It makes also sens to find this function in the same header than
> the opposite string to size functions: qemu_strtosz*().
> Note than this function is already implemented in util/cutils.c.
> 
> Since we introduce a new function in a header, we document it,
> using the previous comment from the source file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/qemu-common.h        |  1 -
>  include/qemu/cutils.h        | 13 +++++++++++++
>  qapi/string-output-visitor.c |  2 +-
>  util/cutils.c                |  6 ------
>  4 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index ed60ba251d..760527294f 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -153,7 +153,6 @@ void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size);
>  int parse_debug_env(const char *name, int max, int initial);
>  
>  const char *qemu_ether_ntoa(const MACAddr *mac);
> -char *size_to_str(uint64_t val);
>  void page_size_init(void);
>  
>  /* returns non-zero if dump is in progress, otherwise zero is
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index d2dad3057c..9ee40470e3 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -157,6 +157,19 @@ int qemu_strtosz(const char *nptr, const char **end, uint64_t *result);
>  int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *result);
>  int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
>  
> +/**
> + * size_to_str:
> + *
> + * Return human readable string for size @val.
> + * Use IEC binary units like KiB, MiB, and so forth.
> + *
> + * @val: The value to format.
> + *       Can be anything that uint64_t allows (no more than "16 EiB").
> + *
> + * Caller is responsible for passing it to g_free().
> + */
> +char *size_to_str(uint64_t val);
> +
>  /* used to print char* safely */
>  #define STR_OR_NULL(str) ((str) ? (str) : "null")
>  
> diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> index 7ab64468d9..edf268b373 100644
> --- a/qapi/string-output-visitor.c
> +++ b/qapi/string-output-visitor.c
> @@ -11,9 +11,9 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu-common.h"
>  #include "qapi/string-output-visitor.h"
>  #include "qapi/visitor-impl.h"
> +#include "qemu/cutils.h"
>  #include "qemu/host-utils.h"
>  #include <math.h>
>  #include "qemu/range.h"
> diff --git a/util/cutils.c b/util/cutils.c
> index e098debdc0..a8a3a3ba3b 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -816,12 +816,6 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
>      return ret;
>  }
>  
> -/*
> - * Return human readable string for size @val.
> - * @val can be anything that uint64_t allows (no more than "16 EiB").
> - * Use IEC binary units like KiB, MiB, and so forth.
> - * Caller is responsible for passing it to g_free().
> - */
>  char *size_to_str(uint64_t val)
>  {
>      static const char *suffixes[] = { "", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei" };
> 

Applied to my trivial-patches branch with updated patch description.

Thanks,
Laurent
