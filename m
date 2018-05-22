Received: from eggs.gnu.org ([2001:4830:134:3::10]:43138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fL9t2-0004YW-0v
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fL9sx-00074H-RZ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:11:43 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:34892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fL9sx-00073k-Kf
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:11:39 -0400
Received: by mail-pl0-x22a.google.com with SMTP id i5-v6so11188297plt.2
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 09:11:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA-aD98+wh=XfMkY1iUwHjDJZ6dH7Juv0_o_VbgkcV0etw@mail.gmail.com>
	<214c47f3-1583-6480-4837-8b8ced37f038@twiddle.net>
	<CAFEAcA9QN_EFbfwqps+5Bu7CKX4J7GLGjBMURmk-1Jk22iixKA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7af06713-7e42-6489-5945-85545bc02f26@twiddle.net>
Date: Tue, 22 May 2018 09:11:35 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9QN_EFbfwqps+5Bu7CKX4J7GLGjBMURmk-1Jk22iixKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] TCG helpers that return f16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/22/2018 07:56 AM, Peter Maydell wrote:
>>> However, for TCG helper functions, although we allow the helper
>>> macro to say that the return type is 'f16', in helper-head.h we
>>> seem to just alias f16 as i32, and in dh_sizemask() we only record
>>> "is this 64 bits" and "is this signed". Am I missing the place
>>> where we zero-extend the value we get back from the helper so
>>> that it's the right thing in TCG's i32 ?
>>
>> It happens in C, implicit in "typedef uint16_t float16".
> 
> ...but uint16_t is only 16 bits, so we are returning
> a "real" 16 bit quantity?

The *helpers* are supposed to be returning uint32_t.  That should be enforced
by the prototype generated from "f16" being aliased to "i32".

The softfloat routines are supposed to be returning float16, aka uint16_t.

So:

float16 f();
uint32_t h() { return f(); }

will generate a zero-extend, in C, before returning to TCG generated code.


r~
