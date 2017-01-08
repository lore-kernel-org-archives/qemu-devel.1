Received: from eggs.gnu.org ([2001:4830:134:3::10]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQJKu-0005NN-6X
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQJKq-0008Nq-8s
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:41:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cQJKq-0008NW-2c
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:40:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38FE283F3F
	for <qemu-devel@nongnu.org>; Sun,  8 Jan 2017 19:40:55 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sun,  8 Jan 2017 17:40:36 -0200
Message-Id: <20170108194041.10908-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] Use non-blacklisted family/model/stepping
 for Haswell CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, dgilbert@redhat.com, fweimer@redhat.com, carlos@redhat.com, triegel@redhat.com, berrange@redhat.com, jdenemar@redhat.com, pbonzini@redhat.com

A recent glibc commit[1] added a blacklist to ensure it won't use
TSX on hosts that are known to have a broken TSX implementation.

Our existing Haswell CPU model has a blacklisted
family/model/stepping combination, so it has to be updated to
make sure guests will really use TSX. This is done by patch 5/5.

However, to do this safely we need to ensure the host CPU is not
a blacklisted one, so we won't mislead guests by exposing
known-to-be-good FMS values on a known-to-be-broken host. This is
done by patch 3/5.

[1] https://sourceware.org/git/?p=glibc.git;a=commit;h=2702856bf45c82cf8e69f2064f5aa15c0ceb6359

---
Cc: dgilbert@redhat.com
Cc: fweimer@redhat.com
Cc: carlos@redhat.com
Cc: triegel@redhat.com
Cc: berrange@redhat.com
Cc: jdenemar@redhat.com
Cc: pbonzini@redhat.com

Eduardo Habkost (5):
  i386: Add explicit array size to x86_cpu_vendor_words2str()
  i386: host_vendor_fms() helper function
  i386/kvm: Blacklist TSX on known broken hosts
  pc: Add 2.9 machine-types
  i386: Change stepping of Haswell to non-blacklisted value

 include/hw/i386/pc.h |  6 ++++++
 target/i386/cpu.h    |  1 +
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 target/i386/cpu.c    | 32 ++++++++++++++++++++++----------
 target/i386/kvm.c    | 17 +++++++++++++++++
 6 files changed, 69 insertions(+), 15 deletions(-)

-- 
2.11.0.259.g40922b1
