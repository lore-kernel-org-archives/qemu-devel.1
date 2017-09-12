Received: from eggs.gnu.org ([2001:4830:134:3::10]:40926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drhBZ-0000zs-Kh
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drhBY-0004bK-5o
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:08:49 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drhBX-0004ZL-Qd
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:08:48 -0400
Received: by mail-wr0-x231.google.com with SMTP id a43so19434174wrc.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 02:08:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d9f5a569-42e1-4123-0290-12413936ca8a@twiddle.net>
References: <20170911204936.5020-1-f4bug@amsat.org>
	<CAFEAcA_61iw+u7aMp+vA-CNpmAPjvJ_ynUfHu8Y+p8jmgvbcdw@mail.gmail.com>
	<d9f5a569-42e1-4123-0290-12413936ca8a@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 10:08:26 +0100
Message-ID: <CAFEAcA8qjnPBm8ZCMpc-v=0ofNSwAYf5sydLwN1t1edDnvTSzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

On 12 September 2017 at 05:23, Richard Henderson <rth@twiddle.net> wrote:
> On 09/11/2017 02:37 PM, Peter Maydell wrote:
>> On 11 September 2017 at 21:49, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
>>> this fixes building for ppc64 on ppc32 (changed in 5964fca8a12c):
>>>
>>>   qemu/tcg/ppc/tcg-target.inc.c: In function 'tb_target_set_jmp_target'=
:
>>>   qemu/include/qemu/compiler.h:86:30: error: static assertion failed: "=
not expecting: sizeof(*(uint64_t *)jmp_addr) > ATOMIC_REG_SIZE"
>>>        QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
>>>        ^
>>>   qemu/tcg/ppc/tcg-target.inc.c:1377:9: note: in expansion of macro 'at=
omic_set'
>>>            atomic_set((uint64_t *)jmp_addr, pair);
>>>            ^
>>>
>>> Suggested-by: Richard Henderson <rth@twiddle.net>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> This fixes Shippable builds, see:
>>> https://app.shippable.com/github/qemu/qemu/runs/434/10/console
>>>
>>>  tcg/ppc/tcg-target.inc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
>>> index 21d764c102..0417901289 100644
>>> --- a/tcg/ppc/tcg-target.inc.c
>>> +++ b/tcg/ppc/tcg-target.inc.c
>>> @@ -1374,7 +1374,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, u=
intptr_t jmp_addr,
>>>          pair =3D (uint64_t)i2 << 32 | i1;
>>>  #endif
>>>
>>> -        atomic_set((uint64_t *)jmp_addr, pair);
>>> +        atomic_set__nocheck((uint64_t *)jmp_addr, pair);
>>>          flush_icache_range(jmp_addr, jmp_addr + 8);
>>>      } else {
>>>          intptr_t diff =3D addr - jmp_addr;
>>
>> Can you explain why this is the right thing? On the
>> face of it it looks correct to insist that we don't
>> try to do an atomic set of something that's bigger
>> than the host can actually handle...
>
> It is the correct thing because ppc32 is handled earlier in the function;=
 only
> ppc64 can reach here, therefore a 64-bit atomic_set is always available.
>
> However, I wrote the function intending to minimize the ifdefs so that we=
 can
> be sure that it all compiles -- especially the ppc32 bits which I cannot =
test
> on gcc cfarm machines.  I didn't think about the fact that ppc32 could no=
t
> compile the _Static_assert within the 64-bit atomic_set here in the ppc64=
 section.

Ah, I see. Can we have a comment about why the __nocheck is ok here,
then, please?

thanks
-- PMM
