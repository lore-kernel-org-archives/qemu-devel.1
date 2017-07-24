Received: from eggs.gnu.org ([2001:4830:134:3::10]:44149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZlRP-0004bw-Mz
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZlRO-0000wS-HG
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:03:03 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <DM2PR21MB0060EFC1F6B9F0883A1792369EBB0@DM2PR21MB0060.namprd21.prod.outlook.com>
	<20170724212327.GA24963@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fda73f35-098f-c190-4d15-4363e28872f1@twiddle.net>
Date: Mon, 24 Jul 2017 15:02:53 -0700
MIME-Version: 1.0
In-Reply-To: <20170724212327.GA24963@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Torn read/write possible on aarch64/x86-64 MTTCG?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Andrey Shedel <ashedel@microsoft.com>, =?UTF-8?Q?Alex_Benn=ef=bf=bde?= <alex.bennee@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>

On 07/24/2017 02:23 PM, Emilio G. Cota wrote:
> (Adding some Cc's)
> 
> On Mon, Jul 24, 2017 at 19:05:33 +0000, Andrew Baumann via Qemu-devel wrote:
>> Hi all,
>>
>> I'm trying to track down what appears to be a translation bug in either
>> the aarch64 target or x86_64 TCG (in multithreaded mode). The symptoms

I assume this is really x86_64 and not i686 as host.

>> are entirely consistent with a torn read/write -- that is, a 64-bit
>> load or store that was translated to two 32-bit loads and stores --
>> but that's obviously not what happens in the common path through the
>> translation for this code, so I'm wondering: are there any cases in
>> which qemu will split a 64-bit memory access into two 32-bit accesses?
> 
> That would be a bug in MTTCG.
> 
>> The code: Guest CPU A writes a 64-bit value to an aligned memory
>> location that was previously 0, using a regular store; e.g.:
>> 	f9000034 str	     x20,[x1]
>>
>> Guest CPU B (who is busy-waiting) reads a value from the same location:
>> 	f9400280 ldr	     x0,[x20]
>>
>> The symptom: CPU B loads a value that is neither NULL nor the value
>> written. Instead, x0 gets only the low 32-bits of the value written
>> (high bits are all zero). By the time this value is dereferenced (a
>> few instructions later) and the exception handlers run, the memory
>> location from which it was loaded has the correct 64-bit value with
>> a non-zero upper half.
>>
>> Obviously on a real ARM memory barriers are critical, and indeed
>> the code has such barriers in it, but I'm assuming that any possible
>> mistranslation of the barriers is irrelevant because for a 64-bit load
>> and a 64-bit store you should get all or nothing. Other clues that may
>> be relevant: the code is _near_ a LDREX/STREX pair (the busy-waiting
>> is used to resolve a race when updating another variable), and the
>> busy-wait loop has a yield instruction in it (although those appear
>> to be no-ops with MTTCG).
> 
> This might have to do with how ldrex/strex is emulated; are you relying
> on the exclusive pair detecting ABA? If so, your code won't work in
> QEMU since it uses cmpxchg to emulate ldrex/strex.

ABA problem is nothing to do with tearing.  And cmpxchg will definitely not 
create tearing problems.

I don't know how we would manage 64-bit tearing on a 64-bit host, at least for 
the aarch64 guest, for which I believe we have a good emulation.

> - Pin the QEMU-MTTCG process to a single CPU. Can you repro then?

A good suggestion.

> - Force the emulation of cmpxchg via EXCP_ATOMIC with:
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 87f673e..771effe5 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -2856,7 +2856,7 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
>           }
>           tcg_temp_free_i64(t1);
>       } else if ((memop & MO_SIZE) == MO_64) {
> -#ifdef CONFIG_ATOMIC64
> +#if 0

I suspect this will simply alter the timing.  However, give it a go by all means.

If there's a test case that you can share, that would be awesome.

Especially if you can prod it to happen with a standalone minimal binary.  With 
luck you can reproduce via aarch64-linux-user too, and simply signal an error 
via branch to __builtin_trap.


r~
