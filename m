Received: from eggs.gnu.org ([2001:4830:134:3::10]:41078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJMCb-0001Cc-B2
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJMCa-0000Na-IG
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:56:29 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJMCa-0000NF-CO
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:56:28 -0400
Received: by mail-ot0-x244.google.com with SMTP id h8-v6so5839127otb.2
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 09:56:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f423b535-f3f7-a8ce-8821-8e16f0cbfd38@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
	<20180516223007.10256-27-richard.henderson@linaro.org>
	<CAFEAcA-Erv++skS73s6_ZCWbo=G6xLaE69wukUKyX3-KyuV=oA@mail.gmail.com>
	<f423b535-f3f7-a8ce-8821-8e16f0cbfd38@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 17:56:06 +0100
Message-ID: <CAFEAcA_eXv+-iNXSSM6mE17-fm1=v0RKC92e+NCfeX8DNxcV8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3-a 26/27] target/arm: Extend
 vec_reg_offset to larger sizes
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

On 17 May 2018 at 17:51, Richard Henderson <richard.henderson@linaro.org> wrote:
> On 05/17/2018 08:57 AM, Peter Maydell wrote:
>> This looks right for element sizes up to 8, but I don't understand
>> how it handles 16 byte elements as the commit message says -- the
>> d[0] and d[1] are the wrong way round and don't form a single
>> 16-byte big-endian value, so they must need special casing somewhere
>> else ?
>
> You're right that it's not a proper int128 for host arithmetic.  Fortunately,
> the only operation we have on 128-bit values, at present, is move.
>
> How better might you word the commit message?

You could add in the comment in the function something like:
"For 32 byte elements, we return an offset of zero. The two halves will
not form a host int128 if the host is bigendian, since they're in
the wrong order. However the only 32 byte operation we have is a move,
so we can ignore this for the moment. More complicated 32 byte operations
would have to special case loading and storing from the zregs array."

thanks
-- PMM
