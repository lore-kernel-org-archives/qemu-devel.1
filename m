Received: from eggs.gnu.org ([2001:4830:134:3::10]:54484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDTOG-0002c0-9f
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDTOF-0004en-Bx
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:56:28 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:47033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDTOD-0004OQ-1I
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:56:27 -0400
Received: by mail-oi1-x242.google.com with SMTP id k64-v6so26553116oia.13
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 04:56:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181018221028.GB85911@humpty.home.comstyle.com>
References: <20181018221028.GB85911@humpty.home.comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 12:55:54 +0100
Message-ID: <CAFEAcA_MMUS=-Pf7+EcWnLFn=izyOYtuC7g5zGsjyDjvcw1+1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 October 2018 at 23:10, Brad Smith <brad@comstyle.com> wrote:
> Use MAP_STACK in qemu_alloc_stack() on OpenBSD.
>
> Added to -current and will be in our soon to be 6.4 release.
>
> MAP_STACK      Indicate that the mapping is used as a stack.  This
>                flag must be used in combination with MAP_ANON and
>                MAP_PRIVATE.
>
> Implement MAP_STACK option for mmap().  Synchronous faults (pagefault and
> syscall) confirm the stack register points at MAP_STACK memory, otherwise
> SIGSEGV is delivered. sigaltstack() and pthread_attr_setstack() are modified
> to create a MAP_STACK sub-region which satisfies alignment requirements.
> Observe that MAP_STACK can only be set/cleared by mmap(), which zeroes the
> contents of the region -- there is no mprotect() equivalent operation, so
> there is no MAP_STACK-adding gadget.
>
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
>
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index fbd0dc8c57..7814e61114 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -596,6 +596,7 @@ pid_t qemu_fork(Error **errp)
>  void *qemu_alloc_stack(size_t *sz)
>  {
>      void *ptr, *guardpage;
> +    int flags;
>  #ifdef CONFIG_DEBUG_STACK_USAGE
>      void *ptr2;
>  #endif
> @@ -610,8 +611,15 @@ void *qemu_alloc_stack(size_t *sz)
>      /* allocate one extra page for the guard page */
>      *sz += pagesz;
>
> -    ptr = mmap(NULL, *sz, PROT_READ | PROT_WRITE,
> -               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    flags = MAP_PRIVATE | MAP_ANONYMOUS;
> +#if defined(MAP_STACK) && defined(__OpenBSD__)
> +    /* Only enable MAP_STACK on OpenBSD. Other OS's such
> +       as Linux/FreeBSD/NetBSD have a flag with the same
> +       name but have differing functionality. */
> +    flags |= MAP_STACK;
> +#endif

I think it would be useful to also add "OpenBSD will SEGV
if it spots execution with a stack pointer pointing at
memory that was not allocated with MAP_STACK." (summarising
what the interesting bit of OpenBSD behaviour is here to save
having to go back and read the commit message in future).

Also our multiline comment format is linux-kernel style
 /*
  * line 1
  * line 2
  */
(as noted in CODING_STYLE).

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
