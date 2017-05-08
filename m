Received: from eggs.gnu.org ([2001:4830:134:3::10]:53235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7kiI-00012E-2H
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7kiH-0007ow-9n
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:36:42 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d7kiH-0007o0-2s
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:36:41 -0400
Date: Mon, 8 May 2017 17:36:25 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170508153625.y7jhzv32go5fzlwh@aurel32.net>
References: <87pofj8kek.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87pofj8kek.fsf@linaro.org>
Sender: Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [Qemu-devel] Future of SoftFloat use in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Aleksandar Markovic <aleksandar.markovic@imgtec.com>, Pranith Kumar <bobby.prani@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

Hi,

On 2017-05-08 15:58, Alex Benn=C3=A9e wrote:
> Hi,
>=20
> We've got a task coming up to implement half-precision floating point
> (FP16) for ARMv8.2. As you know pretty much all our floating point in
> QEMU is handled by our internal fork of John R. Hauser's BSD SoftFloat
> library. Our current implementation is based on version 2a which doesn't
> support FP16.
>=20
> As it happens there has been a new release of SoftFloat recently.
> Version 3 is a complete re-write which made a number of changes, some
> notable ones being:
>=20
>   - Complete rewrite, different use license than earlier releases.
>   - Renaming most types and functions, upgrading some algorithms
>     - restructuring the source files, and making SoftFloat into a true li=
brary.
>   - Added functions to convert between floating-point and unsigned intege=
rs, both 32-bit and 64-bit (uint32_t and uint64_t).
>   - Added functions for fused multiply-add, for all supported floating-po=
int formats except 80-bit double-extended-precision.
>   - Added support for a fifth rounding mode, near_maxMag (round to neares=
t, with ties to maximum magnitude, away from zero).
>=20
> And in the most recent release as of February 2017, 3c:
>=20
>   - Added optional rounding mode odd (round to odd, also known as jamming=
).
>   - Implemented the common 16-bit =E2=80=9Chalf-precision=E2=80=9D floati=
ng-point format (float16_t)
>=20
> See: http://www.jhauser.us/arithmetic/SoftFloat-3c/doc/SoftFloat-history.=
html
>=20
> Of course the softfloat in QEMU's tree hasn't been static either. We've
> made numerous changes over the years to add and fix various features,
> including features that have since been added to the upstream softfloat.
> It seems unlikely we could switch to the newer softfloat without risking
> breaking something. However if we look at back-porting stuff from the
> newer library we essentially get to own our version of softfloat
> forever.

There have been many many changes in our forked version of softfloat:
qNaN/sNaN, IEEE754-2008 functions, squash input denormal, many floatx80
fixes, ...

Do we know if all those changes are also in the new softfloat version,
and if it is not the case if we can work with upstream to implement
that? That seems to me like a pre-requisite before trying to get this
new version in QEMU, either as an option or as the only version.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
