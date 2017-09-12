Received: from eggs.gnu.org ([2001:4830:134:3::10]:52371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drsM7-00033U-K6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drsM4-0007ta-7C
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:04:27 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:37655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drsM4-0007tN-14
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:04:24 -0400
Received: by mail-wr0-f171.google.com with SMTP id k20so25082746wre.4
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 14:04:23 -0700 (PDT)
References: <20170911204936.5020-1-f4bug@amsat.org>
	<CAFEAcA_61iw+u7aMp+vA-CNpmAPjvJ_ynUfHu8Y+p8jmgvbcdw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4eddca72-c75e-0cbc-e07d-280c1cd0f095@redhat.com>
Date: Tue, 12 Sep 2017 23:04:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_61iw+u7aMp+vA-CNpmAPjvJ_ynUfHu8Y+p8jmgvbcdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/ppc: disable atomic write check on
 ppc32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 11/09/2017 23:37, Peter Maydell wrote:
> On 11 September 2017 at 21:49, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> this fixes building for ppc64 on ppc32 (changed in 5964fca8a12c):
>>
>>   qemu/tcg/ppc/tcg-target.inc.c: In function 'tb_target_set_jmp_target':
>>   qemu/include/qemu/compiler.h:86:30: error: static assertion failed: "not expecting: sizeof(*(uint64_t *)jmp_addr) > ATOMIC_REG_SIZE"
>>        QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
>>        ^
>>   qemu/tcg/ppc/tcg-target.inc.c:1377:9: note: in expansion of macro 'atomic_set'
>>            atomic_set((uint64_t *)jmp_addr, pair);
>>            ^
>>
>> Suggested-by: Richard Henderson <rth@twiddle.net>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> This fixes Shippable builds, see:
>> https://app.shippable.com/github/qemu/qemu/runs/434/10/console
>>
>>  tcg/ppc/tcg-target.inc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
>> index 21d764c102..0417901289 100644
>> --- a/tcg/ppc/tcg-target.inc.c
>> +++ b/tcg/ppc/tcg-target.inc.c
>> @@ -1374,7 +1374,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
>>          pair = (uint64_t)i2 << 32 | i1;
>>  #endif
>>
>> -        atomic_set((uint64_t *)jmp_addr, pair);
>> +        atomic_set__nocheck((uint64_t *)jmp_addr, pair);
>>          flush_icache_range(jmp_addr, jmp_addr + 8);
>>      } else {
>>          intptr_t diff = addr - jmp_addr;
> 
> Can you explain why this is the right thing? On the
> face of it it looks correct to insist that we don't
> try to do an atomic set of something that's bigger
> than the host can actually handle...

Probably because this code is guarded by "if (TCG_TARGET_REG_BITS ==
64)", so actually it only ever runs with 64-bit targets.

I wonder if QEMU_BUILD_BUG_ON (at least in atomics) should not use a
static assertion, but rather the 'error ("MESSAGE")' attribute instead.
This way, if the code is dead it does not cause a build failure.

Paolo
