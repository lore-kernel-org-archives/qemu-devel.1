Received: from eggs.gnu.org ([2001:4830:134:3::10]:59311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7qTn-0008V3-Dk
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7qTm-00038E-8r
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:46:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:60006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d7qTm-00037y-2F
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:46:06 -0400
Date: Mon, 8 May 2017 23:45:59 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170508214559.lnrgrsztrdh4o7xq@aurel32.net>
References: <87pofj8kek.fsf@linaro.org>
	<20170508153625.y7jhzv32go5fzlwh@aurel32.net>
	<addc4f06-5554-0a8c-b651-3c921a148bfb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <addc4f06-5554-0a8c-b651-3c921a148bfb@redhat.com>
Subject: Re: [Qemu-devel] Future of SoftFloat use in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Aleksandar Markovic <aleksandar.markovic@imgtec.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <rth@twiddle.net>

On 2017-05-08 17:58, Thomas Huth wrote:
> On 08.05.2017 17:36, Aurelien Jarno wrote:
> > Hi,
> >=20
> > On 2017-05-08 15:58, Alex Benn=C3=A9e wrote:
> >> Hi,
> >>
> >> We've got a task coming up to implement half-precision floating point
> >> (FP16) for ARMv8.2. As you know pretty much all our floating point in
> >> QEMU is handled by our internal fork of John R. Hauser's BSD SoftFloat
> >> library. Our current implementation is based on version 2a which doesn=
't
> >> support FP16.
> >>
> >> As it happens there has been a new release of SoftFloat recently.
> >> Version 3 is a complete re-write which made a number of changes, some
> >> notable ones being:
> >>
> >>   - Complete rewrite, different use license than earlier releases.
> >>   - Renaming most types and functions, upgrading some algorithms
> >>     - restructuring the source files, and making SoftFloat into a true=
 library.
> >>   - Added functions to convert between floating-point and unsigned int=
egers, both 32-bit and 64-bit (uint32_t and uint64_t).
> >>   - Added functions for fused multiply-add, for all supported floating=
-point formats except 80-bit double-extended-precision.
> >>   - Added support for a fifth rounding mode, near_maxMag (round to nea=
rest, with ties to maximum magnitude, away from zero).
> >>
> >> And in the most recent release as of February 2017, 3c:
> >>
> >>   - Added optional rounding mode odd (round to odd, also known as jamm=
ing).
> >>   - Implemented the common 16-bit =E2=80=9Chalf-precision=E2=80=9D flo=
ating-point format (float16_t)
> >>
> >> See: http://www.jhauser.us/arithmetic/SoftFloat-3c/doc/SoftFloat-histo=
ry.html
> >>
> >> Of course the softfloat in QEMU's tree hasn't been static either. We've
> >> made numerous changes over the years to add and fix various features,
> >> including features that have since been added to the upstream softfloa=
t.
> >> It seems unlikely we could switch to the newer softfloat without riski=
ng
> >> breaking something. However if we look at back-porting stuff from the
> >> newer library we essentially get to own our version of softfloat
> >> forever.
> >=20
> > There have been many many changes in our forked version of softfloat:
> > qNaN/sNaN, IEEE754-2008 functions, squash input denormal, many floatx80
> > fixes, ...
>=20
> Note that we've apparently also got plenty of bugs in our version of
> softloat left, for example:

I don't say that our version of softfloat is bug free, but I would not
blame softfloat without further investigation:

> - https://bugs.launchpad.net/qemu/+bug/645662

qemu/i386 doesn't use softfloat for many instructions, but rather rely
on the float/double type of the host. This is mostly because softfloat
doesn't provide directly usable trigonometric functions. There are also
a few simple ones that might be more easily converted to softfloat.

> - http://lists.nongnu.org/archive/html/qemu-ppc/2017-05/msg00187.html
>=20
> ... would be interesting to know whether such issues are fixed with the
> newer version of softfloat...

The exception flags are likely to be a bug in the PowerPC
implementation, as this CPU provides more fine grained exception than
what softfloat provides. The actual wrong answers which match the
expected fpscr value look very suspicious to me.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
