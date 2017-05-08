Received: from eggs.gnu.org ([2001:4830:134:3::10]:43222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7k78-0005nE-S4
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7k76-0002wd-9m
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:58:18 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7k76-0002wV-2j
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:58:16 -0400
Received: by mail-wr0-x231.google.com with SMTP id z52so46521123wrc.2
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 07:58:15 -0700 (PDT)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 08 May 2017 15:58:59 +0100
Message-ID: <87pofj8kek.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] Future of SoftFloat use in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@imgtec.com>, Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi,

We've got a task coming up to implement half-precision floating point
(FP16) for ARMv8.2. As you know pretty much all our floating point in
QEMU is handled by our internal fork of John R. Hauser's BSD SoftFloat
library. Our current implementation is based on version 2a which doesn't
support FP16.

As it happens there has been a new release of SoftFloat recently.
Version 3 is a complete re-write which made a number of changes, some
notable ones being:

  - Complete rewrite, different use license than earlier releases.
  - Renaming most types and functions, upgrading some algorithms
    - restructuring the source files, and making SoftFloat into a true library.
  - Added functions to convert between floating-point and unsigned integers, both 32-bit and 64-bit (uint32_t and uint64_t).
  - Added functions for fused multiply-add, for all supported floating-point formats except 80-bit double-extended-precision.
  - Added support for a fifth rounding mode, near_maxMag (round to nearest, with ties to maximum magnitude, away from zero).

And in the most recent release as of February 2017, 3c:

  - Added optional rounding mode odd (round to odd, also known as jamming).
  - Implemented the common 16-bit “half-precision” floating-point format (float16_t)

See: http://www.jhauser.us/arithmetic/SoftFloat-3c/doc/SoftFloat-history.html

Of course the softfloat in QEMU's tree hasn't been static either. We've
made numerous changes over the years to add and fix various features,
including features that have since been added to the upstream softfloat.
It seems unlikely we could switch to the newer softfloat without risking
breaking something. However if we look at back-porting stuff from the
newer library we essentially get to own our version of softfloat
forever.

So what else can we do?

We could investigate having both libraries included in QEMU. It seems
the API has changed quite a bit so that might be possible although there
would be hackage involved in having two different softfloat.h's
involved.

This would be useful if we wanted to take a piecemeal approach to
updating the library. For example we could just use softfloat3 when we
need the newer features (e.g. FP16).

Or we could convert one architecture at a time so each qemu binary links
against either a version 2 or version 3 softfloat library. Of course
that does run the risk of permanently holding two versions of softfloat
in the code if the less maintained guest architectures don't convert
quickly.

So any thoughts about what would make the best approach?

--
Alex Bennée
