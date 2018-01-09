Received: from eggs.gnu.org ([2001:4830:134:3::10]:51310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsvi-0006Yl-Va
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYsve-0006Al-Ul
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:22:58 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:41028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYsve-00067m-N9
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:22:54 -0500
Received: by mail-wm0-x236.google.com with SMTP id g75so20185415wme.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:22:54 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:32 +0000
Message-Id: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/20] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Here is version two of the softfloat re-factoring. See the previous
posting for details of the approach:

  https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg01708.html

There is only one new patch to remove USE_SOFTFLOAT_STRUCT_TYPES which
had bit-rotted to irrelevance. I did run into a problem with inclusion
of softfloat.h by bswap.h - which is likely the cause of the excessive
rebuilds when touching softfloat headers. We probably want to think
about moving the the type definitions to somewhere common
(qemu/typedefs.h?) but I haven't done it here to avoid too much churn.

This work is part of the larger chunk of adding half-precision ops to
the ARM front-end. However I've split the series up to make for a less
messy review. This tree can be found at:

  https://github.com/stsquad/qemu/tree/softfloat-refactor-and-fp16-v2

While I have been testing the half-precision stuff in the ARM
specific tree this series is all common code. It has however been
tested with ARM RISU which exercises the float32/64 code paths quite
nicely.

Any additional testing appreciated.

Changes for v2
--------------

 - added rth's s-o-b tags
 - added review tags
 - clean-ups for compare, minmax and float to int

As usual the details are in the individual commit messages.

Alex Bennée (20):
  fpu/softfloat: implement float16_squash_input_denormal
  include/fpu/softfloat: remove USE_SOFTFLOAT_STRUCT_TYPES
  include/fpu/softfloat: implement float16_abs helper
  include/fpu/softfloat: implement float16_chs helper
  include/fpu/softfloat: implement float16_set_sign helper
  include/fpu/softfloat: add some float16 constants
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
 fpu/softfloat.c            | 7417 ++++++++++++++++++++------------------------
 include/fpu/softfloat.h    |  117 +-
 4 files changed, 3437 insertions(+), 4256 deletions(-)

-- 
2.15.1
