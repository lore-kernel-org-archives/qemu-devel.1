Received: from eggs.gnu.org ([2001:4830:134:3::10]:36220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4HiY-0003mT-Ge
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 22:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4HiT-0003zI-Jd
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 22:34:54 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:46387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4HiT-0003ym-D3
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 22:34:49 -0400
Received: by mail-pg0-x229.google.com with SMTP id k7so262654pga.3
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 19:34:49 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f1b0c3ad-e3db-8d76-7706-0df497e13072@linaro.org>
Date: Mon, 16 Oct 2017 19:34:45 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 00/30] v8.2 half-precision support
 (work-in-progress)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> SoftFloat
> =========
> 
> Previously I had pondered if switching to the newer SoftFloat3 would
> be a worthwhile. While the upstream project is certainly open to
> accepting patches it would be a slow process given the changes we've
> made over the years. As a result I've decided to stick with expanding
> our current code.
> 
> Most of the helpers have been done fairly mechanically by copying the
> float32 equivalent, filing off the 32's, replacing with 16's and
> adjusting the constants appropriately (min/max exp, NaNs etc). I've
> done this in conjunction with reading the SoftFloat3 code as a sanity
> check although in places the design is a little different.

I think we need a re-think of the approach here.

For the most part, the code would be sharable *if* our internal representation
between float32 and float16 were identical.  So that all that's different are
unpacking and repacking routines at the beginning and end.

Unfortunately, the existing float32 code does lots of random unpacking in the
middle of other classification.  Fixing that would be a prerequisite.  Is it
worth upending our code base to make this happen?

Failing that, we need to stop using magic numbers, since so many of them were
wrong.  We need names for these.  We can start with float16 and then later
backport those numbers into larger formats.


r~
