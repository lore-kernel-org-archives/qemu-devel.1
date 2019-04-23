Received: from eggs.gnu.org ([209.51.188.92]:59180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ39Y-0002yb-MN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ39X-0001ka-Ly
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:40:36 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ39X-0001h8-DX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:40:35 -0400
Received: by mail-pl1-x642.google.com with SMTP id x15so3801511pln.9
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 14:40:31 -0700 (PDT)
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-13-richard.henderson@linaro.org>
	<ab0269a3-c0fd-44c4-f939-e3f073e8e2dd@redhat.com>
	<a32e78bf-e4e4-a808-0c42-95e3b64ed1cf@linaro.org>
	<a2cca8a8-24ca-679e-22ce-500bf111ac8f@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <952ddc67-8012-eb87-3f1f-8ef1f27b93da@linaro.org>
Date: Tue, 23 Apr 2019 14:40:27 -0700
MIME-Version: 1.0
In-Reply-To: <a2cca8a8-24ca-679e-22ce-500bf111ac8f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/38] tcg: Add gvec expanders for variable
 shift
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

On 4/23/19 2:02 PM, David Hildenbrand wrote:
> On 23.04.19 21:28, Richard Henderson wrote:
>> On 4/23/19 12:04 PM, David Hildenbrand wrote:
>>> In order to use this on s390x for VECTOR ELEMENT SHIFT, like
>>>
>>> +static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
>>> +{
>>> +    const uint8_t es = get_field(s->fields, m4);
>>> +    const uint8_t v1 = get_field(s->fields, v1);
>>> +    const uint8_t v2 = get_field(s->fields, v2);
>>> +    const uint8_t v3 = get_field(s->fields, v3);
>>> +
>>> +    if (es > ES_64) {
>>> +        gen_program_exception(s, PGM_SPECIFICATION);
>>> +        return DISAS_NORETURN;
>>> +    }
>>> +
>>> +    switch (s->fields->op2) {
>>> +    case 0x70:
>>> +        gen_gvec_fn_3(shlv, es, v1, v2, v3);
>>> +        break;
>>> +    case 0x7a:
>>> +        gen_gvec_fn_3(sarv, es, v1, v2, v3);
>>> +        break;
>>> +    case 0x78:
>>> +        gen_gvec_fn_3(shrv, es, v1, v2, v3);
>>> +        break;
>>> +    default:
>>> +        g_assert_not_reached();
>>> +    }
>>> +
>>> +    return DISAS_NEXT;
>>> +}
>>>
>>> We need to mask of invalid bits from the shift. Can that be added?
>>
>> Yes, I do exactly this in patch 31 for target/ppc.
>>
>>
>> r~
>>
> 
> Got it, so not via a generic gvec expansion. Thanks!

I do wonder if I *should* make the truncating expansion the
generic gvec expansion.  It would be usable from two targets
at least...

Because the one's that *don't* truncate in hardware will
still have to have their own custom expansion code.

Thoughts?


r~
