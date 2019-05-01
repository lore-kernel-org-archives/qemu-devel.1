Received: from eggs.gnu.org ([209.51.188.92]:56647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLqgL-000187-JO
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLqgH-0007yE-RF
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:58:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLqgH-0007xM-LX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:57:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id h4so24868678wre.7
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:57:56 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-4-alex.bennee@linaro.org>
	<83e4f91b-a590-2a2a-bf5f-14b99c5aa0fc@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <83e4f91b-a590-2a2a-bf5f-14b99c5aa0fc@linaro.org>
Date: Wed, 01 May 2019 15:57:53 +0100
Message-ID: <871s1i6x3i.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/30/19 9:52 AM, Alex Benn=C3=A9e wrote:
>> +.error:
>> +	.string "Terminated by exception.\n"
>
> Put it in .rodata just because we can?

Sure.

>
>> +        /* Page table setup (identity mapping).  */
>> +	adrp	x0, ttb
>> +	add	x0, x0, :lo12:ttb
>
> You are in control of the layout of the executable,
> and adr has a 1MB range.  Why use adrp+add?

Ok.

>
>> +        /* Create some (big) pages */
>> +	adr	x1, .				/* phys address */
>> +	bic	x1, x1, #(1 << 30) - 1		/* 1GB block alignment */
>
> Do you really want 1GB pages?  You'll pretty much only be able to test va=
lid
> memory operations with that.  Which is also true until there's something =
other
> than an exit for the exception vector... but ya know what I mean.

Yeah we can do better here. I mainly went with what libgloss had setup
because I was finding it hard to get find a nice summary of the various
page table formats. I want big enough that I don't have to futz around
create multiple page entries and ideally have some fault-able regions as
well.


>
>> +        /* Setup some stack space and enter the test code.
>> +         * Assume everthing except the return value is garbage when we
>> +	 * return, we won't need it.
>> +         */
>> +	adrp	x0, stack
>> +	add	x0, x0, :lo12:stack
>> +        mov      sp, x0
>
> You need a pointer to the end of the stack, not the beginning.
> Again, I think this could be just
>
> 	adr	sp, stack_end

lol, I guess the page table was being crapped over....

>
> Also, there's tab/space confusion all through this file.
> IMO, this is assembly, so it *should* be tabs.

That will probably be my editor getting confused because .S implies cpp

>
>> @@ -0,0 +1,22 @@
>> +ENTRY(__start)
>> +
>> +SECTIONS
>> +{
>> +    /* virt machine, RAM starts at 1gb */
>> +    . =3D (1 << 30);
>> +    .text : {
>> +        *(.text)
>> +    }
>> +    .data : {
>> +        *(.data)
>> +    }
>> +    .rodata : {
>> +        *(.rodata)
>> +    }
>
> If you ever wanted to make this read-only, swap .rodata before .data, so =
that
> it's next to .text.

OK

>
>
> r~


--
Alex Benn=C3=A9e
