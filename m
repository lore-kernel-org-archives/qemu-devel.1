Received: from eggs.gnu.org ([2001:4830:134:3::10]:51409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euGGa-0004XC-MQ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euGGZ-0005rf-KK
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:32:52 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:37468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euGGZ-0005rW-Ee
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:32:51 -0500
Received: by mail-oi0-x22e.google.com with SMTP id f186so6730618oig.4
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 03:32:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180309110152.16109-1-kraxel@redhat.com>
References: <20180309110152.16109-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 11:32:30 +0000
Message-ID: <CAFEAcA8e43LTexse9Dq_V-d-4zb5YeT6hUQ8xH1YZ-fCWL0qTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>

On 9 March 2018 at 11:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
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
> -Wno-address-of-packed-member to our list of warning flags.

I disagree with this part. Everywhere we do this is at least
plausibly a bug, and we should fix the bugs. Taking addresses of
members in packed structs and then passing them to functions will
break on some architectures, because it drops the information that
the field is not at an aligned address.

(In general this is one reason why I prefer to avoid the coding
pattern of trying to reflect hardware or in-memory guest data
structures with host C struct layout. It may happen to work on
x86 but it's not reliably portable.)

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

Should we have configure test for the availability of this
diagnostic rather than assuming that clang never has it and never will?

>  #pragma GCC diagnostic pop
>  #endif
>  #endif
> --
> 2.9.3

thanks
-- PMM
