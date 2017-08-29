Received: from eggs.gnu.org ([2001:4830:134:3::10]:49463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQe-0002Ql-DR
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmnQb-0001T6-Bh
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:08 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:35693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmnQb-0001Sd-4W
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:48:05 -0400
Received: by mail-pg0-x236.google.com with SMTP id 63so13982379pgc.2
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 13:48:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 29 Aug 2017 13:47:51 -0700
Message-Id: <20170829204759.6853-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/8] tcg/s390 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, agraf@suse.de

This finally converts s390 to the tcg_target_op_def function, which
allows constraints to vary at runtime.  Once we have that, we can

(1) Perform some facilities checks once during startup instead of
    every time we evaluate the constraint,
(2) Use the distinct-operands facility from z196.

In addition, two cleanups to the setcond expansion

(3) Use the load-on-condition-2 facility from z13,
(4) Use a smaller expansion for LE/LEU using SLBGR.

I wrote these after soft freeze and before I changed jobs, so it has
seen some testing.  Unfortunately, I no longer have access to s390
hardware, so I'd appreciate it if someone could re-test this rebase.


r~


Richard Henderson (8):
  tcg/s390: Fully convert tcg_target_op_def
  tcg/s390: Merge cmpi facilities check to tcg_target_op_def
  tcg/s390: Merge muli facilities check to tcg_target_op_def
  tcg/s390: Merge add2i facilities check to tcg_target_op_def
  tcg/s390: Merge ori+xori facilities check to tcg_target_op_def
  tcg/s390: Use distinct-operands facility
  tcg/s390: Use load-on-condition-2 facility
  tcg/s390: Use slbgr for setcond le and leu

 tcg/s390/tcg-target.h     |   2 +
 tcg/s390/tcg-target.inc.c | 700 +++++++++++++++++++++++++---------------------
 2 files changed, 380 insertions(+), 322 deletions(-)

-- 
2.13.5
