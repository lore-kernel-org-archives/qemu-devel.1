Received: from eggs.gnu.org ([2001:4830:134:3::10]:59514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWZNa-0004lF-9E
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 22:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWZNV-00048H-CG
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 22:33:54 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWZNV-00047u-5n
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 22:33:49 -0400
Received: by mail-pf0-x241.google.com with SMTP id e199so15512194pfh.0
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 19:33:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-10-rth@twiddle.net>
	<20170715225934.lap5cnukiyotqrqs@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <00736ea7-4c08-2f01-3271-1a669110a4a9@twiddle.net>
Date: Sat, 15 Jul 2017 16:33:44 -1000
MIME-Version: 1.0
In-Reply-To: <20170715225934.lap5cnukiyotqrqs@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/27] linux-user/sh4: Clean env->flags
 on signal boundaries
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

On 07/15/2017 12:59 PM, Aurelien Jarno wrote:
> On 2017-07-06 16:20, Richard Henderson wrote:
>> If a signal is delivered during the execution of a delay slot,
>> or a gUSA region, clear those bits from the environment so that
>> the signal handler does not start in that same state.
> 
> How are signals delivered in linux-user? At least in system mode we
> forbid interrupts in the delay slot (see commit 5c6f3eb7db), as the
> manual clearly declare them as indivisible. Maybe the same should be
> done for linux-user?

Signals get queued, and delivered eventually.  I don't believe that we do 
anything to check that "signals can't be delivered yet" like we do in system mode.

>> +    regs->flags &= ~(DELAY_SLOT_MASK | GUSA_MASK);
>>   }
>>   
>>   static void setup_frame(int sig, struct target_sigaction *ka,
> 
> Why not using TB_FLAG_ENVFLAGS_MASK introduced earlier in this patch
> series?

I really want to clear these two sets.  I didn't want to assume that 
ENVFLAGS_MASK would never contain anything else.


r~
