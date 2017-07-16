Received: from eggs.gnu.org ([2001:4830:134:3::10]:59397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWZL1-00042B-1j
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 22:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWZKw-0002T4-3j
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 22:31:15 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWZKv-0002ST-SQ
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 22:31:10 -0400
Received: by mail-pg0-x244.google.com with SMTP id y129so15195449pgy.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 19:31:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-7-rth@twiddle.net>
	<20170715221412.3yprwf5i3te4gdxa@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <65cb9165-42a1-9648-7519-0bd893c1ac13@twiddle.net>
Date: Sat, 15 Jul 2017 16:30:59 -1000
MIME-Version: 1.0
In-Reply-To: <20170715221412.3yprwf5i3te4gdxa@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/27] target/sh4: Handle user-space
 atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 07/15/2017 12:14 PM, Aurelien Jarno wrote:
> On 2017-07-06 16:20, Richard Henderson wrote:
>> For uniprocessors, SH4 uses optimistic restartable atomic sequences.
>> Upon an interrupt, a real kernel would simply notice magic values in
>> the registers and reset the PC to the start of the sequence.
>>
>> For QEMU, we cannot do this in quite the same way.  Instead, we notice
>> the normal start of such a sequence (mov #-x,r15), and start a new TB
>> that can be executed under cpu_exec_step_atomic.
> 
> Do you have actually have a good documentation about gUSA? I have found
> a few documents (some of them in Japanese), the most complete one being
> the LinuxTag paper. The ABI is also described in the kernel and the
> glibc. That said I am missing the following informations:

Kernel sources and glibc are good.  The description in GCC is pretty good as well:

https://gcc.gnu.org/viewcvs/gcc/trunk/gcc/config/sh/sync.md?revision=243994&view=markup#l53

> - What kind of instructions are allowed in the atomic sequence? Your
>    patch takes into account branches, but are there allowed? used in
>    practice? What about FP instructions?

Any sequence that can be restarted.

> - Does the atomic sequence is actually allowed to cross pages?

I don't see why not.  It would be restarted on a page fault, but assuming that 
a process can have 2 pages in ram doesn't seem onerous.

> - Is there any alignement required? The paper mention adding a nop to
>    gUSA_exchange_and_add to align the end point to 4 bytes.

That's about the mov.l instruction that computes the address.


> This looks fine. I guess this can be improved in a another patch by
> changing the caller to pass a single target address and if the condition
> is true or false. This would avoid having to detect that here, and would
> not make the code below more complicated.

Sure.

>> +    if (ctx->tbflags & GUSA_EXCLUSIVE) {
>> +        /* Regardless of single-stepping or the end of the page,
>> +           we must complete execution of the gUSA region while
>> +           holding the exclusive lock.  */
>> +        *pmax_insns = max_insns;
>> +        return 0;
>>       }
> 
> What are the consequence of not stopping the translation when crossing
> the page in user mode? If it doesn't have any, we should probably change
> the code to never stop when crossing pages.

The only consequence is recognizing a segv "too early".  It's a quirk that, 
frankly, I'm willing to accept.

>> +    if (ctx.tbflags & GUSA_EXCLUSIVE) {
>> +        /* Ending the region of exclusivity.  Clear the bits.  */
>> +        ctx.envflags &= ~GUSA_MASK;
>> +    }
>> +
> 
> IIUC this assumes the number of instructions in the sequence is always
> executed. I guess this is not correct if the TCG op buffer is full. Some
> non-privileged instructions might also stop the translation, but they
> are all FPU instructions, so I guess the section is simply not valid in
> that case.

The TCG op buffer is always empty when we begin the sequence.  Since we're 
limited to 128 bytes, or 64 instructions, I'm not concerned about running out. 
I attempt to make sure that all of the paths out -- like exceptions and 
branches -- that don't do what we want have GUSA state zapped.

At which point ya gets what ya gets.  Not atomic, but not really wrong either.


r~
