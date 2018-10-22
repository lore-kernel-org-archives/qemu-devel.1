Received: from eggs.gnu.org ([2001:4830:134:3::10]:35731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEetg-0002x4-FA
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEetc-0003fd-F0
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:25:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEetc-0003cM-7O
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:25:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id f17-v6so14277865wrs.12
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 11:25:41 -0700 (PDT)
References: <20181022181623.8810-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <615be422-c338-a4bb-cf66-eeda2b553b7c@redhat.com>
Date: Mon, 22 Oct 2018 20:25:38 +0200
MIME-Version: 1.0
In-Reply-To: <20181022181623.8810-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH, build fix] osdep: Work around MinGW assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 22/10/18 20:16, Richard Henderson wrote:
> In several places we use assert(FEATURE), and assume that if FEATURE
> is disabled, all following code is removed as unreachable.  Which allows
> us to compile-out functions that are only present with FEATURE, and
> have a link-time failure if the functions remain used.
> 
> MinGW does not mark its internal function _assert() as noreturn, so the
> compiler cannot see when code is unreachable, which leads to link errors
> for this host that are not present elsewhere.
> 
> The current build-time failure concerns 62823083b8a2, but I remember
> having seen this same error before.  Fix it once and for all for MinGW.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   include/qemu/osdep.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 4f8559e550..0c1e335a43 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -122,6 +122,18 @@ extern int daemon(int, int);
>   #include "glib-compat.h"
>   #include "qemu/typedefs.h"
>   
> +/*
> + * For mingw, as of v6.0.0, the function implementing the assert macro is
> + * not marked a noreturn, so the compiler cannot delete code following an
> + * assert(false) as unused.  We rely on this within the code base to delete
> + * code that is unreachable when features are disabled.
> + * All supported versions of Glib's g_assert() satisfy this requirement.
> + */
> +#ifdef __MINGW32__
> +#undef assert
> +#define assert(x)  g_assert(x)
> +#endif
> +
>   /*
>    * According to waitpid man page:
>    * WCOREDUMP
> 
