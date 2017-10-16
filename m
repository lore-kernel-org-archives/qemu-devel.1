Received: from eggs.gnu.org ([2001:4830:134:3::10]:50913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46bq-0004x9-5l
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1e46bi-0005G5-FB
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1e46bi-0005FE-93
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:43:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 16 Oct 2017 16:42:55 +0200
Message-Id: <20171016144302.24284-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/7] kvm: slot handling fixes (and small
 cleanups)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Joe Clifford <joeclifford@gmail.com>

Hopefully this is the last bunch of fixes for the cleanup series.

1. log_start() was called before region_add(), which is wrong.
2. I messed up the calculation of the delta when aligning the ram address
   (maybe we should simply also use ROUND_UP there ...).
3. I think we could get log_start/log_stop/log_sync when we actually
   haven't registered a slot (due to trapping).
4. Some further cleanups

Available on: https://github.com/davidhildenbrand/qemu/commits/kvm_slot

@Joe, if you could retest, this would be great! I updated the branch.

David Hildenbrand (7):
  memory: call log_start after region_add
  kvm: fix alignment of ram address
  kvm: tolerate non-existing slot for log_start/log_stop/log_sync
  kvm: fix error message when failing to unregister slot
  kvm: region_add and region_del is not called on updates
  kvm: simplify kvm_align_section()
  memory: reuse section_from_flat_range()

 accel/kvm/kvm-all.c | 39 ++++++++++++++-------------------------
 memory.c            | 16 +++++-----------
 2 files changed, 19 insertions(+), 36 deletions(-)

-- 
2.13.5
