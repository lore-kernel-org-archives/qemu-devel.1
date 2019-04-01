Received: from eggs.gnu.org ([209.51.188.92]:42868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB477-0003h9-8y
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB476-0004yb-4u
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42590
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB475-0004nt-W3
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4f5e053895
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:49 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkrjx58jf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:45 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:45 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:38 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-65-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 64/97] qemu-img: Fix leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Max Reitz <mreitz@redhat.com>

create_opts was leaked here.  This is not too bad since the process is
about to exit anyway, but relying on that does not make the code nicer
to read.

Fixes: d402b6a21a825a5c07aac9251990860723d49f5d
Reported-by: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 3ecd5a4f19fd9a497490a91aaa96e76a5edadd2c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-img.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qemu-img.c b/qemu-img.c
index cb4a73e5f9..4799e097dc 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -263,6 +263,7 @@ static int print_block_option_help(const char *filename, const char *fmt)
         if (!proto_drv->create_opts) {
             error_report("Protocol driver '%s' does not support image creation",
                          proto_drv->format_name);
+            qemu_opts_free(create_opts);
             return 1;
         }
         create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
-- 
2.17.1
