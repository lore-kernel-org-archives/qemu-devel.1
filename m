Received: from eggs.gnu.org ([2001:4830:134:3::10]:45826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXaAt-00084Q-6M
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXaAp-0003N4-VL
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:36:59 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXaAp-0003Mv-Pf
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:36:55 -0400
Received: by mail-qk0-x243.google.com with SMTP id d136so4037182qkg.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 14:36:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170718200255.31647-1-rth@twiddle.net>
	<20170718200255.31647-2-rth@twiddle.net>
	<20170718201906.grxwco4ztzgzalzb@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <910e6a15-e2ac-e473-f2f5-2070e604f80e@twiddle.net>
Date: Tue, 18 Jul 2017 11:36:48 -1000
MIME-Version: 1.0
In-Reply-To: <20170718201906.grxwco4ztzgzalzb@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/30] target/sh4: Use cmpxchg for movco
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

On 07/18/2017 10:19 AM, Aurelien Jarno wrote:
> On 2017-07-18 10:02, Richard Henderson wrote:
>> As for other targets, cmpxchg isn't quite right for ll/sc,
>> suffering from an ABA race, but is sufficient to implement
>> portable atomic operations.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>>
>> ---
>> V2: Clear lock_addr in rte, do_interrupt, syscall entry, & signal delivery.
>>      Fix movli to tollerate overlap between R0 and REG(B11_8).
>> ---
>>   target/sh4/cpu.h       |  3 ++-
>>   linux-user/main.c      |  1 +
>>   linux-user/signal.c    |  2 ++
>>   target/sh4/helper.c    |  2 +-
>>   target/sh4/translate.c | 72 +++++++++++++++++++++++++++++---------------------
>>   5 files changed, 48 insertions(+), 32 deletions(-)
> 
> I still believe that for the system case, we should implement the
> behaviour described in the manual, that is setting ldst to 1 in movli
> and clearing it in an interrupt. Otherwise the plainly silly following
> instruction sequence will give different results than on real silicon:
> 
>      movli.l   @r1,r0
>      add       #4, r1
>      movco.l   r0, @r1
> 
> Yes, this is plainly silly to use movli/movco to copy data, but we have
> also implemented silly behaviour for other CPUs. For the user case it's
> different, we don't have real choice, plus we know that it will be used
> to execute linux binaries, which are more likely to have a sane usage of
> atomic instructions.

Ok, I guess I didn't understand your last comment.
But now the "ifdeffing" portion of that makes sense.


r~
