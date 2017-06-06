Received: from eggs.gnu.org ([2001:4830:134:3::10]:52048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dI7E2-00048u-8D
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 01:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dI7E1-0001Kc-8n
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 01:40:18 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:35383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dI7E1-0001K0-3f
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 01:40:17 -0400
Received: by mail-it0-x242.google.com with SMTP id 67so25802148itx.2
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 22:40:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496702979-26132-2-git-send-email-cota@braap.org>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-2-git-send-email-cota@braap.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 6 Jun 2017 01:39:45 -0400
Message-ID: <CAJhHMCDHLrU5NEuZGJqkVcJyQnXYsrdcYbNiNw4DAgiT=0R9pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] compiler: define QEMU_CACHELINE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jun 5, 2017 at 6:49 PM, Emilio G. Cota <cota@braap.org> wrote:
> This is a constant used as a hint for padding structs to hopefully avoid
> false cache line sharing.
>
> The constant can be set at configure time by defining QEMU_CACHELINE_SIZE
> via --extra-cflags. If not set there, we try to obtain the value from
> the machine running the configure script. If we fail, we default to
> reasonable values, i.e. 128 bytes for ppc64 and 64 bytes for all others.
>
> Note: the configure script only picks up the cache line size when run
> on Linux hosts because I have no other platforms (e.g. Windows, BSD's)
> to test on.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  configure               | 38 ++++++++++++++++++++++++++++++++++++++
>  include/qemu/compiler.h | 17 +++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/configure b/configure
> index 13e040d..6a68cb2 100755
> --- a/configure
> +++ b/configure
> @@ -4832,6 +4832,41 @@ EOF
>    fi
>  fi
>
> +# Find out the size of a cache line on the host
> +# TODO: support more platforms
> +cat > $TMPC<<EOF
> +#ifdef __linux__
> +
> +#include <stdio.h>
> +
> +#define SYSFS "/sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size"
> +
> +int main(int argc, char *argv[])
> +{
> +    unsigned int size;
> +    FILE *fp;
> +
> +    fp = fopen(SYSFS, "r");
> +    if (fp == NULL) {
> +        return -1;
> +    }
> +    if (!fscanf(fp, "%u", &size)) {
> +        return -1;
> +    }
> +    return size;
> +}
> +#else
> +#error Cannot find host cache line size
> +#endif
> +EOF

Is there any reason not to use sysconf(_SC_LEVEL1_DCACHE_LINESIZE)?

Thanks,
-- 
Pranith
