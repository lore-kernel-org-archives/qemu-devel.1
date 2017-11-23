Received: from eggs.gnu.org ([2001:4830:134:3::10]:35232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHtvy-0002jy-MS
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHtvt-0006TW-57
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:01:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHtvs-0006SO-Vb
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:00:57 -0500
References: <1511452598-6077-1-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bdbc6042-bbae-b057-c9ee-769c6d7e8345@redhat.com>
Date: Thu, 23 Nov 2017 17:00:52 +0100
MIME-Version: 1.0
In-Reply-To: <1511452598-6077-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11?] osdep.h: Make TIME_MAX handle
 different time_t types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <n54@gmx.com>

On 23/11/2017 16:56, Peter Maydell wrote:
> In our various supported host OSes, the time_t type may be either 32
> or 64 bit, and could in theory also be either signed or unsigned.
> Notably, in OpenBSD time_t is a 64 bit type even if 'long' is 32
> bits, so using LONG_MAX for TIME_MAX is incorrect.
> 
> Use an approach suggested by Paolo Bonzini which calculates
> the maximum value of the type rather than hardcoding it;
> to do this we use the TYPE_MAXIMUM macro from Gnulib.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/qemu/osdep.h | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 281782d..e8568a0 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -147,8 +147,35 @@ extern int daemon(int, int);
>  #if !defined(ESHUTDOWN)
>  #define ESHUTDOWN 4099
>  #endif
> +
> +/* time_t may be either 32 or 64 bits depending on the host OS, and
> + * can be either signed or unsigned, so we can't just hardcode a
> + * specific maximum value. This is not a C preprocessor constant,
> + * so you can't use TIME_MAX in an #ifdef, but for our purposes
> + * this isn't a problem.
> + */
> +
> +/* The macros TYPE_SIGNED, TYPE_WIDTH, and TYPE_MAXIMUM are from
> + * Gnulib, and are under the LGPL v2.1 or (at your option) any
> + * later version.
> + */
> +
> +/* True if the real type T is signed.  */
> +#define TYPE_SIGNED(t) (!((t)0 < (t)-1))
> +
> +/* The width in bits of the integer type or expression T.
> + * Padding bits are not supported.
> + */
> +#define TYPE_WIDTH(t) (sizeof(t) * CHAR_BIT)
> +
> +/* The maximum and minimum values for the integer type T.  */
> +#define TYPE_MAXIMUM(t)                                                \
> +  ((t) (!TYPE_SIGNED(t)                                                \
> +        ? (t)-1                                                        \
> +        : ((((t)1 << (TYPE_WIDTH(t) - 2)) - 1) * 2 + 1)))
> +
>  #ifndef TIME_MAX
> -#define TIME_MAX LONG_MAX
> +#define TIME_MAX TYPE_MAXIMUM(time_t)
>  #endif
>  
>  /* HOST_LONG_BITS is the size of a native pointer in bits. */
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
