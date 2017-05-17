Received: from eggs.gnu.org ([2001:4830:134:3::10]:56256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApyu-0004Dv-Nf
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dApyq-0000lV-CJ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dApyq-0000lB-2j
	for qemu-devel@nongnu.org; Tue, 16 May 2017 23:50:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4H3hj4a045326
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:30 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2agcfmdtku-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 23:50:30 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 17 May 2017 13:50:27 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 09:19:16 +0530
Message-Id: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 0/6] ppc/spapr: Fix migration of radix
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

This patchset fixes the migration of sPAPR radix guests.

Changes in v1:
--------------
- Added two patches to fix generic savevm unregistration issues.
- HTAB savevm handlers are now registered/unregistered when HTAB
  is created/destroyed instead of doing this in CAS call (as in v0).

TODO:
- I have checks in spapr_post_load() to detect and fail the migration
  of radix guest to a host that doesn't support radix. However I couldn't
  test this as I am hitting some other unrelated migration failure
  when testing this path.
- I have tested may scenarios like
  - tcg hash->hash, radix->radix, hash->radix and radix->hash reboot
  - kvm hash reboot and migration
  - kvm radix reboot and migration
  However boot->reboot->migration of radix guest doesn't complete
  and this seems to be a different issue to be fixed.

v0: https://lists.gnu.org/archive/html/qemu-ppc/2017-05/msg00197.html

Bharata B Rao (6):
  migration: Fix unregister_savevm()
  migration: Introduce unregister_savevm_live()
  spapr: Make h_register_process_table hcall flags global
  spapr: Consolidate HPT freeing code into a routine
  spapr: Unregister HPT savevm handlers for radix guests
  spapr: Fix migration of Radix guests

 hw/net/vmxnet3.c            |  2 +-
 hw/ppc/spapr.c              | 43 +++++++++++++++++++++++++++++++++++++------
 hw/ppc/spapr_hcall.c        | 38 +++++++++++++++++---------------------
 hw/s390x/s390-skeys.c       |  2 +-
 include/hw/ppc/spapr.h      | 14 ++++++++++++++
 include/migration/vmstate.h |  4 +++-
 migration/savevm.c          | 16 +++++++++++++---
 slirp/slirp.c               |  2 +-
 8 files changed, 87 insertions(+), 34 deletions(-)

-- 
2.7.4
