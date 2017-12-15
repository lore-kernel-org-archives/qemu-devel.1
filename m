Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuRQ-0006d3-0q
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuRK-0004g4-OX
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:10:35 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuRK-0004fD-If
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:10:30 -0500
Received: by mail-qt0-x242.google.com with SMTP id u42so13116638qte.7
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:10:30 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-13-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fe178322-dd76-9e2d-0f27-cc03fb45263f@amsat.org>
Date: Fri, 15 Dec 2017 15:10:26 -0300
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/13] ucontext: annotate coroutine
 stack for ASAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 12/15/2017 12:06 PM, Marc-André Lureau wrote:
> It helps ASAN to detect more leaks on coroutine stacks, as found in
> the following patch.

Nice!

> A similar work would need to be done for sigaltstack & windows fibers
> to have similar coverage. Since ucontext is prefered, I didn't bother
> checking the other coroutine implementations for now.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/qemu/compiler.h   |  4 ++++
>  util/coroutine-ucontext.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 340e5fdc09..5fcc4f7ec7 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -111,4 +111,8 @@
>  #define GCC_FMT_ATTR(n, m)
>  #endif
>  
> +#ifndef __has_feature
> +#define __has_feature(x) 0 /* compatibility with non-clang compilers */
> +#endif
> +
>  #endif /* COMPILER_H */
> diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
> index 6621f3f692..e78eae8766 100644
> --- a/util/coroutine-ucontext.c
> +++ b/util/coroutine-ucontext.c
> @@ -31,6 +31,11 @@
>  #include <valgrind/valgrind.h>
>  #endif
>  
> +#if defined(__SANITIZE_ADDRESS__) || __has_feature(address_sanitizer)
> +#define CONFIG_ASAN 1
> +#include <sanitizer/asan_interface.h>
> +#endif
> +
>  typedef struct {
>      Coroutine base;
>      void *stack;
> @@ -59,11 +64,37 @@ union cc_arg {
>      int i[2];
>  };
>  
> +static void finish_switch_fiber(void *fake_stack_save)
> +{
> +#ifdef CONFIG_ASAN
> +    const void *bottom_old;
> +    size_t size_old;
> +
> +    __sanitizer_finish_switch_fiber(fake_stack_save, &bottom_old, &size_old);
> +
> +    if (!leader.stack) {
> +        leader.stack = (void *)bottom_old;
> +        leader.stack_size = size_old;
> +    }
> +#endif
> +}
> +
> +static void start_switch_fiber(void **fake_stack_save,
> +                               const void *bottom, size_t size)
> +{
> +#ifdef CONFIG_ASAN
> +    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
> +#endif
> +}
> +
>  static void coroutine_trampoline(int i0, int i1)
>  {
>      union cc_arg arg;
>      CoroutineUContext *self;
>      Coroutine *co;
> +    void *fake_stack_save = NULL;
> +
> +    finish_switch_fiber(NULL);
>  
>      arg.i[0] = i0;
>      arg.i[1] = i1;
> @@ -72,9 +103,13 @@ static void coroutine_trampoline(int i0, int i1)
>  
>      /* Initialize longjmp environment and switch back the caller */
>      if (!sigsetjmp(self->env, 0)) {
> +        start_switch_fiber(&fake_stack_save,
> +                           leader.stack, leader.stack_size);
>          siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
>      }
>  
> +    finish_switch_fiber(fake_stack_save);
> +
>      while (true) {
>          co->entry(co->entry_arg);
>          qemu_coroutine_switch(co, co->caller, COROUTINE_TERMINATE);
> @@ -87,6 +122,7 @@ Coroutine *qemu_coroutine_new(void)
>      ucontext_t old_uc, uc;
>      sigjmp_buf old_env;
>      union cc_arg arg = {0};
> +    void *fake_stack_save = NULL;
>  
>      /* The ucontext functions preserve signal masks which incurs a
>       * system call overhead.  sigsetjmp(buf, 0)/siglongjmp() does not
> @@ -122,8 +158,12 @@ Coroutine *qemu_coroutine_new(void)
>  
>      /* swapcontext() in, siglongjmp() back out */
>      if (!sigsetjmp(old_env, 0)) {
> +        start_switch_fiber(&fake_stack_save, co->stack, co->stack_size);
>          swapcontext(&old_uc, &uc);
>      }
> +
> +    finish_switch_fiber(fake_stack_save);
> +
>      return &co->base;
>  }
>  
> @@ -169,13 +209,19 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
>      CoroutineUContext *from = DO_UPCAST(CoroutineUContext, base, from_);
>      CoroutineUContext *to = DO_UPCAST(CoroutineUContext, base, to_);
>      int ret;
> +    void *fake_stack_save = NULL;
>  
>      current = to_;
>  
>      ret = sigsetjmp(from->env, 0);
>      if (ret == 0) {
> +        start_switch_fiber(action == COROUTINE_TERMINATE ?
> +                           NULL : &fake_stack_save, to->stack, to->stack_size);
>          siglongjmp(to->env, action);
>      }
> +
> +    finish_switch_fiber(fake_stack_save);
> +
>      return ret;
>  }
>  
> 
