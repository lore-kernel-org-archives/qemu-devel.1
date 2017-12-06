Received: from eggs.gnu.org ([2001:4830:134:3::10]:38134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMWsZ-00046M-5v
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMWsV-00044Q-4t
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:24:39 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eMWsU-00043q-Uh
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:24:35 -0500
Received: by mail-wr0-x244.google.com with SMTP id o2so3320229wro.5
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 02:24:34 -0800 (PST)
References: <20171123163538.31411-1-laurent@vivier.eu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171123163538.31411-1-laurent@vivier.eu>
Date: Wed, 06 Dec 2017 10:24:32 +0000
Message-ID: <871sk8rw67.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>


Laurent Vivier <laurent@vivier.eu> writes:

> Implement fmod, frem, fscale, fgetman and fgetexp.
>
> Instead of using functions of libm (v1 of this series)
> and converting between host long double and floatx80 type
> the new version (v2) adds new floatx80 functions in softfloat.

68k used 80bit float, well TIL ;-)

Just for reference Richard and I did a sprint on hacking the softfloat
last week. The results are currently brewing in:

  https://github.com/stsquad/qemu/tree/softfloat-and-arm-fp16-v2

The main push has been to decompose 16/32/64 bit floats and have a
common set of operations. This means we work with an internal 64 bit
fractional part and then just round appropriately when we pack the
result. It's a big departure from SoftFloat2a but seeing as we are not
likely to bring in changes from upstream we felt it was worth it from a
code clarity point of view.

However we have punted touching the 80bit code and any potential
quad-precision stuff to a later date, preferably when int128_t is easier
to use. Perhaps it is worth considering that option now?

>
> All the floatx80 functions are copied from "Previous",
> the NeXT Computer Emulator, and written by Andreas Grabher.
>
> Laurent Vivier (5):
>   softfloat: add floatx80_mod()
>   target/m68k: add fmod/frem
>   softfloat: use floatx80_infinity in softfloat
>   softfloat: add floatx80_getman(), floatx80_getexp(), floatx80_scale()
>   target-m68k: add fscale, fgetman and fgetexp
>
>  fpu/softfloat-specialize.h |  29 +++++
>  fpu/softfloat.c            | 258 +++++++++++++++++++++++++++++++++++++++=
+++---
>  include/fpu/softfloat.h    |  13 ++-
>  target/m68k/cpu.h          |   1 +
>  target/m68k/fpu_helper.c   |  48 +++++++++
>  target/m68k/helper.h       |   5 +
>  target/m68k/translate.c    |  15 +++
>  7 files changed, 355 insertions(+), 14 deletions(-)


--
Alex Benn=C3=A9e
