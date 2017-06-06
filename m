Received: from eggs.gnu.org ([2001:4830:134:3::10]:49989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGK1-0001IZ-Qn
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGJw-0006Gd-T2
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:23:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIGJw-0006Ex-Ih
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:23:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56FM0VY034327
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 11:22:59 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2awxj1sdjp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 11:22:59 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 6 Jun 2017 16:22:56 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 06 Jun 2017 17:22:53 +0200
In-Reply-To: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149676257351.31274.10816877292939465521.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 2/3] target/ppc: fix memory leak in
 kvmppc_is_mem_backend_page_size_ok()
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

The string returned by object_property_get_str() is dynamically allocated.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/kvm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 88817620766c..f2f7c531bc7b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -486,6 +486,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
 
     if (mempath) {
         pagesize = qemu_mempath_getpagesize(mempath);
+        g_free(mempath);
     } else {
         pagesize = getpagesize();
     }
