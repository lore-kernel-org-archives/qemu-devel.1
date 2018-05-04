Received: from eggs.gnu.org ([2001:4830:134:3::10]:56891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEdEA-0008JY-5G
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEdE9-0004lP-DD
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:06:34 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEdE9-0004l4-8X
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:06:33 -0400
Received: by mail-ot0-x241.google.com with SMTP id y10-v6so25021590otg.10
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:06:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9cf54353-2e76-dcb0-04d7-b64c65d39b5f@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-9-richard.henderson@linaro.org>
	<CAFEAcA_ZaP8Wxe3P+5SKpmQxzJqOEQxnKcdh7StGytOi9iR0yg@mail.gmail.com>
	<9cf54353-2e76-dcb0-04d7-b64c65d39b5f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 17:06:12 +0100
Message-ID: <CAFEAcA8_S_eG3ouh2JE8tugfoWj_2EJPssqtbys_jeJp3D+AQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 8/9] target/arm: Implement CAS and CASP
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

On 3 May 2018 at 18:32, Richard Henderson <richard.henderson@linaro.org> wrote:
> On 05/03/2018 07:55 AM, Peter Maydell wrote:
>>> +        /* If compare equal, write back new data, else write back old data.  */
>>> +        tcg_gen_movcond_i64(TCG_COND_NE, c1, c2, zero, t1, d1);
>>> +        tcg_gen_movcond_i64(TCG_COND_NE, c2, c2, zero, t2, d2);
>>> +        tcg_gen_qemu_st_i64(c1, addr, memidx, MO_64 | s->be_data);
>>> +        tcg_gen_qemu_st_i64(c2, a2, memidx, MO_64 | s->be_data);
>>
>> I think this has the wrong behaviour if you do a CASP-with-mismatched-value
>> to read-only memory -- architecturally this should fail the comparison
>> and return the memory value in registers, it's not allowed to do a
>> memory write and take a data abort because the memory isn't writable.
>
> If this is true [...]

Fortunately it turns out that it is not true. In the pseudocode,
the CAS accesses are made with an acctype of either AccType_ORDEREDRW
or AccType_ATOMICRW, and when this gets down into the translation table
walk code AArch64.CheckPermission() handles those access types
specially and generates a permission fault on !r || !w, so will fault
the read part of the read-modify-write.

I wouldn't be too surprised if we get the ESR_ELx WnR bit wrong
for this (it is supposed to be "0 if a plain read would fault,
otherwise 1"), but let's not worry about that for now...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
