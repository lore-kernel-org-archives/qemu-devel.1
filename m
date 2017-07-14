Received: from eggs.gnu.org ([2001:4830:134:3::10]:47949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dW1Ki-0004Sc-8X
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dW1Kf-0002Jg-6S
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:12:40 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dW1Ke-0002JP-WD
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:12:37 -0400
Received: by mail-wm0-x232.google.com with SMTP id f67so23975191wmh.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:12:36 -0700 (PDT)
References: <20170713141928.25419-1-alex.bennee@linaro.org>
	<20170713141928.25419-6-alex.bennee@linaro.org>
	<CAFEAcA8o4rU7BXR_+VEQhAXBSzJ7usAnkYXDb=CEqQ=duuirqA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8o4rU7BXR_+VEQhAXBSzJ7usAnkYXDb=CEqQ=duuirqA@mail.gmail.com>
Date: Fri, 14 Jul 2017 15:12:33 +0100
Message-ID: <87pod3umy6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 5/6] target/arm: use gen_goto_tb for ISB
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 13 July 2017 at 15:19, Alex Bennée <alex.bennee@linaro.org> wrote:
>> While an ISB will ensure any raised IRQs happen on the next
>> instruction it doesn't cause any to get raised by itself. We can
>> therefor use a simple tb exit for ISB instructions and rely on the
>> exit_request check at the top of each TB to deal with exiting if
>> needed.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>> ---
>>  target/arm/translate-a64.c | 2 +-
>>  target/arm/translate.c     | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index 66139b6046..2ac565eb10 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -1393,7 +1393,7 @@ static void handle_sync(DisasContext *s, uint32_t insn,
>>           * a self-modified code correctly and also to take
>>           * any pending interrupts immediately.
>>           */
>> -        s->is_jmp = DISAS_UPDATE;
>> +        gen_goto_tb(s, 0, s->pc);
>>          return;
>>      default:
>>          unallocated_encoding(s);
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index 493a7b424a..d8892d9ba5 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -8168,7 +8168,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>>                   * self-modifying code correctly and also to take
>>                   * any pending interrupts immediately.
>>                   */
>> -                gen_lookup_tb(s);
>> +                gen_goto_tb(s, 0, s->pc & ~1);
>>                  return;
>>              default:
>>                  goto illegal_op;
>> @@ -10561,7 +10561,7 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
>>                               * and also to take any pending interrupts
>>                               * immediately.
>>                               */
>> -                            gen_lookup_tb(s);
>> +                            gen_goto_tb(s, 0, s->pc & ~1);
>>                              break;
>>                          default:
>>                              goto illegal_op;
>
> Why do we need to clear the low bit of s->pc for ISB?
> s->pc is the actual PC, not the "PC and low bit indicates
> Thumb mode" form that jump addresses have.

It's what gen_lookup_tb does to it's PC before the calculated jump. If
it can never happen I can get rid of it.

--
Alex Bennée
