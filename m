Received: from eggs.gnu.org ([209.51.188.92]:34192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghY8p-0008G0-Fg
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghY8o-0004LE-Hd
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:04:51 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:36037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ghY8m-0004HL-GL
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:04:50 -0500
References: <1547115782-26271-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5dc4b081-ebd9-d7e7-7f5d-889d187500c8@vivier.eu>
Date: Thu, 10 Jan 2019 12:04:00 +0100
MIME-Version: 1.0
In-Reply-To: <1547115782-26271-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Fix compilation with clang
 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

On 10/01/2019 11:23, Thomas Huth wrote:
> Clang version 3.4.2 does not know the -Wpragmas option yet and bails
> out with an error when we try to disable it in linux-user/qemu.h.
> Fortunately, clang has a __has_warning() macro which allows us to add
> an explicit check for the warning that we like to disable. With that we
> can check for the availability of "-Waddress-of-packed-member" properly
> and do not need the "-Wpragmas" at all here.
> 
> Fixes: 850d5e330a9c68cc998cecc02caf8a3c8d1ee8a3
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Drop -Wpragmas now completely
> 
>   include/qemu/compiler.h | 4 ++++
>   linux-user/qemu.h       | 6 +-----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 261842b..28fa438 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -113,6 +113,10 @@
>   #define GCC_FMT_ATTR(n, m)
>   #endif
>   
> +#ifndef __has_warning
> +#define __has_warning(x) 0 /* compatibility with non-clang compilers */
> +#endif
> +
>   #ifndef __has_feature
>   #define __has_feature(x) 0 /* compatibility with non-clang compilers */
>   #endif
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index dd5771c..63a8998 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -474,17 +474,13 @@ static inline int access_ok(int type, abi_ulong addr, abi_ulong size)
>    *   functions than host-endian unaligned load/store plus tswapN.
>    * - The pragmas are necessary only to silence a clang false-positive
>    *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
> - * - We have to disable -Wpragmas warnings to avoid a complaint about
> - *   an unknown warning type from older compilers that don't know about
> - *   -Waddress-of-packed-member.
>    * - gcc has bugs in its _Pragma() support in some versions, eg
>    *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
>    *   include the warning-suppression pragmas for clang
>    */
> -#ifdef __clang__
> +#if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
>   #define PRAGMA_DISABLE_PACKED_WARNING                                   \
>       _Pragma("GCC diagnostic push");                                     \
> -    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
>       _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
>   
>   #define PRAGMA_REENABLE_PACKED_WARNING          \
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
