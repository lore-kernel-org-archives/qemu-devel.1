Received: from eggs.gnu.org ([2001:4830:134:3::10]:53857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef4Or-0004jb-Tc
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef4Or-0007oG-1x
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:50:37 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef4Oq-0007nz-Tr
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:50:36 -0500
Received: by mail-oi0-x243.google.com with SMTP id 5so335612oip.5
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 05:50:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <80dfd9f6-e104-918e-9a31-bd22e9990f4f@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
	<20171218172425.18200-7-richard.henderson@linaro.org>
	<CAFEAcA9XeA6Osy90-NH6rzPH5o7DdPvAwz9iHWxVOORy9KRU0w@mail.gmail.com>
	<80dfd9f6-e104-918e-9a31-bd22e9990f4f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 10:05:45 +0000
Message-ID: <CAFEAcA9qpJD--HYNaGv45CBU2To=D0brsRmkgkcZj-v6zXz5LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 06/11] target/arm: Decode aa32 armv8.1
 two reg and a scalar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 26 January 2018 at 07:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 01/15/2018 09:47 AM, Peter Maydell wrote:
>> On 18 December 2017 at 17:24, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  target/arm/translate.c | 38 +++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>>> index a9587ae242..1a0b0eaced 100644
>>> --- a/target/arm/translate.c
>>> +++ b/target/arm/translate.c
>>> @@ -6973,11 +6973,43 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>>>                          }
>>>                          neon_store_reg64(cpu_V0, rd + pass);
>>>                      }
>>> +                    break;
>>> +                case 14: /* VQRDMLAH scalar */
>>> +                case 15: /* VQRDMLSH scalar */
>>> +                    if (!arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
>>> +                        return 1;
>>> +                    }
>>> +                    if (u && ((rd | rn) & 1)) {
>>> +                        return 1;
>>> +                    }
>>
>> The pseudocode also has UNDEF if Q==1 && Vm<0> == 1 ....
>
> Not for the indexed version, encoding A2.

Ah, yes.

>>
>>> +                    tmp2 = neon_get_scalar(size, rm);
>>> +                    for (pass = 0; pass < (u ? 4 : 2); pass++) {
>>> +                        void (*fn)(TCGv_i32, TCGv_env, TCGv_i32,
>>> +                                   TCGv_i32, TCGv_i32);
>>
>> Can we define a typedef for this, please ?
>
> What would you name it?

NeonGenThreeOpEnvFn would fit the naming scheme we've got
in translate-a64.c.

thanks
-- PMM
