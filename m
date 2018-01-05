Received: from eggs.gnu.org ([2001:4830:134:3::10]:42976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eXTFM-00011W-8l
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eXTFI-0008Qk-1U
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:45:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35684
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.vnet.ibm.com>)
	id 1eXTFH-0008Q8-SK
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:45:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w05EiEsv113733
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 09:45:18 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fab0r13mc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 09:45:18 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.vnet.ibm.com>;
	Fri, 5 Jan 2018 09:45:17 -0500
From: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Date: Fri,  5 Jan 2018 12:44:40 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20180105144440.18129-1-muriloo@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] block/ssh: fix possible segmentation fault
 when .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Richard W M Jones <rjones@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

This patch prevents a possible segmentation fault when .desc members are checked
against NULL.

The ssh_runtime_opts was added by commit
8a6a80896d6af03b8ee0c17cdf37219eca2588a7 ("block/ssh: Use QemuOpts for runtime
options").

This fix was inspired by
http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg00883.html.

Fixes: 8a6a80896d6af03b8ee0c17cdf37219eca2588a7 ("block/ssh: Use QemuOpts for runtime options")
Cc: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
---
 block/ssh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/ssh.c b/block/ssh.c
index b049a16eb9..8890a0c4ba 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -556,6 +556,7 @@ static QemuOptsList ssh_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "Defines how and what to check the host key against",
         },
+        { /* end of list */ }
     },
 };
 
-- 
2.14.3
