Received: from eggs.gnu.org ([2001:4830:134:3::10]:47560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GwT-00030q-IB
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9GwN-0003qE-Kh
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:18:09 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9GwN-0003nI-Cz
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:18:03 -0400
Received: by mail-pf0-x242.google.com with SMTP id z9so3236331pfe.6
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:18:03 -0700 (PDT)
References: <20180419112131.16932-1-edgar.iglesias@gmail.com>
	<20180419112131.16932-2-edgar.iglesias@gmail.com>
	<4439efca-e41e-14f8-85ff-89478608c80a@linaro.org>
	<20180419203347.5m4bwxmkkesergbx@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f4c1406a-2151-0027-8b6c-10e5ce215ad7@linaro.org>
Date: Thu, 19 Apr 2018 11:17:58 -1000
MIME-Version: 1.0
In-Reply-To: <20180419203347.5m4bwxmkkesergbx@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/5] target-microblaze: Respect MSR.PVR
 as read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, sai.pavan.boddu@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, frasse.iglesias@gmail.com

On 04/19/2018 10:33 AM, Edgar E. Iglesias wrote:
> On Thu, Apr 19, 2018 at 09:56:40AM -1000, Richard Henderson wrote:
>> On 04/19/2018 01:21 AM, Edgar E. Iglesias wrote:
>>>  static inline void msr_write(DisasContext *dc, TCGv v)
>>>  {
>>> -    TCGv t;
>>> -
>>> -    t = tcg_temp_new();
>>>      dc->cpustate_changed = 1;
>>>      /* PVR bit is not writable.  */
>>> -    tcg_gen_andi_tl(t, v, ~MSR_PVR);
>>> -    tcg_gen_andi_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], MSR_PVR);
>>> -    tcg_gen_or_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], v);
>>> -    tcg_temp_free(t);
>>> +    tcg_gen_deposit_tl(cpu_SR[SR_MSR], v, cpu_SR[SR_MSR], MSR_PVR_SHIFT, 1);
>>>  }
>>
>> Um... the old code was correct, but the new code isn't.
>>
>> The new code sets msr to v, with bit 10 set to the old msr bit 0.
>>
>> Why do you believe the old code to be wrong?
> 
> The old code was incorrectly ORing v instead of t...

Ah, yes.

> What about the following?
>     tcg_gen_shri_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], MSR_PVR_SHIFT);
>     tcg_gen_deposit_tl(cpu_SR[SR_MSR], v, cpu_SR[SR_MSR], MSR_PVR_SHIFT, 1);

*shrug* While that would be functional, I don't think it's any better than just
fixing the typo in the OR.


r~
