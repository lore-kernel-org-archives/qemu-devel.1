Received: from eggs.gnu.org ([2001:4830:134:3::10]:49105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drSq7-0000jd-Nr
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drSq3-00082v-Na
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drSq3-00082B-HI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:49:39 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Sep 2017 19:49:27 +0200
Message-Id: <20170911174933.20789-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/6] QEMU: kvm: cleanup kvm_slot handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, david@redhat.com

We can heavily simplify the kvm_slot code. Flatview will make sure that we
don't have to deal with overlapping slots. E.g. when a memory section is
resized, we are first notified about the removal and then about the new
memory section.

So basically, we can directly always map one memory section to one
kvm slot (if the fixed up size is > 0).


RFC -> v1:
- minor changes to avoid changing indentation, therefore making it easier
  to review


David Hildenbrand (6):
  kvm: require JOIN_MEMORY_REGIONS_WORKS
  kvm: factor out alignment of memory section
  kvm: use start + size for memory ranges
  kvm: we never have overlapping slots in kvm_set_phys_mem()
  kvm: kvm_log_start/stop are only called with known sections
  kvm: kvm_log_sync() is only called with known memory sections

 accel/kvm/kvm-all.c | 235 +++++++++++++++-------------------------------------
 1 file changed, 68 insertions(+), 167 deletions(-)

-- 
2.13.5
