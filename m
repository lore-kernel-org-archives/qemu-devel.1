Received: from eggs.gnu.org ([2001:4830:134:3::10]:36655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8RHF-0000JK-Ei
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8RHB-0003FV-Io
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:08:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f8RHB-0003Es-ED
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:08:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E66D4068046
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:08:04 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-72.ams2.redhat.com
	[10.36.116.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 954B3202660D
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:08:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Apr 2018 16:07:58 +0200
Message-Id: <20180417140802.16711-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] exec: reintroduce MemoryRegion caching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

MemoryRegionCache was reverted to "normal" address_space_* operations
for 2.9, due to lack of support for IOMMUs.  This series reinstates
optimizations, caching only the IOMMU translation but not the IOMMU
lookup and target AddressSpace translation.

Patches 1 to 3 prepare by introducing a new function
address_space_translate_iommu (split out of address_space_translate)
and new header files for declarations shared by regular and "cached"
address_space_* functions.  Patch 4 uses them to introduce both
the slow path for IOMMU and MMIO cached regions, and the fast path
for RAM cached regions.

Paolo

Paolo Bonzini (4):
  exec: move memory access declarations to a common header, inline
    *_phys functions
  exec: small changes to flatview_do_translate
  exec: extract address_space_translate_iommu, fix page_mask corner case
  exec: reintroduce MemoryRegion caching

 exec.c                                | 245 ++++++++++++++++++++------
 include/exec/cpu-all.h                |  79 ++++-----
 include/exec/memory-internal.h        |   3 +
 include/exec/memory.h                 | 209 ++++++++++------------
 include/exec/memory_ldst.inc.h        |  71 ++++++++
 include/exec/memory_ldst_cached.inc.h | 108 ++++++++++++
 include/exec/memory_ldst_phys.inc.h   | 147 ++++++++++++++++
 memory.c                              |   4 +-
 memory_ldst.inc.c                     | 126 -------------
 9 files changed, 651 insertions(+), 341 deletions(-)
 create mode 100644 include/exec/memory_ldst.inc.h
 create mode 100644 include/exec/memory_ldst_cached.inc.h
 create mode 100644 include/exec/memory_ldst_phys.inc.h

-- 
2.17.0
