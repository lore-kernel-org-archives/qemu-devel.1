Received: from eggs.gnu.org ([2001:4830:134:3::10]:56512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f859R-0005LH-7n
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f859Q-0006Sy-9y
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:30:37 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f859Q-0006SS-5b
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:30:36 -0400
Received: by mail-oi0-x243.google.com with SMTP id h11-v6so5354310oic.3
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 07:30:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a11d7ba8-4b29-5970-9574-b2ee2fa5c8c9@linaro.org>
References: <20180412140222.2096-1-peter.maydell@linaro.org>
	<a11d7ba8-4b29-5970-9574-b2ee2fa5c8c9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 15:30:14 +0100
Message-ID: <CAFEAcA81fMyUdTAz2d1NkV2gk_hXFdz1PTVgZjq8kVefPz4-2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] linux-user/signal.c: Put AArch64
 frame record in the right place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, "patches@linaro.org" <patches@linaro.org>

On 13 April 2018 at 05:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 04/12/2018 04:02 AM, Peter Maydell wrote:
>> AArch64 stack frames include a 'frame record' which holds a pointer
>> to the next frame record in the chain and the LR on entry to the
>> function. The procedure calling standard doesn't mandate where
>> exactly this frame record is in the stack frame, but for signal
>> frames the kernel puts it right at the top. We used to put it
>> there too, but in commit 7f0f4208b3a96f22 we accidentally put
>> the "enlarge to the 4K reserved space minimum" check after the
>> "allow for the frame record" code, rather than before it, with
>> the effect that the frame record would be inside the reserved
>> space and immediately after the last used part of it.
>>
>> Move the frame record back out of the reserved space to where
>> we used to put it.
>>
>> This bug shouldn't break any sensible guest code, but test
>> programs that deliberately look at the internal details
>> of the signal frame layout will not find what they are
>> expecting to see.
>>
>> Fixes: 7f0f4208b3a96f22
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> I'm marking this as for-2.12 on the basis that it puts our frame
>> layout back to exactly what 2.11 had, and so seems safest.
>> No sensible guest code should really care, though, so this is
>> in the "only if we're doing an rc4" bucket; but I think that the
>> softfloat fixes deserve an rc4 anyway.

We needed an rc4, so I've applied this to master.

-- PMM
