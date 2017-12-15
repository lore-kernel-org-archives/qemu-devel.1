Received: from eggs.gnu.org ([2001:4830:134:3::10]:40841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlsaidhi@gmail.com>) id 1ePlNS-0007I1-LA
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlsaidhi@gmail.com>) id 1ePlNQ-0003iw-Uu
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:29:54 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:39383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlsaidhi@gmail.com>) id 1ePlNQ-0003eN-Bz
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:29:52 -0500
Received: by mail-lf0-x243.google.com with SMTP id 6so1045436lfa.6
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 00:29:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <871sk8rw67.fsf@linaro.org>
References: <20171123163538.31411-1-laurent@vivier.eu>
	<871sk8rw67.fsf@linaro.org>
From: william lin <wlsaidhi@gmail.com>
Date: Fri, 15 Dec 2017 02:29:10 -0600
Message-ID: <CAGC02hTeoT-CcEi3+8vEuzpJ7pj=5NpCiA0btvoycsc3e9aGtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] target/m68k: implement 680x0 FPU
 (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Wesley Wiedenmeier <wesley.wiedenmeier@utexas.edu>

Hi,

Does anyone know what is the status on this patch? In particular I
need the code from the later patches in Laurent's tree
(sin, cos, etc..) to fix the x87 fpu bug.

>From what I understand, there shouldn't be any licensing issue with the
code as implementation's algorithm was taken from the version of the
asm lib that is GPL compatible. (both versions' algorithms are identical)

As for the Softfloat libraries, Andreas is correct, they are all identical
other than the headers.


I would be happy to create a new patch thread with all the licensing
and sourcing issues summarized for the code in question, however
I'm not sure what would be the best way to go about giving Laurent
credit in the patches.

Thanks,
William

On Wed, Dec 6, 2017 at 4:24 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Laurent Vivier <laurent@vivier.eu> writes:
>
> > Implement fmod, frem, fscale, fgetman and fgetexp.
> >
> > Instead of using functions of libm (v1 of this series)
> > and converting between host long double and floatx80 type
> > the new version (v2) adds new floatx80 functions in softfloat.
>
> 68k used 80bit float, well TIL ;-)
>
> Just for reference Richard and I did a sprint on hacking the softfloat
> last week. The results are currently brewing in:
>
>   https://github.com/stsquad/qemu/tree/softfloat-and-arm-fp16-v2
>
> The main push has been to decompose 16/32/64 bit floats and have a
> common set of operations. This means we work with an internal 64 bit
> fractional part and then just round appropriately when we pack the
> result. It's a big departure from SoftFloat2a but seeing as we are not
> likely to bring in changes from upstream we felt it was worth it from a
> code clarity point of view.
>
> However we have punted touching the 80bit code and any potential
> quad-precision stuff to a later date, preferably when int128_t is easier
> to use. Perhaps it is worth considering that option now?
>
> >
> > All the floatx80 functions are copied from "Previous",
> > the NeXT Computer Emulator, and written by Andreas Grabher.
> >
> > Laurent Vivier (5):
> >   softfloat: add floatx80_mod()
> >   target/m68k: add fmod/frem
> >   softfloat: use floatx80_infinity in softfloat
> >   softfloat: add floatx80_getman(), floatx80_getexp(), floatx80_scale()
> >   target-m68k: add fscale, fgetman and fgetexp
> >
> >  fpu/softfloat-specialize.h |  29 +++++
> >  fpu/softfloat.c            | 258 ++++++++++++++++++++++++++++++
> ++++++++++++---
> >  include/fpu/softfloat.h    |  13 ++-
> >  target/m68k/cpu.h          |   1 +
> >  target/m68k/fpu_helper.c   |  48 +++++++++
> >  target/m68k/helper.h       |   5 +
> >  target/m68k/translate.c    |  15 +++
> >  7 files changed, 355 insertions(+), 14 deletions(-)
>
>
> --
> Alex Benn=C3=A9e
>
>
