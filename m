Received: from eggs.gnu.org ([2001:4830:134:3::10]:42590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1df2w6-00046W-0A
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1df2w2-0000hW-1z
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:44:34 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:37165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1df2w1-0000h5-Rz
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:44:29 -0400
Received: by mail-ua0-x243.google.com with SMTP id 80so1896368uas.4
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 04:44:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1502189042-9676-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a3e33242-068c-a121-ffa9-f96e6d467ff9@twiddle.net>
Date: Tue, 8 Aug 2017 04:44:25 -0700
MIME-Version: 1.0
In-Reply-To: <1502189042-9676-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] docs/devel/loads-stores.rst: Document our
 various load and store APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On 08/08/2017 03:44 AM, Peter Maydell wrote:
> QEMU has a wide selection of different functions for doing
> loads and stores; provide some overview documentation of
> what they do and how to pick which one to use.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is currently a work in progress, with many TODO points.
> Some of the formatting is a bit inconsistent from section to
> section. I post it to see if people think it's a useful
> document to have and to try to get some answers to the TODO
> points which are "I don't know why this function exists" and
> "when should we use this function rather than that other one"...
> 
>  docs/devel/loads-stores.rst | 365 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 365 insertions(+)
>  create mode 100644 docs/devel/loads-stores.rst
> 
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> new file mode 100644
> index 0000000..73ae4c8
> --- /dev/null
> +++ b/docs/devel/loads-stores.rst
> @@ -0,0 +1,365 @@
> +..
> +   Copyright (c) 2017 Linaro Limited
> +   Written by Peter Maydell
> +   TODO: do we have a standard doc license? bitmaps.rst
> +   uses the FreeBSD documentation license, I notice.
> +
> +===================
> +Load and Store APIs
> +===================
> +
> +QEMU internally has multiple families of functions for performing
> +loads and stores. This document attempts to enumerate them all
> +and indicate when to use them. It does not provide detailed
> +documentation of each API -- for that you should look at the
> +documentation comments in the relevant header files.
> +
> +
> +``ld*_p and st_*p``
> +~~~~~~~~~~~~~~~~~~~
> +
> +These functions operate on a host pointer, and should be used
> +when you already have a pointer into host memory (corresponding
> +to guest ram or a local buffer). They deal with doing accesses
> +with the desired endianness and with correctly handling
> +potentially unaligned pointer values.
> +
> +Function names follow the pattern:
> +
> +load: ``ld{type}{sign}{size}_{endian}_p(ptr)``
> +
> +store: ``st{type}{size}_{endian}_p(ptr, val)``
> +
> +``type``
> + - (empty) : integer access
> + - ``f`` : float access
> +
> +``sign``
> + - (empty) : for 32 or 64 bit sizes (including floats and doubles)
> + - ``u`` : unsigned
> + - ``s`` : signed
> +
> +``size``
> + - ``b`` : 8 bits
> + - ``w`` : 16 bits
> + - ``l`` : 32 bits
> + - ``q`` : 64 bits
> +
> +``endian``
> + - ``he`` : host endian
> + - ``be`` : big endian
> + - ``le`` : little endian
> +
> +(except for byte accesses, which have no endian infix).
> +
> +The ``_{endian}`` infix is omitted for target-endian accesses.
> +
> +The target endian accessors are only available to source
> +files which are built per-target.
> +
> +Regexes for git grep
> + - ``\<ldf\?[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
> + - ``\<stf\?[bwlq]\(_[hbl]e\)\?_p\>``
> +
> +``cpu_{ld,st}_*``
> +~~~~~~~~~~~~~~~~~
> +
> +These functions operate on a guest virtual address. Be aware
> +that these functions may cause a guest CPU exception to be
> +taken (eg for an alignment fault or MMU fault) which will
> +result in guest CPU state being updated and control longjumping
> +out of the function call. They should therefore only be used
> +in code that is implementing emulation of the target CPU.
> +
> +Function names follow the pattern:
> +
> +load: ``cpu_ld{sign}{size}_{mmusuffix}(env, ptr)``
> +
> +store: ``cpu_st{size}_{mmusuffix}(env, ptr, val)``
> +
> +``sign``
> + - (empty) : for 32 or 64 bit sizes
> + - ``u`` : unsigned
> + - ``s`` : signed
> +
> +``size``
> + - ``b`` : 8 bits
> + - ``w`` : 16 bits
> + - ``l`` : 32 bits
> + - ``q`` : 64 bits
> +
> +``mmusuffix`` is one of the generic suffixes ``data`` or ``code``, or
> +(for softmmu configs) a target-specific MMU mode suffix as defined
> +in the target's ``cpu.h``.

On memory faults, these functions will not do any unwinding.  So the cpu state
most have been saved by the translator before calling a helper that uses these.


> +
> +Regexes for git grep
> + - ``\<cpu_ld[us]\?[bwlq]_[a-zA-Z0-9]\+\>``
> + - ``\<cpu_st[bwlq]_[a-zA-Z0-9]\+\>``
> +
> +``cpu_{ld,st}_*_ra``
> +~~~~~~~~~~~~~~~~~~~~
> +
> +Thes functions work like the ``cpu_{ld,st}_*`` functions except
> +that they also take a ``retaddr`` argument.
> +
> +**TODO**: when should these be used and what should ``retaddr`` be?

retaddr should be GETPC() called directly from a HELPER(foo), so that it
computes the return address into code_gen_buffer.  retaddr will be used to
unwind the cpu state, and so the translator need not have done any extra saving
before calling the helper.

I would say that these functions should preferentially be used with all new code.


> +
> +Function names follow the pattern:
> +
> +load: ``cpu_ld{sign}{size}_{mmusuffix}_ra(env, ptr, retaddr)``
> +
> +store: ``cpu_st{sign}{size}_{mmusuffix}_ra(env, ptr, val, retaddr)``
> +
> +Regexes for git grep
> + - ``\<cpu_ld[us]\?[bwlq]_[a-zA-Z0-9]\+_ra\>``
> + - ``\<cpu_st[bwlq]_[a-zA-Z0-9]\+_ra\>``
> +
> +``helper_*_{ld,st}*mmu``
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +These functions are intended primarily to be called by the code
> +generated by the TCG backend. They may also be called by target
> +CPU helper function code. (XXX why, and when this vs cpu_{ld,st}_* ?)

Because cpu_{ld,st}_* infer a mmu_idx from the name + cpu_mmu_index, whereas
these functions take it as a parameter.

> +
> +**TODO** tcg.h claims the target-endian helper_ret* are temporary and
> +will go away?

Heh.  Yes.  Except that the usage within the target front-end helpers got in
the way.  The tcg backends were all converted to explicit endianness, but the
front ends did want a convenient target-endian name.  I suppose we could rename
"ret" to "te" or something, or just remove the comment...

> +
> +**TODO** why is "target endian" "ret" anyway?

"ret" was added simply to indicate that these functions take a "retaddr", as
opposed to the oldest iteration of these functions that did not.  It was the
third iteration that added "le"/"be".


r~
