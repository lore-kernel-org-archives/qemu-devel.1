Received: from eggs.gnu.org ([2001:4830:134:3::10]:33778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dqrHM-0005lO-5E
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 21:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dqrHI-0004eq-9G
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 21:43:20 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:36116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dqrHI-0004eQ-2I
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 21:43:16 -0400
Received: by mail-pf0-x235.google.com with SMTP id e199so9411484pfh.3
	for <qemu-devel@nongnu.org>; Sat, 09 Sep 2017 18:43:14 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-3-richard.henderson@linaro.org>
	<877examon2.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <05363152-8a66-af3f-7c66-9627cbdc290b@linaro.org>
Date: Sat, 9 Sep 2017 18:43:10 -0700
MIME-Version: 1.0
In-Reply-To: <877examon2.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 09/07/2017 09:58 AM, Alex Bennée wrote:
>> +    switch (size + 4 * is_u) {
> 
> Hmm I find this switch a little too magical. I mean I can see that the
> encoding abuses size for the final opcode when I look at the manual but
> it reads badly.
> 
>> +    case 0: /* AND */
>> +        gvec_op = tcg_gen_gvec_and8;
>> +        goto do_gvec;
>> +    case 1: /* BIC */
>> +        gvec_op = tcg_gen_gvec_andc8;
>> +        goto do_gvec;
>> +    case 2: /* ORR */
>> +        gvec_op = tcg_gen_gvec_or8;
>> +        goto do_gvec;
>> +    case 3: /* ORN */
>> +        gvec_op = tcg_gen_gvec_orc8;
>> +        goto do_gvec;
>> +    case 4: /* EOR */
>> +        gvec_op = tcg_gen_gvec_xor8;
>> +        goto do_gvec;
>> +    do_gvec:
>> +        gvec_op(vec_full_reg_offset(s, rd),
>> +                vec_full_reg_offset(s, rn),
>> +                vec_full_reg_offset(s, rm),
>> +                is_q ? 16 : 8, vec_full_reg_size(s));
>> +        return;
> 
> No default case (although I guess we just fall through). What's wrong
> with just having a !is_u test with gvec_op = tbl[size] and skipping all
> the goto stuff?

Because that would still leave EOR out in the woods.
I do think this is the cleanest way to filter out these 5 operations.


r~
