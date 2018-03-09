Received: from eggs.gnu.org ([2001:4830:134:3::10]:50043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euGCT-0001bs-FI
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euGCQ-0003yZ-B3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:28:37 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:56303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euGCQ-0003yC-4W
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:28:34 -0500
Received: by mail-wm0-x242.google.com with SMTP id q83so3293941wme.5
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 03:28:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180309110152.16109-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1b247bd6-9d14-ff31-c406-3c9bf081faef@amsat.org>
Date: Fri, 9 Mar 2018 12:28:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180309110152.16109-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] build: try improve handling of clang
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 03/09/2018 12:01 PM, Gerd Hoffmann wrote:
> This patch disables the pragma diagnostic -Wunused-but-set-variable for
> clang in util/coroutine-ucontext.c.
> 
> This in turn allows us to remove it from the configure check, so the
> CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE will succeed for clang.
> 
> With that in place clang builds (linux) will use -Werror by default,
> which breaks the build due to warning about unaligned struct members.
> 
> Given that our structs are often dictated by the hardware qemu emulates
> and the file formats we use this can't be fixed easily, so I think it is
> reasonaable to turn off this warning.  Do so by adding

reasonable

> -Wno-address-of-packed-member to our list of warning flags.
> 
> Now clang builds qemu without warnings.  Well, almost.  There are some
> left in the rdma code.  Leaving that to the rdma people.  All others can
> use --disable-rdma to workarounds this.
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

This looks the clever way to fix this.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  configure                 | 2 +-
>  util/coroutine-ucontext.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 6f3921c02a..5e4310b910 100755
> --- a/configure
> +++ b/configure
> @@ -1692,6 +1692,7 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
>  gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>  gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
>  gcc_flags="-Wno-string-plus-int $gcc_flags"
> +gcc_flags="-Wno-address-of-packed-member $gcc_flags"
>  # Note that we do not add -Werror to gcc_flags here, because that would
>  # enable it for all configure tests. If a configure test failed due
>  # to -Werror this would just silently disable some features,
> @@ -4860,7 +4861,6 @@ fi
>  pragma_disable_unused_but_set=no
>  cat > $TMPC << EOF
>  #pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
>  #pragma GCC diagnostic ignored "-Wstrict-prototypes"
>  #pragma GCC diagnostic pop
>  
> diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
> index 926d3402e3..090ba21a13 100644
> --- a/util/coroutine-ucontext.c
> +++ b/util/coroutine-ucontext.c
> @@ -170,7 +170,7 @@ Coroutine *qemu_coroutine_new(void)
>  }
>  
>  #ifdef CONFIG_VALGRIND_H
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
>  /* Work around an unused variable in the valgrind.h macro... */
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wunused-but-set-variable"
> @@ -179,7 +179,7 @@ static inline void valgrind_stack_deregister(CoroutineUContext *co)
>  {
>      VALGRIND_STACK_DEREGISTER(co->valgrind_stack_id);
>  }
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
>  #pragma GCC diagnostic pop
>  #endif
>  #endif
> 
