Received: from eggs.gnu.org ([2001:4830:134:3::10]:45087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwufd-0004Ld-IC
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwufa-0003Qx-Fj
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwufa-0003Qk-A9
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:22 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Sep 2017 20:33:12 +0200
Message-Id: <20170926183318.12995-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/6] s390x/tcg: fix some accesses using low
 address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

Conny reported that a guest Linux currently spits out:
  "The s390-virtio transport is deprecated. Please switch to a modern host
  providing virtio-ccw."

This is strange, because we have no legacy virtio transport in QEMU :)

Main problem is, that a page is tested for acccess, and the test does not
fail. All memory access variants like stb_phys() will never fail. On
invalid memory, they simply do nothing.

Linux uses lura for this check. Let's introduce a _real MMU that handles
prefixing and can later be used for things like low address protection.

The other BUG is that a check for invalid memory is wrong. Therefore,
Patch 1 alone makes the guest crash when trying to initialize the
virtio transport. Crazy stuff.

David Hildenbrand (6):
  s390x/tcg: fix checking for invalid memory check
  s390x/tcg: add MMU for real addresses
  s390x/tcg: make lura(g) use the new _real mmu.
  s390x/tcg: make stora(g) use the new _real mmu
  s390x/tcg: make testblock use the new _real mmu
  s390x/tcg: make idte/ipte use the new _real mmu

 target/s390x/cpu.h         |  4 +++-
 target/s390x/excp_helper.c | 29 +++++++++++++++++++----------
 target/s390x/internal.h    |  2 ++
 target/s390x/mem_helper.c  | 36 +++++++++++-------------------------
 target/s390x/mmu_helper.c  | 19 +++++++++++++++++++
 target/s390x/translate.c   |  4 ----
 6 files changed, 54 insertions(+), 40 deletions(-)

-- 
2.13.5
