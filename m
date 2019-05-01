Received: from eggs.gnu.org ([209.51.188.92]:52547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqMJ-000893-1z
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqMF-0002mw-W3
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:37:18 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqMF-0002mU-Oz
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:37:15 -0400
Received: by mail-pg1-x542.google.com with SMTP id t22so5369733pgi.10
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:37:15 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <83e4f91b-a590-2a2a-bf5f-14b99c5aa0fc@linaro.org>
Date: Wed, 1 May 2019 07:37:11 -0700
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 03/15] tests/tcg/aarch64: add system
 boot.S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org

On 4/30/19 9:52 AM, Alex Bennée wrote:
> +.error:
> +	.string "Terminated by exception.\n"

Put it in .rodata just because we can?

> +        /* Page table setup (identity mapping).  */
> +	adrp	x0, ttb
> +	add	x0, x0, :lo12:ttb

You are in control of the layout of the executable,
and adr has a 1MB range.  Why use adrp+add?

> +        /* Create some (big) pages */
> +	adr	x1, .				/* phys address */
> +	bic	x1, x1, #(1 << 30) - 1		/* 1GB block alignment */

Do you really want 1GB pages?  You'll pretty much only be able to test valid
memory operations with that.  Which is also true until there's something other
than an exit for the exception vector... but ya know what I mean.

> +        /* Setup some stack space and enter the test code.
> +         * Assume everthing except the return value is garbage when we
> +	 * return, we won't need it.
> +         */
> +	adrp	x0, stack
> +	add	x0, x0, :lo12:stack
> +        mov      sp, x0

You need a pointer to the end of the stack, not the beginning.
Again, I think this could be just

	adr	sp, stack_end

Also, there's tab/space confusion all through this file.
IMO, this is assembly, so it *should* be tabs.

> @@ -0,0 +1,22 @@
> +ENTRY(__start)
> +
> +SECTIONS
> +{
> +    /* virt machine, RAM starts at 1gb */
> +    . = (1 << 30);
> +    .text : {
> +        *(.text)
> +    }
> +    .data : {
> +        *(.data)
> +    }
> +    .rodata : {
> +        *(.rodata)
> +    }

If you ever wanted to make this read-only, swap .rodata before .data, so that
it's next to .text.


r~
