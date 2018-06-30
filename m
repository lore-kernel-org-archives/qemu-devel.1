Received: from eggs.gnu.org ([2001:4830:134:3::10]:58281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZ3Lm-0002F4-Rw
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 20:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZ3Lj-00077d-P6
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 20:02:50 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:36269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fZ3Lj-00076B-IE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 20:02:47 -0400
Received: by mail-pl0-x241.google.com with SMTP id a7-v6so5168726plp.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 17:02:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 29 Jun 2018 17:02:40 -0700
Message-Id: <20180630000242.29594-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] Fix qemu-system-aarch64 crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The sequence of events was
  (1) Kernel executed a disabled sve insn,
  (2) Undefined Instruction trap went to EL3,
  (3) Lookup of the exception handler saw el3 and returned asidx 1,
  (4) Which hadn't been set up.

So there's definitely a bug with SVE exception routing.
That said...

With just the first patch, the kernel goes into a silly exception loop
which is understandable.  With just the second patch, qemu gets SIGABRT
instead of SIGSEGV, which is definitely easier to debug.

I think I'm in favor of both patches, but you might say we shouldn't
have to have the first one and just apply the second.


r~


Richard Henderson (2):
  target/arm: Always return ARMASIdx_NS when num_ases == 1
  cpu: Assert asidx_from_attrs return value in range

 include/qom/cpu.h | 6 ++++--
 target/arm/cpu.h  | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.17.1
