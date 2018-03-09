Received: from eggs.gnu.org ([2001:4830:134:3::10]:52709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euKD3-0005gr-MW
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euKD0-0004Ev-DR
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:45:29 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euKCz-0004EN-SG
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:45:26 -0500
Received: by mail-wm0-x242.google.com with SMTP id 139so4708900wmn.2
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 07:45:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180309135945.20436-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7de78a92-4f42-3287-e2ff-895f804e2f37@amsat.org>
Date: Fri, 9 Mar 2018 16:45:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180309135945.20436-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] build: try improve handling of clang
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 03/09/2018 02:59 PM, Gerd Hoffmann wrote:
> This patch disables the pragma diagnostic -Wunused-but-set-variable for
> clang in util/coroutine-ucontext.c.
> 
> This in turn allows us to remove it from the configure check, so the
> CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE will succeed for clang.
> 
> With that in place clang builds (linux) will use -Werror by default,
> which breaks the build due to warning about unaligned struct members.
> 
> Just turning off this warning isn't a good idea as it indicates
> portability problems.  So make it a warning again, using
> -Wno-error=address-of-packed-member.  That way it doesn't break the
> build but still shows up in the logs.
> 
> Now clang builds qemu without errors.  Well, almost.  There are some
> left in the rdma code.  Leaving that to the rdma people.  All others can
> use --disable-rdma to workarounds this.
> 
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  configure                 | 2 +-
>  util/coroutine-ucontext.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index 6f3921c02a..3a12173c83 100755
> --- a/configure
> +++ b/configure
> @@ -1692,6 +1692,7 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
>  gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>  gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
>  gcc_flags="-Wno-string-plus-int $gcc_flags"
> +gcc_flags="-Wno-error=address-of-packed-member $gcc_flags"
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
