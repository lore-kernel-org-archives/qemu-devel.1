Received: from eggs.gnu.org ([2001:4830:134:3::10]:52494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ediIq-0002Mn-PE
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ediIn-0004Fl-Jt
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:02:48 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:44677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ediIn-0004Fb-CZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:02:45 -0500
Received: by mail-pg0-x22f.google.com with SMTP id m20so7909817pgc.11
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 12:02:45 -0800 (PST)
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-3-richard.henderson@linaro.org>
	<CAFEAcA-R0XrQrLRAt5XQtOki0jk1qFnPuBQsf7a5xh2MX37usA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <21d81fa8-8bcf-f492-ce4f-52bf9cfed88e@linaro.org>
Date: Mon, 22 Jan 2018 12:02:39 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-R0XrQrLRAt5XQtOki0jk1qFnPuBQsf7a5xh2MX37usA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10.5 02/20] tcg: Add types and basic
 operations for host vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 01/22/2018 10:53 AM, Peter Maydell wrote:
>> +void tcg_gen_movi_v128(TCGv_vec r, uint64_t a, uint64_t b)
>> +{
>> +    TCGTemp *rt = tcgv_vec_temp(r);
>> +    TCGArg ri = temp_arg(rt);
>> +
>> +    tcg_debug_assert(rt->base_type == TCG_TYPE_V128);
>> +    if (a == b) {
>> +        tcg_gen_dup64i_vec(r, a);
>> +    } else if (TCG_TARGET_REG_BITS == 64) {
>> +        vec_gen_3(INDEX_op_movi_vec, TCG_TYPE_V128, 0, ri, a, b);
>> +    } else {
>> +        TCGOp *op = tcg_emit_op(INDEX_op_movi_vec);
>> +        TCGOP_VECL(op) = TCG_TYPE_V128 - TCG_TYPE_V64;
>> +        op->args[0] = ri;
>> +        op->args[1] = a;
>> +        op->args[2] = a >> 32;
>> +        op->args[3] = b;
>> +        op->args[4] = b >> 32;
> 
> Is it intentional that this doesn't set TCGOP_VECE(op) ?
> The vec_gen_* functions all do.
> 
> This seems like it ought to be a vec_gen_5().

It's not intentional.  That said, I had put this in for use by backends in
expanding operations, but they aren't used so far.  I should just remove them
for now.

>> +********* Host vector operations
>> +
>> +All of the vector ops have two parameters, TCGOP_VECL & TCGOP_VECE.
>> +The former specifies the length of the vector in log2 64-bit units; the
>> +later specifies the length of the element (if applicable) in log2 8-bit units.
>> +E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
> 
> ...but at the tcg_gen_and_vec() function level, the functions
> take a parameter for VECE but not one for VECL ? That's a bit
> confusing. (I think this is perhaps an example of the awkwardness of
> our documenting the TCG interface only at an abstract "ops" level
> and not documenting the concrete function APIs at all.)

For the functions, VECL is taken from the type of the TCGv_vec operands.

But, yes, README is for the ops only...



r~
