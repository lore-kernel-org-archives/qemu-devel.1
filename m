Received: from eggs.gnu.org ([2001:4830:134:3::10]:34110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDuyR-00071O-ES
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:14:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDuyN-0005nh-Hq
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:14:35 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:32808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cDuyN-0005nH-DB
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:14:31 -0500
Received: by mail-qt0-x244.google.com with SMTP id n6so36264370qtd.0
	for <qemu-devel@nongnu.org>; Mon, 05 Dec 2016 07:14:31 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-2-git-send-email-rth@twiddle.net>
	<87y3zuzfab.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <982b0201-6f05-112f-ecce-b703ecb4ae1a@twiddle.net>
Date: Mon, 5 Dec 2016 07:14:26 -0800
MIME-Version: 1.0
In-Reply-To: <87y3zuzfab.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 01/64] tcg: Add field extraction
 primitives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 12/05/2016 05:17 AM, Alex Bennée wrote:
>> +    /* ??? Ideally we'd know what values are available for immediate AND.
>> +       Assume that 8 bits are available, plus the special case of 16,
>> +       so that we get ext8u, ext16u.  */
>> +    switch (len) {
>> +    case 1 ... 8: case 16:
>> +        tcg_gen_shri_i32(ret, arg, ofs);
>> +        tcg_gen_andi_i32(ret, ret, (1u << len) - 1);
>> +        break;
>> +    default:
>> +        tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
>> +        tcg_gen_shri_i32(ret, ret, 32 - len);
>> +        break;
>> +    }
> 
> Hmm is this starting to make a case for backend specific optimisation
> passes which have a better idea of the code that can be generated or
> exposing a TCG_TARGET_HAS_8IMM_BITS or some such from the backend to the
> generators?

Thanks for the prod.  In theory the information is already available.

  tcg_target_const_match((1u << len) - 1, TCG_TYPE_I32,
                         &tcg_op_defs[INDEX_op_and_i32].args_ct[2]);

That's currently static in tcg.c, but that could be fixed.

There could well be a call for backend-specific passes.  I've been thinking of
the problems surrounding constant generation and reverse-endian stores for a
while now, which also sort of fall into this category.


r~
