Received: from eggs.gnu.org ([2001:4830:134:3::10]:51415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONdv-0002JV-VR
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONds-0007XW-Sn
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:12 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eONds-0007W3-Kz
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:08 -0500
Received: by mail-wm0-x22f.google.com with SMTP id f140so13911889wmd.2
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 04:57:08 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Dec 2017 12:56:46 +0000
Message-Id: <20171211125705.16120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 00/19] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

In my previous run at this I'd simply taken the existing float32
functions and attempted to copy and paste the code changing the
relevant constants. Apart from the usual typos and missed bits there
were sections where softfloat pulls tricks because it knows the exact
bit positions of things. While I'm sure it's marginally faster it does
make the code rather impenetrable to someone not familiar with how
SoftFloat does things. One thing the last few months have taught me is
the world is not awash with experts on the finer implementation
details of floating point maths. After reviewing the last series
Richard Henderson suggested a different approach which pushed most of
the code into common shared functions. The majority of the work on the
fractional bits is done in 64 bit resolution which leaves plenty of
spare bits for rounding for everything from float16 to float64. This
series is a result of that work and a coding sprint we did 2 weeks ago
in Cambridge.

We've not touched anything that needs higher precision which at the
moment is float80 and 128 bit quad precision operations. They would
need similar decomposed routines to operate on the higher precision
fractional parts. I suspect we'd need to beef up our Int128 wrapper in
the process so it can be done efficiently with 128 bit maths.

This work is part of the larger chunk of adding half-precision ops to
the ARM front-end. However I've split the series up to make for a less
messy review. This tree can be found at:

  https://github.com/stsquad/qemu/tree/softfloat-refactor-and-fp16-v1

While I have been testing the half-precision stuff in the ARM
specific tree this series is all common code. It has however been
tested with ARM RISU which exercises the float32/64 code paths quite
nicely.

Any additional testing appreciated.

Series Breakdown
----------------

The first five patches are simple helper functions that are mostly
inline and there for the benefit of architecture helper functions.
This includes the float16 constants in the final patch.

The next two patches fixed a bug in NaN propagation which only showed
up when doing ARM "Reduction" operations in float16. Although the
minmax code is totally replaced later on I wanted to fix it in place
first rather than add the fix when it was re-written.

The next two patches start preparing the ground for the new decomposed
functions and their public APIs. I've used macro expansion in a few
places just to avoid the amount of repeated boiler-plate for these
APIs. Most of the work is done in the static decompose_foo functions.

As you can see in the diffstat there is an overall code reduction even
though we have also added float16 support. For reference the previous
attempt added 1258 lines of code to implement a subset of the float16
functions. I think the code is also a lot easier to follow and reason
about.

Alex Bennée (19):
  fpu/softfloat: implement float16_squash_input_denormal
  include/fpu/softfloat: implement float16_abs helper
  include/fpu/softfloat: implement float16_chs helper
  include/fpu/softfloat: implement float16_set_sign helper
  include/fpu/softfloat: add some float16 contants
  fpu/softfloat: propagate signalling NaNs in MINMAX
  fpu/softfloat: improve comments on ARM NaN propagation
  fpu/softfloat: move the extract functions to the top of the file
  fpu/softfloat: define decompose structures
  fpu/softfloat: re-factor add/sub
  fpu/softfloat: re-factor mul
  fpu/softfloat: re-factor div
  fpu/softfloat: re-factor muladd
  fpu/softfloat: re-factor round_to_int
  fpu/softfloat: re-factor float to int/uint
  fpu/softfloat: re-factor int/uint to float
  fpu/softfloat: re-factor scalbn
  fpu/softfloat: re-factor minmax
  fpu/softfloat: re-factor compare

 fpu/softfloat-macros.h     |   44 +
 fpu/softfloat-specialize.h |  115 +-
 fpu/softfloat.c            | 6668 ++++++++++++++++++++------------------------
 include/fpu/softfloat.h    |   89 +-
 4 files changed, 3066 insertions(+), 3850 deletions(-)

-- 
2.15.1
