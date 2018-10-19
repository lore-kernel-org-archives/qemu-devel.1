Received: from eggs.gnu.org ([2001:4830:134:3::10]:39866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDWVJ-0002mc-I6
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDWVE-0006Ib-Jl
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:15:57 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDWVE-0006HC-43
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:15:52 -0400
Received: by mail-pl1-x641.google.com with SMTP id f8-v6so16017508plb.2
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 08:15:51 -0700 (PDT)
References: <20181011205206.3552-1-richard.henderson@linaro.org>
	<20181011205206.3552-19-richard.henderson@linaro.org>
	<CAFEAcA-3iFca2v+8Q2xo4yB7MsUz6xBb5UKNJEYVrpo2A=o22Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <42f6be30-721b-bbeb-ebeb-f59622c0d763@linaro.org>
Date: Fri, 19 Oct 2018 08:15:47 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-3iFca2v+8Q2xo4yB7MsUz6xBb5UKNJEYVrpo2A=o22Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/20] target/arm: Reorg NEON VLD/VST all
 elements
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

On 10/19/18 6:50 AM, Peter Maydell wrote:
> On 11 October 2018 at 21:52, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Instead of shifts and masks, use direct loads and stores from the neon
>> register file.  Mirror the iteration structure of the ARM pseudocode
>> more closely.  Correct the parameters of the VLD2 A2 insn.
> 
> So is this actually fixing a bug here? The new code definitely
> looks right, but I can't make heads nor tails of the old code,
> so I'm not sure whether it actually behaved differently...

Hmm, that comment was written in July.  Working backward,

-    {4, 2, 1},
+    {2, 2, 2},

which is for "VLD2 (multiple 2-element structures) A2", which does have

    regs = 2; inc = 2;

in the pseudocode.  So, yes, we had the wrong stride (last number) for that insn.

Aside from that the old code and the new code should have the same end result.

The old code computed addresses as it stepped through register elements, and so
accesses memory in a "random" order.  The new code accesses memory sequentially
and computes the register element that corresponds.  This is for simplicity of
tcg computation of addresses and not correctness.


r~
