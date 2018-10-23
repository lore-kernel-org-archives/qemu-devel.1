Received: from eggs.gnu.org ([2001:4830:134:3::10]:35063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEuSV-0000nO-D9
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gEuSR-0000Il-DB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:02:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gEuSR-0000Gb-67
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:02:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id d2-v6so1188316wro.7
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:02:43 -0700 (PDT)
References: <20181023070253.6407-1-richard.henderson@linaro.org>
	<20181023070253.6407-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2c94b099-ea22-43b5-e8e1-4c858c69bf26@redhat.com>
Date: Tue, 23 Oct 2018 13:02:40 +0200
MIME-Version: 1.0
In-Reply-To: <20181023070253.6407-3-richard.henderson@linaro.org>
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
Cc: cota@braap.org

On 23/10/18 9:02, Richard Henderson wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
