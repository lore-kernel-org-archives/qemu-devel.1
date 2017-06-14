Received: from eggs.gnu.org ([2001:4830:134:3::10]:46916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLDp5-0005AZ-UC
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLDp2-0008Co-Pb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:19:23 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLDp2-0008Ca-M5
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:19:20 -0400
Received: by mail-qt0-x242.google.com with SMTP id o21so2027732qtb.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 12:19:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-4-alex.bennee@linaro.org>
	<09a35585-d876-6c9e-7045-8cda418455e0@twiddle.net>
	<a1a0b43c-b074-a1a4-dc26-717964121b1a@redhat.com>
	<871sqmo3xb.fsf@linaro.org>
	<CAFEAcA-02MVgmdMaDMfhU55J9B7ER1gT6TmyNsZE+bc3wTW45w@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <48da7ce0-2bb5-cdb4-ad5a-a0f0de4cb3f2@twiddle.net>
Date: Wed, 14 Jun 2017 12:19:16 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-02MVgmdMaDMfhU55J9B7ER1gT6TmyNsZE+bc3wTW45w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] tcg-runtime: short-circuit
 lookup_tb_ptr on IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>

On 06/14/2017 12:11 PM, Peter Maydell wrote:
> On 14 June 2017 at 18:49, Alex Bennée <alex.bennee@linaro.org> wrote:
>> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
>> index 2a85666579..7e67bb3db2 100644
>> --- a/target/arm/op_helper.c
>> +++ b/target/arm/op_helper.c
>> @@ -835,6 +835,9 @@ void HELPER(msr_i_pstate)(CPUARMState *env, uint32_t op, uint32_t imm)
>>           break;
>>       case 0x1f: /* DAIFClear */
>>           env->daif &= ~((imm << 6) & PSTATE_DAIF);
>> +        /* This may result in pending IRQs being unmasked so ensure we
>> +           exit the loop */
>> +        cpu_exit(ENV_GET_CPU(env));
>>           break;
>>       default:
>>           g_assert_not_reached();
> 
> The 'op' field we're switching on here is just a constant
> from the instruction encoding, so I'd rather see us
> identify that in translate-a64.c and end the TB or
> whatever when we need to, rather than doing the
> longjump-out-of-here that cpu_exit() does at runtime.

cpu_exit isn't the longjmp; this is just a set of exit_request and icount_decr.

That said, you're right that we can do this more directly from the translator.


r~
