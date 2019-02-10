Received: from eggs.gnu.org ([209.51.188.92]:54650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsg1q-0006Yq-BC
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 22:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsg1k-000540-Lp
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 22:43:36 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsg1d-0004zN-H1
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 22:43:28 -0500
Received: by mail-pf1-x441.google.com with SMTP id f132so3589310pfa.6
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 19:43:22 -0800 (PST)
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-7-richard.henderson@linaro.org>
	<CAFEAcA9Kcd6a1Af4ChbOH55XRVWfpeCAexJwxH5AwP8Kn_U0+g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <22287812-8733-ce2e-f6f0-7d1f4a2bb304@linaro.org>
Date: Sat, 9 Feb 2019 19:43:17 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Kcd6a1Af4ChbOH55XRVWfpeCAexJwxH5AwP8Kn_U0+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/17] target/arm: Implement the IRG
 instruction
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

On 2/7/19 8:47 AM, Peter Maydell wrote:
> On Mon, 14 Jan 2019 at 01:11, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/helper-a64.h    |  1 +
>>  target/arm/mte_helper.c    | 55 ++++++++++++++++++++++++++++++++++++++
>>  target/arm/translate-a64.c |  7 +++++
>>  3 files changed, 63 insertions(+)
>>
>> diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
>> index fa4c371a47..7a6051fdab 100644
>> --- a/target/arm/helper-a64.h
>> +++ b/target/arm/helper-a64.h
>> @@ -104,3 +104,4 @@ DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
>>  DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
>>
>>  DEF_HELPER_FLAGS_2(mte_check, TCG_CALL_NO_WG, i64, env, i64)
>> +DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
>> diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
>> index 6f4bc0aa04..1878393fc4 100644
>> --- a/target/arm/mte_helper.c
>> +++ b/target/arm/mte_helper.c
>> @@ -36,6 +36,48 @@ static int allocation_tag_from_addr(uint64_t ptr)
>>      return (extract64(ptr, 56, 4) + extract64(ptr, 55, 1)) & 15;
>>  }
>>
>> +/* Like ChooseNonExcludedTag, except that GCR_EL1 is already in.  */
> 
> I don't understand this comment -- neither the pseudocode
> function nor this code refer to GCR_EL1.

That's changed since the first rev.  Now ChooseNonExcludedTag just has an
exclude argument, and the caller includes GCR_EL1.Exclude.

>> +static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
>> +{
>> +    if (exclude != 0xffff) {
>> +        int i;
>> +        for (i = 0; i < offset; ++i) {
>> +            do {
>> +                tag = (tag + 1) & 15;
>> +            } while (exclude & (1 << tag));
>> +        }
>> +    }
>> +    return tag;
> 
> This doesn't seem to do the same thing as ChooseNonExcludedTag()
> for the offset==0 case, or for the exclude == 0xffff case.

All of this has changed since the first rev too.

> This comment is trying to say that our IMPDEF choice for GCR_EL1.RRND==1
> is "behave the same as if RRND==0", right? I think that would be
> clearer as a comment at the callsite, because if you're following
> along with the pseudocode you expect the IRG code to do an
> "if RRND == 1 then { choose_random_nonexcluded_tag(); } else { ... }".

Thanks for the verbage.


r~
