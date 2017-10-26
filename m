Received: from eggs.gnu.org ([2001:4830:134:3::10]:33009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e7ogL-0002j0-IM
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 16:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e7ogJ-0007Nf-5q
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 16:23:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57344
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e7ogJ-0007NB-0V
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 16:23:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9QKN6UN143653
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 16:23:07 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dugyy9k4q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 16:23:06 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 16:23:04 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 18:22:47 -0200
Message-Id: <20171026202250.6118-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 0/3] ppc: adding some RTAS calls in
 tests/libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com, lvivier@redhat.com

This series implements a few RTAS hypercalls in tests/libqos
that, used together, implement the DRC state transition described
in PAPR 2.7+, 13.4.

This started as an attempt of implementing hot unplug qtests for the
sPAPR machine but I've found a few issues that will require more time
solving:

- CPU hot unplug: for some reason the machine freezes after the
callback is returned.

- LMB hot unplug: not supported by the sPAPR machine if not
set in CAS.

I have a feeling that the CPU hot unplug  issue might be related
with the lack of CAS negotiation step as well, but only way to be
sure is to further understanding how the CAS negotation interfere
with the device hot unplug. If needed we'll have to implement the
client architecture support hypercall as well in the future.

Until then, I believe these hypercalls have a value of their own and
are worth being pushed upstream.


Daniel Henrique Barboza (3):
  tests: adding 'check_exception' RTAS implementation
  tests: adding 'set_indicator' RTAS call
  tests: ibm,configure-connector RTAS call implementation

 tests/libqos/rtas.c | 105 +++++++++++++++++++++++++
 tests/libqos/rtas.h |   5 ++
 tests/rtas-test.c   | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 328 insertions(+)

-- 
2.13.6
