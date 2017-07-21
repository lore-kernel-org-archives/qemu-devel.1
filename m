Received: from eggs.gnu.org ([2001:4830:134:3::10]:49413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYUIq-0000zT-A8
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYUIm-0007GT-40
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:32:56 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:38682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYUIl-0007G3-U2
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:32:52 -0400
Received: by mail-wr0-x232.google.com with SMTP id f21so23668579wrf.5
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:32:51 -0700 (PDT)
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-6-alex.bennee@linaro.org>
	<71a11f23-39e7-d89a-36d5-2870ed76d940@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <71a11f23-39e7-d89a-36d5-2870ed76d940@twiddle.net>
Date: Fri, 21 Jul 2017 10:32:49 +0100
Message-ID: <87y3ri6sou.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 05/23] softfloat3c: initial
 build machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Richard Henderson <rth@twiddle.net> writes:

> On 07/20/2017 05:04 AM, Alex Bennée wrote:
>> +# so they can still be linked when needed. We build these files surpressing so of the normal CFLAGS.
>
> "surpressing so" -> "suppressing some"
>
> Do we gain any confidence for our still supported but less tested
> 32-bit hosts (all of which do support a 64-bit type) by dropping the
> FAST_INT64 distinction?

I guess so. Certainly I can cross-compile aarch64-softmmu on armhf
defining all the:

  softfloat3_fastint64="yes"
  softfloat3_fastdiv32to16="yes"
  softfloat3_fastdiv64to32="yes"

without any issue. I guess it might mean our 32 bit guests might run
slightly slower but none of our FP is fast anyway.

There is also a slight intermingling in the build setup between the
FASTINT64 and the specialisation even though there are for different
things.

The 8086 code basically makes NaN propagation match old x86 whereas SSE
is the more recent and more IEEE like SSE behaviour. See section 5 of:

  http://www.jhauser.us/arithmetic/SoftFloat-3c/doc/SoftFloat-source.html

I suspect what we should have here are specialisation for each of our
guests. We do something similar in the softfloat2a code in it's
specialise header. Maybe we should rename 8086-SSE to default and then
create a specialisation for each guest that needs it?

>
>> -#ifdef __GNUC_STDC_INLINE__
>> -#define INLINE inline
>> -#else
>> -#define INLINE extern inline
>
> Why are you removing this?

I was having compile issues I think because it was defaulting to extern
inline which was breaking given all the inline functions are defined in
the header. Having re-read the docs for __GNUC_STDC_INLINE__ though it
must have been for one of the more esoteric compile targets as that
should be defined for our default C99 compile?

--
Alex Bennée
