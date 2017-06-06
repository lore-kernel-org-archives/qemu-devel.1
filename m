Received: from eggs.gnu.org ([2001:4830:134:3::10]:49881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGJs-00010t-6m
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGJo-000655-Sh
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:22:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIGJo-00064O-HX
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:22:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56FJ9JJ112569
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 11:22:51 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2awq37aukm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 11:22:51 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 6 Jun 2017 16:22:46 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 06 Jun 2017 17:22:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 0/3] ppc: fix memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Coverity just reported a memory leak introduced by this commit (QEMU 2.9):

commit df58713396f8b2deb923e39c00b10744c5c63909
Author: Thomas Huth <thuth@redhat.com>
Date:   Wed Feb 15 10:21:44 2017 +0100

    hw/ppc/spapr: Check for valid page size when hot plugging memory

It boils down to the fact that object_property_get_str() returns a string
allocated with g_strdup(), which must be deallocated with g_free() at some
point.

--
Greg

---

Greg Kurz (3):
      target/ppc: pass const pointer to kvmppc_is_mem_backend_page_size_ok()
      target/ppc: fix memory leak in kvmppc_is_mem_backend_page_size_ok()
      spapr: fix memory leak in spapr_memory_pre_plug()


 hw/ppc/spapr.c       |    5 ++++-
 target/ppc/kvm.c     |    5 +++--
 target/ppc/kvm_ppc.h |    2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)
