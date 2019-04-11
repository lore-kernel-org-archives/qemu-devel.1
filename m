Received: from eggs.gnu.org ([209.51.188.92]:56257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hET5C-0006On-RO
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hET5B-0004N5-EW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:21:10 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hET5B-0004Lt-2N
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:21:09 -0400
Received: by mail-pg1-x541.google.com with SMTP id z9so2985499pgu.10
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 23:21:07 -0700 (PDT)
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
	<20190405090212.GF6105@redhat.com>
	<740ce541-c92d-5369-1191-eb73fc861fdd@redhat.com>
	<a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
	<35359e2b-7f07-8815-4f2b-f1435abc4e63@linaro.org>
	<526e88d8-1c5e-1598-6ad3-9b4152ece556@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a04b5f09-4c21-04bc-f224-e9d0b3fb1d79@linaro.org>
Date: Wed, 10 Apr 2019 20:21:00 -1000
MIME-Version: 1.0
In-Reply-To: <526e88d8-1c5e-1598-6ad3-9b4152ece556@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Aurelien Jarno <aurelien@aurel32.net>

On 4/9/19 8:17 PM, Stefan Weil wrote:
> On 09.04.19 22:39, Richard Henderson wrote:
>> On 4/9/19 9:46 AM, Stefan Weil wrote:
>>> * Calling conventions. The current implementation works on many hosts,
>>> but for example not on Sparc. A fix would require simple calling
>>> conventions for all helper functions (for example stack based argument
>>> passing, can this be enforced?), or it needs to know the signature of
>>> each helper function at runtime. I'm afraid that fixing this would
>>> require much work. A runtime test whether calls of helper functions work
>>> correctly could be implemented easily and could abort the program
>>> execution when calls fail to pass the right arguments. Would such a
>>> runtime test help a little bit?
>>
>> In the rewrite of tci that I proposed some years ago,
>> I used libffi for this.
>>
>> Those patches could probably be recovered...
>>
>> https://patchwork.ozlabs.org/patch/348528/
>> https://patchwork.ozlabs.org/patch/348527/
> 
> 
> The first patch is the important one because it adds the signature to
> each helper function. As soon as this information is passed to the
> interpreter, the rest is simple. It should not be necessary to add a new
> dependency on libffi, because there are no foreign calling conventions
> here: all helpers use the C calling convention of the host architecture.

Perhaps the "foreign" in libffi is confusing you.  Its goal *is* the C calling
convention of the host architecture.

> The TCG implementation for Sparc (and other hosts with special calling
> conventions) must also have some minimum information on the signatures
> of the helper functions. It should be possible to use the same
> information for TCI. Maybe your approach ist a general form which could
> be used for any TCG implementation.

We currently capture only enough information to support the TCG native hosts.
If we were to attempt to support, e.g. m68k as a host, then we would have to
expand this.  What I capture for libffi is exact, so it's certainly possible.

But the number of possible function signatures is large.  I forget the simple
math that expresses this well, but doing this the long way suggests 4372 as the
number of combinations (up to 6 arguments of 3 types; 4 return types).

This number is large enough that you cannot just open code all of the possible
calls.  You absolutely have to know something about the host compiler's calling
convention.

I see only 3 possibilities for this:

(1) Use per host ifdefs and/or assembly to DTRT within TCI.
    This admits that TCI requires *some* porting and does
    not automatically run everywhere.
(2) Use an external library that already has said assembly,
    and has already been ported to every interesting processor,
    since it is often done along with the compiler port.
(3) Write a proper TCG backend for each host.

If you see another possibility, please enlighten me.


r~
