Received: from eggs.gnu.org ([2001:4830:134:3::10]:59104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfR7U-0008T9-2Z
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dfR7Q-0003OW-6N
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:33:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dfR7Q-0003Ne-0g
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:33:52 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed,  9 Aug 2017 15:33:40 +0200
Message-Id: <20170809133346.30271-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/6] QEMU: kvm: cleanup kvm_slot handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, david@redhat.com

If I am not missing something important here, we can heavily simplify
the kvm_slot code. Flatview will make sure that we don't have to deal
with overlapping slots. E.g. when a memory section is resized, we are
first notified about the removal and then about the new memory section.

So basically, we can directly always map one memory section to one
kvm slot (if the fixed up size is > 0).

Only very briefly tested. Will do some more testing if we agree that this
is the right thing to do.

David Hildenbrand (6):
  kvm: require JOIN_MEMORY_REGIONS_WORKS
  kvm: factor out alignment of memory section
  kvm: use start + size for memory ranges
  kvm: we never have overlapping slots in kvm_set_phys_mem()
  kvm: kvm_log_start/stop are only called with known sections
  kvm: kvm_log_sync() is only called with known memory sections

 accel/kvm/kvm-all.c | 276 +++++++++++++++++-----------------------------------
 1 file changed, 89 insertions(+), 187 deletions(-)

-- 
2.9.4
