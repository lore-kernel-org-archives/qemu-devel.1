Received: from eggs.gnu.org ([2001:4830:134:3::10]:44084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiXy-0001zp-1p
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZiXu-0004Rt-VG
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:29:54 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZiXu-0004Qj-P4
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:29:50 -0500
Received: by mail-pg0-x244.google.com with SMTP id q67so2837561pga.9
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 11:29:50 -0800 (PST)
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-6-richard.henderson@linaro.org>
	<CAFEAcA8+fQ7QiygiM0C5kgesNSpiFnJDCjnAyjAtm=zt2cRnAw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2373642e-8d28-d94c-dfb5-55f0bf33e32b@linaro.org>
Date: Thu, 11 Jan 2018 11:29:47 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8+fQ7QiygiM0C5kgesNSpiFnJDCjnAyjAtm=zt2cRnAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] target/arm: Add
 aa32_vfp_dreg/aa64_vfp_qreg helpers
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

On 01/11/2018 10:39 AM, Peter Maydell wrote:
> On 18 December 2017 at 17:30, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Helpers that return a pointer into env->vfp.regs so that we isolate
>> the logic of how to index the regs array for different cpu modes.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.h           | 20 +++++++++++++++++++-
>>  linux-user/signal.c        | 22 ++++++++++++----------
>>  target/arm/arch_dump.c     |  8 +++++---
>>  target/arm/helper-a64.c    | 13 +++++++------
>>  target/arm/helper.c        | 32 ++++++++++++++++++++------------
>>  target/arm/kvm32.c         |  4 ++--
>>  target/arm/kvm64.c         | 31 ++++++++++---------------------
>>  target/arm/machine.c       |  2 +-
>>  target/arm/translate-a64.c | 25 ++++++++-----------------
>>  target/arm/translate.c     | 16 +++++++++-------
>>  10 files changed, 93 insertions(+), 80 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 7a705a09a1..e1a8e2880d 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -493,7 +493,7 @@ typedef struct CPUARMState {
>>           * the two execution states, and means we do not need to explicitly
>>           * map these registers when changing states.
>>           */
>> -        float64 regs[64] QEMU_ALIGNED(16);
>> +        uint64_t regs[64] QEMU_ALIGNED(16);
> 
> Why are we changing the type of this field ?

Because that's how it's actually used.  We were using casts before.


r~
