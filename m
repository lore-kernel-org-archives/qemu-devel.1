Received: from eggs.gnu.org ([2001:4830:134:3::10]:36426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6fIl-00072f-CO
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6fIh-0002FE-CQ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:10:07 -0400
Date: Mon, 23 Oct 2017 18:09:59 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171023160959.GC10220@stefanha-x1.localdomain>
References: <20171023025016.3088-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023025016.3088-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [libfdt][PATCH v3] implement strnlen for systems
 that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: david@gibson.dropbear.id.au, richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, peter.maydell@linaro.org, devicetree-compiler@vger.kernel.org, ian@freebsd.org

On Sun, Oct 22, 2017 at 10:50:16PM -0400, John Arbuckle wrote:
> Prior the Mac OS 10.7, the function strnlen() was not available. This patch
> implements strnlen() on Mac OS X versions that are below 10.7.
> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v3 changes:
> - Replaced loop with memchr()
> 
> v2 changes:
> - Simplified the code to make it static inline'ed
> - Changed the type of count to size_t
> 
>  libfdt/libfdt_env.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/libfdt/libfdt_env.h b/libfdt/libfdt_env.h
> index 952056c..d43b66b 100644
> --- a/libfdt/libfdt_env.h
> +++ b/libfdt/libfdt_env.h
> @@ -109,4 +109,28 @@ static inline fdt64_t cpu_to_fdt64(uint64_t x)
>  #undef CPU_TO_FDT16
>  #undef EXTRACT_BYTE
>  
> +#ifdef __APPLE__
> +#include <AvailabilityMacros.h>
> +
> +#define MAC_OS_X_VERSION_10_7 1070

Apple has already defined MAC_OS_X_VERSION_10_7 here:
https://opensource.apple.com/source/xnu/xnu-1699.24.8/EXTERNAL_HEADERS/AvailabilityMacros.h

To avoid a compiler warning, please use:

#ifndef MAC_OS_X_VERSION_10_7
#define MAC_OS_X_VERSION_10_7 1070
#endif

> +/* strnlen() is not available on Mac OS < 10.7 */
> +# if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7)

Does this cover the case where MAC_OS_X_VERSION_MAX_ALLOWED is set to
<1070 on a 10.7+ build machine?  It's possible that the <string.h>
header would define strnlen() and your code redefines the function
(compiler error).

It would be best to check how <string.h>, <Availability.h>, and
<AvailabilityMacros.h> work to make sure that all cases are handled.  I
don't have access to a Mac right now, sorry.

Perhaps this approach works better:

# ifndef MAC_OS_X_VERSION_10_7
