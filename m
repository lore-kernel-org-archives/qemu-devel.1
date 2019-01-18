Received: from eggs.gnu.org ([209.51.188.92]:52247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7b-0004wc-Cn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7a-0001Hm-KT
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:39 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:17 +0100
Message-Id: <20190118121925.24468-4-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
References: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/11] s390x: Return specification exception for
 unimplemented diag 308 subcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Janosch Frank <frankja@linux.ibm.com>, qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

The architecture specifies specification exceptions for all
unavailable subcodes.

The presence of subcodes is indicated by checking some query subcode.
For example 6 will indicate that 3-6 are available. So future systems
might call new subcodes to check for new features. This should not
trigger a hw error, instead we return the architectured specification
exception.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-stable@nongnu.org
Message-Id: <20190111113657.66195-3-frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index acb0f3d4af..aafa740f61 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -130,7 +130,7 @@ out:
         }
         return;
     default:
-        hw_error("Unhandled diag308 subcode %" PRIx64, subcode);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
         break;
     }
 }
-- 
2.17.2
