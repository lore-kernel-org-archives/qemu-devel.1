Received: from eggsout.gnu.org ([209.51.188.92]:54671 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gfZkg-0005Zt-Mt
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 19:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gfZke-0001fy-KA
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 19:23:46 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gfZkc-0001SK-Ty
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 19:23:43 -0500
Received: by mail-wr1-x442.google.com with SMTP id p4so37990918wrt.7
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 16:23:41 -0800 (PST)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::b8?
	(2a01-036c-0113-6e8c-0001-0000-0000-00b8.pool6.digikabel.hu.
	[2a01:36c:113:6e8c:1::b8])
	by smtp.gmail.com with ESMTPSA id r69sm3439953wmd.4.2019.01.04.16.23.39
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Jan 2019 16:23:39 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
References: <20190104153951.32306-1-eblake@redhat.com>
Message-ID: <4e30c442-6ddc-2988-160e-168dec552966@gmail.com>
Date: Sat, 5 Jan 2019 01:23:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190104153951.32306-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] osdep: Make MIN/MAX evaluate arguments
 only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I have a similar patch in my queue[1]

On 2019-01-04 16:39, Eric Blake wrote:
> Use the __auto_type keyword to make sure our min/max macros only
> evaluate their arguments once.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> RFC because __auto_type didn't exist until gcc 4.9, and I don't know
> which clang version introduced it (other than that it went in
> during 2015: https://reviews.llvm.org/D12686).  Our minimum gcc
> version is 4.8, which has typeof; I'm not sure if our minimum clang
> version supports typeof.
> 
> I'm considering adding a snippet to compiler.h that looks like:
> 
>  #if .... // new enough gcc/clang
>  #define QEMU_TYPEOF(a) __auto_type
>  #else
>  #define QEMU_TYPEOF(a) typeof(a)
>  #endif
> 
> at which point we could blindly use QEMU_TYPEOF(a)=(a) anywhere we
> need automatic typing, for the benefit of smaller macro expansion
> [and proper handling of VLA types, although I don't think we use
> those to care about that aspect of __auto_type] in newer compilers,
> while still getting automatic type deduction in older compilers for
> macros that want single evaluation, and where we've localized the
> version checks to one spot instead of everywhere.  But for that to
> work, again, I need to know whether typeof is supported in our
> minimum clang version, and how to properly spell the version check
> for clang on when to prefer __auto_type over typeof (at least I
> know how to spell it for gcc).
> 
> While at it, the comments to MIN_NON_ZERO() state that callers should
> only compare unsigned types; I suspect we don't actually obey that
> rule, but I also think the comment is over-strict - the macro works
> as long as both arguments are non-negative, and when called with a
> mix of signed and unsigned types, as long as the type promotion
> preserves the fact that the value is still non-negative.  But it
> might be interesting to add compile-time checking (or maybe runtime
> asserts) that the macro is indeed only used on non-negative values.
> 
>  include/qemu/osdep.h | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 3bf48bcdec0..b941572b808 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -233,17 +233,31 @@ extern int daemon(int, int);
>  #endif
> 
>  #ifndef MIN
> -#define MIN(a, b) (((a) < (b)) ? (a) : (b))
> +#define MIN(a, b)              \
> +    ({                         \
> +        __auto_type _a = (a);  \
> +        __auto_type _b = (b);  \
> +        _a < _b ? _a : _b;     \
> +    })
>  #endif
>  #ifndef MAX
> -#define MAX(a, b) (((a) > (b)) ? (a) : (b))
> +#define MAX(a, b)              \
> +    ({                         \
> +        __auto_type _a = (a);  \
> +        __auto_type _b = (b);  \
> +        _a > _b ? _a : _b;     \
> +    })
>  #endif
I tried this[2], but apparently random linux headers define their own
MIN/MAX and in case this version won't be used. And the version above
with __auto_type and statement expression doesn't work on bitfields and
when not in functions (for example struct XHCIState has
    USBPort  uports[MAX(MAXPORTS_2, MAXPORTS_3)];
as one of its member). It only works because currently glib/gmacros.h or
sys/param.h defines it's own MIN/MAX which is identical to the old version.

Now that I think about it, instead of undefining the old macro or only
conditionally defining it, maybe the best course of action would be to
rename MIN/MAX to something more unique so it won't clash with random
system headers.

> 
>  /* Minimum function that returns zero only iff both values are zero.
>   * Intended for use with unsigned values only. */
>  #ifndef MIN_NON_ZERO
> -#define MIN_NON_ZERO(a, b) ((a) == 0 ? (b) : \
> -                                ((b) == 0 ? (a) : (MIN(a, b))))
> +#define MIN_NON_ZERO(a, b)                              \
> +    ({                                                  \
> +        __auto_type _a = (a);                           \
> +        __auto_type _b = (b);                           \
> +        _a == 0 ? _b : (_b == 0 || _b > _a) ? _a : _b;  \
> +    })
>  #endif
> 
>  /* Round number down to multiple */
> 

[1]: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05718.html
[2]: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg06006.html

Regards,
Zoltan
