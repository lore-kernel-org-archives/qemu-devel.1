Received: from eggs.gnu.org ([2001:4830:134:3::10]:46827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDtv5-0004Mi-0W
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDtv0-0008La-UV
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:43:50 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDtv0-0008Ky-MW
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:43:46 -0400
Received: by mail-wr0-x244.google.com with SMTP id o4-v6so14529194wrm.0
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 08:43:46 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  2 May 2018 16:43:41 +0100
Message-Id: <20180502154344.10585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] refactor float-to-float conversions and
 fix AHP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is a more polished version of the re-factoring of the softfloat
fcvt code. I've split apart the fixes for ARM alternative
half-precision format for easier review. Rather than rely on some
questionable hacks it introduces a new FloatFmt to allow cleaner
handling of the differences in the common code. If there are other
alternative floating point formats they can follow a similar approach.

I've included the test case for reference although I expect it to be
merged with my tcg-testing revival code which has the rest of the
build and test machinery for the test case.

checkpatch dumps a bunch of false-positives as it doesn't like
scientific notation for floats or inline assembler used in the test
case.

Cheers,

Alex Bennée (3):
  fpu/softfloat: re-factor float to float conversions
  fpu/softfloat: support ARM Alternative half-precision
  tests/tcg/aarch64: add fcvt test cases for AArch64 (!UPSTREAM)

 fpu/softfloat-specialize.h |   40 -
 fpu/softfloat.c            |  524 +++------
 include/fpu/softfloat.h    |    8 +-
 tests/tcg/aarch64/fcvt.c   |  296 +++++
 tests/tcg/aarch64/fcvt.ref | 2138 ++++++++++++++++++++++++++++++++++++
 5 files changed, 2588 insertions(+), 418 deletions(-)
 create mode 100644 tests/tcg/aarch64/fcvt.c
 create mode 100644 tests/tcg/aarch64/fcvt.ref

-- 
2.17.0
