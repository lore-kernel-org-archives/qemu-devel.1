Received: from eggs.gnu.org ([209.51.188.92]:38906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFE4J-0007TE-BU
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFE4I-00020p-D9
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:31:23 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFE4H-00020K-P4
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:31:22 -0400
Received: by mail-pg1-x543.google.com with SMTP id 85so6293658pgc.3
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 01:31:21 -0700 (PDT)
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<20190307144126.31847-3-richard.henderson@linaro.org>
	<CAFEAcA8JwtiBSgUg_8kg52GETGd3vbX86nvziXa6ZyvqDPLt5g@mail.gmail.com>
	<a17fffd5-6242-8efc-a8a6-2ca5a8ae9c3d@linaro.org>
	<CAFEAcA-ee-WmGLn=OMTDpisovgz6wCEfGygZ3Fy+JoHVbfdPKQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4dc82e13-86c7-0f23-957a-463173a86481@linaro.org>
Date: Fri, 12 Apr 2019 22:31:15 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ee-WmGLn=OMTDpisovgz6wCEfGygZ3Fy+JoHVbfdPKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] tcg: Add INDEX_op_extract2_{i32,i64}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>

On 4/3/19 1:56 AM, Peter Maydell wrote:
> On Wed, 3 Apr 2019 at 18:37, Richard Henderson
>> * extract2_i32/i64 dest, t1, t2, pos
>>
>> For N = {32,64}, extract an N-bit quantity from the concatenation
>> of t2:t1, beginning at pos.  The tcg_gen_extract2_* expander allows
>> values 0 <= pos <= N, but will expand 0 and N with mov, so only
>> 1 <= pos <= N-1 will be seen by the host tcg_out_op.
> 
> If I'm reading that correctly, it seems to be combining in one sentence
> the behaviour of the TCG API exposed to the front-end (pos can be
> between 0 and N inclusive) with a detail of the API that a backend
> needs to care about (that it can assume it never sees 0 or N).

You're not wrong.  ;-P

> I think we should be more careful to keep those separate, because
> a reader of this document is almost always going to care only about
> one or the other, never both at the same time. Perhaps things that
> apply only to the backend end of the interface should go in section 4
> of tcg/README?

Sadly, there's a lot of mix up on that count.

Indeed, the very next paragraph,

> * extrl_i64_i32 t0, t1
> 
> For 64-bit hosts only, extract the low 32-bits of input T1 and place it
> into 32-bit output T0.  Depending on the host, this may be a simple move,
> or may require additional canonicalization.

is entirely about the "section 4" opcode.  The "section 2" function,
tcg_gen_extrl_i64_i32, is expanded correctly for 32-bit hosts as a
simple move from the i32 "sub-temp" of the i64 temp.

Clearly the whole thing should be reorganized, but I'm not sure how best that
should be done.

> At any rate I think they should at least be in different sentences :-)

Now that I can do.  ;-)


r~
