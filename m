Received: from eggs.gnu.org ([2001:4830:134:3::10]:33997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1drcjU-0002pe-66
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1drcjR-0001FJ-0r
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:23:32 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1drcjQ-0001Ew-Qk
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:23:28 -0400
Received: by mail-pg0-x244.google.com with SMTP id m30so657220pgn.5
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 21:23:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170911204936.5020-1-f4bug@amsat.org>
	<CAFEAcA_61iw+u7aMp+vA-CNpmAPjvJ_ynUfHu8Y+p8jmgvbcdw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d9f5a569-42e1-4123-0290-12413936ca8a@twiddle.net>
Date: Mon, 11 Sep 2017 21:23:25 -0700
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 09/11/2017 02:37 PM, Peter Maydell wrote:
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

It is the correct thing because ppc32 is handled earlier in the function; only
ppc64 can reach here, therefore a 64-bit atomic_set is always available.

However, I wrote the function intending to minimize the ifdefs so that we can
be sure that it all compiles -- especially the ppc32 bits which I cannot test
on gcc cfarm machines.  I didn't think about the fact that ppc32 could not
compile the _Static_assert within the 64-bit atomic_set here in the ppc64 section.


r~
