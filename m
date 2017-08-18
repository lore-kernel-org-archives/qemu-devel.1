Received: from eggs.gnu.org ([2001:4830:134:3::10]:47170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dihZz-0003m8-2Z
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dihZw-0002rY-0B
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:44:51 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:33881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dihZv-0002r0-RR
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 09:44:47 -0400
Received: by mail-pg0-x229.google.com with SMTP id n4so1153846pgn.1
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 06:44:47 -0700 (PDT)
References: <20170817180404.29334-1-alex.bennee@linaro.org>
	<alpine.DEB.2.20.1708181355080.2770@bulbul.intra.ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <64af762a-5d2b-5e33-fc8e-18244b0c6586@linaro.org>
Date: Fri, 18 Aug 2017 06:44:44 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1708181355080.2770@bulbul.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/9] TCG Vector types and example
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, rth@twiddle.net

On 08/18/2017 04:33 AM, Kirill Batuzov wrote:
> From my own experimentations some times ago,
> 
> (1) translating vector instructions to vector instructions in TCG is faster than
> 
> (2) translating vector instructions to series of scalar instructions in TCG,
> which is faster than*
> 
> (3) translating vector instructions to single helper calls, which is faster
> than*
> 
> (4) translating vector instructions to helper calls for each vector element.
> 
> (*) (2) and (3) may change their respective places in case of some
> complicated instructions.

This was my gut feeling as well.  With the caveat that for the ARM SVE case of
2048-bit registers we cannot afford to expand inline due to generated code size.

> ARM (at least ARM32, I have not checked aarch64 in this regard) uses the
> last, the slowest scheme. As far as I understand, you are want to change
> it to the third approach. This approach is used in SSE emulation, may be
> you can use similar structure of helpers?
> 
> I still hope to finish my own series about implementation of the first
> approach. I apologize for the long delay since last update and hope to
> send next version somewhere next week. I do not think our series
> contradict each other: you are trying to optimize existing general
> purpose case while I'm trying to optimize case where both host and guest
> support vector instructions. Since I'm experimenting on ARM32, we'll not
> have much merge conflicts either.

I posted my own, different, take on vectorization yesterday as well.

  http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03272.html

The primary difference between my version and your version is that I do not
allow target/cpu/translate*.c to create vector types.  All of the host vector
expansion is done within tcg/*.c.

We also would like to settle on a common style for out-of-line helpers, if that
is possible.  One thing *not* to take from our current SSE emulation is that we
do not yet support AVX, AVX2, or AVX512 extensions.  So the current
construction of helpers within target/i386/ doesn't really take into account
all that should be required.

The thing that's common between AVX512 and SVE is that we have multiple vector
lengths, and that elements beyond the operation length are zeroed.  Both Alex
and I have packed operation length + full vector length into a descriptor given
to the helper.  (Alex allows for some other bits too; I'm not sure about that.)


r~
