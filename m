Received: from eggs.gnu.org ([2001:4830:134:3::10]:49542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dTPH1-0003HI-1i
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dTPGw-0006Eq-2C
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:10:02 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60577)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dTPGv-0006DJ-Je
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 05:09:57 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
	<0fbb03b7-d701-765a-6de8-54b6bb5ec1ec@vivier.eu>
Message-ID: <49fe3d18-3485-fb23-ea15-73a9aa85bd72@vivier.eu>
Date: Fri, 7 Jul 2017 11:09:39 +0200
MIME-Version: 1.0
In-Reply-To: <0fbb03b7-d701-765a-6de8-54b6bb5ec1ec@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/27] linux-user/sh4: Notice gUSA
 regions during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, bruno@clisp.org, glaubitz@debian.org

Le 07/07/2017 à 11:05, Laurent Vivier a écrit :
> Le 07/07/2017 à 04:20, Richard Henderson a écrit :
>> We translate gUSA regions atomically in a parallel context.
>> But in a serial context a gUSA region may be interrupted.
>> In that case, restart the region as the kernel would.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>  linux-user/signal.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>> index 3d18d1b..a537778 100644
>> --- a/linux-user/signal.c
>> +++ b/linux-user/signal.c
>> @@ -3471,6 +3471,25 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
>>      return (sp - frame_size) & -8ul;
>>  }
>>  
>> +/* Notice when we're in the middle of a gUSA region and reset.
>> +   Note that this will only occur for !parallel_cpus, as we will
>> +   translate such sequences differently in a parallel context.  */
>> +static void unwind_gusa(CPUSH4State *regs)
>> +{
>> +    /* If the stack pointer is sufficiently negative ... */
>> +    if ((regs->gregs[15] & 0xc0000000u) == 0xc0000000u
>> +        /* ... and we haven't completed the sequence ... */
>> +        && regs->pc < regs->gregs[0]) {
>> +        /* Reset the PC to before the gUSA region, as computed from
>> +           R0 = region end, SP = -(region size), plus one more insn
>> +           that actually sets SP to the region size.  */
>> +        regs->pc = regs->gregs[0] + regs->gregs[15] - 2;
>> +
>> +        /* Reset the SP to the saved version in R1.  */
>> +        regs->gregs[15] = regs->gregs[1];
>> +    }
>> +}
>> +
>>  static void setup_sigcontext(struct target_sigcontext *sc,
>>                               CPUSH4State *regs, unsigned long mask)
>>  {
>> @@ -3534,6 +3553,8 @@ static void setup_frame(int sig, struct target_sigaction *ka,
>>      abi_ulong frame_addr;
>>      int i;
>>  
>> +    unwind_gusa(regs);
>> +
>>      frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
> 
> I think unwind_gusa() should be moved after the get_sigfram() (in both
> cases), because r15  can be updated and the sigframe base lost.
> 

No, it's stupid, r15 is negative

Laurent
