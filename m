Received: from eggs.gnu.org ([2001:4830:134:3::10]:43163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJc-0003EG-1j
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVoJY-00006U-Tw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:40 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:36102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVoJY-000062-OO
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 20:18:36 -0400
Received: by mail-qk0-x232.google.com with SMTP id v17so58225607qka.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 17:18:35 -0700 (PDT)
Received: from bigtime.twiddle.net.com (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	v47sm5647206qtb.11.2017.07.13.17.18.31 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Jul 2017 17:18:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 13 Jul 2017 14:18:11 -1000
Message-Id: <20170714001819.1660-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 0/8] target/alpha cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The new title holder for perf top is helper_lookup_tb_ptr.
Those targets that have a complicated cpu_get_tb_cpu_state
function are going to regret that.

This cleans up the Alpha version of that function such that it is
just two loads and one mask.  Which is one practically-free mask
away from being as minimal as one can get.

Also, in anticipation of LLuis' generic translation loop, fix all
of the temporary leaks.  They all seem to have been on insns that
end the TB, so in practice they weren't harmful, but...


r~


Richard Henderson (8):
  target/alpha: Remove amask from tb->flags
  target/alpha: Copy tb->flags into DisasContext
  target/alpha: Merge several flag bytes into ENV->FLAGS
  target/alpha: Fix temp leak in gen_bcond
  target/alpha: Fix temp leak in gen_mtpr
  target/alpha: Fix temp leak in gen_call_pal
  target/alpha: Fix temp leak in gen_fbcond
  target/alpha: Log temp leaks

 target/alpha/cpu.h       |  79 +++++++----------
 hw/alpha/dp264.c         |   1 -
 linux-user/main.c        |  25 +++---
 target/alpha/cpu.c       |   7 +-
 target/alpha/helper.c    |  12 +--
 target/alpha/machine.c   |  10 +--
 target/alpha/translate.c | 221 +++++++++++++++++++++++++++++------------------
 7 files changed, 194 insertions(+), 161 deletions(-)

-- 
2.9.4
