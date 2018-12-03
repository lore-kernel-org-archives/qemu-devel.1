Received: from eggs.gnu.org ([2001:4830:134:3::10]:35386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqm9-0001ao-UK
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqm5-0003Mi-9L
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:49 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTqm5-0003MK-42
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:45 -0500
Received: by mail-ot1-x341.google.com with SMTP id n8so8214022otl.6
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:08:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 10:08:35 -0600
Message-Id: <20181203160840.15115-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 0/5] tcg/i386: Improve guest_base
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

This tidies guest_base handling such that (1) we require no scratch
registers, (2) we require no extra instructions besides the memory op,
and (3) we reduce the size of the memory op by omitting a prefix.

In principal point 3 is offset by adding additional opcodes to handle
zero-extension when converting 64-bit guest values back to 32-bit guest
addresses.  But those turn out to be hen's teeth, since 32-bit guests
often have no way of even producing 64-bit guest values.

In particular, I saw none in a simple pass through linux-user-test-0.3
for i386, arm, sh4, sparc.


r~


Richard Henderson (5):
  tcg/i386: Propagate is64 to tcg_out_qemu_ld_direct
  tcg/i386: Implement INDEX_op_extr{lh}_i64_i32 for 32-bit guests
  tcg/i386: Assume 32-bit values are zero-extended
  tcg/i386: Precompute all guest_base parameters
  tcg/i386: Add setup_guest_base_seg for FreeBSD

 tcg/i386/tcg-target.h     |   5 +-
 tcg/i386/tcg-target.inc.c | 188 ++++++++++++++++----------------------
 2 files changed, 83 insertions(+), 110 deletions(-)

-- 
2.17.2
