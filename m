Received: from eggs.gnu.org ([2001:4830:134:3::10]:41146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLYta-0001ri-My
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 14:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLYtV-0000SX-Uo
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 14:26:14 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181109173553.22341-1-peter.maydell@linaro.org>
	<20181109173553.22341-2-peter.maydell@linaro.org>
	<CAFEAcA8pbw-D_9P3RYGMZbFXBFD6PzFNgrVLEb_RYQ11YuFdOQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5d8b596c-50f8-f637-f73a-8a5cb56ac908@amsat.org>
Date: Sat, 10 Nov 2018 20:26:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8pbw-D_9P3RYGMZbFXBFD6PzFNgrVLEb_RYQ11YuFdOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] target/arm: Hyp mode R14 is
 shared with User and System
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Adam Lackorzynski <adam.lackorzynski@kernkonzept.com>, "patches@linaro.org" <patches@linaro.org>

On 11/9/18 7:15 PM, Peter Maydell wrote:
> On 9 November 2018 at 17:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Hyp mode is an exception to the general rule that each AArch32
>> mode has its own r13, r14 and SPSR -- it has a banked r13 and
>> SPSR but shares its r14 with User and System mode. We were
>> incorrectly implementing it as banked, which meant that on
>> entry to Hyp mode r14 was 0 rather than the USR/SYS r14.
>>
>> We provide a new function r14_bank_number() which is like
>> the existing bank_number() but provides the index into
>> env->banked_r14[]; bank_number() provides the index to use
>> for env->banked_r13[] and env->banked_cpsr[].
>>
>> All the points in the code that were using bank_number()
>> to index into env->banked_r14[] are updated for consintency:
>>  * switch_mode() -- this is the only place where we fix
>>    an actual bug
>>  * aarch64_sync_32_to_64() and aarch64_sync_64_to_32():
>>    no behavioural change as we already special-cased Hyp R14
>>  * kvm32.c: no behavioural change since the guest can't ever
>>    be in Hyp mode, but conceptually the right thing to do
>>  * msr_banked()/mrs_banked(): we can never get to the case
>>    that accesses banked_r14[] with tgtmode == ARM_CPU_MODE_HYP,
>>    so no behavioural change
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/internals.h | 16 ++++++++++++++++
>>  target/arm/helper.c    | 29 +++++++++++++++--------------
>>  target/arm/kvm32.c     |  4 ++--
>>  target/arm/op_helper.c |  2 +-
>>  4 files changed, 34 insertions(+), 17 deletions(-)
> 
> Rats, this bit accidentally didn't make it into this patch:
> 
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 2b62c53f5b5..eb6fb82fb81 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -725,7 +725,7 @@ uint32_t HELPER(mrs_banked)(CPUARMState *env,
> uint32_t tgtmode, uint32_t regno)
>      case 13:
>          return env->banked_r13[bank_number(tgtmode)];
>      case 14:
> -        return env->banked_r14[bank_number(tgtmode)];
> +        return env->banked_r14[r14_bank_number(tgtmode)];
>      case 8 ... 12:
>          switch (tgtmode) {
>          case ARM_CPU_MODE_USR:
> 
> 
> (it's one of the "no behavioural change" bits).

With this hunk:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Thanks for the detailed patch description,

Phil.

> thanks
> -- PMM
> 
