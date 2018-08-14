Received: from eggs.gnu.org ([2001:4830:134:3::10]:51736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fpNAr-0004um-8V
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fpNAo-0000kn-4d
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:27:01 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fpNAn-0000kZ-RX
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 20:26:58 -0400
Received: by mail-pf1-x441.google.com with SMTP id x17-v6so8427466pfh.5
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 17:26:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 13 Aug 2018 17:26:49 -0700
Message-Id: <20180814002653.12828-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] target/arm: Fix int64_to_float16
 double-rounding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

In 88808a022c0, I tried to fix an overflow problem that affected float16
scaling by coverting first to float64 and then rounding after that.  

However, Laurent reported that -0x3ff40000000001 converted to float16
resulted in 0xfbfe instead of the expected 0xfbff.  This is caused by
the inexact conversion to float64.

Rather than build more logic into target/arm to compensate, just add
a function that takes a scaling parameter so that the whole thing is
done all at once with only one rounding.

I don't have a failing test case for the float-to-int paths, but it
seemed best to apply the same solution.


r~


Richard Henderson (4):
  softfloat: Add scaling int-to-float routines
  softfloat: Add scaling float-to-int routines
  target/arm: Use the int-to-float-scale softfloat routines
  target/arm: Use the float-to-int-scale softfloat routines

 include/fpu/softfloat.h | 169 ++++++++----
 fpu/softfloat.c         | 579 +++++++++++++++++++++++++++++++---------
 target/arm/helper.c     | 130 ++++-----
 3 files changed, 628 insertions(+), 250 deletions(-)

-- 
2.17.1
