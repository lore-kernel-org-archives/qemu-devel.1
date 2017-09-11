Received: from eggs.gnu.org ([2001:4830:134:3::10]:40289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1drKlm-00086u-8X
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1drKlh-0004gR-A2
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:12:42 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:45214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1drKlh-0004f5-3f
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:12:37 -0400
Received: by mail-wm0-x229.google.com with SMTP id f199so34509275wme.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 02:12:37 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-3-richard.henderson@linaro.org>
	<877examon2.fsf@linaro.org>
	<05363152-8a66-af3f-7c66-9627cbdc290b@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <05363152-8a66-af3f-7c66-9627cbdc290b@linaro.org>
Date: Mon, 11 Sep 2017 10:12:34 +0100
Message-ID: <8760cpbnul.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/8] target/arm: Use generic vector
 infrastructure for aa64 add/sub/logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 09/07/2017 09:58 AM, Alex Bennée wrote:
>>> +    switch (size + 4 * is_u) {
>>
>> Hmm I find this switch a little too magical. I mean I can see that the
>> encoding abuses size for the final opcode when I look at the manual but
>> it reads badly.
>>
>>> +    case 0: /* AND */
>>> +        gvec_op = tcg_gen_gvec_and8;
>>> +        goto do_gvec;
>>> +    case 1: /* BIC */
>>> +        gvec_op = tcg_gen_gvec_andc8;
>>> +        goto do_gvec;
>>> +    case 2: /* ORR */
>>> +        gvec_op = tcg_gen_gvec_or8;
>>> +        goto do_gvec;
>>> +    case 3: /* ORN */
>>> +        gvec_op = tcg_gen_gvec_orc8;
>>> +        goto do_gvec;
>>> +    case 4: /* EOR */
>>> +        gvec_op = tcg_gen_gvec_xor8;
>>> +        goto do_gvec;
>>> +    do_gvec:
>>> +        gvec_op(vec_full_reg_offset(s, rd),
>>> +                vec_full_reg_offset(s, rn),
>>> +                vec_full_reg_offset(s, rm),
>>> +                is_q ? 16 : 8, vec_full_reg_size(s));
>>> +        return;
>>
>> No default case (although I guess we just fall through). What's wrong
>> with just having a !is_u test with gvec_op = tbl[size] and skipping all
>> the goto stuff?
>
> Because that would still leave EOR out in the woods.
> I do think this is the cleanest way to filter out these 5 operations.

Is this going to look better if the other operations in this branch of
the decode are converted as well?

--
Alex Bennée
