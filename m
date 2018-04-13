Received: from eggs.gnu.org ([2001:4830:134:3::10]:50035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f73IW-0001J2-Ay
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f73IR-0002ok-Aq
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:44 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:42972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f73IR-0002oH-5U
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:39 -0400
Received: by mail-pl0-x243.google.com with SMTP id t20-v6so6528967ply.9
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 11:19:39 -0700 (PDT)
References: <20180412140222.2096-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a11d7ba8-4b29-5970-9574-b2ee2fa5c8c9@linaro.org>
Date: Thu, 12 Apr 2018 18:46:52 -1000
MIME-Version: 1.0
In-Reply-To: <20180412140222.2096-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On 04/12/2018 04:02 AM, Peter Maydell wrote:
> AArch64 stack frames include a 'frame record' which holds a pointer
> to the next frame record in the chain and the LR on entry to the
> function. The procedure calling standard doesn't mandate where
> exactly this frame record is in the stack frame, but for signal
> frames the kernel puts it right at the top. We used to put it
> there too, but in commit 7f0f4208b3a96f22 we accidentally put
> the "enlarge to the 4K reserved space minimum" check after the
> "allow for the frame record" code, rather than before it, with
> the effect that the frame record would be inside the reserved
> space and immediately after the last used part of it.
> 
> Move the frame record back out of the reserved space to where
> we used to put it.
> 
> This bug shouldn't break any sensible guest code, but test
> programs that deliberately look at the internal details
> of the signal frame layout will not find what they are
> expecting to see.
> 
> Fixes: 7f0f4208b3a96f22
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> I'm marking this as for-2.12 on the basis that it puts our frame
> layout back to exactly what 2.11 had, and so seems safest.
> No sensible guest code should really care, though, so this is
> in the "only if we're doing an rc4" bucket; but I think that the
> softfloat fixes deserve an rc4 anyway.

Granted.


r~
