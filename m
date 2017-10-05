Received: from eggs.gnu.org ([2001:4830:134:3::10]:51410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e06WM-0006O5-LH
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e06WL-0006T8-Pw
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 09:49:02 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170708025030.15845-1-rth@twiddle.net>
	<20170708025030.15845-3-rth@twiddle.net>
	<CAFEAcA9mSQnJCDzPOvf4PsBHx0kPB7CFCLC3AdDv9G0EHrEXXg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c9fdb06e-301f-0dd5-be0d-ad48865d029c@twiddle.net>
Date: Thu, 5 Oct 2017 09:48:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9mSQnJCDzPOvf4PsBHx0kPB7CFCLC3AdDv9G0EHrEXXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] linux-user: Tidy and enforce
 reserved_va initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-arm <qemu-arm@nongnu.org>

On 10/03/2017 12:24 PM, Peter Maydell wrote:
> On 8 July 2017 at 03:50, Richard Henderson <rth@twiddle.net> wrote:
>> We had a check using TARGET_VIRT_ADDR_SPACE_BITS to make sure
>> that the allocation coming in from the command-line option was
>> not too large, but that didn't include target-specific knowledge
>> about other restrictions on user-space.
>>
>> Remove several target-specific hacks in linux-user/main.c.
>>
>> For MIPS and Nios, we can replace them with proper adjustments
>> to the respective target's TARGET_VIRT_ADDR_SPACE_BITS definition.
>>
>> For ARM, we had no existing ifdef but I suspect that the current
>> default value of 0xf7000000 was chosen with this in mind.  Define
>> a workable value in linux-user/arm/, and also document why the
>> special case is required.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>  linux-user/arm/target_cpu.h |  4 ++++
>>  target/mips/mips-defs.h     |  6 +++++-
>>  target/nios2/cpu.h          |  6 +++++-
>>  linux-user/main.c           | 38 +++++++++++++++++++++++++-------------
>>  4 files changed, 39 insertions(+), 15 deletions(-)
>>
>> diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
>> index d888219..c4f79eb 100644
>> --- a/linux-user/arm/target_cpu.h
>> +++ b/linux-user/arm/target_cpu.h
>> @@ -19,6 +19,10 @@
>>  #ifndef ARM_TARGET_CPU_H
>>  #define ARM_TARGET_CPU_H
>>
>> +/* We need to be able to map the commpage.
>> +   See validate_guest_space in linux-user/elfload.c.  */
>> +#define MAX_RESERVED_VA  0xfff00000ul
>> +
> 
> This should be 0xffff0000, but you'll need the bugfix patch I just sent
> out first.
> 
> (Why "UL" ? That's usually a wrong choice compared to either U or ULL.)

Because that matches the type of

+unsigned long reserved_va = MAX_RESERVED_VA;

Which, arguably, should be uintptr_t or size_t something instead, but that
would certainly be for a different patch.

If you prefer, since this is a 32-bit value, I could trim the define to U and
still be correct.


r~
