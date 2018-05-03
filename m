Received: from eggs.gnu.org ([2001:4830:134:3::10]:60131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEI5v-0008C1-Ug
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEI5s-0002gx-RG
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:32:39 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:43031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEI5s-0002gj-Je
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:32:36 -0400
Received: by mail-pf0-x231.google.com with SMTP id j20so958325pff.10
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 10:32:36 -0700 (PDT)
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-9-richard.henderson@linaro.org>
	<CAFEAcA_ZaP8Wxe3P+5SKpmQxzJqOEQxnKcdh7StGytOi9iR0yg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9cf54353-2e76-dcb0-04d7-b64c65d39b5f@linaro.org>
Date: Thu, 3 May 2018 10:32:32 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ZaP8Wxe3P+5SKpmQxzJqOEQxnKcdh7StGytOi9iR0yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/9] target/arm: Implement CAS and CASP
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

On 05/03/2018 07:55 AM, Peter Maydell wrote:
>> +        /* If compare equal, write back new data, else write back old data.  */
>> +        tcg_gen_movcond_i64(TCG_COND_NE, c1, c2, zero, t1, d1);
>> +        tcg_gen_movcond_i64(TCG_COND_NE, c2, c2, zero, t2, d2);
>> +        tcg_gen_qemu_st_i64(c1, addr, memidx, MO_64 | s->be_data);
>> +        tcg_gen_qemu_st_i64(c2, a2, memidx, MO_64 | s->be_data);
> 
> I think this has the wrong behaviour if you do a CASP-with-mismatched-value
> to read-only memory -- architecturally this should fail the comparison
> and return the memory value in registers, it's not allowed to do a
> memory write and take a data abort because the memory isn't writable.

If this is true, then we cannot use the x86 cmpxchg insn in the parallel case
either.  We will also have already raised an exception for a non-writable page;
that happens generically within ATOMIC_MMU_LOOKUP.  It is also how we implement
non-parallel cmpxchg in tcg-op.c.

I guess I was trying to read in some wiggle room in the clearing of exclusive
monitors and such.

I really don't see another way.  What do you want to do?


r~
