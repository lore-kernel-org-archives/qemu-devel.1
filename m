Received: from eggs.gnu.org ([209.51.188.92]:35436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1ghv8C-00067P-Qq
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1ghv8C-0000V3-5P
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:37:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42872
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1ghv8B-0000Uv-UM
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:37:44 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0BBNn38000981
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 06:37:43 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pxsh52yqy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 06:37:43 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Fri, 11 Jan 2019 11:37:41 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 11 Jan 2019 12:36:57 +0100
In-Reply-To: <20190111113657.66195-1-frankja@linux.ibm.com>
References: <20190111113657.66195-1-frankja@linux.ibm.com>
Message-Id: <20190111113657.66195-3-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] s390x: Return specification exception for
 unimplemented diag 308 subcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

The architecture specifies specification exceptions for all
unavailable subcodes.

The presence of subcodes is indicated by checking some query subcode.
For example 6 will indicate that 3-6 are available. So future systems
might call new subcodes to check for new features. This should not
trigger a hw error, instead we return the architectured specification
exception.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-stable@nongnu.org
---
 target/s390x/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index cfd7222ddd..c28cf1d9f1 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -132,7 +132,7 @@ out:
         }
         return;
     default:
-        hw_error("Unhandled diag308 subcode %" PRIx64, subcode);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
         break;
     }
 }
-- 
2.14.3
