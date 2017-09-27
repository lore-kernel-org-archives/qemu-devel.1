Received: from eggs.gnu.org ([2001:4830:134:3::10]:59927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxFhN-0006b3-2a
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxFhI-00060T-Fd
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:00:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxFhI-0005zM-97
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:00:32 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Sep 2017 19:00:24 +0200
Message-Id: <20170927170027.8539-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/3] s390x/tcg: LAP support using immediate
 TLB invalidation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>

Details about Low-Address Protection can be found in description of
patch 1 and 2. It is basically a subpage protection of the first two
pages of every address space (for which it is enabled).

We can achieve this by simply directly invalidating the TLB entry and
therefore forcing every write accesses onto these two pages into the slow
path.

With this patch, I can boot Linux just fine (which uses LAP). This also
makes all related kvm-unit-tests that we have pass.

The checks are working that good, that I discovered a STFL bug. STFL
stores into the low addresses but low-address protection does explicitly
not apply. The Linux kernel calls STFL while LAP is active. So without
patch nr 3, booting Linux will fail. (this change is also part of a patch
of my SMP series).

Based on: https://github.com/cohuck/qemu.git s390-next
Available on: https://github.com/dhildenb/qemu.git s390x_lap


David Hildenbrand (3):
  accel/tcg: allow to invalidate a write TLB entry immediately
  s390x/tcg: low-address protection support
  s390x/tcg: make STFL store into the lowcore

 accel/tcg/cputlb.c           |  5 ++-
 accel/tcg/softmmu_template.h |  4 +-
 include/exec/cpu-all.h       |  3 ++
 target/s390x/excp_helper.c   |  3 +-
 target/s390x/helper.h        |  2 +-
 target/s390x/mem_helper.c    |  8 ----
 target/s390x/misc_helper.c   |  7 +++-
 target/s390x/mmu_helper.c    | 96 ++++++++++++++++++++++++++++----------------
 8 files changed, 78 insertions(+), 50 deletions(-)

-- 
2.13.5
