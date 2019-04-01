Received: from eggs.gnu.org ([209.51.188.92]:56797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hAuBt-0003Gt-1N
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hAuBs-0005pZ-22
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:29:21 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hAuBr-0005op-9n
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:29:19 -0400
Received: by mail-pl1-x642.google.com with SMTP id b65so4277461plb.6
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 03:29:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  1 Apr 2019 17:29:05 +0700
Message-Id: <20190401102911.8685-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.1 0/6] target/s390x: Clean up tcg
 exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, cohuck@redhat.com, qemu-s390x@nongnu.org

I've been cleaning up some random branches and found this,
dating from mid-2017(!)  My memory is that I wrote this going
into some softfreeze and then failed to do anything with it
once development opened again.  Oops.

The major change is to handle ILEN via TCG unwinding, so that
we don't have to Just Know about the ILEN (the majority of the
calls to s390_program_interrupt use constants), or re-read from
memory (which gets EX wrong).


r~


Richard Henderson (6):
  target/s390x: Truncate 32-bit psw_addr before creating TB
  target/s390x: Add ilen to unwind data
  target/s390x: Use ilen from unwind in tlb_fill
  target/s390x: Remove ilen parameter from tcg_s390_program_interrupt
  target/s390x: Remove ilen parameter from s390_program_interrupt
  target/s390x: Use tcg_s390_program_interrupt in TCG helpers

 target/s390x/cpu.h           | 33 +++++++++++++-------
 target/s390x/internal.h      |  2 +-
 target/s390x/tcg_s390x.h     |  4 +--
 hw/s390x/s390-pci-inst.c     | 58 ++++++++++++++++++------------------
 target/s390x/cc_helper.c     |  4 +--
 target/s390x/crypto_helper.c |  7 ++---
 target/s390x/diag.c          | 14 ++++-----
 target/s390x/excp_helper.c   | 10 +++----
 target/s390x/fpu_helper.c    |  6 ++--
 target/s390x/int_helper.c    | 15 +++++-----
 target/s390x/interrupt.c     | 12 ++++----
 target/s390x/ioinst.c        | 40 ++++++++++++-------------
 target/s390x/mem_helper.c    | 53 +++++++++++++++++++-------------
 target/s390x/misc_helper.c   | 27 ++++++-----------
 target/s390x/tcg-stub.c      |  4 +--
 target/s390x/translate.c     | 16 +++++-----
 16 files changed, 163 insertions(+), 142 deletions(-)

-- 
2.17.1
