Received: from eggs.gnu.org ([2001:4830:134:3::10]:34153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d8nio-0006g1-PS
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d8nij-0004G6-8T
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:01:34 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:34744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d8nij-0004Fe-34
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:01:29 -0400
Received: by mail-it0-x242.google.com with SMTP id c26so3032282itd.1
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 06:01:28 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <C0128B48-DC8A-495B-9030-45B19C85C4A1@gmail.com>
Content-Transfer-Encoding: quoted-printable
From: G 3 <programmingkidx@gmail.com>
Date: Thu, 11 May 2017 09:01:17 -0400
Subject: Re: [Qemu-devel] Future of SoftFloat use in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "alex.bennee@linaro.org Benn?e" <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

> Hi,
>
> We've got a task coming up to implement half-precision floating point
> (FP16) for ARMv8.2. As you know pretty much all our floating point in
> QEMU is handled by our internal fork of John R. Hauser's BSD SoftFloat
> library. Our current implementation is based on version 2a which =20
> doesn't
> support FP16.
>
> As it happens there has been a new release of SoftFloat recently.
> Version 3 is a complete re-write which made a number of changes, some
> notable ones being:
>
>   - Complete rewrite, different use license than earlier releases.
>   - Renaming most types and functions, upgrading some algorithms
>     - restructuring the source files, and making SoftFloat into a =20
> true library.
>   - Added functions to convert between floating-point and unsigned =20
> integers,
> both 32-bit and 64-bit (uint32_t and uint64_t).
>   - Added functions for fused multiply-add, for all supported =20
> floating-point
> formats except 80-bit double-extended-precision.
>   - Added support for a fifth rounding mode, near_maxMag (round to =20
> nearest,
> with ties to maximum magnitude, away from zero).
>
> And in the most recent release as of February 2017, 3c:
>
>   - Added optional rounding mode odd (round to odd, also known as =20
> jamming).
>   - Implemented the common 16-bit =93half-precision=94 floating-point =20=

> format
> (float16_t)
>
> See: http://www.jhauser.us/arithmetic/SoftFloat-3c/doc/SoftFloat-=20
> history.html
>
> Of course the softfloat in QEMU's tree hasn't been static either. =20
> We've
> made numerous changes over the years to add and fix various features,
> including features that have since been added to the upstream =20
> softfloat.
> It seems unlikely we could switch to the newer softfloat without =20
> risking
> breaking something. However if we look at back-porting stuff from the
> newer library we essentially get to own our version of softfloat
> forever.
>
> So what else can we do?
>
> We could investigate having both libraries included in QEMU. It seems
> the API has changed quite a bit so that might be possible although =20
> there
> would be hackage involved in having two different softfloat.h's
> involved.
>
> This would be useful if we wanted to take a piecemeal approach to
> updating the library. For example we could just use softfloat3 when we
> need the newer features (e.g. FP16).
>
> Or we could convert one architecture at a time so each qemu binary =20
> links
> against either a version 2 or version 3 softfloat library. Of course
> that does run the risk of permanently holding two versions of =20
> softfloat
> in the code if the less maintained guest architectures don't convert
> quickly.
>
> So any thoughts about what would make the best approach?
>
> --
> Alex Benn=E9e


Given all the features this new library has I suggest we do upgrade =20
to Softfloat 3c. Your idea on keeping both two versions of this =20
library until all targets have been converted sound like an effective =20=

plan.
