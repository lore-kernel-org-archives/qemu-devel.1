Received: from eggs.gnu.org ([209.51.188.92]:58422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1ePU-0005QX-7U
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1ePT-0005eA-Cm
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:49:08 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-9-mark.cave-ayland@ilande.co.uk>
	<5c37085e-2c33-32d0-235c-76a9100d4bbf@linaro.org>
	<ecbf29cd-6d89-1a4e-870e-a6a06a5b37ec@ilande.co.uk>
Message-ID: <823e7dd1-4170-c219-d31f-326157a5e043@ilande.co.uk>
Date: Wed, 6 Mar 2019 21:48:59 +0000
MIME-Version: 1.0
In-Reply-To: <ecbf29cd-6d89-1a4e-870e-a6a06a5b37ec@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 8/8] target/ppc: simplify
 get_cpu_vsrh() and get_cpu_vsrl() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 05/03/2019 18:16, Mark Cave-Ayland wrote:

> On 03/03/2019 23:35, Richard Henderson wrote:
> 
>> On 3/3/19 9:23 AM, Mark Cave-Ayland wrote:
>>>  static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
>>>  {
>>> -    if (n < 32) {
>>> -        get_fpr(dst, n);
>>> -    } else {
>>> -        get_avr64(dst, n - 32, true);
>>> -    }
>>> +    tcg_gen_ld_i64(dst, cpu_env, vsrh_offset(n));
>>>  }
>>>  
>>>  static inline void get_cpu_vsrl(TCGv_i64 dst, int n)
>>>  {
>>> -    if (n < 32) {
>>> -        get_vsrl(dst, n);
>>> -    } else {
>>> -        get_avr64(dst, n - 32, false);
>>> -    }
>>> +    tcg_gen_ld_i64(dst, cpu_env, vsrl_offset(n));
>>>  }
>>>  
>>>  static inline void set_cpu_vsrh(int n, TCGv_i64 src)
>>>  {
>>> -    if (n < 32) {
>>> -        set_fpr(n, src);
>>> -    } else {
>>> -        set_avr64(n - 32, src, true);
>>> -    }
>>> +    tcg_gen_st_i64(src, cpu_env, vsrh_offset(n));
>>>  }
>>
>> I think these ought to have a "high" parameter, like set/get_avr64.
> 
> Right, this is effectively the same discussion as in my previous email so I suggest
> we follow this up there.

I've reworked this patchset over the evening to keep avr64_offset() and looking over
the result it's more readable than I thought, mostly thanks to its use of the VsrD macro.

The only part I'm now not sure about is whether from the above you want to keep
fpr_offset() and vsrh_offset(), or whether in the final patch in the series I can
introduce vsr64_offset() similar to avr64_offset() and switch the callers over to use it?


ATB,

Mark.
